indexing
	description: "C++ code writer"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_CPP_CLASS

inherit
	WIZARD_WRITER_CPP_EXPORT_STATUS

	WIZARD_WRITER_C

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
			create members.make (10)
			create functions.make (10)
			create {LINKED_LIST [WIZARD_WRITER_C_MEMBER]} global_variables.make
			create {LINKED_LIST [WIZARD_PARENT_CPP_CLASS]} parents.make
			create {LINKED_LIST [STRING]} import_files.make
			import_files.compare_objects
			create {LINKED_LIST [STRING]} import_files_after.make
			import_files_after.compare_objects
			create {LINKED_LIST [STRING]} others.make
			create {LINKED_LIST [STRING]} others_source.make
			create {LINKED_LIST [WIZARD_WRITER_CPP_CONSTRUCTOR]} constructors.make
			create {LINKED_LIST [WIZARD_WRITER]} ordered_elements.make
			create {LINKED_LIST [WIZARD_WRITER_C_FUNCTION]} extern_functions.make
			standard_include
		end

feature -- Access

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
			Result.append (Double_quote)
			Result.append (header_file_name)
			Result.append (Double_quote)
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

			Result.append (cpp_protector_start)
			Result.append (New_line)
			Result.append (New_line)

			from
				extern_functions.start
			until
				extern_functions.after
			loop
				Result.append (Extern)
				Result.append (Space)
				Result.append (Double_quote)
				Result.append (C)
				Result.append (Double_quote)
				Result.append (Space)
				Result.append (extern_functions.item.generated_code)
				Result.append (New_line)
				Result.append (New_line)
				extern_functions.forth
			end

			from
				ordered_elements.start
			until
				ordered_elements.after
			loop
				Result.append (ordered_elements.item.generated_code)
				ordered_elements.forth
				Result.append (New_line)
				Result.append (New_line)
			end

			from
				constructors.start
			until
				constructors.after
			loop
				Result.append (name)
				Result.append (Colon)
				Result.append (Colon)
				Result.append (name)
				Result.append (constructors.item.generated_code)
				Result.append (New_line)
				Result.append (C_open_comment_line)
				Result.append (C_close_comment_line)
				Result.append (New_line)
				Result.append (New_line)
				constructors.forth
			end
			if destructor_body /= Void and then not destructor_body.empty then
				Result.append (name)
				Result.append (Colon)
				Result.append (Colon)
				Result.append (Tilda)
				Result.append (name)
				Result.append (Open_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (New_line)
				Result.append (Open_curly_brace)
				Result.append (New_line)
				Result.append (destructor_body)
				Result.append (New_line)
				Result.append (Close_curly_brace)
				Result.append (Semicolon)
				Result.append (New_line)
				Result.append (C_open_comment_line)
				Result.append (C_close_comment_line)
				Result.append (New_line)
				Result.append (New_line)
			end
			from
				functions.start
			until
				functions.after
			loop
				from
					functions.item_for_iteration.start
				until
					functions.item_for_iteration.after
				loop
					Result.append (generated_function_code (functions.item_for_iteration.item))
					Result.append (New_line)
					Result.append (C_open_comment_line)
					Result.append (C_close_comment_line)
					Result.append (New_line)
					Result.append (New_line)
					functions.item_for_iteration.forth
				end
				functions.forth
			end

			Result.append (New_line)
			Result.append (cpp_protector_end)
		end
	
	generated_header_file: STRING is
			-- Generated code for corresponding header file
		require
			ready: can_generate
		local
			class_protector: STRING
		do
			if not abstract then
				conversion_include
			end

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

			Result.append (cpp_protector_start1)
			Result.append (New_line)
			Result.append (New_line)

			if abstract then
				class_protector := clone (name)
				class_protector.prepend ("__")
				class_protector.append ("_FWD_DEFINED__")

				Result.append (Hash_if_ndef)
				Result.append (Space)
				Result.append (class_protector)
				Result.append (New_line)

				Result.append (Hash_define)
				Result.append (Space)
				Result.append (class_protector)
				Result.append (New_line)
			end

			
			Result.append (C_class_keyword)
			Result.append (Space)
			Result.append (name)
			Result.append (Semicolon)
			Result.append (New_line)

			if abstract then
				Result.append (Hash_end_if)
				Result.append (New_line)
			end
			Result.append (New_line)

			Result.append (cpp_protector_end1)
			Result.append (New_line)
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
				Result.append (global_variables.item.generated_header_file)
				Result.append (New_line)
				global_variables.forth
			end

			from
				others.start
			until
				others.after
			loop
				Result.append (others.item)
				others.forth
				Result.append (New_line)
				Result.append (New_line)
			end

			from
				extern_functions.start
			until
				extern_functions.after
			loop
				Result.append (Extern)
				Result.append (Space)
				Result.append (Double_quote)
				Result.append (C)
				Result.append (Double_quote)
				Result.append (Space)
				Result.append (extern_functions.item.generated_header_file)
				Result.append (New_line)
				Result.append (New_line)
				extern_functions.forth
			end

			Result.append (cpp_protector_start1)
			if abstract then
				class_protector := clone (name)
				class_protector.prepend ("__")
				class_protector.append ("_INTERFACE_DEFINED__")

				Result.append (Hash_if_ndef)
				Result.append (Space)
				Result.append (class_protector)
				Result.append (New_line)

				Result.append (Hash_define)
				Result.append (Space)
				Result.append (class_protector)
				Result.append (New_line)
			end
			Result.append (C_class_keyword)
			Result.append (Space)
			Result.append (name)
			if not parents.empty then
				Result.append (Space)
				Result.append (Colon)
				Result.append (Space)
				from
					parents.start
					Result.append (cpp_status_keywords.item (parents.item.export_status))
					Result.append (Space)
					Result.append (parents.item.name)
					parents.forth
				until
					parents.after
				loop
					Result.append (Comma)
					Result.append (Space)
					Result.append (cpp_status_keywords.item (parents.item.export_status))
					Result.append (Space)
					Result.append (parents.item.name)
					parents.forth
				end
			end
			Result.append (New_line)
			Result.append (Open_curly_brace)
			Result.append (New_line)
			Result.append (cpp_status_keywords.item (Public))
			Result.append (Colon)
			Result.append (New_line)
			from
				constructors.start
			until
				constructors.after
			loop
				Result.append (tab)
				Result.append (name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				if constructors.item.signature /= Void then
					Result.append (constructors.item.signature)
				end
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line)
				constructors.forth
			end

			if constructors.empty then
				Result.append (Tab)
				Result.append (name)
				Result.append (Space)
				Result.append (Open_parenthesis)
				Result.append (Close_parenthesis)
				Result.append (Space)
				Result.append (Open_curly_brace)
				Result.append (Close_curly_brace)
				Result.append (Semicolon)
				Result.append (New_line)			
			end

			Result.append (tab)
			if not abstract then
				Result.append (clone (Virtual))
				Result.append (Space)
			end
			Result.append (Tilda)
			Result.append (name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (Close_parenthesis)
			if destructor_body = Void or else destructor_body.empty then
				Result.append (Space)
				Result.append (Open_curly_brace)
				Result.append (Close_curly_brace)
			end
			Result.append (Semicolon)
			Result.append (New_line)

			Result.append (generate_members (members, Public))
			Result.append (generate_members (functions, Public))
			Result.append (cpp_status_keywords.item (Protected))
			Result.append (Colon)
			Result.append (New_line)
			Result.append (generate_members (members, Protected))
			Result.append (generate_members (functions, Protected))
			Result.append (cpp_status_keywords.item (Private))
			Result.append (Colon)
			Result.append (New_line)
			Result.append (generate_members (members, Private))
			Result.append (generate_members (functions, Private))
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
			Result.append (New_line)
			if abstract then
				Result.append (Hash_end_if)
				Result.append (New_line)
			end
			Result.append (cpp_protector_end1)
			Result.append (New_line)
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

			Result.append (Hash_end_if)
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := name /= Void and header /= Void 
				and header_file_name /= Void and then not header_file_name.empty
				and not abstract implies not constructors.empty
		end

	name: STRING
			-- C++ class name
			
	members: HASH_TABLE [LIST [WIZARD_WRITER_C_MEMBER], INTEGER]  
			-- C++ class members
	
	functions: HASH_TABLE [LIST [WIZARD_WRITER_C_FUNCTION], INTEGER]
			-- C++ class functions

	extern_functions: LIST [WIZARD_WRITER_C_FUNCTION]
			-- C extern functions

	header: STRING
			-- C++ class header comment

	parents: LIST [WIZARD_PARENT_CPP_CLASS]
			-- Parent classes

	constructors: LIST [WIZARD_WRITER_CPP_CONSTRUCTOR]
			-- List of constructors
			
	destructor_body: STRING
			-- Destructor code

	abstract: BOOLEAN 
			-- Is class abstruct?

	ordered_elements: LIST [WIZARD_WRITER]
			-- Ordered elements (appears in code with same order
			-- as added)

feature -- Element Change

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
			valid_syntax: a_name.item (1) /= '%N' and a_name.item (a_name.count) /= '%N'
		do
			name := a_name
		ensure
			name_set: name.is_equal (a_name)
		end

	add_constructor (a_constructor: WIZARD_WRITER_CPP_CONSTRUCTOR) is
			-- Add `a_constructor' to class constructors.
		require
			non_void_constructor: a_constructor /= Void
		do
			constructors.extend (a_constructor)
		ensure
			added: constructors.last = a_constructor
		end

	set_destructor (a_destructor_body: STRING) is
			-- Set `a_destructor_body' as destructor.
		require
			non_void_destructor: a_destructor_body /= Void
			valid_destructor: not a_destructor_body.empty
			valid_syntax: a_destructor_body.item (1) /= '%N' and a_destructor_body.item (a_destructor_body.count) /= '%N'
		do
			destructor_body := a_destructor_body
		ensure
			destructor_set: destructor_body.is_equal (a_destructor_body)
		end

	add_member (a_member: WIZARD_WRITER_C_MEMBER; a_export_status: INTEGER) is
			-- Add `a_member' to `members' with `export_status' export status.
			-- See class WIZARD_WRITER_CPP_EXPORT_STATUS for possible `export_status' value.
		require
			non_void_member: a_member /= Void
			valid_export_status: is_valid_export_status (a_export_status)
		do
			if not members.has (a_export_status) then
				members.put (create {LINKED_LIST [WIZARD_WRITER_C_MEMBER]}.make, a_export_status)
			end
			check
				members.has (a_export_status)
			end
			members.item (a_export_status).extend (a_member)
		ensure
			added: members.has (a_export_status) and then members.item (a_export_status).last = a_member
		end
	
	add_function (a_function: WIZARD_WRITER_C_FUNCTION; a_export_status: INTEGER) is
			-- Add `a_function' to functions.
		require
			non_void_function: a_function /= Void
		do
			if not functions.has (a_export_status) then
				functions.put (create {LINKED_LIST [WIZARD_WRITER_C_FUNCTION]}.make, a_export_status)
			end
			check
				functions.has (a_export_status)
			end
			functions.item (a_export_status).extend (a_function)
		ensure
			added: functions.has (a_export_status) and then functions.item (a_export_status).last = a_function
		end
	
	set_header (a_header: like header) is
			-- Set `header' with `a_header'.
		require
			non_void_header: a_header /= Void
			valid_syntax: a_header.item (1) /= '%N' and a_header.item (a_header.count) /= '%N'
		do
			header := a_header
		ensure
			header_set: header.is_equal (a_header)
		end

	add_parent (a_name: STRING; an_export_status: INTEGER) is
			-- Add `a_parent' to `parents'.
		require
			non_void_parent: a_name /= Void
			valid_parent: not a_name.empty
			valid_syntax: a_name.item (1) /= '%N' and a_name.item (a_name.count) /= '%N'
		local
			a_parent: WIZARD_PARENT_CPP_CLASS
		do
			create a_parent.make (a_name, an_export_status)
			parents.extend (a_parent)
		ensure
			added: parents.last.name.is_equal (a_name)
		end

	set_abstract is
			-- Set `abstract' to `True'.
		do
			abstract := True
		ensure
			valid_abstract: abstract = True
		end

	add_directive (a_directive: WIZARD_WRITER_C_DIRECTIVE) is
			-- Add directive `a_directive' to CPP class.
		do
			ordered_elements.extend (a_directive)
		ensure
			added: ordered_elements.last = a_directive
		end

	add_static_function (a_static_function: WIZARD_WRITER_C_FUNCTION) is
			-- Add static function `a_static_function' to CPP class.
		do
			ordered_elements.extend (a_static_function)
		ensure
			added: ordered_elements.last = a_static_function
		end

	add_extern_function (an_extern_function: WIZARD_WRITER_C_FUNCTION) is
			-- Add C extern function `an_extern_function' to CPP class.
		do
			extern_functions.extend (an_extern_function)
		ensure
			added: extern_functions.last = an_extern_function
		end

feature -- Basic Operations

	save_header_file (a_header_file: STRING) is
			-- Save header file into `a_header_file'.
   		require
   			can_generate: can_generate
   		do
			save_content (a_header_file, generated_header_file)
	 	end

	conversion_include is
			-- Standart include files.
		do
			add_import_after (Ecom_generated_rt_globals_header_file_name)
		end

feature {NONE} -- Implementation

	generate_members (a_members: HASH_TABLE [LIST [WIZARD_WRITER_C_MEMBER], INTEGER]; a_export_status: INTEGER): STRING is
			-- Generate code for `a_members' functions with export status `a_export_status'.
		require
			non_void_members: a_members /= Void
			valid_export_status: is_valid_export_status (a_export_status)
		do
			create Result.make (1000)
			a_members.search (a_export_status)
			if a_members.found then
				from
					a_members.found_item.start
				until
					a_members.found_item.after
				loop
					Result.append (a_members.found_item.item.generated_header_file)
					Result.append (New_line)
					Result.append (New_line)
					a_members.found_item.forth
				end
			end
			Result.append (New_line)
		end
					
	generated_function_code (a_function: WIZARD_WRITER_C_FUNCTION): STRING is
			-- Generated code
		require
			non_void_function: a_function /= Void
		do
			create Result.make (10000)
			Result.append (a_function.result_type)
			Result.append (Space)
			Result.append (name)
			Result.append (Colon)
			Result.append (Colon)
			Result.append (a_function.name)
			Result.append (Open_parenthesis)
			if a_function.signature /= Void then 
				Result.append (Space)
				Result.append (a_function.signature)
				Result.append (Space)
			end
			Result.append (Close_parenthesis)

			Result.append (New_line)
			Result.append (New_line)
			Result.append (C_open_comment_line)
			Result.append (New_line_tab)
			Result.append (a_function.comment)
			Result.append (New_line)
			Result.append (C_close_comment_line)
			Result.append (New_line)
			Result.append (Open_curly_brace)
			Result.append (New_line)
			Result.append (a_function.body)
			Result.append (New_line)
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.empty
		end

invariant

	non_void_members: members /= Void
	non_void_functions: functions /= Void
	non_void_global_variables: global_variables /= Void
	non_void_parents: parents /= Void
	non_void_import_files: import_files /= Void
	non_void_constructors: constructors /= Void

end -- class WIZARD_WRITER_CPP_CLASS

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
  
