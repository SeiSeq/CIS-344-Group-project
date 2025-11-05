<?php
session_start();
include('db_connect.php');

$sql = "SELECT * FROM meditations";
$result = mysqli_query($conn, $sql);
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
  <title>Meditation Square</title>
  <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<h1>Welcome to Meditation Square</h1>

<?php
if (isset($_SESSION['username'])) {
  echo "<p>Welcome, " . $_SESSION['username'] . "! <a href='logout.php'>Logout</a></p>";
} else {
  echo "<a href='login.php'>Login</a> | <a href='register.php'>Register</a>";
}
?>
<h2>Available Meditations</h2>
<?php
if (mysqli_num_rows($result) > 0) {
  while ($row = mysqli_fetch_assoc($result)) {
    echo "<div style='margin-bottom:20px;'>";
    echo "<h3>" . $row['title'] . "</h3>";
    echo "<p>" . $row['description'] . "</p>";
    echo "<a href='play.php?id=" . $row['meditation_id'] . "' class='play-btn'>Play</a>";
    echo "</div>";
  }
} else {
  echo "No meditations found.";
}
mysqli_close($conn);
?>

<footer>
    <p>© 2025 Meditation Square | Relax. Focus. Rewind.</p>
  </footer>

</body>
</html>