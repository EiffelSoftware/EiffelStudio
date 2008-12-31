note
	description: "[
			Objects that provide access to constants loaded from files.
			Perform and desired constant redefinitions in this class.
			Note that if you are loading constants from a file and wish to
			change the location of the file, redefine `initialize_constants' in this
			class to load from the desired location.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS

inherit
	CONSTANTS_IMP

feature

	copyright_text_directory: STRING = "texts"
			-- Name of copyright texts directory.

	current_directory: STRING
			-- Current directory
		once
			Result := operating_environment.Current_directory_name_representation
		end

	separator: CHARACTER
			-- System seperator
		once
			Result := operating_environment.directory_separator
		end

	subfix: STRING
			-- Subfix of copyright texts file.
		once
			Result := ".cpr"
		end

	attaching_finished: STRING
			-- Attaching finished.
		once
			Result := "Processing finished."
		end

	warning_missing_copyright_directory: STRING
			-- Warning missing copyright directory
		once
			Result := "Copyright texts directory %"" + copyright_text_directory + "%" is missing at%N%"" + current_directory + "%" or its parents.%N"
		end

	warning_text_unsaved: STRING
			-- Warning text unsaved.
		once
			Result := "Text is unsaved.%NSave it now?"
		end

	instructions: STRING
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

	save_file_dialog_title: STRING
			-- Texts for save file dialog title.
		once
			Result := "Save As..."
		end

	choose_dirs_dialog_title: STRING
			-- Texts for choose directories title.
		once
			Result := "Select directories to attach copyright infomation"
		end

	top_index_insert_strings: HASH_TABLE [STRING, STRING]
			-- Texts inserts to top index.
		once
			create Result.make (2)
			Result.put ("%"See notice at end of class.%"", "status")
			Result.put ("%"See notice at end of class.%"", "legal")
		end

	file_can_not_parse_string (a_file_path: STRING): STRING
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Not processed because of failure of parsing. "
		end

	file_post_parsing_failed (a_file_path: STRING): STRING
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "File post parsing failed. "
		end

	top_index_inserted_string (a_file_path: STRING): STRING
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Top indexing was inserted. "
		end

	top_index_modified_string (a_file_path: STRING): STRING
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Top indexing was modified. "
		end

	bottom_index_inserted_string (a_file_path: STRING): STRING
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Bottom indexing was inserted. "
		end

	bottom_index_replaced_string (a_file_path: STRING): STRING
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Bottom indexing was replaced. "
		end

	end_class_comments_removed_string (a_file_path: STRING): STRING
			--
		require
			a_file_path_attached: a_file_path /= Void
		do
			Result := "Copyright information after the class was removed. "
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CONSTANTS
