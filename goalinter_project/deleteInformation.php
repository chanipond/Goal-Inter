<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");
	error_reporting(E_ERROR | E_PARSE);

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}else {

	if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
		$idinformation = $_GET['idinformation'];		
									
		$sql = "DELETE FROM information WHERE idinformation = '$idinformation'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "True";
		} else {
			echo "False";
		}

	} else echo "Fail";
   
}
	
}
	mysqli_close($link);
?>