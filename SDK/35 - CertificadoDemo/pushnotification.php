<?php 	
	insertHeaders();
	
	$token = $_REQUEST['token'];
	$message = $_REQUEST['message'];
	$function = $_REQUEST['function'];
	
	if ($function == 'send') {
		sendPushWith($token, $message, 2, 'default');	
		$function = '';
	}
	if ($function == '') {
		?>
		<form enctype=multipart/form-data action='pushnotification.php' method=GET>
			
			<div style='width: 200px;'>Token: </div><div><input type=text name='token' size=100 /></div><br>
			<div style='width: 200px;'>Mensagem: </div><div><input type=text name='message' size=100 /></div><br>
			<input name='function' type=hidden value='send' />
			<input type=submit value=Enviar />
		</form>
		<?php
	}

	
	function sendPushWith($token, $text, $badge, $sound) {
		$apnsHost = 'gateway.sandbox.push.apple.com';
		$apnsCert = 'apns.pem';
		$apnsPort = 2195;
		$passPhrase = '1234';
		
		$streamContext = stream_context_create();
		stream_context_set_option($streamContext, 'ssl', 'local_cert', $apnsCert);
		stream_context_set_option($streamContext, 'ssl', 'passphrase', $passPhrase);
		
		$apns = stream_socket_client('ssl://' . $apnsHost . ':' . $apnsPort, $error, $errorString, 2, STREAM_CLIENT_CONNECT, $streamContext);
		
		$payload['aps'] = array('alert' => $text, 'badge' => $badge, 'sound' => $sound);
		$output = json_encode($payload);

		$token = pack('H*', str_replace(' ', '', $token));
		$apnsMessage = chr(0) . chr(0) . chr(32) . $token . chr(0) . chr(strlen($output)) . $output;
		
		if (fwrite($apns, $apnsMessage) == false) {
			echo '<br>ERROR: '.$apnsMessage.'</br>';
		}
		else {
			echo '<br>OK: '.$apnsMessage.'</br>';
		}
//		echo fwrite($apns, $apnsMessage);
		
		socket_close($apns);
		fclose($apns);		
	}

	function insertHeaders() {
		?>
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		    <head>
		        <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		        <title>PUSH NOTIFICATION</title>
		
		    </head>
		
		    <body >
		<?php
	}





