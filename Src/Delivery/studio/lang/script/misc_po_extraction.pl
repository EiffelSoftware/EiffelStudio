#!/bin/perl
#This script extracts miscellious

# File testing
unless (open DATABASE, "../../eifinit/default.xml") {
	die "Error: Couldn't open ../../eifinit/default.xml: $!; aborting";
}

unless (open DATABASE, "../../eifinit/spec/unix/default.xml") {
	die "Error: Couldn't open ../../eifinit/spec/unix/default.xml: $!; aborting";
}

unless (open DATABASE, "../../eifinit/spec/windows/default.xml") {
	die "Error: Couldn't open ../../eifinit/spec/windows/default.xml: $!; aborting";
}

unless (open DATABASE, "../../eifinit/code_analysis.xml") {
	die "Error: Couldn't open ../../eifinit/code_analysis.xml: $!; aborting";
}

unless (open POT_FILE, ">>../po_files/estudio.pot") {
	die "Error: Couldn't open ../po_files/estudio.pot: $!; aborting";
}

my @pm_files = glob "../../wizards/new_projects/*.dsc";
foreach $dsc_file (@pm_files){
	unless (open DATABASE, $dsc_file) {
		die "Error: Couldn't open $dsc_file: $!; aborting";
	}
}

select POT_FILE;
#print "msgid \"\"\n";
#print "msgstr \"\"\n";
#print "\"Language-Team: YOUR TEAM HERE\\n\"\n";
#print "\"Content-Type: text/plain; charset=UTF-8\\n\"\n";
#print "\"Content-Transfer-Encoding: 8bit\\n\"\n";
#print "\"Plural-Forms: nplurals=2; plural=n>1;\\n\"\n";
#print "\"MIME-Version: 1.0\\n\"\n";
#print "\"Last-Translator: YOUR NAME HERE\\n\"\n\n";

# Extracting names and descriptions from preference xml files.
unless (open DATABASE, "../../eifinit/default.xml") {
	die "Error: Couldn't open default.xml: $!; aborting";
}
&extract ("\$EIFFEL_SRC/Delivery/studio/eifinit/default.xml");
unless (open DATABASE, "../../eifinit/spec/windows/default.xml") {
	die "Error: Couldn't open default.xml: $!; aborting";
}
&extract ("\$EIFFEL_SRC/Delivery/studio/eifinit/spec/windows/default.xml");
unless (open DATABASE, "../../eifinit/spec/unix/default.xml") {
	die "Error: Couldn't open default.xml: $!; aborting";
}
&extract ("\$EIFFEL_SRC/Delivery/studio/eifinit/spec/unix/default.xml");

unless (open DATABASE, "../../eifinit/code_analysis.xml") {
	die "Error: Couldn't open code_analysis.xml: $!; aborting";
}
&extract ("\$EIFFEL_SRC/Delivery/studio/eifinit/code_analysis.xml", "code_analysis.preference");

# Extracting names from wizard discription files.
foreach $dsc_file (@pm_files){
	unless (open DATABASE, $dsc_file) {
		die "Error: Couldn't open $dsc_file: $!; aborting";
	}
	$count = 0;
	$dsc_file =~ /[\\\/]([^\\\/]+\.dsc)/i;
	$file_name = $1;
	while ($line = <DATABASE>) {
		$o_line = $line;
		$count = $count + 1;
		chomp;
		if ($line =~ /NAME\s*=\s*\"((?:[^"]|\"\")+)\"/i) {
			$extracted = $1;
			print "#. $o_line\n";
			print "#: $file_name:$count\n";
			print "msgctxt \"wizard\"\n";
			print "msgid \"$extracted\"\n";
			print "msgstr \"\"\n\n";
		}
	}
}

select STDOUT;

# Arguments:
# 0 - file name
# 1 (optional) - context
sub extract {
	$count = 0;
	while ($line = <DATABASE>) {
		$count = $count + 1;
		$o_line = $line;
		$file_name = $_[0];
		$context = $_[1] ? $_[1] : "preference";
		chomp;
		if ($line =~ /DESCRIPTION\s*=\s*\"((?:[^"]|\"\")+)\"/i) {
			$extracted = &escape_xml ($1);
			print "#. $o_line\n";
			print "#: $file_name:$count\n";
			print "msgctxt \"$context\"\n";
			print "msgid \"$extracted\"\n";
			print "msgstr \"\"\n\n";
		}
		if ($line =~ /NAME\s*=\s*\"((?:[^"]|\"\")+)\"/i) {
				# A name is in the form of "parent1.parent2.shortname" 
				# where "parent1.parent2" can be "word1_word2.word3_word4" 
				# and "shortname" can be "word1_word2_word3".
			@spit_parent = split /\./, $1;
			foreach $parent (@spit_parent){
					# Follow the algorithm of {PREFERENCES_GRID}.formatted_name
					# to ensure that i18n can find strings extracted.
				$words = &upper_case (&make_words ($parent));
				print "#. $o_line\n";
				print "#: $file_name:$count\n";
				print "msgctxt \"$context\"\n";
				print "msgid \"$words\"\n";
				print "msgstr \"\"\n\n";
			}
		}
	}
}

sub escape_xml {
	$_ = $_[0];
	s/\"\"/\"/g;
	s/%N/\\n/g;
	s/\&lt\;/</g;
	s/\&gt\;/>/g;
	s/\&amp\;/&/g;
	s/\&apos\;/'/g;
	s/\&quot\;/"/g;
	$_;
}

sub make_words {
	$_ = $_[0];
		# Replace "_" with space if there are no spaces inside.
	s/_/ /g if /^\S*$/;
	$_;
}

sub upper_case {
	$_ = $_[0];
	s/(.)/\U$1/;
	$_;
}

