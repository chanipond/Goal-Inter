<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

	function chaeckDateTimeOverlap ($start1, $end1, $start2, $end2) {
		return $start1 < $end2 && $end1 > $start2;
	}

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
		$datetime_start = $_GET['datetime_start'];
		$datetime_end = $_GET['datetime_end'];
		$typeField = $_GET['typeField'];

		// $json_mix_data = json_decode($request->mix_data, true);
        // foreach ($json_mix_data as $key => $value) {
        //     $mix_id = mixbev_info::create([
        //         'time' => $time,
        //     ])->id;
        //     foreach ($value['time'] as $key2 => $value2) {
        //         bevtoppingadd_info::create([
        //             'mixbev_id' => $mix_id,
        //             'topping_id' => $value2,
        //         ]);
        //     }
        // }
		$old_data = mysqli_query($link, "SELECT datetime_start, datetime_end FROM book WHERE typeField = '$typeField'");
        
		while($row=mysqli_fetch_assoc($old_data)){
			$old_start = $row['datetime_start'];
			$old_end = $row['datetime_end'];
			if (chaeckDateTimeOverlap($datetime_start, $datetime_end, $old_start, $old_end)) {
				echo "Time is overlap";
				exit();
			}

		} 

        if ($old_data) {
            echo "true";
        }
        else {
            echo "false";
        }


	} else echo "Fail";
   
}
	mysqli_close($link);
?>