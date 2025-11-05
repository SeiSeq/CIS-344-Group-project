<?php
session_start();
include('db_connect.php');

if (isset($_SESSION['user_id'])) {
  $user_id = $_SESSION['user_id'];
  $meditation_id = $_POST['meditation_id'];
  $duration = $_POST['duration_seconds'];
  $mood = $_POST['mood'];
  $notes = $_POST['notes'];

  $sql = "INSERT INTO sessions (user_id, meditation_id, started_at, duration_seconds, mood, notes)
          VALUES ('$user_id', '$meditation_id', NOW(), '$duration', '$mood', '$notes')";
  if (mysqli_query($conn, $sql)) {
    echo "Session recorded successfully.<br><a href='index.php'>Go back</a>";
  } else {
    echo "Error: " . mysqli_error($conn);
  }
} else {
  echo "You must be logged in to record a session.";
}
mysqli_close($conn);
?>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="assets/style.css">
  <meta charset="UTF-8">
  <title></title>
</head>
<body>

</body>
</html>>