<?php
/* PUT data comes in on the stdin stream */
$putdata = fopen("php://input", "r");

/* Open a file for writing */
/* The file path must exists and web server must has the file's write permisson! ***/
$fp = fopen("/root/eiffel_tower_received.jpg", "w");

/* Read the data 1 KB at a time and write to the file */
while ($data = fread($putdata, 1024))
  fwrite($fp, $data);

/* Close the streams */
fclose($fp);
fclose($putdata);
?>

