<?php

$root = 'root';
$root_pass = 'i6Qq3gp7qmGuM5TTXMHs';
$dsn1 = 'mysql:host=mysql3.winserver.ne.jp;dbname=japan_system_development';

$user = $argv[1];

/* ƒnƒbƒVƒ…‰» */

try {
	$pdo_account = new PDO($dsn1, $root, $root_pass);
	$stmt = $pdo_account->prepare("UPDATE web_account SET `stopped` = 0 WHERE `user` = ?");
	$stmt->execute(array($user));

} catch (PDOException $e) {
	print('Error ' . $e->getMessage());
	$pdo_account = NULL;
	die();
}

?>