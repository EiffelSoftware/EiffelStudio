<?php

require_once ("isedoc.lib.inc");

function isedoc_update_pages($op) {
  drupal_set_message("Update $op");
  $books = array();
  $all_books = book_get_books();
  switch ($op) {
    case 'all':
	foreach($all_books as $b) {
		$books[] = $b['bid'];
	}
	break;
    default:
	$bn = strtolower($op);
	foreach($all_books as $b) {
		if (strtolower($b['title']) == $bn) {
			$books[] = $b['bid'];
		}
	}
	break;
  }
  foreach($books as $bid){
	isedoc_update_pages_of_book($bid);
  }
  return "Update $op";
}


function isedoc_update_pages_of_book($a_bookid) {
	drupal_set_message("Update book $a_bookid");
	$node =& node_load(array('nid' => $a_bookid), NULL, FALSE);
	if ($node) {
		if (isset($node->book)) {
			$tree = book_menu_subtree_data($node->book);
			isedoc_update_book_traverse(&$tree);
		}
	}
}

function isedoc_update_book_traverse(&$a_tree) {
	foreach($a_tree as $data) {
		$b_save = FALSE;
		if ($node = node_load($data['link']['nid'], FALSE)) {
			//drupal_set_message(var_dump_r($node));
			if (is_callable(array($node, 'field_uuid'), TRUE)) {
				$l_uuid = $node->field_uuid[0]['value'];
				if (!$l_uuid) {
					$l_uuid = isedoc_uuid();	
					//drupal_set_message($node->title . " New uuid=$l_uuid");
					$node->field_uuid[0]['value'] = $l_uuid;;
					$b_save = TRUE;
				}
			}
			if (module_exists('pathauto')) {
				//drupal_set_message($node->title . ": " . $node->path . " - " . $node->pathauto_perform_alias . " -old- " . $node->old_alias);
				// Check pathauto_nodeapi()...
			}
			if ($b_save) {
				drupal_set_message("Save " .$node->title);
				//node_save(&$node);
			}
		}
		if ($data['below']) {
			isedoc_update_book_traverse(&$data['below']);
		}
	}
}

?>
