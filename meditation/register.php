<?php
include('db_connect.php');

$message = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  $username = $_POST['username'];
  $email = $_POST['email'];
  $password = $_POST['password'];

  $sql = "INSERT INTO users (username, email, password_hash) VALUES ('$username', '$email', '$password')";
  if (mysqli_query($conn, $sql)) {
    $message = "Registration successful. <a href='login.php'>Login here</a>";
  } else {
    $message = "Error: " . mysqli_error($conn);
  }
}
?>
<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" href="assets/style.css">
  <meta charset="UTF-8">
</head>
<body>
<h1>Register</h1>
<form method="post" action="">
  <label>Username:</label><br>
  <input type="text" name="username"><br>
  <label>Email:</label><br>
  <input type="email" name="email"><br>
  <label>Password:</label><br>
  <input type="password" name="password"><br><br>
  <input type="submit" value="Register">
</form>
<p><?php echo $message; ?></p>
</body>
</html>
