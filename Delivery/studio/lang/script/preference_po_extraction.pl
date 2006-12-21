#!/bin/perl
#This script extracts descriptions from default.xml,
#and put them into generated preference.pot file.

unless (open DATABASE, "../../eifinit/default.xml") {
	die "Error: Couldn't open default.xml: $!; aborting";
}

unless (open DATABASE, "../../eifinit/spec/unix/default.xml") {
	die "Error: Couldn't open default.xml: $!; aborting";
}

unless (open POT_FILE, ">>../po_files/estudio.pot") {
	die "Error: Couldn't open estudio.pot: $!; aborting";
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
unless (open DATABASE, "../../eifinit/default.xml") {
	die "Error: Couldn't open default.xml: $!; aborting";
}
&extract;
unless (open DATABASE, "../../eifinit/spec/windows/default.xml") {
	die "Error: Couldn't open default.xml: $!; aborting";
}
&extract;
unless (open DATABASE, "../../eifinit/spec/windows/default.xml") {
	die "Error: Couldn't open default.xml: $!; aborting";
}
&extract;
select STDOUT;

sub extract {
	while ($line = <DATABASE>) {
		chomp;
		if ($line =~ /DESCRIPTION\s*=\s*\"((?:[^"]|\"\")+)\"/i) {
			$extracted = &escape_xml ($1);
			print "msgid \"$extracted\"\n";
			print "msgstr \"\"\n\n";
		}
		if ($line =~ /NAME\s*=\s*\"((?:[^"]|\"\")+)\"/i) {
				# A name is in the form of "parent1.parent2.shortname" 
				# where "parent1.parent2" can be "word1_word2.word3_word4" 
				# and "shortname" can be "word1_word2_word3".
			@spit_parent = split /\./, $1;
			foreach $parent (@spit_parent){
					# Follow the algerithm of {PREFERENCES_GRID}.formatted_name
					# to ensure that i18n can find strings extracted.
				$words = &upper_case (&make_words ($parent));
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
		# Replace "_" with space.
	s/_/ /g;
	$_;
}

sub upper_case {
	$_ = $_[0];
	s/(.)/\U$1/;
	$_;
}

