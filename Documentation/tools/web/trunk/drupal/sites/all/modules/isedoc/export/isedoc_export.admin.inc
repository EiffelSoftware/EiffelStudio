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
	drupal_set_message(t("Exporting book #<strong>$a_bookid</strong> to <strong>$a_dirpath</strong>."),'status');
	$book =& node_load(array('nid' => $a_book_id), NULL, FALSE);
	drupal_set_message(var_dump_r ($book),'status');
	if ($book) {
		drupal_set_message(t("Exporting book #<strong>%bookname</strong> to <strong>$a_dirpath</strong>.", 
			array('%bookname' => $book-title)),'status');
	} else {
		drupal_set_message(t("Error loading book #<strong>$a_bookid</strong>!"),'error');
		return 0;
	}

	return 0;
}

?>
