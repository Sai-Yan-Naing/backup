#Unique Variables
$cmd = $Args[0]
$host_ip = $Args[1]
$ftpuser = $Args[2]
$ftppass = $Args[3]
$dir = $Args[4]

$FTPServer = "ftp://${host_ip}"
$FTPUsername = "${ftpuser}"
$FTPPassword = "${ftppass}" 
#$LocalDirectory = "E:\webroot\LocalUser\test" 
$FileToUpload = "${dir}"

#Connect to the FTP Server
$ftp = [System.Net.FtpWebRequest]::create("$FTPServer/$FileToUpload")
$ftp.Credentials =  New-Object System.Net.NetworkCredential($FTPUsername,$FTPPassword)

#Upload file to FTP Server
$ftp.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile

#Verify the file was uploaded
$ftp.GetResponse()