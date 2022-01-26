<?php
$date = date("Y-m-d");
$backupall=backupAll();
// print_r($backupall);
// die();
foreach ($backupall as $key => $value) {
	$src = "E:/webroot/LocalUser/$value[name]";
        $directory = "G:/backup/$value[name]";
        $dst = "$directory/$value[name]-$date";
        if(is_dir($directory)){
            deleteBackup($directory);
        }
        custom_copy($src, $dst);
}

/*Backup Folder*/
    function custom_copy($src, $dst) { 
        // open the source directory
        $dir = opendir($src); 
        // Make the destination directory if not exist
        if(!is_dir($dst)){
            //Directory does not exist, so lets create it.
            @mkdir($dst, 0755, true);
        }
        //@mkdir($dst); 
        // Loop through the files in source directory
        while( $file = readdir($dir) ) { 
            if (( $file != '.' ) && ( $file != '..' )) { 
                if ( is_dir($src . '/' . $file) ) { 
                    // Recursively calling custom copy function
                    // for sub directory 
                    custom_copy($src . '/' . $file, $dst . '/' . $file); 
    
                }else { 
                    copy($src . '/' . $file, $dst . '/' . $file); 
                } 
            } 
        } 
        closedir($dir);
    } 

    /*Delete Folder*/
    function deleteBackup($dir){  
        // Assigning files inside the directory
        $dir = new RecursiveDirectoryIterator(
            $dir, FilesystemIterator::SKIP_DOTS);
        // Reducing file search to given root
        // directory only
        $dir = new RecursiveIteratorIterator(
            $dir,RecursiveIteratorIterator::CHILD_FIRST);
        // Removing directories and files inside
        // the specified folder
        foreach ( $dir as $file ) { 
            $file->isDir() ?  rmdir($file) : unlink($file);
        }
        
    }  

    function backupAll()
	{
			$pdo_account = new PDO('mysql:host=localhost:3306;dbname=japan_system_development_c', 'root', '');
			$stmt1 = $pdo_account->prepare("SELECT * FROM backup_data WHERE `scheduler` = ?");
			$stmt1->execute(array(1));
			$data = $stmt1->fetchAll(PDO::FETCH_ASSOC);
			return $data;
	}