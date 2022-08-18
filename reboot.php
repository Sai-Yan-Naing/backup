<?php
define('DBDSN','sqlsrv:Server=202.218.224.21;Database=master');
// define('SERVICEDSN','sqlsrv:Server=202.218.224.21;Database=service_db');
define('DBROOT','tester');
define('DBROOT_PASS','welcome123!');

$root = 'tester';
$root_pass = 'welcome123!';
$pass_key = 'cee358b7cd218370be64e518934687be';
$dsn = 'sqlsrv:Server=202.218.224.21;Database=japan_system_development_18102021';
$pass_encrypted = hash_hmac( 'sha256', $password, $pass_key);
$instance = $argv[1];

try {
  $pdo_account = new PDO($dsn, $root, $root_pass);
  $query = "UPDATE vps_account SET reboot= 0 WHERE instance = ?";
  $stmt = $pdo_account->prepare($query);
  $stmt->execute(array($instance));

} catch (PDOException $e) {
  print('Error ' . $e->getMessage());
  $pdo = NULL;
  die();
}
