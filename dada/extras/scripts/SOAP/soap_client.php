<?php

include 'SOAP/Client.php';

$proxy     = 'http://localhost/cgi-bin/soap_server.cgi'; 
$namespace = 'DadaMail';


$email     = 'user@example.com'; 
$list      = 'mylist'; 


$params  = array();
$options = array('namespace' => $namespace, 'trace' => 1);


$client = new SOAP_Client($proxy);


$params2 = array($list, $email); 

$result = array(); 
$result = $client->call("subscription_check", $params2, $options);

echo "<pre>\n"; 

echo "	* Email: $email\n"; 
echo "	* List: $list\n\n";


echo "Subscription Check: $result[0]\n"; 

$errors = $result[1]; 

if($errors){ 
	echo "Errors: \n"; 
	while (list($key, $value) = each($errors)) {
		echo "	* Error: $key\n";
	}
}

echo "done.\n";


?>