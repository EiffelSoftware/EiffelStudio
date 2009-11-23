<?php

require_once ("isedoc.lib.inc");

function isedoc_eis_docinfo ($a_eis_info) {
drupal_set_message("info=" . $a_eif_info);
	$a_ref = $a_eis_info['uuid'];
	$l_name = "Unknown";
	$l_docuuid = "";
	switch (strtoupper($a_ref)) {
	case '6D7FF712-BBA5-4AC0-AABF-2D9880493A01': 
		$l_name = "EiffelBase"; 
		$l_docuuid = "0153c1de-bf88-fa0d-52a5-e50ffcc4e8c8";
		break;
	case '78D80981-EF3C-42EC-8919-EF7D7BB61701': 
		$l_name = "EiffelTime"; 
/*
		$l_docs = array (
				"*,*,*,DATE" => "195849fc-1a9c-d734-2d2b-acae78133886",
				"*,*,*,DATE_TIME" => "195849fc-1a9c-d734-2d2b-acae78133886",
				"*,*,*,TIME" => "195849fc-1a9c-d734-2d2b-acae78133886"
			);
*/
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
		$l_docuuid = "0f0913fe-d71c-43d3-6c22-706c8ed5d4ad"; /* Solution's book */
	}
	return array('name' => $l_name, 'docuuid' => $l_docuuid);
}

function isedoc_eis_query($eis) {
	$output = t("Query Documentation page for <strong>EIS=%eis</strong>.", array('%eis'=>$eis));
	$output .= '<br/>';
/*
        $args = arg();
        //$eis_parts = explode ("@", $eis);
        foreach($args as $n) {
		if (!is_null($eis_parts)) {
			$eis_parts[] = $n;
		} elseif ($n == 'eis') { 
			$eis_parts = array();
			$eis_parts[] = $eis;
		}
        }
*/
	$eis_parts = explode ("@", $eis);
	if (!is_null($eis_parts)) {
		$c = count ($eis_parts);
		$eis_info['uuid'] = $eis_parts[0];
		$i = 0;
		if ($i + $c >= 4) {
			$i = $i + 1;
			$eis_info['library'] = $eis_parts[$i];
		}
		if ($i + $c >= 3) {
			$i = $i + 1;
			$eis_info['cluster'] = $eis_parts[$i];
		}
		if ($i + $c >= 2) {
			$i = $i + 1;
			$eis_info['class'] = $eis_parts[$i];
		} 
		$output .= '<ul>';
		foreach ($eis_info as $k => $p) {
			$output .= '<li>' . $k . '=' . $p . '</li>';
		}

		$l_uuid = $eis_info['uuid'];
		if (!empty($l_uuid)) {
			$l_section = "";

			$docinfo = isedoc_eis_docinfo($eis_info);
			$docref = $docinfo['name'];
			$docuuid = $docinfo['docuuid'];
			$output .= '<li style="font-weight: bold;">Related to ' . $docref . ' =&gt; ' . $docuuid . '</li>';

			$nids = isedoc_node_ids_by_uuid($docuuid);
			if ($nids) {
				$output .= "<ul>";
				if (count($nids) == 1) {
					end(&$nids);
					$nid = key(&$nids);
					$vid = current(&$nids);
					$node =& node_load(array('nid' => $nid));
					if ($node and $node->vid == $vid) {
						// Check the version id...
						//drupal_set_message(t("Accessed by the UUID=%uuid.",array('%uuid' => $uuid)), 'status');
						drupal_goto($node->path,NULL,$l_section);
						$output .= '<li>' . isedoc_uuid_page_display(&$node) . '</li>';
					} else {
						// Should not occur ...
						$output .= t("Unable to find referenced page.");
					}
				} else {
					// Should not occur ...
					foreach($nids as $nid => $vid) {
						$node =& node_load(array('nid' => $nid));
						if ($node) {
							$output .= '<li>' . isedoc_uuid_page_display(&$node) . '</li>';
						}
					}
				}
				$output .= "</ul>";
			} else {
				$output .= t("Unable to find referenced page.");
			}
		}
		$output .= '</ul>';
	}


$output .= t ("Not Yet Implemented.");

/*
	$nids = isedoc_node_ids_by_uuid($uuid);
	if ($nids) {
		$output .= "<ul>";
		if (count($nids) == 1) {
			end(&$nids);
                        $nid = key(&$nids);
                        $vid = current(&$nids);
			$node =& node_load(array('nid' => $nid));
			if ($node and $node->vid == $vid) {
				// Check the version id...
				//drupal_set_message(t("Accessed by the UUID=%uuid.",array('%uuid' => $uuid)), 'status');
				drupal_goto($node->path,NULL,$a_section);
				$output .= '<li>' . isedoc_uuid_page_display(&$node) . '</li>';
			} else {
				// Should not occur ...
				$output .= t("Unable to find referenced page.");
			}
		} else {
			// Should not occur ...
			foreach($nids as $nid => $vid) {
				$node =& node_load(array('nid' => $nid));
				if ($node) {
					$output .= '<li>' . isedoc_uuid_page_display(&$node) . '</li>';
				}
			}
		}
		$output .= "</ul>";
	} else {
		$output .= t("Unable to find referenced page.");
	}
*/

	return $output."<br/><br/>";
}


?>
