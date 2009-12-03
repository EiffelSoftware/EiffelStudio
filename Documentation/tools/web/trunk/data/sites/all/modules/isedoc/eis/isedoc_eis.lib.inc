<?php

require_once (dirname(__FILE__)."/../isedoc.lib.inc");

function _isedoc_eis_doc_mapping($a_uuid,$a_library,$a_cluster,$a_classname) {
//drupal_set_message("Query: SELECT puuid, psection FROM `isedoc_eis` WHERE uuid='$a_uuid' AND library='$a_library' AND cluster='$a_cluster' AND classname='$a_classname'");
 	$res = db_query("SELECT puuid, psection FROM {isedoc_eis} WHERE uuid='%s' AND library='%s' AND cluster='%s' AND classname='%s' ", 
			$a_uuid, $a_library, $a_cluster, $a_classname
 		);
	if ($res === FALSE) {
		//drupal_set_message("isedoc_eis: error");
	} else {
		$r = db_fetch_array($res);
		if ($r === FALSE) {
			//drupal_set_message("isedoc_eis: not found");
		} else {
			//drupal_set_message("isedoc_eis: OK, found ". $r['puuid']." " .$r['psection']);
			return array('section' => $r['psection'], 'docuuid' => $r['puuid']);
		}
	}
}

function _isedoc_eis_doc_mappers($a_docuuid='',$a_section='') {
	if (strlen($a_docuuid) == 0) {
		$res = db_query("SELECT * FROM {isedoc_eis}");
	} else {
		if (strlen($a_section) == 0) {
			$res = db_query("SELECT * FROM {isedoc_eis} WHERE puuid='%s'", strtolower($a_docuuid));
		} else {
			$res = db_query("SELECT * FROM {isedoc_eis} WHERE puuid='%s' AND psection='%s'", strtolower($a_docuuid), $a_section);
		}
	}
	if ($res === FALSE) {
		//drupal_set_message("isedoc_eis: error");
	} else {
		$mappers = array();
		while ($r = db_fetch_array($res)) {
			$mappers[] = $r;
		}
		return $mappers;
	}
}

function _isedoc_eis_info_to_string($info) {
	return $info['uuid'].'@'.$info['library'].'@'.$info['cluster'].'@'.$info['classname'].'='.$info['puuid'].'#'.$info['psection'];
}

function _isedoc_eis_save($info) {
	global $user;
	$res = db_query("SELECT * FROM {isedoc_eis} "
		." WHERE uuid='%s' AND library='%s' AND cluster='%s' AND classname='%s' ",
		strtoupper($info['uuid']), $info['library'], $info['cluster'], strtoupper($info['classname'])
	);
	if ($res and db_fetch_array($res)) {
		$res = db_query("UPDATE {isedoc_eis} SET uuid='%s', library='%s', cluster='%s', classname='%s', puuid='%s', psection='%s' "
			." WHERE uuid='%s' AND library='%s' AND cluster='%s' AND classname='%s' ",
			strtoupper($info['uuid']), $info['library'], $info['cluster'], strtoupper($info['classname']),
			strtolower($info['puuid']), $info['psection'],
			strtoupper($info['uuid']), $info['library'], $info['cluster'], strtoupper($info['classname'])
		);
		if ($res) {
			watchdog('isedoc', 'User %user updated EIS mapping "%eis"', array('%user' => $user->name, '%eis' => _isedoc_eis_info_to_string($info)), WATCHDOG_INFO);
		}
	} else {
		$res = db_query("INSERT INTO {isedoc_eis} (uuid, library, cluster, classname, puuid, psection) VALUES ('%s', '%s', '%s', '%s', '%s', '%s')",
			strtoupper($info['uuid']), $info['library'], $info['cluster'], strtoupper($info['classname']),
			strtolower($info['puuid']), $info['psection']
		);
		if ($res) {
			watchdog('isedoc', 'User %user added EIS mapping "%eis"', array('%user' => $user->name, '%eis' => _isedoc_eis_info_to_string($info)), WATCHDOG_INFO);
		}
	}
}

function _isedoc_eis_delete($info) {
	global $user;
	$res = db_query("SELECT * FROM {isedoc_eis} "
		." WHERE uuid='%s' AND library='%s' AND cluster='%s' AND classname='%s' ",
		strtoupper($info['uuid']), $info['library'], $info['cluster'], strtoupper($info['classname'])
	);
	if ($res and db_fetch_array($res)) {
		$res = db_query("DELETE FROM {isedoc_eis} "
			." WHERE uuid='%s' AND library='%s' AND cluster='%s' AND classname='%s' AND puuid='%s' AND psection=LOWER('%s')",
			strtoupper($info['uuid']), $info['library'], $info['cluster'], strtoupper($info['classname']),
			strtolower($info['puuid']), $info['psection']
		);
		if ($res) {
			drupal_set_message("Mapper deleted");
			if ($res) {
				watchdog('isedoc', 'User %user deleted EIS mapping "%eis"', array('%user' => $user->name, '%eis' => _isedoc_eis_info_to_string($info)), WATCHDOG_INFO);
			}
		} else {
			watchdog('isedoc', 'User %user tried to delete EIS mapping "%eis but ERROR occured"', array('%user' => $user->name, '%eis' => _isedoc_eis_info_to_string($info)), WATCHDOG_ERROR);
		}
	} else {
		drupal_set_message("Inexistant EIS mapper => no deletion");
	}
}

function _isedoc_eis_docinfo ($a_eis_info) {
	$l_section = 'content';
	$l_docuuid = '';
	if (isset($a_eis_info['uuid']))    { $l_uuid    = strtoupper($a_eis_info['uuid']); } else { $l_uuid    = ''; }
	if (isset($a_eis_info['library'])) { $l_library = $a_eis_info['library'];          } else { $l_library = ''; }
	if (isset($a_eis_info['cluster'])) { $l_cluster = $a_eis_info['cluster'];          } else { $l_cluster = ''; }
	if (isset($a_eis_info['classname']))   { $l_class   = strtoupper($a_eis_info['classname']);} else { $l_class   = ''; }

	$r = _isedoc_eis_doc_mapping($l_uuid,$l_library,$l_cluster,$l_class);
	if ($r == NULL) {
		$r = _isedoc_eis_doc_mapping($l_uuid,'','','');
		if ($r) {
			$r['suggested'] = true;
		}
	}
	
	if ($r) {
		return $r;
	} else {
		$l_docuuid = "0f0913fe-d71c-43d3-6c22-706c8ed5d4ad"; /* Solution's book */
		$r = array('section' => 'content', 'docuuid' => $l_docuuid);
		$r['suggested'] = true;
		//return $r;
		return;
	}
}

function _isedoc_eis_arguments($eis) {
	$eis_parts = explode ("@", $eis);
	if (!is_null($eis_parts)) {
		$c = count ($eis_parts);
		$eis_info['uuid'] = $eis_parts[0];
		$eis_info['library'] = '';
		$eis_info['cluster'] = '';
		$eis_info['classname'] = '';
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
			$eis_info['classname'] = $eis_parts[$i];
		} 
		return $eis_info;
	} else {
		return;
	}
}

function _isedoc_eis_mapping_to_string($eis,$eis_info,$docinfo,$view_mode=TRUE) {
	$output = "<h2>";
	$output .= t("EIS mapping: <strong>%eis</strong>.", array('%eis'=>$eis));
	$output .= '</h2>';
	if ($eis_info) {
		//$info_params = "";
		$output .= '<ul>';
		foreach ($eis_info as $k => $p) {
			if (strlen($p) > 0 ) {
				$output .= '<li><strong>' . $k . '</strong>:' . $p . '</li>';
				//$info_params .= " ($k=<b>$p</b>)";
			}
		}
		$output .= '</ul>';
		//drupal_set_message("EIS entry: " . $info_params);

		$l_uuid = $eis_info['uuid'];
		if (!empty($l_uuid)) {
			$l_section = "";

			$docref = $docinfo['section'];
			$docuuid = $docinfo['docuuid'];
			$doc_suggested = $docinfo['suggested'] == true;
			$output .= '<h3>';
			if ($doc_suggested) {
				$output .= '(No exact matching) Suggested mapping to ';
			} else {
				$output .= 'Mapped to ';
			}
			$output .= $docuuid;
			if (strlen($docref) > 0) { $output .= ' (section:' . $docref . ')'; }
			$output .= '</h3>';
			$output .= '<ul>';

			$nids = isedoc_node_ids_by_uuid($docuuid);
			if ($nids) {
				if (count($nids) == 1) {
					end(&$nids);
					$nid = key(&$nids);
					$vid = current(&$nids);
					$node =& node_load(array('nid' => $nid));
					if ($node and $node->vid == $vid) {
						// Check the version id...
						//drupal_set_message(t("Accessed by the UUID=%uuid.",array('%uuid' => $uuid)), 'status');
						if ($view_mode and !$doc_suggested) {
							drupal_goto($node->path,NULL,$docref);
						}

						$output .= '<li>' . isedoc_uuid_page_display(&$node,$docref) . '</li>';
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
			} else {
				$output .= '<li>'.t("No associated documentation page.").'</li>';
			}
			$output .= '</ul>';
		}
	}
	return $output;

}

?>
