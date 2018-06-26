<?php 

namespace Hcode;

use Rain\Tpl;

/**
  * Mailer, classe para envio de email
  */
 class Mailer
 {
 	const USERNAME = "marcelo@updatehost.pt";
 	const PASSWORD = "YhnYgv43@";
 	const NAME_FROM = "Revenda Update Host";
 	
 	private $mail;

 	public function __construct($toAddress, $toName, $subject, $tplName, $data = array())
 	{
 		// config
		$config = array(
		"tpl_dir"       => $_SERVER["DOCUMENT_ROOT"] . "/views/email/",
		"cache_dir"     => $_SERVER["DOCUMENT_ROOT"] . "/views-cache/",
		"debug"         => false // set to false to improve the speed
		);

		Tpl::configure( $config );

		$tpl = new Tpl;

		foreach ($data as $key => $value) {
			$tpl->assign($key, $value);
		}

		$html = $tpl->draw($tplName, true);

 		//use PHPMailer\PHPMailer\PHPMailer;
		//require_once('vendor/autoload.php');
		$this->mail = new \PHPMailer;
		$this->mail->isSMTP();

		$this->mail->SMTPOptions = array(
		    'ssl' => array(
		    'verify_peer' => false,
		    'verify_peer_name' => false,
		   'allow_self_signed' => true
		));

		$this->mail->SMTPDebug = 0;

		$this->mail->Host = 'mail.updatehost.pt';
		$this->mail->Port = 465;
		$this->mail->SMTPSecure = 'ssl';
		$this->mail->SMTPAuth = true;
		$this->mail->Username = Mailer::USERNAME;
		$this->mail->Password = Mailer::PASSWORD;
		$this->mail->setFrom(Mailer::USERNAME, Mailer::NAME_FROM);
		$this->mail->addAddress($toAddress, $toName);
		$this->mail->Subject = $subject;


		$this->mail->msgHTML($html);
		$this->mail->AltBody = 'Caso nao veja aqui vc vera';
		//var_dump($this->mail->smtpConnect($this->mail->SMTPOptions));

 	}

 	public function send()
 	{
 		return $this->mail->send();

 		/*if(!$mail->send()) {
		    echo 'A mensagem não pôde ser enviada.';
		    echo 'Mailer Error: ' . $this->mail->ErrorInfo;
		} else {
		    echo 'A mensagem foi enviada com sucesso!';
		}
		*/
 	}

 } 



 ?>