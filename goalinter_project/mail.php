<?php
use PHPMailer\PHPMailer\PHPMailer;

error_reporting(E_ERROR | E_PARSE);


// require("PHPMailer/src/PHPMailer.php");
// require("PHPMailer/src/SMTP.php");
// // require("PHPMailerAutoload.php");

// $mail = new PHPMailer\PHPMailer\PHPMailer();

// $mail->isSMTP();                                      // Set mailer to use SMTP
// $mail->Host = 'mail.smtp2go.com';  // Specify main and backup SMTP servers
// $mail->SMTPAuth = true;                               // Enable SMTP authentication
// $mail->Username = 'Goalinter';                 // SMTP username
// $mail->Password = 'a39264on';                           // SMTP password
// $mail->SMTPSecure = 'tls';                            // Enable encryption, 'ssl' also accepted

// $mail->From = 'from@example.com';
// $mail->FromName = 'Mailer';
// $mail->addAddress('chanipond@gmail.com', 'Joe User');     // Add a recipient
// // $mail->addAddress('ellen@example.com');               // Name is optional
// // $mail->addReplyTo('info@example.com', 'Information');
// // $mail->addCC('cc@example.com');
// // $mail->addBCC('bcc@example.com');

// // $mail->WordWrap = 50;                                 // Set word wrap to 50 characters
// // $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
// // $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
// $mail->isHTML(true);                                  // Set email format to HTML

// $mail->Subject = 'Here is the subject';
// $mail->Body    = 'This is the HTML message body <b>in bold!</b>';
// $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

// if(!$mail->send()) {
//     echo 'Message could not be sent.';
//     echo 'Mailer Error: ' . $mail->ErrorInfo;
// } else {
//     echo 'Message has been sent';
// }
// 	// 	$mail = new PHPMailer\PHPMailer\PHPMailer();
                      
// 	// 	$mail->Host = 'mail.smtp2go.com';  
// 	// 	$mail->SMTPAuth = true;             
// 	// 	$mail->Username = 'Goalinter';            
// 	// 	$mail->Password = 'a39264on'; 
// 	// 	$mail->Port = 2525;                          
// 	// 	$mail->SMTPSecure = 'tls';   

// 	// 	$mail->isHTML(true);
// 	// 	$mail->setFrom("chanipond.k@ku.th", "admin");
// 	// 	$mail->addAddress("chanipond@gmail.com");
// 	// 	$mail->Subject = "Test mail";
// 	// 	$mail->Body = "Hello world ja edok";
// 	// 	$mail->AltBody = 'Test mail';


// 	// 	if($mail->send()) {
// 	// 		echo 'Message has been sent';
// 	// 	}else{
// 	// 		echo 'Message could not be sent.';
// 	// 		echo 'Mailer Error: ' . $mail->ErrorInfo;
// 	// 	}


// 	// mysqli_close($link);

		$mail = new PHPMailer(true);

        try {

            // Email server settings
            $mail->SMTPDebug = 0;
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';             //  smtp host
            $mail->SMTPAuth = true;
            $mail->Username = 'naruepon.sao@gmail.com';   //  sender username
            $mail->Password = 'zewbnjtwuxdqiyrl';       // sender password
            $mail->SMTPSecure = 'tls';                  // encryption - ssl/tls
            $mail->Port = 587;                          // port - 587/465

            $mail->setFrom('naruepon.sao@gmail.com', 'SenderName');
            $mail->addAddress('chanipond@gmail.com', 'Aon Name');     // Add a recipient


            $mail->isHTML(true);                // Set email content format to HTML

            $mail->Subject = "eiei";
            $mail->Body    = "eieieieieieiei";
            ;

		if(!$mail->send()) {
			echo "failed";
			echo "Email not sent." . $mail->ErrorInfo;
		}else{
			echo "success", "Email has been sent.";
		}
		} catch (Exception $e) {
			echo "error","Message could not be sent.";

        } 
?>