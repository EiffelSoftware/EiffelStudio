#!/bin/perl
#This script extracts descriptions from default.xml,
#and put them into generated preference.pot file.

unless (open DATABASE, "../../eifinit/default.xml") {
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
while (<DATABASE>) {
	chomp;
	if (/DESCRIPTION\s*=\s*\"((?:[^"]|\"\")+)\"/i) {
		$_ = $1;
		s/\"\"/\"/g;
		s/%N/\\n/g;
		s/\&lt\;/</g;
		s/\&gt\;/>/g;
		s/\&amp\;/&/g;
		s/\&apos\;/'/g;
		s/\&quot\;/"/g;
		print "msgid \"$_\"\n";
		print "msgstr \"\"\n\n";
	}
}
select STDOUT;
