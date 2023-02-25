<?php
	include 'conn.php';

	isset( $_POST['email'] ) ? $email = $_POST['email'] : $email = "";
	isset( $_POST['password'] ) ? $password = $_POST['password'] : $password = "";
	$passwordenc = md5($password);

	$queryResult=$connect->query("SELECT * FROM user WHERE email = '".$email."' AND password = '".$passwordenc."'");
	// $sql = "SELECT * FROM user WHERE email = '".$email."' AND password = '".$passwordenc."'";

	$result=array();

	while($fetchData=$queryResult->fetch_assoc()){
		$result[]=$fetchData;
	} echo json_encode($result);

	// $result = mysqli_query($db,$sql);
	// $count = mysqli_num_rows($result);

	// if($count == 1) {
	// 	echo json_encode("Success");
	// }else{
	// 	echo json_encode("Error");
	// }
?>