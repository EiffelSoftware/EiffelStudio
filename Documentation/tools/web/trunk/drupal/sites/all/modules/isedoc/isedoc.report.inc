<?php

require_once ("isedoc.lib.inc");

function isedoc_report($target,$a_op='') {
  $output = '';
drupal_add_css(drupal_get_path('module', 'system') .'/system.css');
drupal_add_js('misc/collapse.js');

  $op = $a_op;
  if ($op == '') {
    $op = 'all';
  }
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
  		if (isedoc_book_title_to_book_name_id($b['title']) == $bn) {
  			$books[] = $b['bid'];
  		}
  	}
  	break;
    }
    if (count($books) > 0) {
      foreach($books as $bid){
    	$output .= isedoc_report_on_book($bid,$op);
      }
      if ($op) {
        $output .= "Report $target ($op): completed.";
      } else {
        $output .= "Report $target: completed.";
      }
      $output .= "<br/>".l(t("Report other books"), "isedoc/report/_")."<br/>";
    } else {
	$output .= "<ul>";
	$output .= "<li><strong>".l(t("Report all the books"), "isedoc/report/all")."</strong></li>";
  	foreach($all_books as $b) {
  		$bn = isedoc_book_title_to_book_name_id($b['title']);
		$output .= "<li>".l(t("Report only: ").$bn, "isedoc/report/$bn")."</li>";
  	}
	$output .= "</ul>";
    }
  } else {
    drupal_access_denied();
    $output .= "Report $target: access denied.";
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

function isedoc_report_on_book($a_bookid,$a_op) {
	$output = '';
	$node =& node_load(array('nid' => $a_bookid), NULL, FALSE);
	if ($node) {
		if (isset($node->book)) {
			list($l_unused, $l_book_name_id) = explode('/', $node->path);
			$l_book_short_path = "book/$l_book_name_id";
			$tree = book_menu_subtree_data($node->book);
			$output .= '<fieldset class="collapsible">';
			$output .= '<legend><a href="#">';
			$output .= "Report on book $a_bookid: $l_book_short_path";
			$output .= '</a></legend>';
			$output .= '<div class="fieldset-wrapper">';
			$o .= isedoc_report_on_book_traverse(&$tree, $l_book_short_path,$a_op);
			if ($o == '') {
				$o = t("Nothing special to report.");
			}
			$output .= $o;
			$output .= '</div>';
			$output .= '</fieldset>';
		}
	}
	return $output;
}

function isedoc_report_on_book_traverse(&$a_tree, $a_book_short_path, $a_op) {
	$output = '';
	foreach($a_tree as $data) {
		$o = '';
		$l_log = '';
		if ($node = node_load($data['link']['nid'], FALSE)) {
			$o .= isedoc_report_on_node(&$node,$a_book_short_path, $a_op);
		}
		$c = '';
		if ($data['below']) {
			$c = isedoc_report_on_book_traverse(&$data['below'], $a_book_short_path,$a_op);
		}
		$output .= $o.$c;
	}
	return $output;
}

function isedoc_report_on_node(&$node, $a_book_short_path, $a_op='all') {
	$output = "<strong>" . l($node->title, $node->path) . "</strong>";
	$node_bid = $node->book['bid'];
	$out = '';
	if ($a_op == 'all' or $a_op == 'uuid') {
		if (is_callable(array($node, 'field_uuid'), TRUE)) {
			$l_uuid = $node->field_uuid[0]['value'];
			if (!$l_uuid) {
				$out .= "<li>".$node->title . ": missing uuid"."</li>";
			}
		}
	}
	if ($a_op == 'all' or $a_op == 'wikilinks') {
		$pat = '/\[\[\s*([a-zA-Z0-9:_ -]+)\s*(\||\]\])/';
		$lnk_count = 0;
		preg_match_all($pat, $node->body, $matches, PREG_PATTERN_ORDER);
		if (count($matches[1]) > 0) {
			$o = '';
			foreach($matches[1] as $mk => $n_title) {
				if (strlen($n_title) > 6 and strtolower(substr($n_title,0,6)) == "image:") {
					$t = NULL;
				} else {
					$lnk_count += 1;
					$nids = isedoc_node_ids_by_title($n_title,'doc');
					if ($nids) {
						$nb = count($nids);
						if ($nb > 0 ) {
							$t = '';
							foreach($nids as $n_nid) {
								$n = node_load($n_nid);
								$tt = '';
								if ($n) {
									$bid = $n->book['bid'];
									if ($bid != $node_bid) {
										$bn = isedoc_book_name($bid);
										$tt .= " from other book <strong>".l($bn,"node/$bid")."</strong>";
									} elseif ($nb > 1) {
										$tt .= " same book";
									}
									if (defined('STATUS_TRASH') and $n->status == STATUS_TRASH) {
										$tt .= ' <span class="error">TRASHED</span>';
									}
								} else {
									$tt .= " unable to load";
								}
								if ($tt != '') {
									$tt = l("node/$n_nid", "node/$n_nid") . ": $tt";
									if ($nb > 1) {
										$tt = "<li>$tt</li>";
									}
									$t .= $tt;
								}
							}
							if ($t == '') {
								//$t = "$n_title: <strong>$nb page(s)</strong>";
							} else {
								if ($nb > 1) {	
									$t = "$n_title: <strong>$nb page(s)</strong><ul>$t</ul>";
								} else {
									$t = "$n_title: $t";
								}
							}
						}
					} else {
						$t = "$n_title: <strong>missing node</strong>";
					}
				}
				if ($t != '') {
					$o .= "<li>$t</li>";
				}
			}
		}
		if ($o != '') {
			$out .= $o;
		}
	}

	if ($lnk_count === FALSE) {
	} else {
		$output .= " <em>($lnk_count link";
		if ($lnk_count > 1) {
			$output .= "s";
		}
		$output .= ")</em>";
	}
	if ($out == '') {
		$output = '';
	} else {
		$output .= "<ul style=\"margin: 0 0 5px 0; border-bottom: dotted 1px #ccc;\">$out</ul>\n";
	}
	return $output;
}

?>
