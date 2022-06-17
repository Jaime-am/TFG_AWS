<?php

//obtener el id del CV que se quiere ver
$id=  filter_input(INPUT_GET, 'id');
if($id==''){
  die ("No tenemos el id");
}

//Cargamos variables para entablar conexion con mysql
$dbhost = "localhost";
$dbuser = "jaime";
$dbpass = "";
$dbname = "web";

//Trataremos la conexion con mysql como una variable: conn
$conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname) or die("Error al conectar al servidor");	

$sql="SELECT ARCHIVO, TIPO, NOMBRE FROM ARCHIVOS WHERE ID = $id";

//ejecutar la sentencia sql
$resultado = mysqli_query($conn, $sql) or die("Error: no se pudo hacer la consulta.");

while($row = mysqli_fetch_array($resultado)){
  $archivo= $row[0]; //obtener el archivo
  $tipo=$row[1]; //obtener el tipo de archivo
  $nombre=$row[2]; //obtener el nombre del archivo
}

mysqli_close($conn);

//header para tranformar la salida en el tipo de archivo que hemos guardado
header("Content-type: $tipo"); 
header('Content-Disposition: attachment; filename="'.$nombre.'"');

//imprimir el archivo
echo $archivo;
?>