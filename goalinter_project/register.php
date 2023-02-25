<?php
	$db = mysqli_connect('localhost', 'padukcanfly', 'a39264on', 'goalinter_project');
	if (!$db) {
		echo "Database connection faild";
	}

	isset( $_POST['firstname'] ) ? $firstname = $_POST['firstname'] : $firstname = "";
	isset( $_POST['lastname'] ) ? $lastname = $_POST['lastname'] : $lastname = "";
	isset( $_POST['telephonenumber'] ) ? $telephonenumber = $_POST['telephonenumber'] : $telephonenumber = "";
	isset( $_POST['email'] ) ? $email = $_POST['email'] : $email = "";
	isset( $_POST['password'] ) ? $password = $_POST['password'] : $password = "";

	$sql = "SELECT * FROM user WHERE firstname = '".$firstname."' AND lastname = '".$lastname."' AND telephonenumber = '".$telephonenumber."' AND email = '".$email."' AND password = '".$password."'";

	$result = mysqli_query($db,$sql);
	$count = mysqli_num_rows($result);

	if($count == 1){
		echo json_encode("Error");
	}else{
		$passwordenc = md5($password);
		$insert = "INSERT INTO user(firstname,lastname,telephonenumber,email,password,userlevel)VALUES('".$firstname."','".$lastname."','".$telephonenumber."','".$email."','".$passwordenc."','m')";

		$query = mysqli_query($db,$insert);
		if ($query) {
			echo json_encode("Success");
		}
	}

?>