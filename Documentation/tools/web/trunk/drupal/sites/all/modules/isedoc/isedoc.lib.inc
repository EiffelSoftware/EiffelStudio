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

function isedoc_mkdir($a_dir) {
	if (!file_check_directory($a_dir)) {
		//drupal_set_message("create directory: $a_dir", 'status');
		mkdir($a_dir, 0775, TRUE);
	}
}

function isedoc_rm_recursive($filepath) {
    if (is_dir($filepath) && !is_link($filepath))
    {
        if ($dh = opendir($filepath))
        {
            while (($sf = readdir($dh)) !== false)
            {
                if ($sf == '.' || $sf == '..')
                {
                    continue;
                }
                if (!isedoc_rm_recursive($filepath.'/'.$sf))
                {
                    throw new Exception($filepath.'/'.$sf.' could not be deleted.');
                }
            }
            closedir($dh);
        }
        return rmdir($filepath);
    }
    return unlink($filepath);
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

function isedoc_book_parent_of($nid) {
	$parent_sql = "SELECT b.nid FROM {book} b INNER JOIN {menu_links} m ON m.mlid = b.mlid INNER JOIN {menu_links} m2 ON m.mlid = m2.plid INNER JOIN {book} b2 ON b2.nid = '%d' AND m2.mlid = b2.mlid ";
	$parent = db_result(db_query(db_rewrite_sql($parent_sql), $nid));
	if ($parent) {
		return $parent;
	} else {
		return FALSE;
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

function isedoc_book_name ($bid) {
	static $s_book_names;
	if (!$s_book_names) {
		$s_book_names = array();
	}
	if (isset($s_book_names[$bid])) {
		$bn = $s_book_names[$bid];
	} else {
		$b =& node_load($bid);
		if ($b) {
			$bn = $b->title;
		} else {
			$bn = "Book id#$bid";
		}
		$s_book_names[$bid]=$bn;
	}
	return $bn;
}

function isedoc_node_ids_by_title($title,$type='') {
	if ($type == '') {
		$sql_type = '';
	} else {	
		if (is_array($type)) {
			$sql_type = '(';
			foreach($type as $t) {
				$sql_type .= " n.type = '$t' OR";
			}
			$sql_type = substr($sql_type,0, -2);
			$sql_type .= ')';
		} else {
			$sql_type = " n.type = '$type' AND ";
		}
	}
        $sql = "SELECT n.nid, n.title, n.vid FROM {node} n INNER JOIN {node_revisions} r ON n.nid = r.nid AND n.vid = r.vid WHERE $sql_type LOWER(r.title) = LOWER('%s') ORDER BY nid";
	$res = db_query($sql, $title);
	if ($res === FALSE) {
		return FALSE;
	} else {
		$nids = array();
		while ($v = db_fetch_array($res)) {
			$nids[] = $v['nid'];
		}
		return $nids;
	}
}

function isedoc_node_ids_by_uuid($uuid) {
	$sql = "SELECT nid, vid FROM {content_type_".'doc'."} WHERE LOWER(field_uuid_value) = LOWER('%s') ORDER BY nid ASC ,vid ASC";
	$res = db_query($sql, $uuid);
	if ($res === FALSE) {
		return FALSE;
	} else {
		$nids = array();
		while ($v = db_fetch_array($res)) {
			$nid = $v['nid'];
			$vid = $v['vid'];
			//drupal_set_message("nid=$nid; v=$vid");
			$nids[$nid] = $vid;
		}
		return $nids;
	}
}

/*
 * Query References
 */

function isedoc_pages_referencing_image($a_title) {
	$l_body_filter = 'REGEXP \'[[.[.]][[.[.]]Image:[:blank:]*'.strtolower($a_title).'[:blank:]*([[.|.]]|[[.].]][[.].]])\'';
        $sql = "SELECT n.nid, n.title, n.vid FROM {node} n INNER JOIN {node_revisions} r ON n.nid = r.nid AND n.vid = r.vid WHERE n.type = 'doc' AND LOWER(r.body) $l_body_filter ";
	$sql .= " ORDER BY n.nid, n.vid ";
        $res = db_query($sql);
	$result = array();
	if ($res === FALSE) {
		return FALSE;
	} else {
		while ($r = db_fetch_array($res)) {
			$result[$r['nid']] = $r;
		}
		return $result;
	}
}

function isedoc_pages_referencing_template($a_title) {
	$l_body_filter = 'REGEXP \'[[.left-brace.]][[.left-brace.]][:blank:]*'.strtolower($a_title).'[:blank:]*[[.|.]]\'';
        $sql = "SELECT n.nid, n.title, n.vid FROM {node} n INNER JOIN {node_revisions} r ON n.nid = r.nid AND n.vid = r.vid WHERE n.type = 'doc' AND LOWER(r.body) $l_body_filter ";
	$sql .= " ORDER BY n.nid, n.vid ";
        $res = db_query(db_rewrite_sql($sql));
	$result = array();
	if ($res === FALSE) {
		return FALSE;
	} else {
		while ($r = db_fetch_array($res)) {
			$result[$r['nid']] = $r;
		}
		return $result;
	}
}

function isedoc_pages_referencing($a_title) {
	$l_body_filter = 'REGEXP \'[[.[.]][[.[.]][:blank:]*'.strtolower($a_title).'[:blank:]*([[.|.]]|[[.].]][[.].]])\'';
        //$l_body_filter = 'LIKE LOWER(\'%[['.$a_title.'%\')';
        $sql = "SELECT n.nid, n.title, n.vid FROM {node} n INNER JOIN {node_revisions} r ON n.nid = r.nid AND n.vid = r.vid WHERE n.type = 'doc' AND LOWER(r.body) $l_body_filter ";
	$sql .= " ORDER BY n.nid, n.vid ";
        $res = db_query($sql);
	$result = array();
	if ($res === FALSE) {
		return FALSE;
	} else {
		while ($r = db_fetch_array($res)) {
			$result[$r['nid']] = $r;
		}
		return $result;
	}
}

function _isedoc_file_content($a_fn) {
	$l_fp = fopen($a_fn, "r");
	$contents = fread($l_fp, filesize($a_fn));
	fclose($l_fp);
	return $contents;
}

?>
