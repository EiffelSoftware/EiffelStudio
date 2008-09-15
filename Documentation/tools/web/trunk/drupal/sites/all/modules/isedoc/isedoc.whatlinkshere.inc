<?php

require_once ("isedoc.lib.inc");

function isedoc_whatlinkshere($node) {
  drupal_set_title(check_plain($node->title));
  $refs = isedoc_pages_referencing($node->title);
  $output = "<br/>";
  if ($refs) {
    $output .= '<strong>The following pages reference page \''.l($node->title,$node->path).'\'?</strong><br/>';
    $output .= "<ul>";
    foreach($refs as $r_nid => $r) {
      $n =& node_load($r_nid);
      if ($n) {
        $output .= "<li>".$n->title;
        $output .= " (".l(t("view"), $n->path);
        $output .= ", ".l(t("edit"), 'node/'.$n->nid.'/edit');
        $output .= ")</li>";
      } else {
        $output .= "<li>".$r_nid.": ".$r['title']."</li>";
      }
    }
    $output .= "</ul>";
  } else {
    $output .= '<strong>It seems that no page reference page \''.l($node->title,$node->path).'\'!</strong><br/>';
  }
  return $output;
}

?>
