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

	file_list: ARRAY [FILE_NAME]
		-- Array of files that have been processed.

	base_path: STRING
		-- Path to prepend to file from `file_list'.

	word_list: HASH_TABLE [LINKED_SET [INTEGER], STRING]
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

	set_base_path (path: STRING) is
			-- Set `base_path' to `path'.
		require
			path_not_void: path /= Void
		do
			base_path := clone (path)
		ensure
			paths_are_equal: base_path.is_equal (path)
		end;

	get_path (file_num: INTEGER): STRING is
			-- Get item `file_num' from `file_list' and append `base_path'.
		require
			array_has_file: file_list.valid_index (file_num)
			base_path_not_void: base_path /= Void
		do
			Result := clone (file_list.item (file_num))
			Result.append (base_path)
		ensure
			result_not_void: Result /= Void
			path_changed: not Result.is_equal (file_list.item (file_num))
		end;

end -- class ROOT_CLASS
