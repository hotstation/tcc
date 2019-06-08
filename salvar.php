<?php

	include('conexao.php');
      
        

	$var_id = $_GET['var_id'];
	$var_id_enviar = $_GET['var_id'];
	//$consumo_total = $_GET['consumo_total'];
	$consumo_kwh = $_GET['consumo_kwh'];
	$credito_in = $_GET['credito_in'];
        $estado = $_GET['estado'];
        $link_enviar = $_GET['link_enviar'];
        $estado_porta = $_GET['estado_porta'];
        
        if($estado_porta!=1){
	$sql = "UPDATE 2922783_tccweb.pre SET consumo_total = ( ( consumo_total ) + ( :consumo_kwh) ), consumo_kwh = :consumo_kwh, credito_in = :credito_in , estado = :estado , link_enviar= :link_enviar WHERE (id = :var_id)";
        }
        
        
        else{
      $sql = "UPDATE 2922783_tccweb.pre SET consumo_total = ( ( consumo_total ) + ( :consumo_kwh) ), consumo_kwh = :consumo_kwh, credito_in = :credito_in , estado = :estado , link_enviar= :link_enviar , obs= \"porta_aberta\" WHERE (id = :var_id)";
        }
        
        
	if ($link_enviar ==""){$link_enviar =0;}

$stmt = $PDO->prepare($sql);

$stmt->bindParam(':var_id', $var_id);
$stmt->bindParam(':consumo_total', $consumo_total);
$stmt->bindParam(':consumo_kwh', $consumo_kwh);
$stmt->bindParam(':credito_in', $credito_in);
$stmt->bindParam(':estado', $estado);
$stmt->bindParam(':link_enviar', $link_enviar);

	if($stmt->execute()){ 
		echo "salvo_com_sucesso_em_Table_pre";	

	}
	else {
		echo "erro_ao_salvar_em_Table_pre";
	}

/*enviar update table auxiliar pre*/


			$sql8 = "UPDATE 2922783_tccweb.aux_pre SET cre_key1 = :credito_in WHERE (id = :var_id)";

		

$stmt = $PDO->prepare($sql8);

$stmt->bindParam(':var_id', $var_id);
$stmt->bindParam(':credito_in', $credito_in);

	if($stmt->execute()){ 
		echo "salvo_com_sucesso_em_Table_auxiliar-pre";	

	}
	else {
		echo "erro_ao_salvar_em_Table_auxiliar-pre";
	}

/* fim do enviar table auxiliar pre*/

/*enviar para nodemcu*/

$sql3 = "SELECT * FROM 2922783_tccweb.pre where id like  $var_id_enviar ";

$stmt3 = $PDO->prepare($sql3);
$stmt3->execute();



echo "<table border=\"1\">";
echo "<tr> <th>id</th> <th>nome</th> <th>ultima_leitura</th> <th>consumo_total</th> <th>consumo_kwh</th>
 <th>credito_atual</th>	<th>cred_restante</th><th>estado</th>	<th>credito_in</th> <th>obs</th> <th>link_enviar</th>	</tr>";


while ($linha3 = $stmt3->fetch(PDO::FETCH_OBJ)) {


	echo "<tr>";
	echo "<td>" . $linha3->id . "</td>";
	echo "<td>" . $linha3->nome . "</td>";
	echo "<td>" . $linha3->ultima_leitura . "</td>";
	echo "<td>" . "ww" .$linha3->consumo_total . "w" ."</td>";
	echo "<td>" . $linha3->consumo_kwh . "</td>";
	echo "<td>" . $linha3->credito_atual . "</td>";
        echo "<td>" . "xx" . $linha3->cred_restante . "x" . "</td>";
	echo "<td>" . $linha3->estado . "</td>";
	echo "<td>" . $linha3->credito_in . "</td>";
        echo "<td>" . "yy" . $linha3->obs . "y" . "</td>";
        echo "<td>" . "zz" . $linha3->link_enviar . "z" . "</td>";
	echo "</tr>	";


}

echo "</table>";




?>
