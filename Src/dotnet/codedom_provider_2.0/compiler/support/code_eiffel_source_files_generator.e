indexing
	description: "Split given string into Eiffel source files"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EIFFEL_SOURCE_FILES_GENERATOR

inherit
	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	CODE_SHARED_CLASS_SEPARATOR
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_dir: STRING) is
			-- Set `destination_directory' with `a_dir'.
		require
			non_void_directory: a_dir /= Void
			valid_directory: (create {DIRECTORY}.make (a_dir)).exists
		local
			l_content: LIST [STRING]
			l_file: RAW_FILE
			l_item, l_file_name, l_dir: STRING
			l_count: INTEGER
		do
			create destination_directory.make (a_dir)
			l_content := destination_directory.linear_representation
			from
				l_content.start
			until
				l_content.after
			loop
				l_item := l_content.item
				l_count := l_item.count
				if l_item.substring (l_count - 1, l_count).is_equal (".e") then
					l_dir := destination_directory.name
					create l_file_name.make (l_dir.count + l_count + 1)
					l_file_name.append (l_dir)
					l_file_name.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
					l_file_name.append (l_item)
					create l_file.make (l_file_name)
					if l_file.exists then
						try_delete (l_file)
					end
				end
				l_content.forth
			end
			last_index_suffix := 1
		ensure
			destination_directory_set: destination_directory.name.is_equal (a_dir)
		end

feature -- Access

	destination_directory: DIRECTORY
			-- Path to directory where generated Eiffel files should be written

	Eiffel_source_file: STRING is "generated.e"
			-- Generated Eiffel source file name prefix

feature -- Basic Operation

	generate (a_content: STRING) is
			-- Split `a_content' and write corresponding Eiffel source files.
		require
			non_void_content: a_content /= Void
		local
			l_index, l_index2, l_old_index: INTEGER
		do
			from
				l_old_index := 1
				l_index := a_content.substring_index (Class_separator, l_old_index)
			until
				l_index = 0
			loop
				write_file (a_content.substring (l_old_index, l_index - 1))
				l_old_index := l_index + Class_separator.count
				l_index := a_content.substring_index (Class_separator, l_old_index)
			end
		end

feature {NONE} -- Implementation

	try_delete (a_file: RAW_FILE) is
			-- Try to delete `a_file', don't throw an exception if not possible.
		require
			attached_file: a_file /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.File_deletion, [a_file.name])
				a_file.delete
			end
		rescue
			l_retried := True
			Event_manager.process_exception
			retry
		end

	write_file (a_content: STRING) is
			-- Write `a_content' into file `a_file_name' in `destination_directory'.
		require
			attached_content: a_content /= Void
		local
			l_source: RAW_FILE
			l_file_name, l_path: STRING
		do
			l_file_name := unique_file_name
			create l_path.make (destination_directory.count + 1 + l_file_name.count)
			l_path.append (destination_directory.name)
			l_path.append_character (Directory_separator)
			l_path.append (l_file_name)
			create l_source.make_open_write (l_path)
			l_source.put_string (a_content)
			l_source.close
		end
		
	unique_file_name: STRING is
			-- Unique file name for directory `destination_directory'
		local
			i: INTEGER
		do
			i := 2
			create Result.make (Eiffel_source_file.count + 4) -- up to 999 files before string resizing is needed
			from
				Result.append (Eiffel_source_file)
				if destination_directory.has_entry (Result) then
					last_index_suffix := last_index_suffix + 1
					Result.keep_head (Result.count - 2)
					Result.append_character ('_')
					Result.append (last_index_suffix.out)
					Result.append (".e")
					i := last_index_suffix + 1
				end
			until
				not destination_directory.has_entry (Result)
			loop
				Result.replace_substring (i.out, Result.last_index_of ('_', Result.count) + 1, Result.last_index_of ('.', Result.count) - 1)
				i := i + 1
			end
			last_index_suffix := i - 1
		ensure
			exists: Result /= Void
			is_unique: not destination_directory.has_entry (Result)
		end
	
	last_index_suffix: INTEGER;
			-- Last suffix used in `unique_file_name'

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class CODE_EIFFEL_SOURCE_FILES_GENERATOR

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
