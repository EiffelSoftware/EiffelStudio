#!/usr/bin/perl -w
#===============================================================================
# gen_indexing_features.pl
#===============================================================================

# Did we get a source path on the command line?
if ($#ARGV != 0) {
	print ("usage: gen_indexing_features.pl path_to_source\n");
	exit 1
}
$dir = $ARGV[0];

# Get a list of source files.
@hfiles = `find $dir -name '*.e'`;
if (@hfiles == 0) {
	# Can't find them.
	print ("$dir? Sorry, I can't see any Eiffel source files there.\n");
	exit 1;
}

$descriptions = "";
$keywordss = "";

# Look at each file.
foreach (@hfiles) {
	$file = $_;
	open (EFILE, $file);
	$description = "";
	while (<EFILE>) {
		if (/	description:?/) {
			while (<EFILE>) {
				if (/^[^%:]*:/) {
					last;
				} else {
					$description = "$description$_\n";
				}
			}
		}
	}
	close (EFILE);
	if ($description eq "") {
		$description = "\"No description\"";
	}

	$keywords = "";
	open (EFILE, $file);
	while (<EFILE>) {
		if (/	keywords: *([^;]*)/) {
			$keywords = $1;
			chomp $keywords;
			$keywords =~ s/\" *//g;
			$keywords =~ s/, /,/g;
			$keywords =~ s/([^,]+)/\"$1\"/g;
		}
	}
	close (EFILE);

	open (EFILE, $file);
	while (<EFILE>) {
		if (/^class|^deferred class/) {
			while (<EFILE>) {
				s/[ 	\n]*//g;
				$class = $_;
				last;
			}
			last;
		}
	}
	close (EFILE);

	$descriptions = "$descriptions\n			Result.force ($description, \"$class\")";
	$keywordss = "$keywordss\n			Result.force (<<$keywords>>, \"$class\")";

}


print <<EOT;
indexing
	description:
		"Eiffel Vision internal information."
	status: "Generated!"
	keywords: "internal, description, keyword"
	date: "Generated!"
	revision: "Generated!"

class
	EV_INTERNAL

feature -- Access

	descriptions: HASH_TABLE [STRING, STRING] is
			-- Table of class descriptions by name.
		once
			create Result.make(100)
			$descriptions
		end

	keywords: HASH_TABLE [LINKED_LIST [STRING], STRING] is
			-- Table of class keywords by name.
		once
			create Result.make(100)
			$keywordss
		end

	classes_by_keyword: HASH_TABLE [LINKED_LIST [STRING], STRING] is
			-- Table of classes by keyword.
		local
			kwt: HASH_TABLE [LINKED_LIST [STRING], STRING]
			kws: LINKED_LIST [STRING]
			kwd: STRING
			cls: STRING
			ci: CURSOR
			cj: CURSOR
		once
			create Result.make(100)
			kwt := keywords
			ci := kwt.cursor
			from
				kwt.start
			until
				kwt.after
			loop
				kws := kwt.item_for_iteration
				cls := kwt.key_for_iteration
				cj = kws.cursor
				from
					kws.start
				until
					kws.after
				loop
					kwd := kws.item	
					if Result.item (kwd) = Void then
						Result.put (create {LINKED_LIST [STRING]}.make, kwd)
					end
					Result.item (kwd).extend (cls)
					kws.forth
				end
				kws.go_to (cj)
				kwt.forth
			end
			kwt.go_to (ci)
		end

end -- class EV_INTERNAL
EOT

#===============================================================================
# End of file
#===============================================================================

#===============================================================================
# CVS log
#===============================================================================
#
# $Log$
# Revision 1.1  2000/02/29 18:48:24  oconnor
# initial
#
#===============================================================================
# End of CVS log
#===============================================================================
