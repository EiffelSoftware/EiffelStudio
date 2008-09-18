<?php
// $Id$

require_once (dirname(__FILE__)."/../isedoc.lib.inc");

/**
 * Admin settings callback.
 */
function isedoc_export_admin_settings() {

	$form['isedoc_export'] = array(
		'#type' => 'fieldset',
		'#title' => t('Export Documentation Settings')
	);

	$form['isedoc_export']['isedoc_export_folder'] = array(
		'#type' => 'textfield',
		'#title' => t('Import Folder'),
		'#default_value' => variable_get('isedoc_export_folder', '/isedoc/export'),
		'#description' => t('Directory "%dir" where documentation will be generated to. Do not include trailing slash.<br/>To export content, %link', array('%dir' => file_directory_path(), '%link' => 'admin/content/isedoc_export')),
		'#required' => TRUE,
	);
	$form['isedoc_export']['isedoc_export_action'] = array(
		'#type' => 'submit',
		'#submit' => array('isedoc_export_admin_settings_goto_export'),
		'#value' => t('Export Content'),
	);

	return system_settings_form($form);
}

function isedoc_export_settings_submit($form, &$form_state) {
	drupal_set_message(t("Processed isedoc_export_settings_submit ..."),'status');
}
function isedoc_export_admin_settings_goto_export($form, &$form_state) {
	drupal_goto('admin/content/isedoc_export');
}

/**
 * Menu: admin/content/isedoc_export
 */
function isedoc_export_form() {
	$form = array();

	$export_path = variable_get('isedoc_export_folder', '/isedoc/export');
	$dirpath = file_directory_path() . $export_path ;

	if (!file_check_directory($dirpath)) {
		drupal_set_message(t("You need to configure the isedoc directory on the isedoc export module's <a href='!admin-settings-isedoc_export'>settings page</a>.", array('!admin-settings-isedoc_export' => url('admin/settings/isedoc/isedoc_export'))), 'error');
		//    return $form;
	}

	/*
	 *	  Parameters 
	 */
	$all_books_titles = array();
	$all_books_titles[''] = t('<None>');
	$dft_book = '';

	$all_books = book_get_books();
	if (count($all_books) > 0) {
		$dft_book = $all_books[1]['title'];
		foreach ($all_books as $b) {
			if ($dft_book == '') { $dft_book = $b['bid']; }
			$all_books_titles[$b['bid']] = $b['title']; //. " #".$b['bid'];
		}
	}
	$form['isedoc_export_booknames'] = array(
		'#type' => 'select',
		'#title' => t('Select a book'),
		'#default_value' => variable_get('isedoc_export_bid', $dft_book),
		'#options' => $all_books_titles,
		'#description' => t('The book containing the content to export.'),
	);

	$all_export_format = array();
	$dft_export_format = 'wiki';
	$all_export_format['wiki'] = t('Export as wiki content (default)');
	$all_export_format['html'] = t('Export as static html content');

	$form['isedoc_export_format'] = array(
		'#type' => 'select',
		'#title' => t('Select a format'),
		'#default_value' => variable_get('isedoc_export_format', $dft_export_format),
		'#options' => $all_export_format,
		'#description' => t('The format of the exported content (default: %dft).',array('%dft' => $dft_export_format)),
	);

	$form['isedoc_export_dirpath'] = array(
		'#type' => 'hidden',
		'#value' => $dirpath,
	);

	$form['buttons']['submit'] = array(
		'#type' => 'submit',
		'#submit' => array('isedoc_export_form_export'),
		'#value' => t('Export'),
	);

	return $form;
}

function theme_isedoc_export_form($form) {
	return drupal_render($form);
}


function isedoc_export_form_export($form, &$form_state) {
	$bookid = $form_state['values']['isedoc_export_booknames'];
	if (isset($form_state['values']['isedoc_export_folder'])) {
		variable_set('isedoc_export_folder',$form_state['values']['isedoc_export_folder']);
	}
	variable_set('isedoc_export_bid',$bookid);
	$op = isset($form_state['values']['op']) ? $form_state['values']['op'] : '';
	if ($op == t('Export')) {
		$dirpath = $form_state['values']['isedoc_export_dirpath'];
		$l_exp_format = $form_state['values']['isedoc_export_format'];
		if (file_check_directory($dirpath)) {
			//drupal_set_message(var_dump_r($form_state['values']));
			if (!ini_get('safe_mode')) { set_time_limit(0); }

			$nodes_count = 0;
			$nodes_count = isedoc_export_book_to($bookid, $dirpath, $l_exp_format);

			// report back on our progress
			if ($nodes_count > 0) {
				drupal_set_message(t("Successfully exported: %nb nodes from book #$bookid", array ('%nb' => $nodes_count)));
			}
			else {
				drupal_set_message(t('No node exported.'));
			}
		}
	}
}

function isedoc_export_book_to($a_bookid, $a_dirpath, $a_exp_format) {
	global $isedoc_export_data;
	global $isedoc_export_dir;
	global $isedoc_node_count;
	global $isedoc_export_book_alias;
	global $base_path;
	global $base_root;
	$isedoc_node_count = 0;

	$node =& node_load(array('nid' => $a_bookid), NULL, FALSE);
	//drupal_set_message(var_dump_r ($node),'status');
	if ($node) {
		if (isset($node->book)) {
			$book_url = $base_root.$base_path.$node->path;
			$isedoc_export_dir = $a_dirpath;
			$l_bk_alias = isedoc_export_node_alias($node);
			$l_bk_dir = $isedoc_export_dir . '/' . $l_bk_alias;

			drupal_set_message(t("Exporting($a_exp_format) book #$a_bookid \"<strong>%bookname</strong>\" to <strong>$l_bk_dir</strong>.", 
				array('%bookname' => $node->title)),'status');

			if (file_check_directory($l_bk_dir)) {
				isedoc_rm_recursive($l_bk_dir);
			}
			isedoc_mkdir($l_bk_dir);

			$tree = book_menu_subtree_data($node->book);

			isedoc_export_images($l_bk_dir.'/_images');

			$isedoc_export_book_alias = $l_bk_alias;
			switch ($a_exp_format) {
			case 'html':
				$isedoc_export_data['html.tpl'] = &isedoc_export_html_page_template($book_url,$node->title);
				$content = isedoc_book_export_traverse($tree,'html','index',$l_bk_alias.'/');
				isedoc_export_book_create_style("$l_bk_dir/book.css");
				isedoc_export_save_file($content, "$l_bk_dir/index.html", 'book html index');
				break;
			case 'wiki':
			default:
				$content = isedoc_book_export_traverse($tree,'wiki','book');
				isedoc_export_save_file($content, "$l_bk_dir/book.index", 'book wiki index');
				break;
			}

		}
	} else {
		drupal_set_message(t("Error loading book #<strong>$a_bookid</strong>!"),'error');
		return 0;
	}

	return $isedoc_node_count;
}

function isedoc_export_images($a_dir) {
	$img_dir = file_directory_path().'/images';
	$files = file_scan_directory($img_dir, "^[^\.]*\.(png|jpg|ico)$", array('.', '..', 'CVS', '.svn'), 0, FALSE, 'filename');
	isedoc_mkdir($a_dir);
	foreach($files as $k => $f) {
		//drupal_set_message("copy $k to $a_dir");
		file_copy($k,$a_dir,FILE_EXISTS_ERROR);
	}
}

function isedoc_export_node_alias(&$a_node) {
	$l_id = end(split('/', $a_node->path));
	return $l_id;
}


function isedoc_book_export_traverse($tree,$type,$a_alias='book',$prefix='') {
  /* Check book_export_traverse($tree, $visit_func) modules/book/book.module, line 905 */

  global $isedoc_export_dir;
  $output = '';
  $l_left = ''; //$a_alias;
  $l_right = '';
  $l_aliases = array();
  $n = count($tree);
  $i = 0;

  foreach ($tree as $data) {
    if ($node = node_load($data['link']['nid'], FALSE)) {
      $l_alias = isedoc_export_node_alias($node);
    };
    $l_aliases[$i] = $l_alias;
    $i = $i + 1;
  }
  $i = 0;

  foreach ($tree as $data) {
    // Note- access checking is already performed when building the tree.
    if ($node = node_load($data['link']['nid'], FALSE)) {

      if ($i == 0) {
        $l_left = $a_alias;
      } elseif ($i <= $n) {
        $l_left = $l_aliases[$i-1];
      }
      if ($i == n) {
        $l_right = '';
      } elseif ($i >= 0) {
        $l_right = $l_aliases[$i+1];
      }


      $l_alias = isedoc_export_node_alias($node);
      $l_src = $prefix . $l_alias;
      switch ($type) {
      case 'html':
        $l_prefix = $prefix;
	$l_html_nav = '';
        if ($data['below']) {
          $l_html_nav = isedoc_export_book_html_children_navigation($data['below']);
        }
        $output .= isedoc_export_book_node_as_html($node, $l_src,$l_alias,$a_alias,$l_left,$l_right,$l_html_nav);
        break;
      case 'wiki':
      default:
        $l_prefix = $l_src . '/';
        if ($data['below']) {
          isedoc_mkdir($isedoc_export_dir . '/' . $l_src);
          $l_src = $l_prefix . 'index';
        }
        $output .= isedoc_export_book_node_as_wiki($node, $l_src, $a_alias);
        break;
      }
      if ($data['below']) {
        $children = isedoc_book_export_traverse($data['below'],$type,$l_alias,$l_prefix);
	$output .= $children;
      }
    }
    $i = $i + 1;
  }
  if ($type == 'html') {
    return "<ul>$output</ul>\n";
  } else {
    return $output;
  }
}

function isedoc_export_book_html_children_navigation($a_children_tree) {
	$output = '<ul id="doc-nav">';
	foreach($a_children_tree as $data) {
	    if ($node = node_load($data['link']['nid'], FALSE)) {
	 	$l_alias = isedoc_export_node_alias($node);
		$output .= "<li><a href=\"$l_alias.html\">".$node->title."</a></li>\n";
	    }
	}
	$output .= '</ul>';
	return $output;
}


function isedoc_export_book_node_as_wiki($a_node,$a_src, $p_alias) {
	global $isedoc_node_count;
	global $isedoc_export_dir;

	//drupal_set_message("Generate WIKI: <strong>book_node (a_node, $a_src, $p_alias)</strong>",'status');
	//drupal_set_message(var_dump_r ($a_node),'status');

	$output = '';

	$l_title = $a_node->title;
	$l_depth = $a_node->book['depth'] - 1;
	$l_weight = $a_node->book['weight'];
	$l_node_id = $a_node->nid;
	$l_src = $a_src;

	$h = "[$l_depth:$p_alias:$l_weight] $l_title\n";
	$h .= " !src=$l_src\n";

	/* Build the wiki text */
	$tw = "#title=$l_title\n";
	if (module_exists('taxonomy')) {
		$taxo =& $a_node->taxonomy;
		if (count($taxo) > 0) {
			$tw .= "#tags=";
			foreach($taxo as $t) {
				$tw .= $t->name.",";
			}
			$tw = rtrim($tw, ',');
			$tw .= "\n";
		}
	}
	if (is_callable(array($a_node, 'field_uuid'), TRUE)) {
		$uuid = $a_node->field_uuid[0]['value'];
		if ($uuid) {
			$tw .= "#uuid=$uuid\n";
		}
	}

	$fn = $isedoc_export_dir . '/' . $l_src . '.wiki';
	$m .= $h;
	//$m .= "<pre>".$a_node->body."</pre>";
	drupal_set_message($m,'status');

	$fp = fopen($fn, 'w');
	if ($fp) {
		fwrite($fp, $tw."\n");
		fwrite($fp, $a_node->body."\n");
		fclose ($fp);
	}

	$isedoc_node_count = $isedoc_node_count + 1;

	$output .= $h;
	return $output;
}


function isedoc_export_book_node_as_html($a_node,$a_src,$a_url_name,$a_parent,$a_left,$a_right,$a_nav) {
	global $isedoc_node_count;
	global $isedoc_export_dir;
	global $isedoc_export_book_alias;
	global $base_path;
	//drupal_set_message("Generate HTML: <strong>book_node (a_node, $a_src, $a_parent)</strong>",'status');
	//drupal_set_message(var_dump_r ($a_node),'status');

	$output = '';

	$l_title = $a_node->title;
	$l_depth = $a_node->book['depth'] - 1;
	$l_weight = $a_node->book['weight'];
	$l_node_id = $a_node->nid;
	$l_src = $a_src;

	//$output .= "[$l_depth";
	//$output .= ":<a class=\"link\" href=\"$a_parent.html\">$a_parent</a>";
	//$output .= ":$l_weight] ";
	$output .= "<a class=\"title\" href=\"$a_url_name.html\">$l_title</a>";

	if (module_exists('taxonomy')) {
		$taxo =& $a_node->taxonomy;
		if (count($taxo) > 0) {
			$tags = " <span class=\"tags\">(tags:";
			foreach($taxo as $t) {
				$tags .= $t->name.",";
			}
			$tags = rtrim($tags, ',');
			$tags .= ")</span>";
			$output .= $tags;
		}
	}
	if (is_callable(array($a_node, 'field_uuid'), TRUE)) {
		$uuid = $a_node->field_uuid[0]['value'];
		if ($uuid) {
			$output .= "<span class=\"uuid\">UUID=$uuid</span>\n";
		}
	}

	$th = isedoc_export_book_node_html($a_node,$a_parent,$a_left, $a_right,$a_nav,$tags);

	$fn = $isedoc_export_dir . '/' . $l_src . '.html';
	drupal_set_message($output,'status');

	$fp = fopen($fn, 'w');
	if ($fp) {
		fwrite($fp, $th."\n");
		fclose ($fp);
	}

	$isedoc_node_count = $isedoc_node_count + 1;
	return "<li>$output</li>";
}

function isedoc_export_save_file($a_content, $a_fn, $a_name) {
	$l_fp = fopen($a_fn, 'w');
	if ($l_fp) {
		drupal_set_message(t("Creating $a_name:").l($a_fn,$a_fn),'status');
		fwrite($l_fp,$a_content);
		fclose($l_fp);
	} else {
		drupal_set_message(t("Error: unable to create $a_name <em>$a_fn</em>!"),'error');
	}
}

function isedoc_export_book_create_style($a_fn) {
	$l_fp = fopen($a_fn, 'w');
	if ($l_fp) {
		drupal_set_message(t("Creating book style file: <em>$a_fn</em>!"),'status');
		$css = <<<CSSTXT
div#doc-header { margin: 5px 5px 5px 5px; padding: 10px; 
	color: #fff; background-color: #003063; border: solid 1px #009; }
#doc-header span#title { font-size: 180%; font-weight: bold; }
#doc-header #nav { float: right; position: relative; top: -20px; }

#doc-header a { color: #00f; text-decoration: none; 
		padding: 0 5px 0 5px;
		margin: 0 5px 0 5px;
		background-color: #fff; border: solid 1px #ccf; }
div#doc-body { margin: 10px 5px 10px 5px; 
		padding: 20px; border: solid 1px #ccc;}

div#doc-body div#doc-tags {
	float: right;
	margin-right: 15px;
	}
ul#doc-nav { margin-left: auto; margin-right: 5px; width: 50%;
		text-align: right;
		list-style-type: none;
		color: #533; 
		background-color: #eef;
		padding: 5px 5px 5px 20px; border: solid 1px #ccc;
	}
#doc-nav a { color: #00f; text-decoration: none; 
		padding-left: 5px; padding-right: 5px;
	}

div#doc-footer { margin: 10px 5px 5px 5px; padding 5px; 
	text-align: center; color: #999;}
CSSTXT;

		fwrite($l_fp, $css);
		fclose($l_fp);
	} else {
		drupal_set_message(t("Error: unable to create book style file <em>$a_fn</em>!"),'error');
	}
}

function isedoc_export_html_page_template($book_url, $book_title) {
	$txt = "<html><head><title>%TITLE%</title>";
	$txt .= '<link type="text/css" rel="stylesheet" media="all" href="book.css" />';
	$txt .= '</head><body>';
	$txt .= '<div id="doc-header">';
	$txt .= "<span id=\"title\">$book_title</span>";
	$txt .= '<div id="nav"><a href="%INDEX_URL%">Index</a> %LEFT_HTML% <a href="%PARENT_URL%">Up</a> %RIGHT_HTML%</div>';
	$txt .= "</div>\n";
	$txt .= '<div id="doc-body"><div id="doc-tags">%TAGS%</div>%BODY%<br/>%NAV_HTML%</div>';
	$txt .= '<div id="doc-footer">';
	$txt .= "Documentation exported from <a href=\"$book_url\">$book_url</a>";

	$l_datetime = date ("d-M-Y H:i:s - T");
	$txt .= " -- $l_datetime";
	$txt .= '</div></body></html>';
	$txt .= '</body></html>';

	return new IseDocTemplateGenerator($txt);
}

function isedoc_export_book_node_html($a_node,$a_parent,$a_left, $a_right, $a_nav, $a_tags='') {
	global $isedoc_export_data;
	global $isedoc_export_book_alias;
	global $base_path;

  	$a_node->build_mode = NODE_BUILD_PRINT;
  	$a_node = node_build_content($a_node, FALSE, FALSE);
  	$a_node->body = drupal_render($a_node->content);
        $content = "".theme('book_node_export_html', $a_node, '');
	$content = str_replace($base_path.'book/'.$isedoc_export_book_alias.'/','',$content);
	$content = str_replace($base_path.'content/','_images/',$content);
	$content = str_replace(file_directory_path().'images/','_images/',$content);

	if (strlen($a_left) > 0) {
		$l_left_html = '<a href="'.$a_left.'.html">Left</a>';
	} else {
		$l_left_html = '';
	}
	if (strlen($a_right) > 0) {
		$l_right_html = '<a href="'.$a_right.'.html">Right</a>';
	} else {
		$l_right_html = '';
	}
	$tpl = &$isedoc_export_data['html.tpl'];
	$l_page = $tpl->generate(array(
				'/%TITLE%/' => $a_node->title,
				'/%INDEX_URL%/' => "index.html",
				'/%LEFT_HTML%/' => $l_left_html,
				'/%PARENT_URL%/' => "$a_parent.html",
				'/%RIGHT_HTML%/' => $l_right_html,
				'/%NAV_HTML%/' => $a_nav,
				'/%BODY%/' => $content,
				'/%TAGS%/' => $a_tags,
				));

	return $l_page;
}

class IseDocTemplateGenerator {
	var $tpl;
	public function __construct($txt) {
		$this->tpl = $txt;
	}
	public function generate($data) {
		$n = count($data);
		$i = $n;
		foreach($data as $pat => $rep) {
			$p[$i] = $pat;
			$r[$n - $i] = $rep;
			$i = $i + 1;
		}
		return preg_replace($p, $r, $this->tpl);
	}
};

?>
