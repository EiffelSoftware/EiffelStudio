<?php

require_once ("isedoc.lib.inc");

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

function isedoc_uuid_page_display(&$node) {
	$output = t("Page %tit", array('%tit' => $node->title));
	$output .= " (" . l(t("view"), $node->path) .")";
	return $output;
}

?>
