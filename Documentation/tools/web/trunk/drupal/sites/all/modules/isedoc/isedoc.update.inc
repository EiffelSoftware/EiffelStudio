<?php

require_once ("isedoc.lib.inc");

function isedoc_update_pages($target,$op) {
  $output = '';
  if (user_access('admin isedoc')) {
    $books = array();
    $all_books = book_get_books();
    switch ($target) {
      case 'all':
  	foreach($all_books as $b) {
  		$books[] = $b['bid'];
  	}
  	break;
      default:
  	$bn = strtolower($target);
  	foreach($all_books as $b) {
		//drupal_set_message(var_dump_r($b));
  		if (isedoc_book_title_to_book_name_id($b['title']) == $bn) {
  			$books[] = $b['bid'];
  		}
  	}
  	break;
    }
    if (count($books) > 0) {
      foreach($books as $bid){
    	isedoc_update_pages_of_book($bid,$op);
      }
      if ($op) {
        $output .= "Update $target ($op): completed.";
      } else {
        $output .= "Update $target: completed.";
      }
      $output .= "<br/>".l(t("Update other books"), "isedoc/update/_")."<br/>";
    } else {
	$output .= "<ul>";
	$output .= "<li><strong>".l(t("Update all the books"), "isedoc/update/all")."</strong></li>";
  	foreach($all_books as $b) {
  		$bn = isedoc_book_title_to_book_name_id($b['title']);
		$output .= "<li>".l(t("Update only: ").$bn, "isedoc/update/$bn")."</li>";
  	}
	$output .= "</ul>";
    }
  } else {
    drupal_access_denied();
    $output .= "Update $target: access denied.";
  }
  return $output;
}

function isedoc_book_title_to_book_name_id($a_title) {
	if (module_exists('pathauto')) {
		module_load_include('inc', 'pathauto', 'pathauto');
		$l_url = pathauto_cleanstring($a_title);
	} else {
		$l_url = $a_title;
	}
	return strtolower($l_url);
}

function isedoc_update_pages_of_book($a_bookid,$a_op) {
	$node =& node_load(array('nid' => $a_bookid), NULL, FALSE);
	if ($node) {
		if (isset($node->book)) {
			list($l_unused, $l_book_name_id) = explode('/', $node->path);
			$l_book_short_path = "book/$l_book_name_id";
			drupal_set_message("<h3>Update book $a_bookid: $l_book_short_path</h3>");
			$tree = book_menu_subtree_data($node->book);
			isedoc_update_book_traverse(&$tree, $l_book_short_path,$a_op);
		}
	}
}

function isedoc_update_book_traverse(&$a_tree, $a_book_short_path, $a_op='all') {
	foreach($a_tree as $data) {
		$b_save = FALSE;
		$b_revision = FALSE;
		$l_log = '';
		if ($node = node_load($data['link']['nid'], FALSE)) {
			drupal_set_message("<strong>" . l($node->title, $node->path) . "</strong>");
			if ($a_op == 'all' or $a_op == 'uuid') {
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
			}
			if ($a_op == 'all' or $a_op == 'alias') {
				if (module_exists('pathauto')) {
					//drupal_set_message("cmp=".strncasecmp($a_book_short_path, $node->path, strlen($a_book_short_path) ));
					if (strncasecmp($a_book_short_path, $node->path, strlen($a_book_short_path) - 1) != 0) {
						drupal_set_message($a_book_short_path . " node=" .$node->path . ": Update url alias");
						$l_log .= "(update url alias)";
						$b_save = TRUE;
					}
				}
			}
			if ($a_op == 'templateseealso') {
				$pat = "/{{\s*seealso\s*\|[' ]*see also[': ]*/i";
				$txt = preg_replace($pat, '{{seealso|',$node->body);
				if (strlen($txt) < strlen($node->body)) {
					drupal_set_message($a_book_short_path . " node=" .$node->path . ": Clean template SeeAlso usage");
					$node->body = $txt;
					$b_save = TRUE;
					$b_revision = TRUE;
				}
			}
			if ($a_op == 'template') {
				$pat = "/{{\s*([a-z]+)\s*\|[' ]*\\1[': ]*/i";
				$txt = preg_replace($pat, '{{${1}|',$node->body);
				if (strlen($txt) < strlen($node->body)) {
					drupal_set_message($a_book_short_path . " node=" .$node->path . ": Clean template usage");
					$node->body = $txt;
					$b_save = TRUE;
					$b_revision = TRUE;
				}
			}
			if ($b_save) {
				$node->revision = $b_revision;
				node_save(&$node);
				drupal_set_message("Saved: " . l($node->title,$node->path). " <em>log=$l_log</em>");
			}
		}
		if ($data['below']) {
			isedoc_update_book_traverse(&$data['below'], $a_book_short_path,$a_op);
		}
	}
}

?>
