;# $Id: fullname.pl 78389 2004-11-30 00:17:17Z manus $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# $Log$
;# Revision 1.1  2004/11/30 00:17:18  manus
;# Initial revision
;#
;# Revision 3.0  1993/08/18  12:10:52  ram
;# Baseline for dist 3.0 netwide release.
;#
;#
sub getfullname {
	local($logname) = @_;
	local($foo,$bar);
	if ($ENV{'NAME'}) {
		$ENV{'NAME'};
	} else {
		open(PASSWD,'/etc/passwd') || die "Can't open /etc/passwd";
		while (<PASSWD>) {
			/(\w+):/;
			last if $1 eq $logname;
		}
		close PASSWD;
		local($login,$passwd,$uid,$gid,$gcos,$home,$shell) = split(/:/);
		if (-f "$home/.fullname") {
			open(FN,"$home/.fullname");
			chop($foo = <FN>);
			close FN;
			$foo;
		} elsif ($nametype eq 'bsd') {
			$gcos =~ s/[,;].*//;
			if ($gcos =~ /&/) {		# oh crud
				($foo,$bar) = ($logname =~ /(.)(.*)/);
				$foo =~ y/a-z/A-Z/;
				$gcos =~ s/&/$foo$bar/;
			}
			$gcos;
		} else {
			$gcos =~ s/[(].*//;
			$gcos =~ s/.*-//;
			$gcos;
		}
	}
}

