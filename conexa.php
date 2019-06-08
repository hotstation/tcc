<?php
try{
		$HOST = "fdb23.awardspace.net";
		$BANCO = "tccweb";
		$USUARIO = "tccweb";
		$SENHA = "";

		$PDO = new PDO("mysql:host=". $HOST . ";dbname=" . $BANCO . ";charset=utf8", $USUARIO , $SENHA );

} catch (PDOExcenption $ERRO){

echo "Erro de conecao " ;
}

?>
