;# $Id: users.pl 78389 2004-11-30 00:17:17Z manus $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# Original Author: Graham Stoney <greyham@research.canon.oz.au>
;#
;# $Log$
;# Revision 1.1  2004/11/30 00:17:18  manus
;# Initial revision
;#
;# Revision 3.0.1.2  1993/11/10  17:41:37  ram
;# patch14: adapted users file format to new @SH package command
;#
;# Revision 3.0.1.1  1993/08/24  12:23:19  ram
;# patch3: added some comments about the users file format
;# patch3: random cleanup
;#
;# Revision 3.0  1993/08/18  12:11:02  ram
;# Baseline for dist 3.0 netwide release.
;#
;# The users file, as built by mailagent upon reception of an '@SH package'
;# command contains a list of e-mail addresses, prefixed by a single letter.
;# Users tagged with 'U' or 'L' are plain users, those with 'M' wish to
;# receive issued patches by e-mail while 'N' users simply want to be notified
;# when a new patch is released;
;#
sub readusers {
	return unless open(USERS, 'users');
	local($_);
	local($status, $name, $pl);
	while (<USERS>) {
		next if /^#/;
		chop if /\n$/;				# Emacs may leave final line without \n
		($status, $pl, $name) = split;
		# Handle oldstyle two-field user file format (PL13 and before)
		$name = $pl unless defined $name;
		if ($status eq 'M') {
			$recipients = $recipients ? "$recipients $name" : $name;
		} elsif ($status eq 'N') {
			$notify = $notify ? "$notify $name" : $name;
		}
	}
	close USERS;
}

