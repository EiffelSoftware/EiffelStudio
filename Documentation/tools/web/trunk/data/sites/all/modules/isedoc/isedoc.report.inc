<?php

require_once ("isedoc.lib.inc");

function _isedoc_images_by_nid($a_type='doc') {
	$results = array();

	$l_body_filter = 'REGEXP \'[[.[.]][[.[.]]Image:[a-z0-9:_ -]*([[.|.]]|[[.].]][[.].]])\' ';
        $sql = "SELECT n.nid, n.title FROM {node} n INNER JOIN {node_revisions} r ON n.nid = r.nid AND n.vid = r.vid WHERE n.type = '$a_type' AND LOWER(r.body) $l_body_filter ";
	$sql .= " ORDER BY n.nid, n.vid ";

	$pat = '/\[\[Image:([a-zA-Z0-9:_ -]+)(\||\]\])/';
        $res = db_query($sql);
	while ($r = db_fetch_array($res)) {
		$nid = $r['nid'];
		$n = node_load($nid);
		if ($n) {
			$n_bid = $n->book['bid'];
			preg_match_all($pat, $n->body, $matches, PREG_PATTERN_ORDER);
			if (count($matches[1]) > 0) {
				foreach($matches[1] as $mk => $i_title) {
					$t = strtolower($i_title);
					//if (!isset($results[$t])) { $results[$t]= array(); }
					$results[$t][$nid] = $n_bid;
				}
			}
		} else {
			drupal_set_message("Can not load node #$nid");
		}
	}

	//drupal_set_message("results=".var_dump_r($results));
	return $results;
}

function isedoc_gallery_taxonomy($vid,$a_tid,$a_name) {
	//drupal_set_message("isedoc_gallery_taxonomy($vid,$a_name) .. ");

	$n = strtolower($a_name);
	$sqlres = db_query("SELECT tid,vid,name,description,weight FROM {term_data} WHERE vid = '%s' AND LOWER(name) = LOWER('%s')", $vid, $n);
	if ($sqlres) {
		$res = db_fetch_object($sqlres);
	}
	if ($res) {
		//drupal_set_message("isedoc_gallery_taxonomy($vid,$a_name) -> tid=".$res->tid . " name=".$res->name);
		return $res;
	} else {
//		$sql = "SELECT tid FROM {term_data} WHERE vid = '%s' AND LOWER(name) = LOWER('%s') ";
//		$tid = db_result (db_query($sql, $vid, 'documentation'));
//		$parents = taxonomy_get_parents ($tid);
//		if ($parents) {
//		    $parent = array_shift ($parents);
//		    $parent = $parent->tid;
//		} else {
//		    $parent = 0;
//		}
		$parent = $a_tid;
		$t = array('parent' => array($parent), 'vid' => $vid, 'name' => $n, "description" => "Images for book $a_name");
		$st = taxonomy_save_term(&$t);
//drupal_set_message("taxonomy_save_term($vid, $a_name) -> $st");
		return isedoc_gallery_taxonomy($vid,$a_tid,$a_name);
	}
}
function isedoc_gallery_set_taxonomy(&$node,$vid,$a_tid,$a_name) {
	//drupal_set_message("isedoc_gallery_set_taxonomy($vid,$a_name)");

	$taxo = isedoc_gallery_taxonomy($vid,$a_tid,$a_name);
	taxonomy_node_delete($node->nid);
	$taxonomy = taxonomy_node_get_terms($node->nid);
	$taxonomy[$taxo->tid] = $taxo;
	$node->taxonomy = $taxonomy;
	taxonomy_node_save($node->nid, $node->taxonomy);
}

function isedoc_report($a_type='doc',$target, $a_op='') {
	drupal_add_css(drupal_get_path('module', 'system') .'/system.css');
	drupal_add_js('misc/collapse.js');
	$output = '';
	if (user_access('admin isedoc') or user_access('query isedoc')) {
		switch ($a_type) {
		case 'gallery':
			$output .= "Gallery $target";

			/* Build the images usage by nid */
			$cat = _isedoc_images_by_nid();

			//$galleries = taxonomy_get_tree(_image_gallery_get_vid(), $tid, -1, 3);
			$vid = db_result (db_query ("SELECT vid FROM {vocabulary} WHERE module='image_gallery'"));
			$tid = db_result (db_query("SELECT tid FROM {term_data} WHERE vid = '%s' AND LOWER(name) = LOWER('%s')", $vid, $target));
			if ($tid) {
				$sql = "SELECT n.nid, n.title FROM {node} n ";
				$sql .= "INNER JOIN {term_node} t ON t.tid = '%s' ";
				$sql .= "INNER JOIN {node_revisions} r ON r.nid = t.nid AND r.vid = t.vid ";
				$sql .= "WHERE n.nid = t.nid AND n.vid = r.vid ";
				$sql .= "ORDER BY t.nid, t.vid ";
				$res = db_query($sql, $tid);

				if ($res) {
					$output .= "<ol>";
					while ($v = db_fetch_array($res)) {
						$b_save = FALSE;

						$v_nid = $v['nid'];
						$v_title = strtolower($v['title']);
						$v_node = node_load($v_nid);
						//drupal_set_message("image $v_title: " .var_dump_r($v_node));

						//Too slow: $refs = isedoc_pages_referencing_image($v_title);
						if (isset($cat[$v_title])) {
							$refs =& $cat[$v_title];
							$nb = count($refs);
							//$refs = array_unique($refs);
						} else {
							$nb = 0;
							$refs = NULL;
						}
						//drupal_set_message("img=$v_title -> ". count($refs));

						$output .= "<li>";
						$output .= $v_title;
						$output .= " " . l("view", "node/".$v_nid);
						//$output .= ": $nb";
						if ($refs) {
							$bids = array();
							foreach($refs as $r_nid => $r_bid) {
								$bids[$r_bid][] = $r_nid;
							}
							switch (count($bids)) {
							case 0:
								$output .= ":<strong> UNUSED</strong>";
								isedoc_gallery_set_taxonomy(&$v_node, $vid, $tid, "unused");
								$b_save = TRUE;
								break;
							case 1:
								end($bids);
								$r_bid = key($bids);
								$r_nids = current($bids);
								$r_bn = isedoc_book_name($r_bid);
								$output .= ": only from book '".l($r_bn, "node/$r_bid")."' (count=".count($r_nids).")";

								isedoc_gallery_set_taxonomy(&$v_node, $vid, $tid, "book-$r_bn");
								$b_save = TRUE;

								break;
							default:
								$output .= ":<strong class=\"error\"> from ".count($bids)." books (CHECK)</strong>";
								$output .= "<ul style=\"margin: 0 0 4px 0;\">";
								foreach($bids as $r_bid => $nids) {
									$output .= "<li>book ".l(isedoc_book_name($r_bid),"node/$r_bid")." (count=".count($nids).")</li>";
									/*
									$output .= "<ul style=\"margin: 0 0 4px 0;\">";
									foreach($nids as $r_nid) {
										$output .= "<li>";
										$output .= l("node/$r_nid", "node/$r_nid");
										$output .= " from ".$r_bid;
										$output .= "</li>";
									}
									$output .= "</ul>";
									*/
								}
								$output .= "</ul>";

								break;
							}
						} else {
							$output .= ":<strong> UNUSED</strong>";
							isedoc_gallery_set_taxonomy(&$v_node, $vid, $tid, "unused");
							$b_save = TRUE;
						}
						$output .= "</li>";
						if ($b_save) {
							//$node->revision = FALSE;
							node_save(&$v_node);
							//drupal_set_message("Saved: " . l($v_node->title,$v_node->path));
						}
					}
					$output .= "</ol>";
				}
			}
			break;
		case 'doc':
			$op = $a_op;
			if ($op == '') {
				$op = 'all';
			}
			$books = array ();
			$all_books = book_get_books ();
			switch ($target) {
			case 'all':
				foreach ($all_books as $b) {
					$books[] = $b['bid'];
				}
				break;
			default:
				$bn = strtolower ($target);
				foreach ($all_books as $b) {
					if (isedoc_book_title_to_book_name_id ($b['title']) == $bn) {
						$books[] = $b['bid'];
					}
				}
				break;
			}

			if (count ($books) > 0) {
				foreach ($books as $bid) {
					$output .= isedoc_report_on_book ($bid, $op);
				}
				if ($op) {
					$output .= "Report $target ($op): completed.";
				} else {
					$output .= "Report $target: completed.";
				}
				$output .= "<br/>".l (t ("Report other books"), "isedoc/report/$a_type/_")."<br/>";
			} else {
				$output .= "<ul>";
				$output .= "<li><strong>".l (t ("Report all the books"), "isedoc/report/$a_type/all")."</strong></li>";
				foreach ($all_books as $b) {
					$bn = isedoc_book_title_to_book_name_id ($b['title']);
					$output .= "<li>".l (t ("Report only: ").$bn, "isedoc/report/$a_type/$bn")."</li>";
				}
				$output .= "</ul>";
			}
			break;
		default:
			break;
		}
	} else {
		//drupal_access_denied();
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
