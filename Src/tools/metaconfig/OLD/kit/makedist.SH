case $CONFIG in
'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. $TOP/config.sh
	;;
esac
echo "Extracting kit/makedist (with variable substitutions)"
cat >makedist <<!GROK!THIS!
$startperl
	eval "exec perl -S \$0 \$*"
		if \$running_under_some_shell;

# $Id: makedist.SH 78389 2004-11-30 00:17:17Z manus $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# $Log$
# Revision 1.1  2004/11/30 00:17:18  manus
# Initial revision
#
# Revision 3.0.1.2  1994/01/24  13:58:20  ram
# patch16: modified call to manifake to trap exceptions manually
# patch16: removed final sed post-processing to allow 'make depend' target
# patch16: added ~/.dist_profile awareness
#
# Revision 3.0.1.1  1993/08/19  06:42:17  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:28  ram
# Baseline for dist 3.0 netwide release.
#

\$version = '$VERSION';
\$patchlevel = '$PATCHLEVEL';
!GROK!THIS!
$spitshell >>makedist <<'!NO!SUBS!'

&profile;					# Read ~/.dist_profile
require 'getopts.pl';
&usage unless &Getopts('c:f:dhvqs:V');

$ENV{'DIST'} = '/dev/null';	# Disable ~/.dist_profile

if ($opt_V) {
	print STDERR "makedist $version PL$patchlevel\n";
	exit 0;
} elsif ($opt_h) {
	&usage;
}

$MAXKITSIZE = 50000 unless $MAXKITSIZE = $opt_s;
$KITOVERHEAD = 1800;
$FILEOVERHEAD = 90;
$CHOPSIZE = $MAXKITSIZE - $KITOVERHEAD - $FILEOVERHEAD;

$NEWMANI = 'MANIFEST.new' unless $NEWMANI = $opt_f;
$MANI = 'MANIFEST' unless $opt_f;
$PACKLIST = 'PACKLIST';
$PACKNOTES = 'PACKNOTES';

$tmpdir = "/tmp/MKst$$";	# Where to copy distribution
$tmpdir = '.' if $opt_q;	# Quick mode: no need to copy distribution

&set_sig('aborted');		# Make sure we clean up in case of emergency

&readpackage;
&get_patchlevel;

eval '&manifake';			# Want to trap possible die and redirect to fatal
if ($@ ne '') {
	chop($@);
	&fatal($@);
}

if ($opt_c) {				# Copy distribution only, no shell archive
	&distcopy;
	exit 0;
}

&distfake;
&copyright'init($copyright) if -f $copyright;

unlink <$package.kit? $package.kit??>;
chop($curdir = `pwd`);
chdir $tmpdir || die "Can't chdir to $tmpdir.\n";

&maniread;
&kitlists;
&manimake;
&kitbuild;
&cleanup;
exit 0;

# Physically build the kits
sub kitbuild {
	$numkits = $#list;
	if ($numkits > 9) {
		$sp = '%02d';
	} else {
		$sp = '%d';
	}

	for ($kitnum = 1; $kitnum <= $numkits; $kitnum++) {
		$list = $list[$kitnum];
		$kit = sprintf("$package.kit" . $sp,$kitnum);
		print "*** Making $kit ***\n";
		open(KIT,">$curdir/$kit") || do fatal("Can't create $curdir/$kit: $!");

		&kitleader;

		@files = split(' ',$list);
		reset 'X';
		for $file (@files) {
			$_ = $file;
			while (s|^(.*)/.*$|$1|) {
				push(@Xdirs,$_) unless $Xseen{$_}++;
			}
		}
		print KIT "mkdir ",join(' ', sort @Xdirs)," 2>/dev/null\n";

		foreach $file (@files) {
			print "\t",$file,"\n" if $opt_v;
			print KIT "echo Extracting $file\n";
			print KIT "sed >$file <<'!STUFFY!FUNK!' -e 's/X//'\n";
			open(FILE, $file);
			&copyright'reset;			# Reset copyright for new file
			while (<FILE>) {
				# Use Lock[e]r as a pattern in case it is applied on ourselves
				s|Lock[e]r:.*\$|\$|;	# Remove locker mark
				print KIT &copyright'filter($_, 'X');
			}
			close FILE;
			print KIT "!STUFFY!FUNK!\n";
			-x "$file" && (print KIT "chmod +x $file\n");
		}
		&kittrailer;
		chmod 0755, $kit;
	}
}

sub kitlists {
	for $filename (keys %comment) {
		next if $filename =~ m|/$|;		# Skip directories
		next if -d $filename;			# Better safe than sorry
		($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,
		   $blksize,$blocks) = stat($filename);

		# Make sure file is not larger than the CHOPSIZE limit. If it is,
		# a split is attempted.
		if ($size > $CHOPSIZE) {
			print "Splitting $filename...\n" if $opt_v;
			$file_comment = $comment{$filename};
			open(FILE, $filename) || die "Can't open $filename: $!\n";
			$piece = 'AA';
			($dir, $name) = ('.', $filename)
				unless ($dir, $name) = ($filename =~ m|(.*)/(.*)|);
			$chopped = $dir . '/' . substr($name, 0, 11);
			$chopped =~ s|^\./||;
			&fatal("There is already a split file named $chopped")
				if defined $Chopped{$chopped};
			$Chopped{$chopped} = $filename;	# Association split <-> real file
			$size = 0;
			open(CURPIECE, ">$chopped:$piece") ||
				&fatal("Can't create $chopped:$piece: $!");
			while (<FILE>) {
				if ($size + length($_) > $CHOPSIZE) {
					close CURPIECE;
					$size{"$chopped:$piece"} = $size;
					$comment{"$chopped:$piece"} = "$file_comment (part $piece)";
					push(@files, "$chopped:$piece");
					print "\t$chopped:$piece ($size bytes)\n" if $opt_v;
					$size = 0;
					$piece++;		# AA -> AB, etc...
					open(CURPIECE, ">$chopped:$piece") ||
						&fatal("Can't create $chopped:$piece: $!");
				}
				print CURPIECE $_;
				$size += length($_);
			}
			close FILE;
			close CURPIECE;
			$size{"$chopped:$piece"} = $size;
			$comment{"$chopped:$piece"} = "$file_comment (part $piece)";
			push(@files, "$chopped:$piece");
			print "\t$chopped:$piece ($size bytes)\n" if $opt_v;
			delete $comment{$filename};		# File split, not in PACKLIST
		} else {
			$size += 1000000 if $filename =~ /README/;
			$size{$filename} = $size;
			push(@files, "$filename");
		}
	}

	# Build a file PACKNOTES to reconstruct split files
	if (defined %Chopped) {
		open(PACKNOTES, ">$PACKNOTES") || &fatal("Can't create PACKNOTES: $!");
		foreach (keys %Chopped) {
			print PACKNOTES <<EOC;
echo 'Building $Chopped{$_}...'
cat $_:[A-Z][A-Z] > $Chopped{$_}
rm -f $_:[A-Z][A-Z]
EOC
		}
		close PACKNOTES;
		push(@files, $PACKNOTES);
		$comment{$PACKNOTES} = 'Script to reconstruct split files';
		($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,
		   $blksize,$blocks) = stat($PACKNOTES);
		$size{$PACKNOTES} = $size;
	}

	# Currently, file PACKLIST does not exist, so its size is unknown and
	# it cannot be correctly put in one archive. Therefore, we take the
	# size of MANIFEST.new, which will give us a good estimation.
	push(@files, 'PACKLIST');

	($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime,$ctime,
	   $blksize,$blocks) = stat($NEWMANI);
	$size{$PACKLIST} = $size;

	sub revnum { $size{$a} < $size{$b} ? 1 : $size{$a} > $size{$b} ? -1 : 0; }
	@files = sort revnum @files;

	for (@files) {
		$size = $size{$_};
		$size -= 1000000 if /README/;
		$i=1;
		while (($newtot = int($tot[$i] + $size + $size/40 + $FILEOVERHEAD)) >
			$MAXKITSIZE-$KITOVERHEAD && $tot[$i]) {
				$i++;
		}
		$tot[$i] = $newtot;
		print "Adding $_ to kit $i giving $newtot bytes\n" if $opt_d;
		$kit{$_} = $i;
		$list[$i] .= " $_";
	}
}

# Read manifest file and initialize the %comment array.
sub maniread {
	do fatal("You don't have a $NEWMANI file.  Run manifake")
		unless -f "$NEWMANI";
	open(NEWMANI,$NEWMANI) || do fatal("Can't read $NEWMANI: $!");
	while (<NEWMANI>) {
		($key,$val) = split(' ',$_,1) unless ($key,$val) = /^(\S+)\s+(.*)/;
		$comment{$key} = $val;
	}
	close NEWMANI;
}

# MANIFEST and MANIFEST.new must say the same thing.  Create the
# PACKLIST file (thus avoiding kit numbers in MANIFEST, which causes big
# patches when only re-ordering occurred).  Note that PACKLIST should
# not appear in MANIFEST.new (the user may remove it).
sub manimake {
	# Add built packlist
	$comment{$PACKLIST} = 'Which files came with which kits';

	open(PACKLIST, ">$PACKLIST") || do fatal("Can't create $PACKLIST: $!");
	print PACKLIST
"After all the $package kits are run you should have the following files:

Filename                   Kit Description
--------                   --- -----------
";
	for (sort keys(comment)) {
		printf PACKLIST "%-27s %2s %.47s\n", $_, $kit{$_}, $comment{$_};
	}
	close PACKLIST;
}

sub kitleader {
	local($plevel);
	$plevel = " at patchlevel $patch_level" if $patch_level ne '';
	print KIT <<EOH;
#! /bin/sh
#
# This is $package version $baserev$plevel.
# Make a new directory for the $package sources, cd to it, and run kits 1 up
# to $numkits through sh.  When all $numkits kits have been run, read README.
#
echo " "
cat <<EOM
This is $package $baserev$plevel, kit $kitnum (of $numkits):
If this shell archive is complete, the line "End of kit $kitnum (of $numkits)"
will echo at the end.
EOM
export PATH || (echo "Please use sh to unpack this archive." ; kill \$\$)
EOH
}

sub kittrailer {
	$rangelist = '';
	for ($i = 1; $i <= $numkits; $i++) {
		$rangelist .= ' ' . $i;
	}
	print KIT <<EOM;
echo \"End of kit $kitnum (of $numkits)\"
echo \" \"
cat /dev/null >kit${kitnum}isdone
run=''
config=''
for iskit in$rangelist; do
	if test -f kit\${iskit}isdone; then
		run=\"\$run \$iskit\"
	else
		todo=\"\$todo \$iskit\"
	fi
done
case \$todo in
	'')
		echo \"You have run all your kits.\"
EOM
	if (defined %Chopped) {		# Some splitting occurred
		print KIT <<EOM;
		if test -f $PACKNOTES; then
			sh $PACKNOTES
		else
			echo \"You have to rebuild split files by hand (see $PACKLIST).\"
		fi
EOM
	}
	if (-f "README" && -f "Configure") {
		print KIT
"		echo \"Please read README and then type Configure.\"
		chmod 755 Configure\n";
	} elsif (-f "README") {
		print KIT
"		echo \"Please read README first.\"\n";
	} elsif (-f "Configure") {
		print KIT
"		echo \"Please run Configure first.\"
		chmod 755 Configure\n";
	}
	print KIT <<EOM;
		rm -f kit*isdone
		;;
	*)  echo \"You have run\$run.\"
		echo \"You still need to run\$todo.\"
		;;
esac
: Someone might mail this, so exit before signature...
exit 0
EOM
}

sub get_patchlevel {
	$patch_level = '';
	if (-f 'patchlevel.h') {
		open(PL, 'patchlevel.h');
		while (<PL>) {
			/^#define\s+PATCHLEVEL\s+(\w+)/ && ($patch_level = $1);
		}
		close PL;
	}
}

sub distfake {
	return if $opt_q;
	local($sw);
	$sw = 's' unless $opt_v;
	mkdir($tmpdir, 0700) || die "Can't create directory $tmpdir.\n";
	print "Building a copy of distribution in $tmpdir...\n" if $opt_v;
	system 'perl', '-S', 'patcol', "-a$sw", '-f', $NEWMANI, '-d', $tmpdir;
	system 'cp', $NEWMANI, "$tmpdir/$NEWMANI"
		unless -f "$tmpdir/$NEWMANI" && !$opt_f;
}

sub distcopy {
	local($sw);			# Switch to force patcol to copy checked out files
	&makedir($opt_c);
	print "Building a copy of distribution in $opt_c...\n" if $opt_v;
	$sw = 'c' if $opt_q;
	$sw .= 's' unless $opt_v;
	system 'perl', '-S', 'patcol', "-aRC$sw", '-f', $NEWMANI, '-d', $opt_c;
}

sub distrm {
	return if $opt_q;
	print "Removing distribution in $tmpdir...\n" if $opt_v;
	chdir "/";			# Do not stay in removed directory...
	system '/bin/rm', '-rf', "$tmpdir";
}

sub splitrm {
	foreach $base (keys %Chopped) {
		print "Removing split files for $base:\n" if $opt_v;
		$piece = 'AA';
		while (-f "$base:$piece") {
			print "\t$base:$piece\n" if $opt_v;
			unlink "$base:$piece";
			$piece++;		# AA -> AB, etc...
		}
	}
}

sub cleanup {
	&distrm if -d $tmpdir;
	if ($opt_q) {
		&splitrm;		# Remove in-place split files
		unlink $PACKLIST, $PACKNOTES;
	}
}

sub fatal {
	local($reason) = shift(@_);
	&cleanup;
	die "$reason\n";
}

sub set_sig {
	local($handler) = @_;
	$SIG{'HUP'} = $handler;
	$SIG{'INT'} = $handler;
	$SIG{'QUIT'} = $handler;
	$SIG{'TERM'} = $handler;
}

sub aborted {
	&set_sig('IGNORE');
	$opt_v = 1;		# Force verbose message in distrm
	&cleanup;
	print "Aborted.\n";
	exit 1;
}

sub usage {
	print STDERR <<EOM;
Usage: makedist [-dhqvV] [-c dir] [-s size] [-f manifest]
  -c : copy files in dir, do not build any shell archive.
  -d : debug mode.
  -f : use this file as manifest.
  -h : print this help message and exits.
  -q : quick mode: use checked-out files.
  -s : set maximum pack size.
  -v : verbose mode.
  -V : print version number and exits.
EOM
	exit 1;
}

!NO!SUBS!
$grep -v '^;#' ../pl/package.pl >>makedist
$grep -v '^;#' ../pl/manifake.pl >>makedist
$grep -v '^;#' ../pl/copyright.pl >>makedist
$grep -v '^;#' ../pl/makedir.pl >>makedist
$grep -v '^;#' ../pl/tilde.pl >>makedist
$grep -v '^;#' ../pl/profile.pl >>makedist
chmod +x makedist
$eunicefix makedist
