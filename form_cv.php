<?php
	if (isset($_POST['submit'])) {
     		$target_path = "/var/www/html/uploads/";
                $target_path = $target_path . basename( $_FILES['archivo']['name']);
                if(!move_uploaded_file($_FILES['archivo']['tmp_name'], $target_path)) {
                    
                    echo '<pre>';
                    echo 'Error en la subida de su PDF';
                    echo '</pre>';
                    
                  } else {

                    $target_path = "/uploads/" . basename( $_FILES['archivo']['name']);

echo <<<EOT
<p>Su PDF ha sido subido con éxito.</p>
<p>Puede consultarlo <a href=$target_path>aquí</a></p>
EOT;
                    
                }
     
            }
?>
