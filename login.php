<?php

//Cargamos variables para entablar conexion con mysql
$dbhost = "localhost";
$dbuser = "jaime";
$dbpass = "jaimeae15";
$dbname = "web";

//Trataremos la conexion con mysql como una variable: conn
$conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);

//Si por alguna razon no entabla conexion, nos lo indica con el error en concreto
if (!$conn) 
{
	die("No hay conexión: ".mysqli_connect_error());
}

//Cargamos variables del form del login para realizar las consultas a la BD
$user_login = $_POST["user_login"];
$pass_login = $_POST["password_login"];
$nombre     = $_POST["nombre"];
$apellido   = $_POST["apellido"];
$user_signup = $_POST["user_signup"];
$pass_signup = $_POST["password_signup"];


//Realizamos consulta PERO INSEGURA: 
//deberiamos utilizar el parametro mysql_real_escape_string para escapar los caracteres especiales
if ($user_login != null && $user_signup == null) {

$query = mysqli_query($conn,"SELECT * FROM usuarios WHERE user = '".$user_login."' and password = '".$pass_login."'");
$nr = mysqli_num_rows($query);
}
else if ($user_login == null && $user_signup != null) {
$query = mysqli_query($conn,"INSERT INTO usuarios (nombre, apellidos, user, password) VALUES ('".$nombre."', '".$apellido."', '".$user_signup."', '".$pass_signup."')");
$nr = mysqli_num_rows($query);
}

//En caso de login exitoso
if($nr == 1)
{
	header("Location: index.htm");
	
}
//En caso de login no exitoso
else if ($nr == 0) 
{
	header("Location: login.html");
}
	


?>
