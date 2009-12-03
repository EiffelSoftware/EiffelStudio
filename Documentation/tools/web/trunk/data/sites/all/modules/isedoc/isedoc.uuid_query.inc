<?php

require_once ("isedoc.lib.inc");

function isedoc_uuid_query($uuid,$a_section) {
	$output = t("Query Documentation page for <strong>UUID=%uuid</strong>.", array('%uuid'=>$uuid));
	$output .= '<br/>';

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
				$l_section = $a_section;
				if (!empty($l_section) and $l_section[0] == '#') {
					$l_section = substr($l_section, 1);
				}
				drupal_goto($node->path,NULL,$l_section);
				$output .= '<li>' . isedoc_uuid_page_display(&$node,$l_section) . '</li>';
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

	return $output."<br/><br/>";
}

?>
