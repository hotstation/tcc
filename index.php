<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>TCC FATEC SA 2019</title>

	<style type="text/css">
	/*estilos gerais*/
	.container{
		width: 50%;
		margin:0 auto;
	
	}
/*formulario*/
		.areaLocalizaID{

			border-radius:5px;
			background: #778899;
			padding: 10px;

		}

		input {
			padding: 10px;
			margin: 8px 0;
			border: 2px solid #000;
			border-radius: 4px;

		}

		/*somente campo de entrada
		input[type=int] {
			width: 30%;
					} */

		input[type=submit] {
			width:20%;
			background-color: #000080; 
			color: #fff;
			cursor: pointer;
		}

		/*estilos das tabelas*/

		table {

			border-collapse: collapse;
			width:100%;
			margin-top: 10px;

		}
		/*tituto da tabela*/
		table th {
			background-color: #000;
			color: #fff;
			height: 30px;

		}

		h1  {
			width:100%;
			
			color: #000;
			font-size: 14px;

			
		}

		h2  {
			width:100%;
			background-color: #000;
			color: #FFF;
			font-size: 20px;
			border-collapse: collapse;
			text-align: center;
		
			margin-top: 10px;

			
		}

		h4 {
			width:100%;
			background-color: #fff;
			color: #000;
			font-size: 20px;
			border-collapse: collapse;
			text-align: center;
		
			margin-top: 10px;

			
		}

	</style>


<h2>TCC-Gerenciamento de consumo de energia elétrica residencial | Pré-pago | FATEC Santo andré


</h2>

</head>
<body>
	<div class = "container">
		<div class="areaLocalizaID">

	<form action="" method="POST">
		<input type="password" name="senha" placeholder="digite o autenticador" >
		<input type="int" name="id" placeholder="digite id" >
		<input type="submit" name="submit" value="buscar">
	<h4>Para inserir credito digite o campo abaixo(opcional)</h4>
		<input type="int" name="online_key" placeholder="codigo de 12 digitos">

</form>


		
		



		</div>
<?php

include('conexao.php');
if($_SERVER['REQUEST_METHOD']== "POST"){
	//echo "<h1> recebeu o id:" . $_POST['id'] . "</h1>";
	$pass_user=0;
	$id_show = $_POST['id'];
	$senha_web = $_POST['senha'];/*alteracao para senha*/
	$online_key = $_POST['online_key'];/*insere o numero de 12 digitos*/

$linha_grafico=0;
	/*verifica se a senha esta correta*/


	$sql11 = "SELECT * FROM 2922783_tccweb.aux_pre where id like  $id_show ";

	$stmt = $PDO->prepare($sql11);
	$stmt->execute();

	while ($linha = $stmt->fetch(PDO::FETCH_OBJ)) {
	/* mostra o q foi lido na tabela auxiliar
	echo "<tr>";
	echo "id=" . $linha->id . " ";

	echo "password encontrado=" . $linha->pass_user . " ";
	echo " ";

	echo " variavel senha =  " . $pass_user . " ";
	*/
			
	$pass_user=$linha->pass_user;
	}

	/*fim do verifica senha*/




	/*if($id_show == 0 ){
	if($senha_web != $pass_user ){
		echo "<h1>usuário não autorizado </h1>";$sql = "SELECT * FROM tcc.pre where id like  9999 ";}*/
	/* else {$sql = "SELECT * FROM tcc.pre  ";}
	} 		else{ */

	
	if($senha_web !=$pass_user ){
		echo "<h1>usuário não autorizado </h1>";$sql = "SELECT * FROM 2922783_tccweb.pre where id like  9999 ";}
	else {

		/* inserir credito*/

if($_SERVER['REQUEST_METHOD']== "POST" && $online_key !=""){

	$sql33 = "UPDATE 2922783_tccweb.aux_pre SET cre_key1 = $online_key WHERE (id = $id_show)";
	
		
	$stmt2 = $PDO->prepare($sql33);

	$stmt2->bindParam(':id', $id_show);
	$stmt2->bindParam(':online_key', $online_key);

	if($stmt2->execute()){ 
		echo "<table border=\"1\">";

		echo "<td>enviado com sucesso</td>";	
		echo "	";
		echo "<td> numero inserido= " . $online_key . "</td> ";	
		echo "	";
		echo "</table>";


			$sql34 = "UPDATE 2922783_tccweb.pre SET credito_in = $online_key WHERE (id = $id_show)";
	
		
	$stmt34 = $PDO->prepare($sql34);

	$stmt34->bindParam(':id', $id_show);
	$stmt34->bindParam(':online_key', $online_key);


		$stmt34->execute();


	}
	else {
		echo "	";
		echo "<table border=\"1\">";
		echo " <td> erro ao inserir credito favor verificar o numero </td>";
 		echo "</table>";
		echo "	";
	}


	}
			/* fim do inserir credito*/





		$sql = "SELECT * FROM 2922783_tccweb.pre where id like  $id_show ";}
	
	 
 



	} else{

	echo "<h1>DIGITE UM ID VALIDO PARA BUSCA</h1>";
	$sql = "SELECT * FROM 2922783_tccweb.pre where id like  9999 ";

			}

	$stmt = $PDO->prepare($sql);
	$stmt->execute();



echo "<table border=\"1\">";
echo "<tr> <th>id</th> <th>nome</th> <th>ultima_leitura</th> <th>consumo total</th> <th>consumo kwh</th>
 <th>credito atual</th>	<th>credito restante</th> <th>estado</th>	<th>ultimo credito inserido</th>	</tr>";


while ($linha = $stmt->fetch(PDO::FETCH_OBJ)) {


	echo "<tr>";
	echo "<td>" . $linha->id . "</td>";
	echo "<td>" . $linha->nome . "</td>";
	echo "<td>" . $linha->ultima_leitura . "</td>";
	echo "<td>" . $linha->consumo_total . "</td>";
	echo "<td>" . $linha->consumo_kwh . "</td>";
	echo "<td>" . $linha->credito_atual . "</td>";
        echo "<td>" . $linha->cred_restante . "</td>";
	echo "<td>" . $linha->estado . "</td>";
	echo "<td>" . $linha->credito_in . "</td>";
	echo "</tr>	";


$linha_var= $linha->localizacao ;
$linha_grafico = $linha->grafico;


}

echo "</table>";

echo "<h1> </h1>";

echo "<h1> </h1>";
echo "<h1> </h1>";

if ($linha_var !="") { echo " LOCALIZACAO ATUAL DO USUARIO " ;} 

echo " " . $linha_var . "";


echo "<h1> </h1>";
echo "<h1> </h1>";

if ($linha_grafico != ""){echo " GRÁFICO DO CONSUMO POR TEMPO " ;}

echo " " . $linha_grafico . "";




?>


</div>

</body>






</html>
