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
	status: "See notice at end of class."
	keywords: "internal, description, keyword"

class
	EV_INTERNAL

feature -- Access

	class_descriptions: HASH_TABLE [STRING, STRING] is
			-- Table of class descriptions by name.
		once
			create Result.make(100)
			$descriptions
		end

	class_keywords: HASH_TABLE [ARRAY [STRING], STRING] is
			-- Table of class keywords by name.
		once
			create Result.make(100)
			$keywordss
		end

	classes_by_keyword: HASH_TABLE [LINKED_LIST [STRING], STRING] is
			-- Table of classes by keyword.
		local
			kwt: HASH_TABLE [ARRAY [STRING], STRING]
			kws: ARRAY [STRING]
			kwd: STRING
			cls: STRING
			i: INTEGER
			c: CURSOR
		once
			create Result.make(100)
			kwt := class_keywords
			c := kwt.cursor
			from
				kwt.start
			until
				kwt.after
			loop
				from
					kws := kwt.item_for_iteration
					cls := kwt.key_for_iteration
					i := 1
				until
					i > kws.count
				loop
					kwd := kws.item	(i)
					if Result.item (kwd) = Void then
						Result.put (create {LINKED_LIST [STRING]}.make, kwd)
					end
					Result.item (kwd).extend (cls)
					i := i + 1
				end
				kwt.forth
			end
			kwt.go_to (c)
		end

end -- class EV_INTERNAL

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license.
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info\@eiffel.com>
--! Customer support e-mail <support\@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
EOT

#===============================================================================
# End of file
#===============================================================================

#===============================================================================
# CVS log
#===============================================================================
#
# $Log$
# Revision 1.3  2001/06/07 23:08:28  rogers
# Merged DEVEL branch into Main trunc.
#
# Revision 1.2.6.1  2000/05/03 19:10:01  oconnor
# mergred from HEAD
#
# Revision 1.2  2000/03/01 03:10:29  oconnor
# perl bug fixes
#
# Revision 1.1  2000/02/29 18:48:24  oconnor
# initial
#
#===============================================================================
# End of CVS log
#===============================================================================
