<?php

require_once (dirname(__FILE__)."/../isedoc.lib.inc");

function isedoc_eis_doc_database() {
	return array (
		//"UUID,lib,cluster,class=doc uuid"
		'6D7FF712-BBA5-4AC0-AABF-2D9880493A01,,,=0153c1de-bf88-fa0d-52a5-e50ffcc4e8c8,EiffelBase',
		'78D80981-EF3C-42EC-8919-EF7D7BB61701,,,=3d96626f-11f3-67a2-dec6-69f7faf4a8d6,EiffelTime',
		'78D80981-EF3C-42EC-8919-EF7D7BB61701,,,DATE=195849fc-1a9c-d734-2d2b-acae78133886,EiffelTime',
		'78D80981-EF3C-42EC-8919-EF7D7BB61701,,,TIME=195849fc-1a9c-d734-2d2b-acae78133886,EiffelTime',
		'78D80981-EF3C-42EC-8919-EF7D7BB61701,,,DATE_TIME=195849fc-1a9c-d734-2d2b-acae78133886,EiffelTime',
		'1557CB9B-9C9F-11DB-B606-0800200C9A66,,,=,EiffelEncoding'
	);
}
function isedoc_eis_doc_data($a_uuid,$a_lib,$a_cluster,$a_class) {
	$l_entry = "$a_uuid,$a_lib,$a_cluster,$a_class";
	//drupal_set_message("entry=$l_entry");
	$n = strlen($l_entry);
	foreach (isedoc_eis_doc_database() as $line) {
		if ($l_entry == substr($line,0,$n)) {
			$p = strpos($line, '=');
			if ($p !== false) {
				list($l_doc_uuid,$l_name) = split(',', substr($line, $p + 1), 2);
				return array('name' => $l_name, 'docuuid' => $l_doc_uuid);
			}
		}
	}
}

function isedoc_eis_docinfo ($a_eis_info) {
	$l_name = "Unknown";
	$l_docuuid = "";
	if (isset($a_eis_info['uuid']))    { $l_uuid    = strtoupper($a_eis_info['uuid']); } else { $l_uuid    = ''; }
	if (isset($a_eis_info['library'])) { $l_library = $a_eis_info['library'];          } else { $l_library = ''; }
	if (isset($a_eis_info['cluster'])) { $l_cluster = $a_eis_info['cluster'];          } else { $l_cluster = ''; }
	if (isset($a_eis_info['class']))   { $l_class   = strtoupper($a_eis_info['class']);} else { $l_class   = ''; }

	$r = isedoc_eis_doc_data($l_uuid,$l_library,$l_cluster,$l_class);
	if ($r == NULL) {
		$r = isedoc_eis_doc_data($l_uuid,'','','');
		if ($r) {
			$r['suggested'] = true;
		}
	}
	
/*
	switch (strtoupper($a_eis_info['uuid'])) {
	case '6D7FF712-BBA5-4AC0-AABF-2D9880493A01': 
		$l_name = "EiffelBase"; 
		$l_docuuid = "0153c1de-bf88-fa0d-52a5-e50ffcc4e8c8";
		break;
	case '78D80981-EF3C-42EC-8919-EF7D7BB61701': 
		$l_name = "EiffelTime"; 
		switch (strtoupper($a_eis_info['class'])) {
		case "DATE":
		case "TIME":
		case "DATE_TIME":
			$l_docuuid = "195849fc-1a9c-d734-2d2b-acae78133886";
			break;
		default:
			$l_docuuid = "3d96626f-11f3-67a2-dec6-69f7faf4a8d6";
			break;
		}
		break;
	case '1557CB9B-9C9F-11DB-B606-0800200C9A66': 
		$l_name = "EiffelEncoding";
		break;
	default:
		break;
	}

	if (empty($l_docuuid)) {
		//$l_docuuid = "0f0913fe-d71c-43d3-6c22-706c8ed5d4ad"; // Solution's book 
	}
	return array('name' => $l_name, 'docuuid' => $l_docuuid);
*/
	if ($r) {
		return $r;
	} else {
		$l_docuuid = "0f0913fe-d71c-43d3-6c22-706c8ed5d4ad"; /* Solution's book */
		//return array('name' => $l_name, 'docuuid' => $l_docuuid);
		return;
	}
}


?>
