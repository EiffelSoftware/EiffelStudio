<?php

require_once ("isedoc.lib.inc");

function isedoc_uuid_query($uuid) {
	$output = t("Query Documentation page for <strong>UUID=%uuid</strong>.", array('%uuid'=>$uuid));
	$output .= '<br/>';

	$nids = isedoc_node_ids_by_uuid($uuid);
	if ($nids) {
		$output .= "<ul>";
		if (count($nids) == 1) {
			end(&$nids);
                        $nid = key(&$nids);
			$node =& node_load(array('nid' => $nid));
			if ($node) {
				drupal_set_message(t("Accessed by the UUID=%uuid.",array('%uuid' => $uuid)), 'status');
				drupal_goto($node->path);
				$output .= '<li>' . isedoc_uuid_page_display(&$node) . '</li>';
			} else {
				// Should not occur ...
				$output .= t("Unable to find page referenced by UUID:%uuid", array('%uuid' => $uuid));
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
		$output .= t("Unable to find page referenced by UUID:%uuid", array('%uuid' => $uuid));
	}

	return $output."<br/><br/>";
}

function isedoc_uuid_page_display(&$node) {
	$output = t("Page %tit", array('%tit' => $node->title));
	$output .= " (" . l(t("view"), $node->path) .")";
	return $output;
}

?>
