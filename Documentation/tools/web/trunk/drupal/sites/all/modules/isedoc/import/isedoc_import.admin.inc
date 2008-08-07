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
	//	$links[] = l('import 1', 'іsedoc/import');
	//	$links[] = l('import 2', 'іsedoc/import');
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

	$files = file_scan_directory($dirpath, '.*', array('.', '..'), 0, TRUE); //FALSE); //TRUE, 'filename');
	ksort($files);
	if ($files) {
		$fields = array('filesize', 'title', 'parent', 'titleexists','nodeid');
		foreach ($fields as $field) {
			$form['files'][$field][0] = NULL;
		}
		$filelist = array(0 => NULL);

		foreach ($files as $file) {
			$info = isedoc_file_info($file->filename, FALSE);
			$filelist[] = substr($file->filename, strlen($dirpath) + 1);
			$form['files']['filesize'][] = array(
				'#type' => 'item',
				'#value' => format_size(filesize($file->filename)),
			);
			$form['files']['title'][] = array(
				'#type' => 'textfield',
				'#size' => 20,
				'#default_value' => $info['title'],
			);
			$form['files']['parent'][] = array(
				'#type' => 'textfield',
				'#size' => 20,
				'#default_value' => $info['parent'],
			);

			$a_nid = book_doc_page_exists($info['title']);
			if ($a_nid != '') {
				$form['files']['titleexists'][] = array(
					'#type' => 'checkbox',
					'#title' => l('#' . $a_nid . '?', 'node/'.$a_nid ),
					'#default_value' => TRUE,
				);
				$form['files']['nodeid'][] = array(
					'#type' => 'hidden',
					'#value' => $a_nid,
				);
//				$form['files']['titleexists'][] = array(
//					'#type' => 'markup',
//					'#value' => l('#' . $a_nid . '?', 'node/'.$a_nid ),
//				);
			} else {
				$form['files']['titleexists'][] = array(
					'#type' => 'item',
					'#value' => '',
				);
				$form['files']['nodeid'][] = array(
					'#type' => 'hidden',
					'#value' => '0',
				);
			}
//			$form['files']['titleexists'][] = array(
//				'#type' => 'checkbox',
//				'#title' => t('Already exists'),
//				'#default_value' => book_doc_page_exists($info['title']),
//			);

		}
		unset($filelist[0]);
		foreach ($fields as $field) {
			$form['files'][$field][0] = NULL;
		}
		// Put the titles into an array.
		$form['files']['title']['#tree'] = TRUE;
		$form['files']['parent']['#tree'] = TRUE;
		$form['files']['titleexists']['#tree'] = TRUE;
		$form['files']['nodeid']['#tree'] = TRUE;

		// Store a copy of the list into a form value so we can compare it to what
		// they submit and not have to worry about files being added or removed from
		// the filesystem.
		$form['file_list'] = array(
			'#type' => 'value',
			'#value' => $filelist,
		);

		$form['import_file'] = array(
			'#type' => 'checkboxes',
			'#options' => $filelist,
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
		$form['import_file'] = array(
			'#type' => 'item',
			'#value' => t('No files were found'),
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


//	$form['isedoc_import_action'] = array(
//		'#type' => 'submit',
//		'#submit' => array('isedoc_import_form_import'),
//		'#value' => t('Import Documentation'),
//	);

	return $form;
}

function theme_isedoc_import_form($form) {
	//	drupal_set_message("theme_isedoc_import_form...");

	$output = '';
	if (isset($form['import_file'])) {
		$f_import_files = &$form['import_file'];
		if ($f_import_files['#type'] == 'checkboxes') {
			$header = array(theme('table_select_header_cell'), t('Name'), t('Size'), t('Title'), t('Parent'), t('Note'));
			$rows = array();
			foreach (element_children($f_import_files) as $key) {
				$filename = $f_import_files[$key]['#title'];
				unset($f_import_files[$key]['#title']);
				$rows[] = array(
					drupal_render($f_import_files[$key]),
					$filename,
					drupal_render($form['files']['filesize'][$key]),
					drupal_render($form['files']['title'][$key]),
					drupal_render($form['files']['parent'][$key]),
					drupal_render($form['files']['titleexists'][$key]),
					drupal_render($form['files']['nodeid'][$key]),
				);
			}
			$output .= theme('table', $header, $rows);
		}
		unset($f_import_files);
	}
	return $output . drupal_render($form);
}


function isedoc_import_form_update($form, &$form_state) {
	drupal_set_message(t('Update processing... "@bookname"', array('@bookname' => $form_state['values']['isedoc_import_bookname'])));
	variable_set('isedoc_import_subfolder',$form_state['values']['isedoc_import_subfolder']);
}

function isedoc_import_form_import($form, &$form_state) {
	$bookid = $form_state['values']['isedoc_import_booknames'];
	drupal_set_message(t('Import processing... "bookid:@bookname"', array('@bookname' => $bookid)));
	if (isset($form_state['values']['isedoc_import_subfolder'])) {
		variable_set('isedoc_import_subfolder',$form_state['values']['isedoc_import_subfolder']);
	}
	variable_set('isedoc_import_bid',$form_state['values']['isedoc_import_booknames']);
	variable_set('isedoc_import_bookname',$form_state['values']['isedoc_import_bookname']);
	$op = isset($form_state['values']['op']) ? $form_state['values']['op'] : '';
	if ($op == t('Import')) {
		$dirpath = $form_state['values']['isedoc_import_dirpath'];
//		$dirpath = variable_get('isedoc_import_subfolder', '');
		drupal_set_message(t("Importing files from %dirpath into bookid=%bookid", array ('%dirpath' => $dirpath, '%bookid' => $bookid)));
		if (file_check_directory($dirpath)) {
			$nodes = array();
			$files = array();
//			drupal_set_message(var_dump_r($form_state['values']));
			foreach (array_filter($form_state['values']['import_file']) as $index) {
				// try to avoid php's script timeout with a bunch of large files or
				// a slow machine
				if (!ini_get('safe_mode')) {
					set_time_limit(0);
				}
				$origname = $form_state['values']['file_list'][$index];
				if ($origname != '__order__') {
					$filename = file_check_location($dirpath .'/'. $origname, $dirpath);
					if ($filename) {
						if ($form_state['values']['titleexists'][$index]) {
							$a_nid = $form_state['values']['nodeid'][$index];
						} else {
							$a_nid = '0';
						}
						if ($a_nid > 0) {
							drupal_set_message(t("Merging from %filename... (#%nid)",array('%filename' => $filename, '%nid' => $a_nid)));
						} else {
							drupal_set_message(t("Importing %filename [%title]...(#%nid)",array('%filename' => $filename, '%title' => $form_state['values']['title'][$index], '%nid' => $a_nid)));
						}
						$node = isedoc_create_node_from(
							$filename,
							$form_state['values']['title'][$index],
							$a_nid
						);
						if ($node) {
							drupal_set_message(var_dump_r($node));
							$nodes[] = t('%filename as <a href="!node-link">@node-title</a> <a href="!edit-link">[edit]</a>', array(
								'%filename' => $origname,
								'!node-link' => url('node/'. $node->nid),
								'@node-title' => $node->title,
								'!edit-link' => url('node/'. $node->nid .'/edit'),
							));
							// Remove the original image now that the import has completed.
							//file_delete($filename);
						} else {
							drupal_set_message(t('Error importing %filename.', array('%filename' => $filename)));
						}
					}
				}
			}

			// report back on our progress
			if (!empty($nodes)) {
				drupal_set_message(t('Successfully imported: ') . theme('item_list', $nodes));
			}
			else {
				drupal_set_message(t('No files were imported.'));
			}
		}
	}
}

function isedoc_create_node_from($filepath, $title = NULL, $nid=0) {
	global $user;

//	if (!user_access('create isedoc')) {
//		drupal_access_denied();
//	}

	// Ensure it's a valid image.
	$isedoc_info = isedoc_file_info($filepath,TRUE);
	if (!$isedoc_info) {
		return FALSE;
	}

	// Make sure we can copy the file into our temp directory.
	$original_path = $filepath;

	// Build the node.
	if ($nid > 0) {
		drupal_set_message("isedoc_create_node_from using nid=$nid");
		$node = node_load ($nid, NULL, TRUE);
	}
	if (!$node) {
		$node = new stdClass();
		$node->type = 'doc';
	}
	$node->uid = $user->uid;
	$node->name = $user->name;
	$node->title = isset($title) ? $title : $isedoc_info['title'];
	$node->body = $isedoc_info['body'];

	// Set the node's defaults... (copied this from node and comment.module)
	$node_options = variable_get('node_options_'. $node->type, array('status', 'promote'));
	$node->status = in_array('status', $node_options);
	$node->promote = in_array('promote', $node_options);
	if (module_exists('comment')) {
		$node->comment = variable_get("comment_$node->type", COMMENT_NODE_READ_WRITE);
	}
	if (module_exists('taxonomy')) {
		$node->taxonomy = $taxonomy;
	}

	if ($nid > 0) {
		$node->revision = TRUE;
		$node->new_file = FALSE;
	} else {
		$node->revision = FALSE;
		$node->new_file = TRUE;
	}
//	$node->images[IMAGE_ORIGINAL] = $filepath;

	// Save the node.
	$node = node_submit($node);
	node_save($node);

	return $node;
}


/**
 * Helpers
 */

function isedoc_file_info($fn, $is_full=FALSE) {
	$l_body = '';
	if (basename($fn) == '__order__') {
		$title = '#order-of-'.basename(dirname($fn));
		if (substr($title, - 6) == '.pages') {
			$title = substr($title, 0, - 6);
		}
		$parent = basename(dirname(dirname($fn)));
	} else {
		$fp = fopen($fn, 'r');
		$line = fgets($fp);
		$line = substr($line, 0, -1);
		if (substr($line, 0, 7) == '#title=') {
			$title = substr($line, 7);
		} else {
			$title = '__'.basename($fn);
		}
		if ($is_full) {
			$l_body = fread($fp, filesize($fn));
		}
		fclose ($fp);
		$parent = basename(dirname($fn));
	}
	if ((strlen($parent) > 6) and (substr($parent, - 6) == '.pages')) {
		$parent = substr($parent, 0, - 6);
	}
	$info = array();
	$info['title'] = $title;
	$info['parent'] = $parent;
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
//	$nid = db_result(db_query("SELECT nid FROM {node} WHERE LOWER(title) = LOWER('%s') AND type IN ()", $a_title));
	$nid = db_result(db_query("SELECT nid FROM {node} WHERE LOWER(title) = LOWER('%s')", $a_title));
	return $nid;
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
