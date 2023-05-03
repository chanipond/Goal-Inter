<?php
	header("Access-Control-Allow-Origin: *");
    error_reporting(0);
    error_reporting(E_ERROR | E_PARSE);
    header("content-type:text/javascript;charset=utf-8");
    $link = mysqli_connect('localhost', 'padukcanfly', 'a39264on', 'goalinter_project');