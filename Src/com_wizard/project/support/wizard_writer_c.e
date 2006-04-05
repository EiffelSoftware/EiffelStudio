indexing
	description: "Common ancestor for C and CPP file writers"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_WRITER_C

inherit
	WIZARD_WRITER

feature -- Access

	import_files: LIST [STRING]
			-- Imported header files

	import_files_after: LIST [STRING]
			-- Imported header files

	others_forward: LIST [STRING]
			-- Forward declarations of C types;

	others: LIST [STRING]
			-- Other C constructs (typedef, etc...)

	others_source: LIST [STRING]
			-- Other C constructs (typedef, etc...)
			-- which are included into source file.

	header_file_name: STRING
			-- Corresponding header file name

	global_variables: LIST [WIZARD_WRITER_C_MEMBER]
			-- Global variables

feature -- Basic operations

	standard_include is
			-- Standart include files.
		do
			add_import (Eif_com_h)
			add_import (Eif_eiffel_h)
		end

	header_protector (a_header_file_name: STRING): STRING is
			-- Protect multiple inclusion of same header file.
		require
			non_void_name: a_header_file_name /= Void
			valid_name: not a_header_file_name.is_empty
		do
			create Result.make (100)
			Result.append ("__")
			Result.append (a_header_file_name)
			Result.append ("__")
			Result.replace_substring_all (".", "_")
			Result.to_upper
		ensure
			non_void_protector: Result /= Void
			valid_protector: not Result.is_empty
		end

	add_global_variable (a_variable: WIZARD_WRITER_C_MEMBER) is
			-- Add `a_varialbe' to `global_variables'.
		require
			non_void_variable: a_variable /= Void
		do
			global_variables.extend (a_variable)
		ensure
			added: global_variables.last = a_variable
		end

	set_header_file_name (a_header_file_name: like header_file_name) is
			-- Set `header_file_name' with `a_header_file_name'.
		require
			non_void_header_file_name: a_header_file_name /= Void
		do
			header_file_name := a_header_file_name
		ensure
			header_file_name_set: header_file_name.is_equal (a_header_file_name)
		end

	add_import (an_import_file: STRING) is
			-- Add `an_import_file' to list of imported header files.
		require
			non_void_import_file: an_import_file /= Void
			valid_import_file: not an_import_file.is_empty
			valid_syntax: an_import_file.item (1) /= '%R' and an_import_file.item (an_import_file.count) /= '%N'
		do
			if not import_files.has (an_import_file) then
				import_files.extend (an_import_file)
			end
		ensure
			added: import_files.has (an_import_file)
		end

	add_other_forward (a_other: STRING) is
			-- Add `a_other' to `others_forward'.
		require
			non_void_other: a_other /= Void
		do
			others_forward.extend (a_other)
		ensure
			added: others_forward.last = a_other
		end

	add_other (a_other: STRING) is
			-- Add `a_other' to `others'.
		require
			non_void_other: a_other /= Void
		do
			others.extend (a_other)
		ensure
			added: others.last = a_other
		end

	add_other_source (a_other: STRING) is
			-- Add `a_other' to `others'.
		require
			non_void_other: a_other /= Void
		do
			others_source.extend (a_other)
		ensure
			added: others_source.last = a_other
		end

	add_import_after (an_import_file: STRING) is
			-- Add `an_import_file' to list of imported header files.
		require
			non_void_import_file: an_import_file /= Void
			valid_import_file: not an_import_file.is_empty
			valid_syntax: an_import_file.item (1) /= '%R' and an_import_file.item (an_import_file.count) /= '%N'
		do
			if not import_files_after.has (an_import_file) then
				import_files_after.extend (an_import_file)
			end
		ensure
			added: import_files_after.has (an_import_file)
		end

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
end -- class WIZARD_WRITER_C

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
