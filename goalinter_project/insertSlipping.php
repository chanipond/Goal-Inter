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
		$id_booking = $_GET['id_booking'];
		$id = $_GET['id'];
		$firstname = $_GET['firstname'];
		$lastname = $_GET['lastname'];
		$date = $_GET['date'];
		$datetime_start = $_GET['datetime_start'];
		$datetime_end = $_GET['datetime_end'];
		$typeField = $_GET['typeField'];
        $slip = $_GET['slip'];
		$price = $_GET['price'];


		$sql = "INSERT INTO `slipping`(`id_slip`,`id_booking`,`id`,`firstname`,`lastname`,`date`,`datetime_start`,`datetime_end`,`typeField`,`slip`,`price`,`status`) VALUES (Null,'$id_booking','$id','$firstname','$lastname','$date','$datetime_start','$datetime_end','$typeField','$slip','$price','s')";
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