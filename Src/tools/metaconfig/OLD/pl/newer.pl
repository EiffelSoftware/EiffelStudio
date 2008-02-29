;# $Id: newer.pl 78389 2004-11-30 00:17:17Z manus $
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
;# Revision 3.0.1.2  1994/01/24  14:33:48  ram
;# patch16: now also aborts when .newer file holds a single new-line
;#
;# Revision 3.0.1.1  1993/09/09  11:51:07  ram
;# patch9: now skips the 'users' file when computing newest file list
;#
;# Revision 3.0  1993/08/18  12:10:56  ram
;# Baseline for dist 3.0 netwide release.
;#
;#
sub newer {
	open(FIND, "find . -type f -newer patchlevel.h -print | sort |") ||
	die "Can't run find.\n";
	open(NEWER,">.newer") || die "Can't create .newer.\n";
	open(MANI,"MANIFEST.new");
	while (<MANI>) {
		($name,$foo) = split;
		$mani{$name} = 1;
	}
	close MANI;
	while (<FIND>) {
	s|^\./||;
	chop;
	next if m|^MANIFEST|;
	next if m|^PACKLIST$|;
	if (!$mani{$_}) {
		next if m|^MANIFEST.new$|;
		next if m|^Changes$|;
		next if m|^Wanted$|;
		next if m|^.package$|;
		next if m|^bugs|;
		next if m|^users$|;
		next if m|^UU/|;
		next if m|^RCS/|;
		next if m|/RCS/|;
		next if m|^config.sh$|;
		next if m|/config.sh$|;
		next if m|^make.out$|;
		next if m|/make.out$|;
		next if m|^all$|;
		next if m|/all$|;
		next if m|^core$|;
		next if m|/core$|;
		next if m|^toto|;
		next if m|/toto|;
		next if m|^\.|;
		next if m|/\.|;
		next if m|\.o$|;
		next if m|\.old$|;
		next if m|\.orig$|;
		next if m|~$|;
		next if $mani{$_ . ".SH"};
		next if m|(.*)\.c$| && $mani{$1 . ".y"};
		next if m|(.*)\.c$| && $mani{$1 . ".l"};
		next if (-x $_ && !m|^Configure$|);
	}
	print NEWER $_,"\n";
	}
	close FIND;
	close NEWER;
	print "Please remove unwanted files...\n";
	sleep(2);
	system '${EDITOR-vi} .newer';
	die "Aborted.\n" unless -s '.newer' > 1;
	@ARGV = split(' ',`cat .newer`);
}

