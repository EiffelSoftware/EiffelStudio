indexing
	description:	"Representation of a help database.  Includes word list and a file_list.";
	author: "Parker Abercrombie"
	date: "7/99"

class
	HELP_INDEX
inherit
	STORABLE
creation

	make

feature -- Initialization

	make is
			-- Create a help index.
		do
		  	create liquid_word_list.make (1)
			create glossary.make (1)
			create file_list.make ( 1, 1 )
		end;

feature -- Access

	file_list: ARRAY [STRING]
		-- Array of files that have been processed.

	word_list: HASH_TABLE [ARRAY [INTEGER], STRING]
		-- Information about word occurrences.

	liquid_word_list: MODIFIABLE_WORD_HASH
		-- Modifiable version of word list.

	glossary: HASH_TABLE [STRING, STRING]
		-- Word glossary.

	freeze_index is
			-- Remove modifiable parts and prepare for storage.
		do
			word_list := liquid_word_list.freeze_list
			liquid_word_list := Void
		end;

end -- class ROOT_CLASS
