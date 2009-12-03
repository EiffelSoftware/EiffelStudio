<?php

require_once (dirname(__FILE__)."/../isedoc.lib.inc");
require_once ("isedoc_eis.lib.inc");

function isedoc_eis_query($eis) {
	$eis_info = _isedoc_eis_arguments($eis);
	if ($eis_info) {
		if (!empty($eis_info['uuid'])) {
			$doc_info = _isedoc_eis_docinfo($eis_info);
		}
	}
	$output = _isedoc_eis_mapping_to_string($eis,$eis_info,$doc_info, TRUE);

	// At this point, if we are not redirected, this means there is no EIS mapping
	$output .= '<ul>';
	$l_puuid = variable_get('isedoc_eis_default_uuid', '');
	if (strlen($l_puuid) > 0) {
		$output .= '<li>(Default mapping is ' . l($l_puuid, "isedoc/uuid/$l_puuid").')</li>';
	}
	if (user_access('edit eis')) {
		$output .= '<li>'.l(t("Edit EIS mapping"), "isedoc/edit/eis/$eis").'</li>';
	} else if (strlen($l_puuid) > 0) {
		drupal_goto("isedoc/uuid/$l_puuid");
	}
	$output .= '</ul>';
	return $output;
}

function isedoc_eis_mapping($node) {
  drupal_set_title(check_plain($node->title));
  $l_docuuid = $node->field_uuid[0]['value'];
  if (empty($l_docuuid)) {
	  $output = '<h2>EIS Mapping is only for Documentation page with UUID (current type is \''.$node->type.'\')<h2>';
  } else {
	  $output = "<h1>EIS Mapping ...</h1>";
	  $output .= "UUID of current documentation page: <b>". l($l_docuuid, "isedoc/uuid/".$l_docuuid)."</b><br/>";
	  $l_mappers = _isedoc_eis_doc_mappers($l_docuuid);
	  if ($l_mappers) {
		$output .= "<h3>" . count($l_mappers)  . " EIS mapper(s) found.</h3>";
		$output .= "<ul>";
		foreach ($l_mappers as $m) {
			$s = $m['uuid'];
			$eis = $s;
			$s = $m['library']; if (strlen($s) > 0) { $eis .= "@$s";  }
			$s = $m['cluster']; if (strlen($s) > 0) { $eis .= "@$s"; }
			$s = $m['classname']; if (strlen($s) > 0) { $eis .= "@$s"; }
			$output .= "<li>$eis ( ". l(t('view'), "isedoc/eis/$eis") . " , " . l(t('edit'), "isedoc/edit/eis/$eis") ." )</li>";
		}
		$output .= "</ul>";
	  } else {
		$output .= "<h3>No EIS mapper found</h3>";
	  }
          $output .= '<ul>';
	  $output .= "<li>" . l("Add a new mapper","isedoc/edit/eis/_/$l_docuuid"). "</li>";
	  if (user_access('access eis')) {
		$output .= '<li>(note: click here to '. l(t('list all existing mappers'), 'admin/content/isedoc_eis') . ')</li>';
	  }
          $output .= '</ul>';
  }

  return $output;
}


?>
