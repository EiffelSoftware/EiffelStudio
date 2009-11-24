<?php

require_once ("isedoc.lib.inc");

function isedoc_list_templates($arg_render) {
	$render = $arg_render == 'preview';
	$output = "<br/>";
	if ($render) {
		$output .= '<em>(Click to list '.l(t('templates without preview'), 'isedoc/templates').')</em>';
	} else {
		$output .= '<em>(Click to list '.l(t('templates with preview'), 'isedoc/templates/preview').')</em>';
	}
	$output .= "<br/>";
	$sql = "SELECT n.nid, n.title FROM {node} n INNER JOIN {node_revisions} r ON n.nid = r.nid AND n.vid = r.vid WHERE n.type = 'template' ";
	$sql .= " ORDER BY n.title, n.nid, n.vid ";
	$res = db_query($sql);
	if ($res === FALSE) {
		return FALSE;
	} else {
		$output .= '<ul>';
		while ($r = db_fetch_array($res)) {
			$output .= _isedoc_display_template($r,$render == 'render');
		}
		$output .= '</ul>';
	}
	return $output;
}
function _isedoc_display_template($tpl,$render=TRUE) {
	if ($node = node_load($tpl['nid'])) {
		$output = "<li>Template ".l($node->title, $node->path);
		if ($render) {
			$node->build_mode = NODE_BUILD_NORMAL;
			$node = node_build_content ($node, FALSE, FALSE);
			$node->body = drupal_render ($node->content);
			unset ($node->teaser);
			node_invoke_nodeapi ($node, 'alter', FALSE, FALSE);
			$output .= '<blockquote>';
			$output .= theme ('book_node_export_html', $node, '');
			$output .= '</blockquote>';
		}
		$output .= "</li>";
	} else {
		$output = "<li>".$tpl['title']."</li>";
	}
	return $output;
}

?>
