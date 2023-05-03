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
				
		$firstname = $_GET['firstname'];
		$lastname = $_GET['lastname'];
		$telephonenumber = $_GET['telephonenumber'];
		$email = $_GET['email'];
		$password = $_GET['password'];
		// $passwordenc = md5($password);	

		$sql = "INSERT INTO `user`(`id`, `firstname`, `lastname`, `telephonenumber`, `email`, `password`, `userlevel`) VALUES (Null,'$firstname','$lastname','$telephonenumber','$email','$password','m')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Sussecc";
   
}
	mysqli_close($link);
?>