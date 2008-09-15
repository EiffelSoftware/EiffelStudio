<?php

require_once ("isedoc.lib.inc");

function isedoc_whatlinkshere($node) {
  drupal_set_title(check_plain($node->title));
  $refs = isedoc_pages_referencing($node->title);
  $output = "<br/>";
  if ($refs) {
    $output .= '<strong>'.t("The page '%tit' is referenced by the following page(s):", array('%tit' => $node->title)).'</strong>';
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
    $output .= '<strong>'.t("It seems that no page references internally the page '%tit'.", array('%tit' => $node->title)).'</strong>';
  }
  return $output;
}

?>
