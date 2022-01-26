
$arg1 = $Args[0]
$arg2 = $Args[1]
$arg3 = $Args[2]
$arg4 = $Args[3]
$arg5 = $Args[4]
$action = $Args[5]
import-module WebAdministration
if([int]$arg5 -eq 0){
   Clear-WebConfiguration -PSPath iis:\Sites\$arg1 -Filter "/system.webServer/httpErrors/error[@statusCode='$arg2']"
}else{
   if($action -eq 'edit')
   {
      Clear-WebConfiguration -PSPath iis:\Sites\$arg1 -Filter "/system.webServer/httpErrors/error[@statusCode='$arg2']"
   }
   Clear-WebConfiguration -PSPath iis:\Sites\$arg1 -Filter "/system.webServer/httpErrors/error[@statusCode='$arg3']"
   add-WebConfiguration -PSPath IIS:\Sites\$arg1 -Filter /System.WebServer/HttpErrors -Value @{StatusCode=[int]$arg3;  Path="$arg4"; ResponseMode="ExecuteURL"}
}