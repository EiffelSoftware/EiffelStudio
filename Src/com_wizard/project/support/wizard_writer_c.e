indexing
	description: "Common ancestor for C and CPP file writers"
	status: "See notice at end of class";
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

	cpp_protector_start1: STRING is
			-- C++ protector start.
		once
			create Result.make (100)
			Result.append (Hash_if_def)
			Result.append (Space)
			Result.append (Cplusplus)
			Result.append (New_line)

			Result.append (Extern)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append ("C")
			Result.append (Double_quote)
			Result.append (Space)
			Result.append (Open_curly_brace)
			Result.append (New_line)
		ensure
			non_void_protector: Result /= Void
			valid_protector: not Result.empty
		end

	cpp_protector_start: STRING is
			-- C++ protector start.
		once
			create Result.make (100)
			Result.append (cpp_protector_start1)
			Result.append (Hash_end_if)
		ensure
			non_void_protector: Result /= Void
			valid_protector: not Result.empty
		end

	cpp_protector_end1: STRING is
			-- C++ protector end.
		once
			create Result.make (100)
			Result.append (Close_curly_brace)
			Result.append (New_line)
			Result.append (Hash_end_if)
		ensure
			non_void_protector: Result /= Void
			valid_protector: not Result.empty
		end

	cpp_protector_end: STRING is
			-- C++ protector end.
		once
			create Result.make (100)
			Result.append (Hash_if_def)
			Result.append (Space)
			Result.append (Cplusplus)
			Result.append (New_line)
			Result.append (cpp_protector_end1)
		ensure
			non_void_protector: Result /= Void
			valid_protector: not Result.empty
		end

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
			valid_name: not a_header_file_name.empty
		do
			create Result.make (100)
			Result.append ("__")
			Result.append (a_header_file_name)
			Result.append ("__")
			Result.replace_substring_all (".", "_")
			Result.to_upper
		ensure
			non_void_protector: Result /= Void
			valid_protector: not Result.empty
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
			valid_import_file: not an_import_file.empty
			valid_syntax: an_import_file.item (1) /= '%N' and an_import_file.item (an_import_file.count) /= '%N'
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
			valid_import_file: not an_import_file.empty
			valid_syntax: an_import_file.item (1) /= '%N' and an_import_file.item (an_import_file.count) /= '%N'
		do
			if not import_files_after.has (an_import_file) then
				import_files_after.extend (an_import_file)
			end
		ensure
			added: import_files_after.has (an_import_file)
		end

end -- class WIZARD_WRITER_C

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
