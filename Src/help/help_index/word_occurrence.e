indexing
	description: "File that a help word occurs in, and how many times it occurs in that file"
	author: "Parker Abercrombie"
	date: "7/99"

class
	WORD_OCCURRENCE

inherit
	COMPARABLE

creation
	make

feature -- Initialization

	make ( file_ref : INTEGER ) is
		require
			file_ref_not_void: file_ref /= Void
		do
			file_reference := file_ref
			occurrences := 1
		end;		

feature -- Access

	file_reference : INTEGER
		-- Numeric code for the file.  Matches index in `file_list' of HELP_INDEX.

	occurrences : INTEGER
		-- Number of times word appeares in this file.

	increment is
		-- Increment the occurrence counter.
		do
			occurrences := occurrences + 1
		end;

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := occurrences > other.occurrences
		end;

end -- class WORD_OCCURRENCE
