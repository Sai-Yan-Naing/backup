<?php

$root = 'root';
$root_pass = 'i6Qq3gp7qmGuM5TTXMHs';
$pass_key = 'cee358b7cd218370be64e518934687be';
$dsn1 = 'mysql:host=mysql3.winserver.ne.jp;dbname=japan_system_development';

$domain = $argv[1];
$user = $argv[2];
$password = $argv[3];

/* ハッシュ化 */

$pass_encrypted = hash_hmac( 'sha256', $password, $pass_key);


try {
	$pdo_account = new PDO($dsn1, $root, $root_pass);
	$stmt = $pdo_account->prepare("SELECT * FROM web_account WHERE `domain` = ?");
	$stmt->execute(array($domain));
	$data = $stmt->fetch(PDO::FETCH_ASSOC);

	if ($data['user'] == "") {
		echo "ユーザー名エラー";
		$pdo_account = NULL;
		die();
	} else {
		$user = $data['user'];
	}


} catch (PDOException $e) {
	print('Error ' . $e->getMessage());
	$pdo_account = NULL;
	die();
}

$stmt = $pdo_account->prepare("UPDATE web_account SET `password` = ? WHERE `domain` = ?");
$stmt->execute(array($pass_encrypted, $domain));
$pdo_account = NULL;

?>