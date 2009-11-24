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
	$output = "<br/>".t("The Eiffel documentation changed, please update your bookmarks, links, etc... with this new website.")."<br/>";
	$output .= '<ul>';
	$output .= '<li>Follow the <a href="/book/guide/guide">guide</a>.</li>';
	$output .= '<li>you can also <a href="/search/">search the new website</a>.</li>';
	$output .= '</ul>';
	$output .= '<p>'.t("Enjoy this new documentation website").'.</p>';

	//$output .= "<p>".t("Redirect Documentation: kind=$kind url=$url ($dir)")."</p>";

	$output .= '<br/>';

	return $output."<br/><br/>";
}

?>
