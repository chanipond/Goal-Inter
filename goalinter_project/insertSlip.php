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
	// if ($_GET['isAdd'] == 'true') {
    //     //$id = $_GET['id'];
	// 	$id = $_GET['id'];
    //     $id_booking = $_GET['id_booking'];
	// 	$slip = $_GET['slip'];

    //     // `slip`='$slip', 

	// 	$sql = "UPDATE `book` SET `status`='cf',`slip`='$slip' WHERE `id_booking` = '$id_booking'"; 
	
	// 	$result = mysqli_query($link, $sql);

	// 	if ($result) {
	// 		echo "true";
	// 	} else {
	// 		echo "false";
	// 	}

	if ($_GET['isAdd'] == 'true') {
		$id_booking = $_GET['id_booking'];
		$slip = $_GET['slip'];

		$sql = "INSERT INTO `slip`(`id_slip`, `id_booking`, `slip`) VALUES (Null,'$id_booking','$slip')";


	} else echo "Fail";
   
}
	mysqli_close($link);
?>