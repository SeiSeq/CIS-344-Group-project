<?php
session_start();
include('db_connect.php');

$id = $_GET['id'];
$sql = "SELECT * FROM meditations WHERE meditation_id = $id";
$result = mysqli_query($conn, $sql);
$row = mysqli_fetch_assoc($result);
?>
<!DOCTYPE html>
<html>
<head>
  <title>Play Meditation</title>
  <link rel="stylesheet" href="assets/style.css">
  <meta charset="UTF-8">
</head>
<body>
<h1><?php echo $row['title']; ?></h1>
<p><?php echo $row['description']; ?></p>
<p>Instructor: <?php echo $row['instructor']; ?></p>

<audio controls>
  <source src="<?php echo $row['media_url']; ?>" type="audio/mpeg">
</audio>

<?php
if (isset($_SESSION['user_id'])) {
?>
<form action="record_session.php" method="post">
  <input type="hidden" name="meditation_id" value="<?php echo $row['meditation_id']; ?>">
  <label>Duration (seconds):</label>
  <input type="text" name="duration_seconds"><br>
  <label>Mood:</label>
  <input type="text" name="mood"><br>
  <label>Notes:</label><br>
  <textarea name="notes" rows="3" cols="40"></textarea><br>
  <input type="submit" value="Record Session">
</form>
<?php
} else {
  echo "<p><a href='login.php'>Login</a> to record your session.</p>";
}
mysqli_close($conn);
?>
</body>
</html>
