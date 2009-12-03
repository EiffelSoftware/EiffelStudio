<?php
// $Id$

require_once ("isedoc_eis.lib.inc");

/**
 * Admin settings callback.
 */
function isedoc_eis_admin_settings() {
	$form['isedoc_eis_admin_settings'] = array(
		'#type' => 'fieldset',
		'#title' => t('EIS mapping Settings') .' ('.l("list mappers","admin/content/isedoc_eis").')'
	);

	$form['isedoc_eis_admin_settings']['f_isedoc_eis_default_uuid'] = array(
		'#type' => 'textfield',
		'#title' => t('Default UUID'),
		'#default_value' => variable_get('isedoc_eis_default_uuid', ''),
		'#description' => t('Default mapping\'s uuid (can be empty)'),
		'#required' => FALSE,
	);
	$form['isedoc_eis_admin_settings']['f_isedoc_eis_default_name'] = array(
		'#type' => 'textfield',
		'#title' => t('Default Name'),
		'#default_value' => variable_get('isedoc_eis_default_name', ''),
		'#description' => t('Default mapping\'s name (can be empty)'),
		'#required' => FALSE,
	);
	$form['#submit'][] = 'isedoc_eis_admin_settings_submit';
	//$form['#validate'][] = 'isedoc_eis_admin_settings_validate';

	return system_settings_form($form);
}


function isedoc_eis_admin_settings_validate($form, &$form_state) {
	//drupal_set_message(t("Processed isedoc_eis_admin_settings_validate ..."),'status');
//drupal_set_message(textvar_dump_r($form));
	$l_uuid = $form_state['values']['f_isedoc_eis_default_uuid'];
	$l_name = $form_state['values']['f_isedoc_eis_default_name'];
	if (strlen($l_uuid) > 34) {
		$l_ids = isedoc_node_ids_by_uuid($l_uuid);
		if ($l_ids === FALSE or count($l_ids) == 0) {
			form_set_error('f_isedoc_eis_default_uuid', t('Invalid UUID [%uuid]',array('%uuid' => $l_uuid)));
		} else {
			$l_id = array_shift($l_ids);
			$n = node_load($l_id);
			$l_name = $n->title;
			form_set_value($form['isedoc_eis_admin_settings']['f_isedoc_eis_default_name'], $l_name, $form_state);
		};
	} else if (strlen($l_name) > 0) {
		$l_ids = isedoc_node_ids_by_title($l_name);
		if ($l_ids === FALSE or count($l_ids) == 0) {
			form_set_error('f_isedoc_eis_default_name', t('Invalid NAME [%name]', array('%name' => $l_name)));
		} else {
			$l_id = array_shift($l_ids);
			$n = node_load($l_id);
			$l_uuid = $n->field_uuid[0]['value'];
			form_set_value($form['isedoc_eis_admin_settings']['f_isedoc_eis_default_uuid'], $l_uuid, $form_state);
		};
	}
}


function isedoc_eis_admin_settings_submit($form, &$form_state) {
	//drupal_set_message(t("Processed isedoc_eis_admin_settings_submit ..."),'status');
//drupal_set_message(textvar_dump_r($form_state,TRUE));

	if (isset($form_state['values']['f_isedoc_eis_default_uuid'])) {
		variable_set('isedoc_eis_default_uuid',$form_state['values']['f_isedoc_eis_default_uuid']);
	}
	if (isset($form_state['values']['f_isedoc_eis_default_name'])) {
		variable_set('isedoc_eis_default_uuid',$form_state['values']['f_isedoc_eis_default_name']);
	}
}
/**
 * Menu: admin/content/isedoc_eis
 */
// function isedoc_eis_form() {
// drupal_set_message("isedoc_eis_form");
// 	$form = array();
// 
// 	$eis_default_uuid = variable_get('isedoc_eis_default_uuid', '');
// 	$eis_default_name = variable_get('isedoc_eis_default_name', '');
// 
// 	return $form;
// }
// 
function isedoc_eis_admin_content() {
 	//$eis_default_uuid = variable_get('isedoc_eis_default_uuid', '');
 	//$eis_default_name = variable_get('isedoc_eis_default_name', '');
	$output = "List of mappers...";
	$mappers = _isedoc_eis_doc_mappers();
	$t_data = array();
	foreach ($mappers as $m) {
		$t_row = array();
		$t_row_data = array();
		$l_uuid = $m['uuid'];
		$l_library = $m['library'];
		$l_cluster = $m['cluster'];
		$l_classname = $m['classname'];
		$l_puuid = $m['puuid'];
		$l_psection = $m['psection'];

 		$t_row_data['UUID'] = $l_uuid;
 		$t_row_data['Library'] = $l_library;
 		$t_row_data['Cluster'] = $l_cluster;
 		$t_row_data['Classname'] = $l_classname;
 		$t_row_data['Documentation'] = $l_puuid;
 		$t_row_data['Section'] = $l_psection;

		$eis = "$l_uuid@$l_library@$l_cluster@$l_classname";
		if (strlen($l_psection) > 0) {
			$s = l(t('View'), "isedoc/uuid/".$l_puuid, array('fragment' => $l_psection));
		} else {
			$s = l(t('View'), "isedoc/uuid/".$l_puuid);
		}
 		$t_row_data['Operations'] = '('.$s .' | ' . l(t('Edit'),'isedoc/edit/eis/'.$eis) .')';
/*
		foreach ($m as $k => $v) {
			switch ($k) {
				case 'puuid':
					$t_row_data[$k] = l($v, "isedoc/uuid/$v");
					break;
				default:
					$t_row_data[$k] = $v;
					break;
			}
		}
*/
		$t_data[] = $t_row_data;
	}
	$output .= theme('table', array( 
					array('data' => "UUID", 'field' => 'UUID'),
					array('data' => "Library"),
					array('data' => "Cluster"),
					array('data' => "Classname"),
					array('data' => "Documentation", 'field' => 'Documentation'),
					array('data' => "Section"),
					array('data' => "Operation")
				),
			$t_data,
			array(
			)
		);
	//$output .= theme('box', drupal_get_form('isedoc_eis_admin_content_form'));
	return $output;
}

function isedoc_eis_admin_content_form() {
	$form['isedoc_eis_admin_content'] = array(
		'#type' => 'fieldset',
		'#title' => t('EIS mappers')
	);

	return system_settings_form($form);
};

function theme_isedoc_eis_admin_settings($form) {
 //drupal_set_message("theme_isedoc_eis_form");
 	$output .= drupal_render($form);
 	return $output;
}

?>
