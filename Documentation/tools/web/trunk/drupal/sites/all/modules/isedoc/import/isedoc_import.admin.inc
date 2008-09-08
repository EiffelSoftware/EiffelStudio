<?php
// $Id$

/**
 * Admin settings callback.
 */
function isedoc_import_admin_settings() {

	$form['isedoc_import'] = array(
		'#type' => 'fieldset',
		'#title' => t('Import Documentation Settings')
	);

	$form['isedoc_import']['isedoc_import_subfolder'] = array(
		'#type' => 'textfield',
		'#title' => t('Import subFolder'),
		'#default_value' => variable_get('isedoc_import_subfolder', '/isedoc/import'),
		'#description' => t('Subdirectory in directory "%dir" where documentation will be loaded from. Do not include trailing slash.<br/>To import content, %link', array('%dir' => file_directory_path(), '%link' => 'admin/content/isedoc_import')),
		'#required' => TRUE,
	);
	$form['isedoc_import']['isedoc_import_action'] = array(
		'#type' => 'submit',
		'#submit' => array('isedoc_import_admin_settings_goto_import'),
		'#value' => t('Import Content'),
	);

	return system_settings_form($form);
}

function isedoc_import_settings_submit($form, &$form_state) {
	drupal_set_message(t("Processed isedoc_import_settings_submit ..."),'status');
}
function isedoc_import_admin_settings_goto_import($form, &$form_state) {
	drupal_goto('admin/content/isedoc_import');
}

/**
 * Callback isedoc/book/import
 */

function _isedoc_import_doc() {
	drupal_set_message("_isedoc_import_doc...");
	//	$links = array();
	//	$links[] = l('import 1', 'Isedoc/import');
	//	$links[] = l('import 2', 'Isedoc/import');
	//	return theme('list', $links);
	$form['isedoc_import'] = array(
		'#type' => 'fieldset',
		'#title' => t('Import Documentation')
	);
	$form['isedoc_import']['toto'] = array(
		'#type' => 'textfield',
		'#title' => t('toto'),
		'#default_value' => 'totofofo',
		'#description' => t('Subdir'),
	);
	return $form;
	//	return "totot";
}

/*
 * Menu: admin/content/isedoc_import
 */
function isedoc_import_form() {
	$form = array();
	//drupal_set_message("<pre>".var_dump_global('GLOBALS')."</pre>");

	$import_path = variable_get('isedoc_import_subfolder', '/isedoc/import');
	$dirpath = file_directory_path() . $import_path ;

	if (!file_check_directory($dirpath)) {
		drupal_set_message(t("You need to configure the isedoc directory on the isedoc import module's <a href='!admin-settings-isedoc_import'>settings page</a>.", array('!admin-settings-isedoc_import' => url('admin/settings/isedoc/isedoc_import'))), 'error');
		//    return $form;
	}

	/*
	 * Files
	 */
	$index_lst = file_scan_directory($dirpath, ".*\.index$", array(), 0, FALSE, 'filename');
	if (count($index_lst) > 0) {

		$all_indexes = array();
		foreach ($index_lst as $idx) {
			if (file_exists($idx->filename.".log")) {
				$all_indexes[$idx->filename] = $idx->name. " (done)";
			} else {
				$all_indexes[$idx->filename] = $idx->name;
			}
		}
		ksort(&$all_indexes);
		foreach ($all_indexes as $k_fn => $v) {
			if (!file_exists($k_fn.".log")) {
				if ($dft_index == '') { $dft_index = $k_fn; }
			}
		}
			
		$form['isedoc_import_indexes'] = array(
			'#type' => 'select',
			'#title' => t('Select a book index to import'),
			'#default_value' => variable_get('isedoc_import_idx', $dft_index),
			'#options' => $all_indexes,
			'#description' => t('The index to import.'),
		);


		/*
		 *	  Parameters 
		 */
		$all_books_titles = array();
		$all_books_titles[''] = t('<None>');
		$dft_book = '';

		$all_books = book_get_books();
		if (count($all_books) > 0) {
			$dft_book = $all_books[1]['title'];
			foreach ($all_books as $b) {
				if ($dft_book == '') { $dft_book = $b['bid']; }
				$all_books_titles[$b['bid']] = $b['title']; //. " #".$b['bid'];
			}
		}

		$form['isedoc_import_booknames'] = array(
			'#type' => 'select',
			'#title' => t('Select a book'),
			'#default_value' => variable_get('isedoc_import_bid', $dft_book),
			'#options' => $all_books_titles,
			'#description' => t('The book to receive the imported content.'),
		);

		$form['isedoc_import_bookname'] = array(
			'#type' => 'textfield',
			'#title' => t('Book name'),
			'#default_value' => variable_get('isedoc_import_bookname', 'ISE Documentation'),
			'#description' => t('Bookname'),
		);
		$form['isedoc_import_dirpath'] = array(
			'#type' => 'hidden',
			'#value' => $dirpath,
		);

		$form['buttons']['submit'] = array(
			'#type' => 'submit',
			'#submit' => array('isedoc_import_form_import'),
			'#value' => t('Import'),
		);
	}
	else {
		$form['isedoc_import_indexes'] = array(
			'#type' => 'item',
			'#value' => t('No book index file found (.*\\.index$)'),
		);

		$form['isedoc_import_subfolder'] = array(
			'#type' => 'textfield',
			'#title' => t('Import path'),
			'#default_value' => $import_path,
			'#description' => t('Import path'),
		);
		$form['isedoc_import_update_action'] = array(
			'#type' => 'submit',
			'#submit' => array('isedoc_import_form_update'),
			'#value' => t('Update'),
		);
	}

	return $form;
}

function theme_isedoc_import_form($form) {
	return drupal_render($form);
}


function isedoc_import_form_update($form, &$form_state) {
	drupal_set_message(t('Update processing... "@bookname"', array('@bookname' => $form_state['values']['isedoc_import_bookname'])));
	variable_set('isedoc_import_subfolder',$form_state['values']['isedoc_import_subfolder']);
}

function isedoc_import_form_import($form, &$form_state) {
	$bookid = $form_state['values']['isedoc_import_booknames'];
	if (isset($form_state['values']['isedoc_import_subfolder'])) {
		variable_set('isedoc_import_subfolder',$form_state['values']['isedoc_import_subfolder']);
	}
	variable_set('isedoc_import_bid',$bookid);
	variable_set('isedoc_import_bookname',$form_state['values']['isedoc_import_bookname']);
	$op = isset($form_state['values']['op']) ? $form_state['values']['op'] : '';
	if ($op == t('Import')) {
		$dirpath = $form_state['values']['isedoc_import_dirpath'];
		if (file_check_directory($dirpath)) {
			$nodes = array();
			$files = array();
//			drupal_set_message(var_dump_r($form_state['values']));
			$book_index_path = $form_state['values']['isedoc_import_indexes'];
			//drupal_set_message(t("Importing files using index %i into bookid=%bookid", array ('%i' => $book_index_path, '%bookid' => $bookid)));

			// a slow machine
			if (!ini_get('safe_mode')) { set_time_limit(0); }

			drupal_set_message(t("Importing files using index=<strong>$book_index_path</strong> into bookid=<strong>$bookid</strong>"),'status');
			$nodes_count = isedoc_import_with_index($dirpath,$book_index_path,$bookid);

			// report back on our progress
			if ($nodes_count > 0) {
				drupal_set_message(t("Successfully imported: %nb nodes from $book_index_path", array ('%nb' => $nodes_count)));
			}
			else {
				drupal_set_message(t('No files were imported.'));
			}
		}
	}
}

function isedoc_create_doc_outline_from($nid,&$info) {

	$node =& node_load ($nid, NULL, TRUE);

        book_nodeapi(&$node, "prepare", NULL, NULL);
        $node->book['bid'] = $info['book_id'];
        book_nodeapi(&$node, "insert", NULL, NULL);

        $node->book['plid'] = $info['parent_mlid'];
        book_nodeapi(&$node, "update", NULL, NULL);

	//drupal_set_message(var_dump_r($node));

	if (isset($info['index'])) {
		if ($info['index'] != 0) {
			$node->book['weight'] = $info['index'];
		}
	}
	node_save(&$node);
	$mlid = $node->book['mlid'];
	return $mlid;

}

function isedoc_create_doc_node_from(&$info) {
	global $user;

//	if (!user_access('create isedoc')) {
//		drupal_access_denied();
//	}

	// Ensure it's a valid image.
	if (!$info) {
		return FALSE;
	}

	// Make sure we can copy the file into our temp directory.
	$original_path = $filepath;

	// Build the node.
	if (isset($info['nid'])) {
		$nid = 0;
	} else {
		$nid = 0;
	}
	if ($nid > 0) {
		//drupal_set_message("isedoc_create_node_from using nid=$nid");
		$node = node_load ($nid, NULL, TRUE);
	}
	if (!$node) {
		$node = new stdClass();
		$node->type = 'doc';
	}
	$node->uid = $user->uid;
	$node->name = $user->name;
	$node->title = $info['title'];
	$node->body = $info['body'];


	// Set the node's defaults... (copied this from node and comment.module)
	$node_options = variable_get('node_options_'. $node->type, array('status', 'promote'));
	$node->status = in_array('status', $node_options);
	$node->promote = in_array('promote', $node_options);

/* Comment is not handled for importation! FIXME
	if (module_exists('comment')) {
		$node->comment = variable_get("comment_$node->type", COMMENT_NODE_READ_WRITE);
	}
*/
	if (module_exists('taxonomy') and !empty($info['tags']) ) {
		isedoc_set_tags (&$node, $info['tags']);
	}
	if ($nid > 0) {
		$node->revision = TRUE;
	} else {
		$node->revision = FALSE;
	}

	// Save the node.
	$node = node_submit($node);
	node_save(&$node);

	return $node;
}

function isedoc_set_tags (&$node, $tags) {
	$l_vocs = array_shift(taxonomy_get_vocabularies($node->type));
	$l_vid = $l_vocs->vid;

	//drupal_set_message("tags -> ".$tags, 'status');
	//drupal_set_message("vocs [$l_vid] -> ".var_dump_r ($l_vocs), 'status');
	$o = taxonomy_nodeapi($node, 'load');
	$taxonomy = $o['taxonomy'];
	// For now, we deal only new node, so there is no tag at this point
	// and $taxonomy is thus an empty array

	$lst_tags = explode(',', $tags);
	foreach ($lst_tags as $l_tag) {
		$t = isedoc_tag_object ($l_vid, trim($l_tag));
		if ($t) {
		  $taxonomy[$t->tid] = $t;
		}
	}
	$node->taxonomy = $taxonomy;
}

function isedoc_tag_object ($a_vid, $a_tag) {
  //drupal_set_message("isedoc_tag_object [$a_vid] tag[$a_tag]", 'status');
  $result = isedoc_fetch_tag_object ($a_vid, $a_tag);
  if ($result) {
    return $result;
  } else {
    $t = array(
	'vid' => $a_vid,
	'name' => $a_tag,
      );
    taxonomy_save_term(&$t);
    return isedoc_fetch_tag_object ($a_vid, $a_tag);
  }
}

function isedoc_fetch_tag_object ($a_vid, $a_tag) {
  //drupal_set_message("isedoc_fetch_tag_object [$a_vid] tag[$a_tag]", 'status');
  $db_result = db_query(db_rewrite_sql("SELECT t.tid, t.* FROM {term_data} t WHERE t.vid = '%s' AND LOWER(t.name) = LOWER('%s')", 't', 'tid'), $a_vid, trim($a_tag));
  return db_fetch_object($db_result);
}


/**
 * Helpers
 */

function isedoc_import_with_index($dn,$fn,$bid) {
	//drupal_set_message(t("Importing using index $fn ..."),'status');
	$logfp = fopen($fn.".log", 'w+');

	$fp = fopen($fn, 'r');
	$node_ids = array();
	$dep = 0;
	$is_reuse = 0;
	$nodes_count = 0;

	while (!feof($fp)) {
		$node = NULL;
		$line = fgets($fp);
		$line = substr($line, 0, -1);
		$i = strpos($line, "[");
		if ($i === FALSE) {
			//drupal_set_message(t("Line=$line UNABLE TO FIND [ ..."),'status');
		} else {
			if (($i > 0) and (substr($line,0,1) == "@" or substr($line, $i-1, 1) == "@")) {
				$is_reuse = 1;
			} else {
				$is_reuse = 0;
			}

			$j = strpos($line, ":", $i);
			$l_depth = substr($line, $i+1, 1 + ($j-1) -($i+1) );

			$i = strpos($line, ":", $j+1);
			$l_base_id = substr($line, $j+1, 1 + ($i-1) -($j+1) );

			$j = strpos($line, "]", $i+1);
			$l_index = substr($line, $i+1, 1 + ($j-1) - ($i+1));

			$l_title = substr($line, $j+2);


			$line = fgets($fp);
			$line = substr($line, 0, -1);

//drupal_set_message(t("Line=$line is_reuse=$is_reuse ..."),'status');
			$i = strpos($line, "!src=");
			if ($i > 0) {
				$l_ref_src = substr($line, $i+5);
				$l_src = $dn . "/". $l_ref_src . ".wiki";

				if ($is_reuse == 0 and $l_depth == 0) {
					// This is related to the book,
					// For now, no specific action 
					$node = node_load ($bid);
					$l_mlid = $node->book['mlid'];
					$node = NULL;
					$node_ids[0] = $l_mlid;
				} else {
					if ($is_reuse == 1) {
						if ($l_depth == 0) {
							$a_nid = $bid;
						} else {
							$a_nid = book_doc_page_exists($l_title);
						}
						if ($a_nid === FALSE) {
							drupal_set_message(t(" ERROR no REUSE dep=%dep \"%tit\" -> %src", array( "%dep" => $l_depth, "%tit" => $l_title, "%bas" => $l_base_id, "%src" => $l_src)),'error');
							$is_reuse = 0;
						} else {
							$node = node_load ($a_nid);
						}
						if (!$node) {
							$is_reuse = 0;
							drupal_set_message(t(" ERROR no REUSE dep=%dep \"%tit\" -> %src", array( "%dep" => $l_depth, "%tit" => $l_title, "%bas" => $l_base_id, "%src" => $l_src)),'error');
						}
					}

					if ($is_reuse) {
						$info = isedoc_file_info($l_src, FALSE);
					} else {
						$info = isedoc_file_info($l_src, TRUE);
					}
					if ($info) {
						//drupal_set_message(t(" -> [%dep:%bas] \"%tit\" -> %src", array( "%dep" => $l_depth, "%tit" => $l_title, "%bas" => $l_base_id, "%src" => $l_src)),'status');
						$info['title'] = $l_title;
						$info['src'] = $l_src;
						$info['baseid'] = $l_baseid;
						$info['depth'] = $l_depth;
						$info['index'] = $l_index;

						if ($dep >= 0) {
							$p_mlid = $node_ids[$l_depth - 1];
						} else {
							$p_mlid = $book_id;
						}
						$dep = $l_depth;
						$info['parent_mlid'] = $p_mlid;
						$info['book_id'] = $bid;
						if ($node) {
							$l_mlid = $node->book['mlid'];
							drupal_set_message(t(" REUSE %tit -> [%dep] %src -> %nid (mlid=$l_mlid)(parent=$p_mlid)", array( "%tit" => $l_title, "%dep" => $l_depth, "%src" => $l_src, "%nid" => $node->nid)),'status');

/*
*/
						} else {
							$node = isedoc_create_doc_node_from (&$info);
							$nodes_count = $nodes_count + 1;
							$l_mlid = isedoc_create_doc_outline_from ($node->nid, &$info);
							fputs($logfp, "#".$info['depth'].":".$node->nid.":".$l_mlid.":".$l_ref_src.":".$info['title']."\n");
							drupal_set_message(t("NEW -> [%dep:%idx] %src -> %nid (mlid=$l_mlid)(parent=$p_mlid)(tags=%tags)", array( "%dep" => $l_depth, "%idx" => $info['index'], "%src" => $l_ref_src, "%nid" => $node->nid, "%tags" => $info['tags'])),'status');
						}
						$node_ids[$l_depth] = $l_mlid;

						$node = NULL;
					} else {
						drupal_set_message(t("ERROR -> [%dep:%bas] \"%tit\" -> %src", array( "%dep" => $l_depth, "%tit" => $l_title, "%bas" => $l_base_id, "%src" => $l_src)),'error');
					}
				}
			}
		}
	}

	fclose ($logfp);
	fclose ($fp);
	return $nodes_count;
}

function isedoc_file_info($fn, $is_full=FALSE) {
	$l_body = '';
	$fp = fopen($fn, 'r');
	$info = array();
	$done = 0;
	while(!$done) {
		$line = fgets($fp);
		$line = substr($line, 0, -1);
		if (strpos ($line, "#") === false) {
			$done = 1;
		} else {
			$i = strpos ($line, "=");
			if ($i > 0) {
				$k = substr($line, 1, $i-1);
				$v = substr($line, $i+1);
				$info[$k] = $v;
			} else {
				$done = 1;
			}
		}
	}
	if ($is_full) {
		$l_body = fread($fp, filesize($fn));
	}
	fclose ($fp);
	$info['body'] = $l_body;
	return $info;
}

function var_dump_r(&$ref, $pre=TRUE) {
	ob_start(); var_dump($ref); $a=htmlspecialchars(ob_get_contents(),ENT_QUOTES); ob_end_clean(); 
	if ($pre) {
		return "<pre>DUMP=".$a . '</pre>';
	} else {
		return 'DUMP='.$a;
	}
}
function var_dump_global($refname) {
	global $$refname;
	ob_start(); var_dump($$refname); $a=htmlspecialchars(ob_get_contents(),ENT_QUOTES); ob_end_clean(); 
	return "DUMP[".$refname."]=".$a;
}

/**
 * Returns an array of all books.
 *
 * This list may be used for generating a list of all the books, or for building
 * the options for a form select.
 */

function book_doc_page_exists($a_title) {
	//$res = db_query("SELECT nid FROM {node} WHERE LOWER(title) = LOWER('%s') AND type IN ()", $a_title);
	//$res = db_query("SELECT nid FROM {node} WHERE LOWER(title) = LOWER('%s') AND type = 'doc' ", $a_title);
	$res = db_query("SELECT nid FROM {node} WHERE type = 'doc' AND LOWER(title) = LOWER('%s') ", $a_title);
	if ($res === FALSE) {
		return FALSE;
	} else {
		$v = db_fetch_object($res);
		return $v->nid;
	}
}

function isedoc_book_get_books() {
  static $all_books;

  if (!isset($all_books)) {
    $all_books = array();
    $result = db_query("SELECT DISTINCT(bid) FROM {book}");
    $nids = array();
    while ($book = db_fetch_array($result)) {
      $nids[] = $book['bid'];
    }
    if ($nids) {
      $result2 = db_query(db_rewrite_sql("SELECT n.type, n.title, b.*, ml.* FROM {book} b INNER JOIN {node} n on b.nid = n.nid INNER JOIN {menu_links} ml ON b.mlid = ml.mlid WHERE n.nid IN (". implode(',', $nids) .") AND n.status = 1 ORDER BY ml.weight, ml.link_title"));
      while ($link = db_fetch_array($result2)) {
        $link['href'] = $link['link_path'];
        $link['options'] = unserialize($link['options']);
        $all_books[$link['bid']] = $link;
      }
    }
  }
  return $all_books;
}
