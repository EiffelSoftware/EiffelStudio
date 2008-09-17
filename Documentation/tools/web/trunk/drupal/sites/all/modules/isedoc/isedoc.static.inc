<?php

require_once ("isedoc.lib.inc");

function isedoc_static_query($delim) {
  global $base_url;
  $args = arg();
  $l_path = FALSE;
  foreach($args as $n) {
    //drupal_set_message("Static Query: n=$n l_path=$l_path");
    if ($l_path === FALSE) {
      if ($n == $delim) {
        $l_path = '';
      }
    } else {
      if ($n == 'reference') {
      } else {
        $l_path = "$l_path/$n";
      }
    }
  }
  $nb = strlen($l_path);
  if ($nb > 5 and substr($l_path, $nb - 5, 5) == 'index') {
    $l_path = substr($l_path, 0, $nb - 5);
    $url = "$base_url/static$l_path";
  } else {
    $url = "$base_url/static$l_path.html";
  }
  drupal_goto($url);
}

?>
