<?php

require_once ("isedoc_eis.lib.inc");

function isedoc_eis_query_edit($eis,$doc='') {
	if ($eis == '_') {
		return _isedoc_eis_query_edit_doc($doc);
	} else {
		return _isedoc_eis_query_edit_eis($eis);
	}
}

function _isedoc_eis_query_edit_doc($doc) {
	$output = t("New mapping on <strong>Doc UUID=%doc</strong>.", array('%doc'=>$doc));

	$output .= _isedoc_eis_query_edit_form(NULL, array('docuuid' => $doc, 'section' => ''));
	return $output;
}

function _isedoc_eis_query_edit_eis($eis) {
	$eis_info = _isedoc_eis_arguments($eis);
	if ($eis_info) {
		if (!empty($eis_info['uuid'])) {
			$doc_info = _isedoc_eis_docinfo($eis_info);
		}
	}
	$output = _isedoc_eis_mapping_to_string($eis,$eis_info,$doc_info,FALSE);
	$output .= _isedoc_eis_query_edit_form($eis_info, $doc_info);

	return $output."<br/><br/>";
}

function _isedoc_eis_query_edit_form($eis_info,$doc_info) {
	variable_set('isedoc_eis_query_edit_tmp_eis', $eis_info);
	variable_set('isedoc_eis_query_edit_tmp_doc', $doc_info);
	$output = theme('box', drupal_get_form('isedoc_eis_query_edit_form'));
	variable_del('isedoc_eis_query_edit_tmp_eis');
	variable_del('isedoc_eis_query_edit_tmp_doc');
	return $output;
}

function isedoc_eis_query_edit_form() {
	$eis_info = variable_get('isedoc_eis_query_edit_tmp_eis',array('uuid' => '', 'library' => '', 'cluster' => '', 'classname' => ''));
	$doc_info = variable_get('isedoc_eis_query_edit_tmp_doc',array('docuuid' => '', 'section' => ''));

	$form['isedoc_eis_query_edit_form_input'] = array(
		'#type' => 'fieldset',
		'#title' => t('EIS input')
	);

	$form['isedoc_eis_query_edit_form_input']['uuid'] = array(
		'#type' => 'textfield',
		'#title' => t('UUID'),
		'#description' => t('UUID related to EIS entry (usually UUID of the Eiffel library)'),
		'#default_value' => $eis_info['uuid'],
		'#required' => TRUE,
	);
	$form['isedoc_eis_query_edit_form_input']['library'] = array(
		'#type' => 'textfield',
		'#title' => t('Library'),
		'#description' => t('Library related to EIS entry'),
		'#default_value' => $eis_info['library'],
		'#required' => FALSE,
	);
	$form['isedoc_eis_query_edit_form_input']['cluster'] = array(
		'#type' => 'textfield',
		'#title' => t('Cluster'),
		'#description' => t('Cluster related to EIS entry'),
		'#default_value' => $eis_info['cluster'],
		'#required' => FALSE,
	);
	$form['isedoc_eis_query_edit_form_input']['classname'] = array(
		'#type' => 'textfield',
		'#title' => t('Classname'),
		'#description' => t('Classname related to EIS entry'),
		'#default_value' => $eis_info['classname'],
		'#required' => FALSE,
	);

	$form['isedoc_eis_query_edit_form_map'] = array(
		'#type' => 'fieldset',
		'#title' => t('Documentation page mapping')
	);
	$form['isedoc_eis_query_edit_form_map']['puuid'] = array(
		'#type' => 'textfield',
		'#title' => t('UUID'),
		'#description' => t('UUID of the associated documentation page'),
		'#default_value' => $doc_info['docuuid'],
		'#required' => TRUE,
	);
	$form['isedoc_eis_query_edit_form_map']['psection'] = array(
		'#type' => 'textfield',
		'#title' => t('Section'),
		'#description' => t('Section of the associated documentation page'),
		'#default_value' => $doc_info['section'],
		'#required' => FALSE,
	);
	$form['#submit'][] = 'isedoc_eis_query_edit_form_submit';
	$form['#validate'][] = 'isedoc_eis_query_edit_form_validate';

	return system_settings_form($form);
}


function isedoc_eis_query_edit_form_validate($form, &$form_state) {
//drupal_set_message(textvar_dump_r($form_state));
	$l_puuid = $form_state['values']['puuid'];
	if (strlen($l_puuid) > 34) {
		$l_ids = isedoc_node_ids_by_uuid($l_puuid);
	}
	if ($l_ids === FALSE or count($l_ids) == 0) {
		form_set_error('puuid', t('Invalid Documentation UUID [%puuid]',array('%puuid' => $l_puuid)));
	}
}

function isedoc_eis_query_edit_form_submit($form, &$form_state) {
	$l_uuid = $form_state['values']['uuid'];
	$l_library = $form_state['values']['library'];
	$l_cluster = $form_state['values']['cluster'];
	$l_classname = $form_state['values']['classname'];
	$l_puuid = $form_state['values']['puuid'];
	$l_psection = $form_state['values']['psection'];

	$info = array(
		'uuid' => $l_uuid,
		'library' => $l_library,
		'cluster' => $l_cluster,
		'classname' => $l_classname,
		'puuid' => $l_puuid,
		'psection' => $l_psection,
	);

	_isedoc_eis_save(&$info);
}

?>
