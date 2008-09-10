<?php
// $Id$

require_once (dirname(__FILE__)."/../isedoc.lib.inc");

/**
 * Admin settings callback.
 */
function isedoc_export_admin_settings() {

	$form['isedoc_export'] = array(
		'#type' => 'fieldset',
		'#title' => t('Export Documentation Settings')
	);

	$form['isedoc_export']['isedoc_export_folder'] = array(
		'#type' => 'textfield',
		'#title' => t('Import Folder'),
		'#default_value' => variable_get('isedoc_export_folder', '/isedoc/export'),
		'#description' => t('Directory "%dir" where documentation will be generated to. Do not include trailing slash.<br/>To export content, %link', array('%dir' => file_directory_path(), '%link' => 'admin/content/isedoc_export')),
		'#required' => TRUE,
	);
	$form['isedoc_export']['isedoc_export_action'] = array(
		'#type' => 'submit',
		'#submit' => array('isedoc_export_admin_settings_goto_export'),
		'#value' => t('Export Content'),
	);

	return system_settings_form($form);
}

function isedoc_export_settings_submit($form, &$form_state) {
	drupal_set_message(t("Processed isedoc_export_settings_submit ..."),'status');
}
function isedoc_export_admin_settings_goto_export($form, &$form_state) {
	drupal_goto('admin/content/isedoc_export');
}

/**
 * Menu: admin/content/isedoc_export
 */
function isedoc_export_form() {
	$form = array();

	$export_path = variable_get('isedoc_export_folder', '/isedoc/export');
	$dirpath = file_directory_path() . $export_path ;

	if (!file_check_directory($dirpath)) {
		drupal_set_message(t("You need to configure the isedoc directory on the isedoc export module's <a href='!admin-settings-isedoc_export'>settings page</a>.", array('!admin-settings-isedoc_export' => url('admin/settings/isedoc/isedoc_export'))), 'error');
		//    return $form;
	}

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
	$form['isedoc_export_booknames'] = array(
		'#type' => 'select',
		'#title' => t('Select a book'),
		'#default_value' => variable_get('isedoc_export_bid', $dft_book),
		'#options' => $all_books_titles,
		'#description' => t('The book containing the content to export.'),
	);

	$form['isedoc_export_dirpath'] = array(
		'#type' => 'hidden',
		'#value' => $dirpath,
	);

	$form['buttons']['submit'] = array(
		'#type' => 'submit',
		'#submit' => array('isedoc_export_form_export'),
		'#value' => t('Export'),
	);

	return $form;
}

function theme_isedoc_export_form($form) {
	return drupal_render($form);
}


function isedoc_export_form_export($form, &$form_state) {
	$bookid = $form_state['values']['isedoc_export_booknames'];
	if (isset($form_state['values']['isedoc_export_folder'])) {
		variable_set('isedoc_export_folder',$form_state['values']['isedoc_export_folder']);
	}
	variable_set('isedoc_export_bid',$bookid);
	$op = isset($form_state['values']['op']) ? $form_state['values']['op'] : '';
	if ($op == t('Export')) {
		$dirpath = $form_state['values']['isedoc_export_dirpath'];
		if (file_check_directory($dirpath)) {
			//drupal_set_message(var_dump_r($form_state['values']));
			if (!ini_get('safe_mode')) { set_time_limit(0); }

			$nodes_count = 0;
			$nodes_count = isedoc_export_book_to($bookid, $dirpath);

			// report back on our progress
			if ($nodes_count > 0) {
				drupal_set_message(t("Successfully exported: %nb nodes from book #$bookid", array ('%nb' => $nodes_count)));
			}
			else {
				drupal_set_message(t('No node exported.'));
			}
		}
	}
}

function isedoc_export_book_to($a_bookid, $a_dirpath) {
	global $isedoc_export_dir;
	global $isedoc_node_count;
	global $isedoc_export_r_indexes;
	$isedoc_node_count = 0;

	$node =& node_load(array('nid' => $a_bookid), NULL, FALSE);
	//drupal_set_message(var_dump_r ($node),'status');
	if ($node) {
		if (isset($node->book)) {
			$isedoc_export_dir = $a_dirpath;
			$l_bk_alias = isedoc_export_node_alias($node);
			$l_bk_dir = $isedoc_export_dir . '/' . $l_bk_alias;

			drupal_set_message(t("Exporting book #$a_bookid \"<strong>%bookname</strong>\" to <strong>$l_bk_dir</strong>.", 
				array('%bookname' => $node->title)),'status');

			if (file_check_directory($l_bk_dir)) {
				isedoc_rm_recursive($l_bk_dir);
			}
			isedoc_mkdir($l_bk_dir);

			$isedoc_export_r_indexes = array();
			$tree = book_menu_subtree_data($node->book);
			$content = isedoc_book_export_traverse($tree,'wiki');

			$l_fn = $l_bk_dir . "/book.index";
			$l_fp = fopen($l_fn, 'w');
			if ($l_fp) {
				drupal_set_message(t("Creating book index: <em>$l_fn</em>!"),'status');
				//$isedoc_export_r_indexes = array_reverse($isedoc_export_r_indexes);
				foreach($isedoc_export_r_indexes as $i) {
					fwrite($l_fp,$i);
				}
				fclose($l_fp);
			} else {
				drupal_set_message(t("Error: unable to create log file <em>$l_fn</em>!"),'error');
				//return 0;
			}
		}
	} else {
		drupal_set_message(t("Error loading book #<strong>$a_bookid</strong>!"),'error');
		return 0;
	}

	return $isedoc_node_count;
}

function isedoc_export_node_alias(&$a_node) {
	$l_id = end(split('/', $a_node->path));
	return $l_id;
}


function isedoc_book_export_traverse($tree,$type,$prefix='') {
  /* Check book_export_traverse($tree, $visit_func) modules/book/book.module, line 905 */

  global $isedoc_export_dir;
  $output = '';

  foreach ($tree as $data) {
    // Note- access checking is already performed when building the tree.
    if ($node = node_load($data['link']['nid'], FALSE)) {
      $l_alias = isedoc_export_node_alias($node);
      $l_src = $prefix . $l_alias;
      $l_prefix = $l_src . '/';
      if ($data['below']) {
        isedoc_mkdir($isedoc_export_dir . '/' . $l_src);
        $l_src = $l_prefix . 'index';
      }
      if ($type == 'wiki') {
        $output .= isedoc_export_book_node_as_wiki($node, $l_src, $l_alias);
      } else {
	// Nothing
      }
      if ($data['below']) {
        $children = isedoc_book_export_traverse($data['below'],$type,$l_prefix);
	$output .= $children;
      }
    }
  }
  return $output;
}

function isedoc_export_book_node_as_wiki($a_node,$a_src, $p_alias) {
	global $isedoc_node_count;
	global $isedoc_export_dir;
	global $isedoc_export_r_indexes;
	//drupal_set_message("<strong>book_node (a_node, $a_src, $p_alias)</strong>",'status');
	//drupal_set_message(var_dump_r ($a_node),'status');

	$l_title = $a_node->title;
	$l_depth = $a_node->book['depth'] - 1;
	$l_weight = $a_node->book['weight'];
	$l_node_id = $a_node->nid;
	$l_src = $a_src;

	$h = "[$l_depth:$p_alias:$l_weight] $l_title\n";
	$h .= " !src=$l_src\n";
	$isedoc_export_r_indexes[] = $h;

	/* Build the wiki text */
	$tw = "#title=$l_title\n";
	$taxo =& $a_node->taxonomy;
	if (count($taxo) > 0) {
		$tw .= "#tags=";
		foreach($taxo as $t) {
			$tw .= $t->name.",";
		}
		$tw = rtrim($m, ',');
		$tw .= "\n";
	}

	$fn = $isedoc_export_dir . '/' . $l_src . '.wiki';
	$m .= $h;
	//$m .= "<pre>".$a_node->body."</pre>";
	drupal_set_message($m,'status');

	$fp = fopen($fn, 'w');
	if ($fp) {
		fwrite($fp, $tw."\n");
		fclose ($fp);
	}

	$isedoc_node_count = $isedoc_node_count + 1;
}

?>
