<?php
// $Id: ise_ctr.inc,v 1.1.2.8.2.11 2010/02/27 05:57:03 heyrocker Exp $

/**
 * @file
 *  Link general user functionalities to services module.
 */

/**
 * Return range of know logs
 */
function ise_ctr_get_logs_range($repo) {
  if (strlen($repo) == 0) {
    return services_error(t('There is no such repository.'), 404);
  }
  return array(10, 350);
}

/**
 * Return missing logs from range of logs
 */
function ise_ctr_get_missing_logs($repo, $lower, $upper) {
  $l = intval($lower);
  $u = intval($upper);
  if (strlen($repo) == 0) {
    return services_error(t('There is no such repository.'), 404);
  }
  return array($l + 1, $u - 5);
}


/**
 * Return Log's information
 *
 * @param $rev
 *   revision of the log
 *
 */
function ise_ctr_get_log($repo, $rev) {
  $r = intval($rev);
  if ($r == 0) {
    return services_error(t('There is no such log.'), 404);
  }
  return "Revision #$r ...";
}

/**
 * Return review's information
 *
 * @param $rev
 *   revision of the log
 *
 */
function ise_ctr_get_review($repo, $rev, $user) {
  $r = intval($rev);
  if ($r == 0) {
    return services_error(t('There is no such revision.'), 404);
  }
  if ($user) {
	  return "Review #$r from user [$user]...";
  } else {
	  return "Review #$r ...";
  }
}


/**
 * Post logs data / upload
 */
function ise_ctr_post_logs($repo, $value) {
  if (strlen($repo) == 0) {
    return services_error(t('There is no such repository.'), 404);
  }
  return array(1, 5);
}

/**
 * Post review information
 *
 * @param $rev
 *   revision of the log
 * @param $rev
 *   revision of the log
 * @param $rev
 *   revision of the log
 *
 */
function ise_ctr_post_review($repo, $rev, $user, $data) {
//drupal_set_message ("ise.ctr.post_review: $data");
  $r = intval($rev);
  $response = "Post for rev#$r : $type [$value]\n";
  if ($r == 0) {
    return services_error(t('There is no such log.'), 404);
  }
  watchdog('ise', t("$rev"));
  foreach ($data as $d) {
    $response .= " data=$d \n";
	watchdog('ise', t("ise.ctr.post_review: $d"));
  }
  return $response;
}

/**
 * Access rules
 */

function ise_ctr_read_access($uid) {
  global $user;
  return user_access('access content');
}
function ise_ctr_write_access($uid) {
  global $user;
  return user_access('edit content');
}

function ise_ctr_post_review_access($uid) {
  return ise_ctr_write_access($uid);
}

function ise_ctr_log_access($uid) {
  return ise_ctr_read_access($uid);
}

