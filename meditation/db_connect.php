<?php
// db_connect.php
$server = "localhost";
$user = "root";
$pass = "";
$db = "meditation_platform";

$conn = mysqli_connect($server, $user, $pass, $db);

if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}
?>
