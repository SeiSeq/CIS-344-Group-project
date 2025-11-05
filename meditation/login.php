<?php
session_start();
include('db_connect.php');

$message = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  $email = $_POST['email'];
  $password = $_POST['password'];

  $sql = "SELECT * FROM users WHERE email='$email' AND password_hash='$password'";
  $result = mysqli_query($conn, $sql);
  if (mysqli_num_rows($result) == 1) {
    $row = mysqli_fetch_assoc($result);
    $_SESSION['user_id'] = $row['user_id'];
    $_SESSION['username'] = $row['username'];
    header("Location: index.php");
  } else {
    $message = "Invalid email or password.";
  }
}
?>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="assets/style.css">
  <meta charset="UTF-8">
</head>
<body>
<h1>Login</h1>
<form method="post" action="">
  <label>Email:</label><br>
  <input type="email" name="email"><br>
  <label>Password:</label><br>
  <input type="password" name="password"><br><br>
  <input type="submit" value="Login">
</form>
<p><?php echo $message; ?></p>
<p>Don't have an account? <a href="register.php">Register here</a></p>
</body>
</html>
