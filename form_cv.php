<?php

if (filter_input(INPUT_POST,'submit')){
//Cargamos variables para entablar conexion con mysql
$dbhost = "localhost";
$dbuser = "jaime";
$dbpass = "";
$dbname = "web";

//Trataremos la conexion con mysql como una variable: conn
$conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);

//Si por alguna razon no entabla conexion, nos lo indica con el error en concreto
if (!$conn) 
{
	die("No hay conexión: ".mysqli_connect_error());
}

//Cargamos variables del form del CV para guardar la informacion
$nombre = $_POST["nombre"];
$apellidos = $_POST["apellidos"];
$archivo_nombre=$_FILES['archivo']['name'];
$archivo_tipo = $_FILES['archivo']['type'];
$archivo_temp = $_FILES['archivo']['tmp_name'];
$comentarios   = $_POST["comentarios"];

//Convertimos el archivo en binario
$archivo_binario = (file_get_contents($archivo_temp));

$sql = "INSERT INTO form (nombre, apellidos, archivo_nombre, archivo_tipo, archivo_binario, comentarios) VALUES (?, ?, ?, ?, ?, ?)";	
	$stmt = mysqli_prepare($conn, $sql);
	
	$stmt->bind_param('sss', $nombre, $apellidos, $archivo_nombre, $archivo_tipo, $archivo_binario, $comentarios);
	
	
	
	//ejecutamos la sentencia
  if(mysqli_stmt_execute($stmt)){
    echo "Ya guardamos el archivo en la base de datos<br/>
          &Uacute;ltimo id insertado: <a href='ver.php?id=". mysqli_stmt_insert_id($stmt)."'>". mysqli_stmt_insert_id($stmt)."</a>";
  }else{
    mysqli_stmt_error($stmt);
  }  
	
	mysqli_stmt_close($stmt);
	mysqli_close($conn);


	header("Location: index.htm");
}
?>