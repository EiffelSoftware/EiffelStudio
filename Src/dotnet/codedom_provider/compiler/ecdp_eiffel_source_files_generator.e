indexing
	description: "Split given string into Eiffel source files"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SOURCE_FILES_GENERATOR

inherit
	OPERATING_ENVIRONMENT
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
		do
			create destination_directory.make (a_dir)
			last_index_suffix := 1
		ensure
			destination_directory_set: destination_directory.name.is_equal (a_dir)
		end

feature -- Access

	destination_directory: DIRECTORY
			-- Path to directory where generated Eiffel files should be written

	Class_separator: STRING is "%N__end_class__%N"
			-- Token used to separate class definition in single file

	Eiffel_source_prefix: STRING is "generated"
			-- Generated Eiffel source file name prefix

feature -- Basic Operation

	generate (a_content: STRING) is
			-- Split `a_content' and write corresponding Eiffel source files.
		require
			non_void_content: a_content /= Void
		local
			l_index, l_old_index: INTEGER
		do
			from
				l_old_index := 1
				l_index := a_content.substring_index (Class_separator, l_old_index)
			until
				l_index = 0
			loop
				write_file (unique_file_name, a_content.substring (l_old_index, l_index - 1))
				l_old_index := l_index + Class_separator.count
				l_index := a_content.substring_index (Class_separator, l_old_index)
			end
			if l_old_index < a_content.count then
				write_file (unique_file_name, a_content.substring (l_old_index,  a_content.count))
			end
		end

feature {NONE} -- Implementation

	write_file (a_file_name, a_content: STRING) is
			-- Write `a_content' into file `a_file_name' in `destination_directory'.
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty and not a_file_name.has ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			non_void_content: a_content /= Void
		local
			l_source: PLAIN_TEXT_FILE
			l_path: STRING
		do
			create l_path.make (destination_directory.count + 1 + a_file_name.count)
			l_path.append (destination_directory.name)
			l_path.append_character (Directory_separator)
			l_path.append (a_file_name)
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
			create Result.make (Eiffel_source_prefix.count + 4) -- up to 999 files before string resizing is needed
			from
				Result.append (Eiffel_source_prefix)
				if destination_directory.has_entry (Result + ".e") then
					last_index_suffix := last_index_suffix + 1
					Result.append_character ('_')
					Result.append (last_index_suffix.out)
					i := last_index_suffix + 1
				end
			until
				not destination_directory.has_entry (Result + ".e")
			loop
				Result.replace_substring (i.out, Result.last_index_of ('_', Result.count) + 1, Result.count)
				i := i + 1
			end
			last_index_suffix := i - 1
			Result.append (".e")
		ensure
			exists: Result /= Void
			is_unique: not destination_directory.has_entry (Result)
		end
	
	last_index_suffix: INTEGER
			-- Last suffix used in `unique_file_name'

end -- class EIFFEL_SOURCE_FILES_GENERATOR

--+--------------------------------------------------------------------
--| Prepare Utility
--| Copyright (C) 2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
