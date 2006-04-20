indexing
	description: "C file writer"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_C_FILE

inherit
	WIZARD_WRITER_C

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
			create {ARRAYED_LIST [WIZARD_WRITER_C_FUNCTION]} functions.make (20)
			create {ARRAYED_LIST [WIZARD_WRITER_C_MEMBER]} global_variables.make (20)
			create {ARRAYED_LIST [STRING]} others_forward.make (20)
			create {ARRAYED_LIST [STRING]} others.make (20)
			create {ARRAYED_LIST [STRING]} others_source.make (20)
			create {ARRAYED_LIST [STRING]} import_files.make (20)
			import_files.compare_objects
			create {ARRAYED_LIST [STRING]} import_files_after.make (20)
			import_files_after.compare_objects

			standard_include
		end

feature -- Access

	generated_header_file: STRING is
			-- Generated header file
		require
			ready: can_generate
		do
			create Result.make (4096)
			Result.append ("/*-----------------------------------------------------------%N")
			Result.append (header)
			Result.append ("%N-----------------------------------------------------------*/%N%N#ifndef ")
			Result.append (header_protector (header_file_name))
			Result.append ("%N#define ")
			Result.append (header_protector (header_file_name))
			Result.append ("%N")
			if not others_forward.is_empty then
				from
					others_forward.start
				until
					others_forward.after
				loop
					Result.append ("%N%N")
					Result.append (others_forward.item)
					others_forward.forth
				end
				Result.append ("%N%N")
			end
			Result.append ("%N")
			from
				import_files.start
			until
				import_files.after
			loop
				Result.append ("#include %"")
				Result.append (import_files.item)
				Result.append ("%"%N%N")
				import_files.forth
			end
			from
				global_variables.start
			until
				global_variables.after
			loop
				Result.append ("%N%N")
				Result.append (global_variables.item.generated_header_file)
				global_variables.forth
			end
			from
				others.start
			until
				others.after
			loop
				Result.append ("%N%N")
				Result.append (others.item)
				others.forth
			end
			from
				functions.start
			until
				functions.after
			loop
				Result.append ("%N%N")
				Result.append (functions.item.generated_header_file)
				functions.forth
			end
			Result.append ("%N")
			from
				import_files_after.start
			until
				import_files_after.after
			loop
				Result.append ("#include %"")
				Result.append (import_files_after.item)
				Result.append ("%"%N%N")
				import_files_after.forth
			end
			Result.append ("%N#endif")
		end

	functions: LIST [WIZARD_WRITER_C_FUNCTION]
			-- Functions part of C file

	header: STRING
			-- C++ class header comment

	generated_code: STRING is
			-- Generated code
		do
			create Result.make (4096)
			Result.append ("/*-----------------------------------------------------------%N")
			Result.append (header)
			Result.append ("%N-----------------------------------------------------------*/%N%N#include %"")
			Result.append (header_file_name)
			Result.append ("%"%N%N")
			from
				others_source.start
			until
				others_source.after
			loop
				Result.append (others_source.item)
				others_source.forth
				Result.append ("%N%N")
			end
			from
				functions.start
			until
				functions.after
			loop
				Result.append ("%N%N")
				Result.append (functions.item.generated_code)
				functions.forth
			end
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := header /= Void and then not header.is_empty and header_file_name /= Void and then not header_file_name.is_empty
		end

feature -- Element Change

	add_function (a_function: WIZARD_WRITER_C_FUNCTION) is
			-- Add `a_function' to functions.
		require
			non_void_function: a_function /= Void
		do
			functions.extend (a_function)
		ensure
			added: functions.last = a_function
		end
	
	set_header (a_header: like header) is
			-- Set `header' with `a_header'.
		require
			non_void_header: a_header /= Void
		do
			header := a_header
		ensure
			header_set: header.is_equal (a_header)
		end

feature -- Basic Operations

	save_header_file (a_header_file: STRING) is
			-- Save header file into `a_header_file'.
   		require
   			can_generate: can_generate
   		do
			save_content (a_header_file, generated_header_file)
	 	end

invariant

		non_void_functions: functions /= Void
		non_void_global_variables: global_variables /= Void
		non_void_others: others /= Void
		non_void_import_files: import_files /= Void

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
end -- class WIZARD_WRITER_C_FILE

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
