indexing
	description: "C++ code writer"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_CPP_CLASS

inherit
	WIZARD_WRITER_CPP_EXPORT_STATUS

	WIZARD_WRITER_C
		rename
			header_file_name as definition_header_file_name,
			set_header_file_name as set_definition_header_file_name
		end

	WIZARD_SHARED_MAPPER_HELPERS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
			create members.make (10)
			create functions.make (10)
			create {ARRAYED_LIST [WIZARD_WRITER_C_MEMBER]} global_variables.make (20)
			create {ARRAYED_LIST [WIZARD_PARENT_CPP_CLASS]} parents.make (20)
			create {ARRAYED_LIST [STRING]} import_files.make (20)
			import_files.compare_objects
			create {ARRAYED_LIST [STRING]} import_files_after.make (20)
			import_files_after.compare_objects
			create {ARRAYED_LIST [STRING]} others.make (20)
			others.compare_objects
			create {ARRAYED_LIST [STRING]} others_forward.make (20)
			others_forward.compare_objects
			create {ARRAYED_LIST [STRING]} others_source.make (20)
			create {ARRAYED_LIST [WIZARD_WRITER_CPP_CONSTRUCTOR]} constructors.make (20)
			create {ARRAYED_LIST [WIZARD_WRITER]} ordered_elements.make (20)
			create {ARRAYED_LIST [WIZARD_WRITER_C_FUNCTION]} extern_functions.make (20)
			standard_include
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		local
			l_writers: LIST [WIZARD_WRITER_C_FUNCTION]
		do
			create Result.make (4096)
			Result.append ("/*-----------------------------------------------------------")
			Result.append ("%N")
			Result.append (header)
			Result.append ("%N-----------------------------------------------------------*/%N%N#include %"")
			if not abstract then
				Result.append (Ecom_generated_rt_globals_header_file_name)
				Result.append ("%"%N#include %"")
			end
			Result.append (definition_header_file_name)
			Result.append ("%"%N")
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
				extern_functions.start
			until
				extern_functions.after
			loop
				Result.append ("extern %"C%" ")
				Result.append (extern_functions.item.generated_code)
				Result.append ("%N%N")
				extern_functions.forth
			end

			from
				ordered_elements.start
			until
				ordered_elements.after
			loop
				Result.append (ordered_elements.item.generated_code)
				ordered_elements.forth
				Result.append ("%N%N")
			end

			from
				constructors.start
			until
				constructors.after
			loop
				if namespace /= Void and then not namespace.is_empty then
					Result.append (namespace)
					Result.append ("::")
				end
				Result.append (name)
				Result.append ("::")
				Result.append (name)
				Result.append (constructors.item.generated_code)
				Result.append ("%N/*----------------------------------------------------------------------------------------------------------------------*/%N%N")
				constructors.forth
			end
			if destructor_body /= Void and then not destructor_body.is_empty then
				if namespace /= Void and then not namespace.is_empty then
					Result.append (namespace)
					Result.append ("::")
				end
				Result.append (name)
				Result.append ("::~")
				Result.append (name)
				Result.append ("()%N{%N")
				Result.append (destructor_body)
				Result.append ("%N};%N/*----------------------------------------------------------------------------------------------------------------------*/%N%N")
			end
			from
				functions.start
			until
				functions.after
			loop
				from
					l_writers := functions.item_for_iteration
					l_writers.start
				until
					l_writers.after
				loop
					Result.append (generated_function_code (l_writers.item))
					Result.append ("%N/*----------------------------------------------------------------------------------------------------------------------*/%N%N")
					l_writers.forth
				end
				functions.forth
			end
		end

	declaration_header_file_name: STRING
			-- Declaration header file name

	generated_declaration_header_file: STRING is
			-- Generated code for corresponding declaration header file
		require
			ready: can_generate
		local
			l_declaration: WIZARD_WRITER_FORWARD_CLASS_DECLARATION
			l_name: STRING
		do
			if declaration_header_file_name /= Void then
				create Result.make (4096)
				Result.append ("/*-----------------------------------------------------------%N")
				Result.append ("Forward declaration of ")
				Result.append (name)
				Result.append ("%N-----------------------------------------------------------*/%N%N#ifndef ")
				l_name := header_protector (declaration_header_file_name)
				Result.append (l_name)
				Result.append ("%N#define ")
				Result.append (l_name)
				Result.append ("%N%N")
				create l_declaration.make (name, namespace, abstract)
				Result.append (l_declaration.generated_code)
				Result.append ("%N#endif")
			end
		end

	generated_definition_header_file: STRING is
			-- Generated code for corresponding definition header file
		require
			ready: can_generate
		local
			l_protector: STRING
		do
			create Result.make (4096)
			Result.append ("/*-----------------------------------------------------------%N")
			Result.append (header)
			Result.append ("%N-----------------------------------------------------------*/%N%N#ifndef ")
			l_protector := header_protector (definition_header_file_name)
			Result.append (l_protector)
			Result.append ("%N#define ")
			Result.append (l_protector)
			if declaration_header_file_name /= Void then
				Result.append ("%N%N#include %"")
				Result.append (declaration_header_file_name)
				Result.append ("%"")
			end
			Result.append ("%N%N")

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
				Result.append (global_variables.item.generated_header_file)
				Result.append ("%N")
				global_variables.forth
			end

			from
				others.start
			until
				others.after
			loop
				Result.append (others.item)
				others.forth
				Result.append ("%N%N")
			end

			from
				extern_functions.start
			until
				extern_functions.after
			loop
				Result.append ("extern %"C%" ")
				Result.append (extern_functions.item.generated_header_file)
				Result.append ("%N%N")
				extern_functions.forth
			end

			if abstract then
				create l_protector.make (50)
				l_protector.append ("__")
				l_protector.append (namespace)
				l_protector.append ("_")
				l_protector.append (name)
				l_protector.append ("_INTERFACE_DEFINED__")

				Result.append ("#ifndef ")
				Result.append (l_protector)
				Result.append ("%N#define ")
				Result.append (l_protector)
				Result.append ("%N")
			end

			if namespace /= Void and then not namespace.is_empty then
				Result.append ("namespace ")
				Result.append (namespace)
				Result.append ("%N{%N")
			end

			Result.append ("class ")
			Result.append (name)
			if not parents.is_empty then
				Result.append (" : ")
				from
					parents.start
					Result.append (cpp_status_keywords.item (parents.item.export_status))
					Result.append (" ")
					if parents.item.namespace /= Void and then not parents.item.namespace.is_empty then
						Result.append (parents.item.namespace)
						Result.append ("::")
					end
					Result.append (parents.item.name)
					parents.forth
				until
					parents.after
				loop
					Result.append (", ")
					Result.append (cpp_status_keywords.item (parents.item.export_status))
					Result.append (" ")
					Result.append (parents.item.name)
					parents.forth
				end
			end
			Result.append ("%N{%N")
			Result.append (cpp_status_keywords.item (Public))
			Result.append (":%N")
			from
				constructors.start
			until
				constructors.after
			loop
				Result.append ("%T")
				Result.append (name)
				Result.append (" (")
				if constructors.item.signature /= Void then
					Result.append (constructors.item.signature)
				end
				Result.append (");%N")
				constructors.forth
			end

			if constructors.is_empty then
				Result.append ("%T")
				Result.append (name)
				Result.append (" () {};%N")
			end

			Result.append ("%T")
			if not abstract then
				Result.append ("virtual ")
			end
			Result.append ("~")
			Result.append (name)
			Result.append (" ()")
			if destructor_body = Void or else destructor_body.is_empty then
				Result.append (" {}")
			end
			Result.append (";%N")
			Result.append (generate_members (members, Public))
			Result.append (generate_members (functions, Public))
			Result.append (cpp_status_keywords.item (Protected))
			Result.append (":%N")
			Result.append (generate_members (members, Protected))
			Result.append (generate_members (functions, Protected))
			Result.append (cpp_status_keywords.item (Private))
			Result.append (":%N")
			Result.append (generate_members (members, Private))
			Result.append (generate_members (functions, Private))
			Result.append ("};%N")

			if namespace /= Void and then not namespace.is_empty then
				Result.append ("}%N")
			end

			if abstract then
				Result.append ("#endif%N")
			end
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

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := name /= Void and header /= Void 
				and definition_header_file_name /= Void and then not definition_header_file_name.is_empty
				and (not abstract implies not constructors.is_empty)
		end

	name: STRING
			-- C++ class name

	namespace: STRING
			-- Namespace.
		
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
			valid_name: not a_name.is_empty
			valid_syntax: a_name.item (1) /= '%R' and a_name.item (a_name.count) /= '%N'
		do
			name := a_name
		ensure
			name_set: name.is_equal (a_name)
		end

	set_namespace (a_name: like name) is
			-- Set `namespace' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_syntax: not a_name.is_empty implies (a_name.item (1) /= '%R' and a_name.item (a_name.count) /= '%N')
		do
			if not a_name.is_empty then
				namespace := a_name
			end
		ensure
			namespace_set: not a_name.is_empty implies namespace.is_equal (a_name)
			void_if_empty: a_name.is_empty implies namespace = Void
		end

	set_declaration_header_file_name (a_name: like declaration_header_file_name) is
			-- Set `declaration_header_file_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			declaration_header_file_name := a_name
		ensure
			declaration_header_file_name_set: declaration_header_file_name = a_name
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
			valid_destructor: not a_destructor_body.is_empty
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
				members.put (create {ARRAYED_LIST [WIZARD_WRITER_C_MEMBER]}.make (20), a_export_status)
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
				functions.put (create {ARRAYED_LIST [WIZARD_WRITER_C_FUNCTION]}.make (20), a_export_status)
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
			valid_syntax: not a_header.is_empty implies a_header.item (1) /= '%R' and a_header.item (a_header.count) /= '%N'
		do
			header := a_header
		ensure
			header_set: header.is_equal (a_header)
		end

	add_parent (a_name: STRING; a_namespace: STRING; a_export_status: INTEGER) is
			-- Add `a_parent' to `parents'.
		require
			non_void_parent: a_name /= Void
			valid_parent: not a_name.is_empty
			valid_syntax: a_name.item (1) /= '%R' and a_name.item (a_name.count) /= '%N'
		local
			a_parent: WIZARD_PARENT_CPP_CLASS
		do
			create a_parent.make (a_name, a_namespace, a_export_status)
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

	save_declaration_header_file (a_header_file: STRING) is
			-- Save declaration header file into `a_header_file'.
   		require
   			can_generate: can_generate
   		do
   			if declaration_header_file_name /= Void then
				save_content (a_header_file, generated_declaration_header_file)
			end
	 	end

	save_definition_header_file (a_header_file: STRING) is
			-- Save definition header file into `a_header_file'.
   		require
   			can_generate: can_generate
   		do
			save_content (a_header_file, generated_definition_header_file)
	 	end

feature {NONE} -- Implementation

	generate_members (a_members: HASH_TABLE [LIST [WIZARD_WRITER_C_MEMBER], INTEGER]; a_export_status: INTEGER): STRING is
			-- Generate code for `a_members' functions with export status `a_export_status'.
		require
			non_void_members: a_members /= Void
			valid_export_status: is_valid_export_status (a_export_status)
		local
			l_writers: LIST [WIZARD_WRITER_C_MEMBER]
		do
			create Result.make (1000)
			a_members.search (a_export_status)
			if a_members.found then
				l_writers := a_members.found_item
				from
					l_writers.start
				until
					l_writers.after
				loop
					Result.append (l_writers.item.generated_header_file)
					Result.append ("%N%N")
					l_writers.forth
				end
			end
			Result.append ("%N")
		end
					
	generated_function_code (a_function: WIZARD_WRITER_C_FUNCTION): STRING is
			-- Generated code
		require
			non_void_function: a_function /= Void
		do
			create Result.make (10000)
			Result.append (a_function.result_type)
			Result.append (" ")
			if namespace /= Void and then not namespace.is_empty then
				Result.append (namespace)
				Result.append ("::")
			end
			Result.append (name)
			Result.append ("::")
			Result.append (a_function.name)
			Result.append ("(")
			if a_function.signature /= Void then 
				Result.append (" ")
				Result.append (a_function.signature)
				Result.append (" ")
			end
			Result.append (")")
			Result.append ("%N%N/*-----------------------------------------------------------%N%T")
			Result.append (a_function.comment)
			Result.append ("%N-----------------------------------------------------------*/%N{%N")
			Result.append (a_function.body)
			Result.append ("%N};")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

invariant

	non_void_members: members /= Void
	non_void_functions: functions /= Void
	non_void_global_variables: global_variables /= Void
	non_void_parents: parents /= Void
	non_void_import_files: import_files /= Void
	non_void_constructors: constructors /= Void

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
end -- class WIZARD_WRITER_CPP_CLASS

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
