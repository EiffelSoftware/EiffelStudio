<?php
// $Id$

/**
 * Admin settings callback.
 */
function isedoc_admin_settings() {

  $form['isedoc'] = array(
    '#type' => 'fieldset',
    '#title' => t('Documentation settings')
  );

  $form['isedoc']['isedoc_import_subfolder'] = array(
    '#type' => 'textfield',
    '#title' => t('Import folder path'),
    '#default_value' => variable_get('isedoc_import_subfolder', '/isedoc/import'),
    '#description' => t('Subdirectory in directory "%dir" where documentation will be loaded from. Do not include trailing slash.', array('%dir' => variable_get('file_directory_path', 'files'))),
  );

  $form['isedoc']['isedoc_export_folder'] = array(
    '#type' => 'textfield',
    '#title' => t('Export folder path'),
    '#default_value' => variable_get('isedoc_export_folder', '/isedoc/export'),
    '#description' => t('Subdirectory in directory "%dir" where documentation will be exported to. Do not include trailing slash.', array('%dir' => file_directory_path())),
  );

  return system_settings_form($form);
}

/**
 * Make changes to the settings before passing them off to
 * system_settings_form_submit().
 *
 * Remove deleted sizes, and use the label as indexes for new sizes.
 */
function isedoc_admin_settings_submit($form, &$form_state) {
	drupal_set_message("tototo is fgoobar");

}
