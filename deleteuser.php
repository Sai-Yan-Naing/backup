<?php

$root = 'root';
$root_pass = 'i6Qq3gp7qmGuM5TTXMHs';
$pass_key = 'cee358b7cd218370be64e518934687be';
$dsn1 = 'mysql:host=mysql3.winserver.ne.jp;dbname=japan_system_development';

$domain = $argv[1];

try {
	$pdo_account = new PDO($dsn1, $root, $root_pass);
	$stmt = $pdo_account->prepare("DELETE FROM web_account WHERE `domain` = ?");
	$stmt->execute(array($domain));

} catch (PDOException $e) {
	print('Error ' . $e->getMessage());
	$pdo = NULL;
	die();
}
?>