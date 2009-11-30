<?php
// $Id$

require_once (dirname(__FILE__)."/../isedoc.lib.inc");

/**
 * Admin settings callback.
 */
function isedoc_eis_admin_settings() {

	$form['isedoc_eis'] = array(
		'#type' => 'fieldset',
		'#title' => t('EIS mapping Settings')
	);

	$form['isedoc_eis']['isedoc_eis_default'] = array(
		'#type' => 'textfield',
		'#title' => t('Default page'),
		'#default_value' => variable_get('isedoc_eis_default', ''),
		'#description' => t('Default mapping (can be empty), %link', array('%link' => 'admin/content/isedoc_eis')),
		'#required' => TRUE,
	);

	return system_settings_form($form);
}

function isedoc_eis_settings_submit($form, &$form_state) {
	drupal_set_message(t("Processed isedoc_eis_settings_submit ..."),'status');
}
function isedoc_eis_admin_settings_goto_eis($form, &$form_state) {
	drupal_goto('admin/content/isedoc_eis');
}

/**
 * Menu: admin/content/isedoc_eis
 */
function isedoc_eis_form() {
	$form = array();

	$eis_default = variable_get('isedoc_eis_default', '');

	return $form;
}

function isedoc_eis_edit_form() {
	$form = array();

	$eis_default = variable_get('isedoc_eis_default', '');

	return $form;
}

function theme_isedoc_eis_form($form) {
	return drupal_render($form);
}

?>
