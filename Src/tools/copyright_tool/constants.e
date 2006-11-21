indexing
	description: "[
			Objects that provide access to constants loaded from files.
			Perform and desired constant redefinitions in this class.
			Note that if you are loading constants from a file and wish to
			change the location of the file, redefine `initialize_constants' in this
			class to load from the desired location.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS

inherit
	CONSTANTS_IMP

feature

	copyright_text_directory: STRING is "texts"
			-- Name of copyright texts directory.

	current_directory: STRING is
			-- Current directory
		once
			Result := operating_environment.Current_directory_name_representation
		end

	separator: CHARACTER is
			-- System seperator
		once
			Result := operating_environment.directory_separator
		end

	subfix: STRING is
			-- Subfix of copyright texts file.
		once
			Result := ".cpr"
		end

	attaching_finished: STRING is
			-- Attaching finished.
		once
			Result := "Processing finished."
		end

	warning_missing_copyright_directory: STRING is
			-- Warning missing copyright directory
		once
			Result := "Copyright texts directory %"" + copyright_text_directory + "%" is missing at%N%"" + current_directory + "%" or its parents.%N"
		end

	warning_text_unsaved: STRING is
			-- Warning text unsaved.
		once
			Result := "Text is unsaved.%NSave it now?"
		end

	instructions: STRING is
			-- Instructions for the tool.
		once
			Result := "[
			1. Select copyright text from "Select copyright" list. Texts from the list are read from "texts" directory at the location of the program.
			All copyright files are ".cpr" files.
			2. Or you can modify texts in "Copyright" and save it.
			3. "Select & Start" to select a directory to process copyright attaching as is shown in "Copyright" to the bottom of classes.
			4. "status: 'See notice at end of class'" and "legal: 'See notice at end of class'" will be added to the top index of classes.
			]"
		end

	save_file_dialog_title: STRING is
			-- Texts for save file dialog title.
		once
			Result := "Save As..."
		end

	choose_dirs_dialog_title: STRING is
			-- Texts for choose directories title.
		once
			Result := "Select directories to attach copyright infomation"
		end

	top_index_insert_strings: HASH_TABLE [STRING, STRING] is
			-- Texts inserts to top index.
		once
			create Result.make (2)
			Result.put ("%"See notice at end of class.%"", "status")
			Result.put ("%"See notice at end of class.%"", "legal")
		end

	file_can_not_parse_string (a_file_path: STRING): STRING is
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Not processed because of failure of parsing. "
		end

	file_post_parsing_failed (a_file_path: STRING): STRING is
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "File post parsing failed. "
		end

	top_index_inserted_string (a_file_path: STRING): STRING is
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Top indexing was inserted. "
		end

	top_index_modified_string (a_file_path: STRING): STRING is
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Top indexing was modified. "
		end

	bottom_index_inserted_string (a_file_path: STRING): STRING is
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Bottom indexing was inserted. "
		end

	bottom_index_replaced_string (a_file_path: STRING): STRING is
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Bottom indexing was replaced. "
		end

	end_class_comments_removed_string (a_file_path: STRING): STRING is
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Copyright information after the class was removed. "
		end

end -- class CONSTANTS
