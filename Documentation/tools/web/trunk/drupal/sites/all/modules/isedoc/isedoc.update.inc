<?php

require_once ("isedoc.lib.inc");

function isedoc_update_pages($op) {
  if (user_access('admin isedoc')) {
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
    return "Update $op: completed.";
  } else {
    drupal_access_denied();
    return "Update $op: access denied.";
  }
}


function isedoc_update_pages_of_book($a_bookid) {
	$node =& node_load(array('nid' => $a_bookid), NULL, FALSE);
	if ($node) {
		if (isset($node->book)) {
			list($l_unused, $l_book_name_id) = explode('/', $node->path);
			$l_book_short_path = "book/$l_book_name_id";
			drupal_set_message("<h3>Update book $a_bookid: $l_book_short_path</h3>");
			$tree = book_menu_subtree_data($node->book);
			isedoc_update_book_traverse(&$tree, $l_book_short_path);
		}
	}
}

function isedoc_update_book_traverse(&$a_tree, $a_book_short_path) {
	foreach($a_tree as $data) {
		$b_save = FALSE;
		$b_revision = FALSE;
		$l_log = '';
		if ($node = node_load($data['link']['nid'], FALSE)) {
			drupal_set_message("<strong>" . l($node->title, $node->path) . "</strong>");
			if (is_callable(array($node, 'field_uuid'), TRUE)) {
				$l_uuid = $node->field_uuid[0]['value'];
				if (!$l_uuid) {
					$l_uuid = isedoc_uuid();	
					$l_log .= "(new uuid=$l_uuid)";
					//drupal_set_message($node->title . ": New uuid=$l_uuid");
					$node->field_uuid[0]['value'] = $l_uuid;;
					$b_save = TRUE;
					//$b_revision = TRUE;
				}
			}
			if (module_exists('pathauto')) {
				if (strncasecmp($a_book_short_path, $node->path, strlen(a_book_short_path)) != 0) {
					//drupal_set_message($node->title . ": Update url alias");
					$l_log .= "(update url alias)";
					$b_save = TRUE;
				}
			}
			if ($b_save) {
				$node->revision = $b_revision;
				node_save(&$node);
				drupal_set_message("Saved: " . l($node->title,$node->path). " <em>log=$l_log</em>");
			}
		}
		if ($data['below']) {
			isedoc_update_book_traverse(&$data['below'], $a_book_short_path);
		}
	}
}

?>
