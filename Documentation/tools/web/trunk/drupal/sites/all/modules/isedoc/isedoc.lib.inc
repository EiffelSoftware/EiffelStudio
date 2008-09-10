<?php


/*
 * Helpers
 */

function var_dump_r(&$ref, $pre=TRUE) {
	ob_start(); var_dump($ref); $a=htmlspecialchars(ob_get_contents(),ENT_QUOTES); ob_end_clean(); 
	if ($pre) {
		return "<pre>DUMP=".$a . '</pre>';
	} else {
		return 'DUMP='.$a;
	}
}
function var_dump_global($refname) {
	global $$refname;
	ob_start(); var_dump($$refname); $a=htmlspecialchars(ob_get_contents(),ENT_QUOTES); ob_end_clean(); 
	return "DUMP[".$refname."]=".$a;
}

/**
 * Returns an array of all books.
 *
 * This list may be used for generating a list of all the books, or for building
 * the options for a form select.
 */

function book_doc_page_exists($a_title) {
	//$res = db_query("SELECT nid FROM {node} WHERE LOWER(title) = LOWER('%s') AND type IN ()", $a_title);
	//$res = db_query("SELECT nid FROM {node} WHERE LOWER(title) = LOWER('%s') AND type = 'doc' ", $a_title);
	$res = db_query("SELECT nid FROM {node} WHERE type = 'doc' AND LOWER(title) = LOWER('%s') ", $a_title);
	if ($res === FALSE) {
		return FALSE;
	} else {
		$v = db_fetch_object($res);
		return $v->nid;
	}
}

function isedoc_book_get_books() {
  static $all_books;

  if (!isset($all_books)) {
    $all_books = array();
    $result = db_query("SELECT DISTINCT(bid) FROM {book}");
    $nids = array();
    while ($book = db_fetch_array($result)) {
      $nids[] = $book['bid'];
    }
    if ($nids) {
      $result2 = db_query(db_rewrite_sql("SELECT n.type, n.title, b.*, ml.* FROM {book} b INNER JOIN {node} n on b.nid = n.nid INNER JOIN {menu_links} ml ON b.mlid = ml.mlid WHERE n.nid IN (". implode(',', $nids) .") AND n.status = 1 ORDER BY ml.weight, ml.link_title"));
      while ($link = db_fetch_array($result2)) {
        $link['href'] = $link['link_path'];
        $link['options'] = unserialize($link['options']);
        $all_books[$link['bid']] = $link;
      }
    }
  }
  return $all_books;
}

?>
