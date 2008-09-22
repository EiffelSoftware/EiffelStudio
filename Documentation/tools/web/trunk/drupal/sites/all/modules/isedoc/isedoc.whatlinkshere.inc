<?php

require_once ("isedoc.lib.inc");

function isedoc_whatlinkshere($node) {
  drupal_set_title(check_plain($node->title));
  $n_bn = isedoc_book_name($node->book['bid']);
  $refs = isedoc_pages_referencing($node->title);
  $output = "<br/>";
  if ($refs) {
    $output .= '<strong>'.t("The page '%tit' is referenced by the following page(s):", array('%tit' => $node->title)).'</strong>';
    $output_by_book=array();
    foreach($refs as $r_nid => $r) {
      $n =& node_load($r_nid);
      $bn = '';
      $t = '';
      if ($n) {
        $t .= "<li><em>".$n->title."</em>";
        $t .= " (".l(t("view"), $n->path);
        $t .= ", ".l(t("edit"), 'node/'.$n->nid.'/edit');
        $t .= ")";
	if (defined('STATUS_TRASH')) {
		if ($node->status == STATUS_TRASH) {
			$t .= " <strong>Trashed</strong>";
		}
	}
	$bid = $n->book['bid'];
	$bn = isedoc_book_name($bid);
        //$t .= " from book <strong>".$bn."</strong>";
        $t .= "</li>";
      } else {
        $t .= "<li>".$r_nid.": ".$r['title']."</li>";
      }
      if (!isset($output_by_book[$bn])) {
        $output_by_book[$bn] = '';
      }
      $output_by_book[$bn] .= $t;
    }
    foreach($output_by_book as $bn => $t) {
      if ($n_bn == $bn) {
        $output .= "<h3>From current book '<em>".$bn."</em>'</h3>";
      } else {
        $output .= "<h3>From book '<em>".$bn."</em>'</h3>";
      }
      $output .= "<ul>";
      $output .= $t;
      $output .= "</ul>";
    }
  } else {
    $output .= '<strong>'.t("It seems that no page references internally the page '%tit'.", array('%tit' => $node->title)).'</strong>';
  }
  return $output;
}

function isedoc_book_name ($bid) {
	static $s_book_names;
	if (!$s_book_names) {
		$s_book_names = array();
	}
	if (isset($s_book_names[$bid])) {
		$bn = $s_book_names[$bid];
	} else {
		$b =& node_load($bid);
		if ($b) {
			$bn = $b->title;
		} else {
			$bn = "Book id#$bid";
		}
		$s_book_names[$bid]=$bn;
	}
	return $bn;
}

?>
