<?php

require_once ("isedoc.lib.inc");

function isedoc_whatlinkshere($node) {
  drupal_set_title(check_plain($node->title));
  $output = "<br/>";

  if (defined('STATUS_TRASH')) {
    if ($node->status == STATUS_TRASH) {
      $output .= t("The page '%tit' is <strong>trashed</strong>.",array('%tit' => $node->title));
      $output .= "<br/>";
    }
  }
  switch($node->type) {
	case 'image':
		$refs = isedoc_pages_referencing_image ($node->title);
		break;
	case 'template':
		$refs = isedoc_pages_referencing_template($node->title);
		break;
	case 'doc':
	default:
		$n_bn = isedoc_book_name ($node->book['bid']);
		$refs = isedoc_pages_referencing ($node->title);
		break;
  }
  if ($refs) {
    $output .= t("The node '%tit' is <strong>referenced by the following %nb page(s)</strong>:", array('%tit' => $node->title, '%nb' => count($refs)));
    $output_by_book=array();
    foreach($refs as $r_nid => $r) {
      $n =& node_load($r_nid);
      $bn = '';
      if ($n) {
        if ($n->type == 'doc') {
	  $bid = $n->book['bid'];
	  $bn = t("book %name", array('%name' => isedoc_book_name($bid)));
        } elseif ($n->type == 'template') {
	  $bn = "Templates";
        }
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
        $t = "From current '<em>".$bn."</em>'";
      } else {
        $t = "From '<em>".$bn."</em>'";
      }
      $output .= _isedoc_display_references($t, $lst);
    }
  } else {
    $output .= '<strong>'.t("It seems that no page references internally the node '%tit'.", array('%tit' => $node->title)).'</strong>';
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
	$t .= "<em>".$n->title."</em>";
        $t .= " (".l(t("view"), $n->path);
        if (isedoc_user_can_edit()) {
          $t .= ", ".l(t("edit"), 'node/'.$n->nid.'/edit');
        }
        $t .= ")";
        //$t .= " status=".$n->status;
        //$t .= " version=".$n->vid;
	if (defined('STATUS_TRASH') and $n->status == STATUS_TRASH) {
		$t = "<strike>$t <strong>Trashed</strong></strike>";
	}
	$output .= "<li>$t</li>\n";
      }
      $output .= "</ul>";
      return $output;
}


?>
