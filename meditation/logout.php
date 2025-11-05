<?php
// logout.php - end user session
session_start();
session_destroy();
header('Location: login.php');
exit;
?>
