<?php

$root = 'root';
$root_pass = 'i6Qq3gp7qmGuM5TTXMHs';
$pass_key = 'cee358b7cd218370be64e518934687be';
$dsn1 = 'mysql:host=mysql3.winserver.ne.jp;dbname=japan_system_development';

$domain = $argv[1];
$user = $argv[2];
$password = $argv[3];
$plan = $argv[4];

/* ハッシュ化 */
$pass_encrypted = hash_hmac( 'sha256', $password, $pass_key);

/* 暗号化
$base64_data = base64_encode($password);
$resource = mcrypt_module_open(MCRYPT_BLOWFISH, '', MCRYPT_MODE_CBC, '');
$ks = mcrypt_enc_get_key_size($resource);
$key = substr(md5($pass_key), 0, $ks);

$ivsize = mcrypt_enc_get_iv_size($resource);
$iv = substr(md5($key), 0, $ivsize);

mcrypt_generic_init($resource, $key, $iv);
$encrypted_data = mcrypt_generic($resource, $base64_data);
mcrypt_generic_deinit($resource);

mcrypt_module_close($resource);

$pass_encrypted = base64_encode($encrypted_data);
*/
try {
	$pdo_account = new PDO($dsn1, $root, $root_pass);
	$stmt = $pdo_account->prepare("SELECT COUNT(domain) as cnt FROM web_account WHERE `domain` = ?");
	$stmt->execute(array($domain));
	$data = $stmt->fetch(PDO::FETCH_ASSOC);
	if ($data['cnt'] > 0) {
		echo "サイトが既に存在します\n";
		die();
	}

} catch (PDOException $e) {
	print('Error ' . $e->getMessage());
	$pdo = NULL;
	die();
}

// $pdo_account->query("SELECT COUNT(domain) as cnt FROM web_account WHERE `domain` = '$domain'");

echo $domain . '\n';
echo $password . '\n';

$stmt = $pdo_account->prepare("INSERT INTO web_account (`domain`, `password`, `user`, `plan`) VALUES (?, ?, ?, ?)");
$stmt->execute(array($domain, $pass_encrypted, $user, $plan)) or die("insert error <br />". print_r($pdo_account->errorInfo(), true));
$pdo_account = NULL;
?>
