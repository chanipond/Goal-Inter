<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$id = $_GET['id'];
		$firstname = $_GET['firstname'];
		$lastname = $_GET['lastname'];
		$date = $_GET['date'];
		$time = $_GET['time'];
		$typeField = $_GET['typeField'];
		$slip = $_GET['slip'];

			

		$sql = "INSERT INTO `book`(`id_booking`, `id`, `firstname`, `lastname`, `date`, `time` , `typeField`, `status`, `slip`) VALUES (Null,'$id','$firstname', '$lastname' ,'$date','$time','$typeField','w','-')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Fail";
   
}
	mysqli_close($link);
?>