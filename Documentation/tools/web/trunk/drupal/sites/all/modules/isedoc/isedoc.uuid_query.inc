<?php

require_once ("isedoc.lib.inc");

function isedoc_uuid_query($uuid) {
	$output = "Query Documentation page for <strong>UUID=$uuid</strong>.";
	drupal_set_message(t("ISE Doc query by UUID is not yet implemented..."), 'error');
	return $output."<br/><br/>";
}

?>
