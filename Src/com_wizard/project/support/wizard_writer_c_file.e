indexing
	description: "C file writer"
	status: "See notice at end of class";
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
			create {LINKED_LIST [WIZARD_WRITER_C_FUNCTION]} functions.make
			create {LINKED_LIST [WIZARD_WRITER_C_MEMBER]} global_variables.make
			create {LINKED_LIST [STRING]} others_forward.make
			create {LINKED_LIST [STRING]} others.make
			create {LINKED_LIST [STRING]} others_source.make
			create {LINKED_LIST [STRING]} import_files.make
			import_files.compare_objects
			create {LINKED_LIST [STRING]} import_files_after.make
			import_files_after.compare_objects

			standard_include
		end

feature -- Access

	generated_header_file: STRING is
			-- Generated header file
		require
			ready: can_generate
		do
			Result := clone (C_open_comment_line)
			Result.append (New_line)
			Result.append (header)
			Result.append (New_line)
			Result.append (C_close_comment_line)
			Result.append (New_line)
			Result.append (New_line)

			Result.append (Sharp)
			Result.append (Ifndef)
			Result.append (Space)
			Result.append (header_protector (header_file_name))
			Result.append (New_line)

			Result.append (Sharp)
			Result.append (define)
			Result.append (Space)
			Result.append (header_protector (header_file_name))
			Result.append (New_line)

			if not others_forward.is_empty then
				Result.append (cpp_protector_start)
				Result.append (New_line)

				from
					others_forward.start
				until
					others_forward.after
				loop
					Result.append (New_line)
					Result.append (New_line)
					Result.append (others_forward.item)
					others_forward.forth
				end
				Result.append (New_line)
				Result.append (New_line)

				Result.append (cpp_protector_end)
				Result.append (New_line)
			end
			Result.append (New_line)

			from
				import_files.start
			until
				import_files.after
			loop
				Result.append (Include_clause)
				Result.append (Space)
				Result.append ("%"")
				Result.append (import_files.item)
				Result.append ("%"")
				Result.append (New_line)
				Result.append (New_line)
				import_files.forth
			end

			Result.append (cpp_protector_start)
			Result.append (New_line)
			Result.append (New_line)

			from
				global_variables.start
			until
				global_variables.after
			loop
				Result.append (New_line)
				Result.append (New_line)
				Result.append (global_variables.item.generated_header_file)
				global_variables.forth
			end
			from
				others.start
			until
				others.after
			loop
				Result.append (New_line)
				Result.append (New_line)
				Result.append (others.item)
				others.forth
			end
			from
				functions.start
			until
				functions.after
			loop
				Result.append (New_line)
				Result.append (New_line)
				Result.append (functions.item.generated_header_file)
				functions.forth
			end

			Result.append (New_line)
			Result.append (cpp_protector_end)
			Result.append (New_line)

			from
				import_files_after.start
			until
				import_files_after.after
			loop
				Result.append (Include_clause)
				Result.append (Space)
				Result.append ("%"")
				Result.append (import_files_after.item)
				Result.append ("%"")
				Result.append (New_line)
				Result.append (New_line)
				import_files_after.forth
			end

			Result.append (New_line)
			Result.append (Sharp)
			Result.append (Endif)
		end

	functions: LIST [WIZARD_WRITER_C_FUNCTION]
			-- Functions part of C file

	header: STRING
			-- C++ class header comment

	generated_code: STRING is
			-- Generated code
		do
			Result := clone (C_open_comment_line)
			Result.append (New_line)
			Result.append (header)
			Result.append (New_line)
			Result.append (C_close_comment_line)
			Result.append (New_line)
			Result.append (New_line)
			Result.append (Include_clause)
			Result.append (Space)
			Result.append ("%"")
			Result.append (header_file_name)
			Result.append ("%"")

			Result.append (New_line)
			Result.append (New_line)

			Result.append (cpp_protector_start)
			Result.append (New_line)
			Result.append (New_line)

			from
				others_source.start
			until
				others_source.after
			loop
				Result.append (others_source.item)
				others_source.forth
				Result.append (New_line)
				Result.append (New_line)
			end


			from
				functions.start
			until
				functions.after
			loop
				Result.append (New_line)
				Result.append (New_line)
				Result.append (functions.item.generated_code)
				functions.forth
			end

			Result.append (New_line)
			Result.append (cpp_protector_end)
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := header /= Void and then not header.is_empty
					and header_file_name /= Void and then not header_file_name.is_empty
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

end -- class WIZARD_WRITER_C_FILE

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
  