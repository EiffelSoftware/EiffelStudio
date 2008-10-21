<?php

require_once ("isedoc.lib.inc");

function isedoc_redirect_query($kind,$d) {
	$args = arg();
	$url = '';
	foreach($args as $n) {
		if ($url != '') {
			$url = "$url/$n";
		} else {
			if ($n == $d) {
				$url .= $d;
			}
		}
	}
	$dir = drupal_get_path('module','isedoc');
	$output = t("Redirect Documentation: kind=$kind url=$url ($dir)");

	$output .= '<br/>';

	return $output."<br/><br/>";
}

?>
