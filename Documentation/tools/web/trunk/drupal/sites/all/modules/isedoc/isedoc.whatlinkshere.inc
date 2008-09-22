<?php

require_once ("isedoc.lib.inc");

function isedoc_whatlinkshere($node) {
  drupal_set_title(check_plain($node->title));
  $n_bn = isedoc_book_name($node->book['bid']);
  $refs = isedoc_pages_referencing($node->title);
  $output = "<br/>";
  if ($refs) {
    $output .= '<strong>'.t("The page '%tit' is referenced by the following %nb page(s):", array('%tit' => $node->title, '%nb' => count($refs))).'</strong>';
    $output_by_book=array();
    foreach($refs as $r_nid => $r) {
      $n =& node_load($r_nid);
      $bn = '';
      if ($n) {
	$bid = $n->book['bid'];
	$bn = isedoc_book_name($bid);
      } else {
        drupal_set_message(t("Unable to find info about '%tit' (node #%nid)", array('%nid' => $r_nid, '%tit' => $r['title'])),'error');
      }
      if (!isset($output_by_book[$bn])) {
        $output_by_book[$bn] = array();
      }
      $output_by_book[$bn][$n->nid] = $n;
    }
    foreach($output_by_book as $bn => $lst) {
      if ($bn == $n_bn) {
        $t = "From current book '<em>".$bn."</em>'";
      } else {
        $t = "From book '<em>".$bn."</em>'";
      }
      $output .= _isedoc_display_references($t, $lst);
    }
  } else {
    $output .= '<strong>'.t("It seems that no page references internally the page '%tit'.", array('%tit' => $node->title)).'</strong>';
  }
  $pnid = isedoc_book_parent_of($node->nid);
  if ($pnid) {
      $n =& node_load($pnid);
      if ($n) {
	$bid = $n->book['bid'];
	$bn = isedoc_book_name($bid);
        $output .= _isedoc_display_references("Parent page (from $bn):", array($n->nid => $n));
      }
  }
  return $output;
}
function _isedoc_display_references($tit, $lst) {
      $output = "<h3>$tit</h3>";
      $output .= "<ul>";
      
      foreach($lst as $n) {
        $t = '';
        $t .= "<li><em>".$n->title."</em>";
        $t .= " (".l(t("view"), $n->path);
        $t .= ", ".l(t("edit"), 'node/'.$n->nid.'/edit');
        $t .= ")";
	if (defined('STATUS_TRASH')) {
		if ($node->status == STATUS_TRASH) {
			$t .= " <strong>Trashed</strong>";
		}
	}
        $t .= "</li>\n";
	$output .= $t;
      }
      $output .= "</ul>";
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
