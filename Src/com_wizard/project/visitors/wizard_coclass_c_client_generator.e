indexing
	description: "Coclass c client generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_C_CLIENT_GENERATOR

inherit
	WIZARD_COCLASS_C_GENERATOR

	WIZARD_CPP_FEATURE_GENERATOR
		export
			{NONE} all
		end

	WIZARD_COMPONENT_C_CLIENT_GENERATOR

feature -- Access

	dispatch_interface: BOOLEAN
			-- Is coclass contained dispatch interface?

feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate c client for coclass.
		local
			default_member: WIZARD_WRITER_C_MEMBER
			tmp_string: STRING
		do
			create cpp_class_writer.make
			create interface_names.make

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_namespace (a_descriptor.namespace)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_header_file_name (a_descriptor.c_header_file_name)
			cpp_class_writer.add_other_source (clsid_definition (a_descriptor.name, a_descriptor.guid))

			process_interfaces (a_descriptor)
			cpp_class_writer.parents.wipe_out
			
			-- Add default member "p_unknown"
			create default_member.make
			default_member.set_name (Iunknown_variable_name)
			default_member.set_result_type (Iunknown)
			default_member.set_comment (Default_iunknown_variable_comment)
			cpp_class_writer.add_member (default_member, Private)

			-- Default header files include global variables and required header files
			cpp_class_writer.add_import (Ecom_generated_rt_globals_header_file_name)

			-- Add member "EXCEPINFO * excepinfo" if is not normal interface and
			-- function "set_exception_information"
			if dispatch_interface then

				-- Add memeber "EXCEPINFO * excepinfo"
				create default_member.make
				default_member.set_name (clone (Excepinfo_variable_name))
				
				create tmp_string.make (10000)
				tmp_string.append (Excepinfo)
				tmp_string.append (Space)
				tmp_string.append (Asterisk)
				default_member.set_result_type (tmp_string)
				default_member.set_comment (Excepinfo_variable_comment)
				cpp_class_writer.add_member (default_member, Private)
				cpp_class_writer.add_function (ccom_last_error_code_function, Public)
				cpp_class_writer.add_function (ccom_last_source_of_exception_function, Public)
				cpp_class_writer.add_function (ccom_last_error_description_function, Public)
				cpp_class_writer.add_function (ccom_last_error_help_file_function, Public)
			end

			cpp_class_writer.set_destructor (destructor (a_descriptor))
			if is_typeflag_fcancreate (a_descriptor.flags) then
				cpp_class_writer.add_constructor (default_constructor (a_descriptor))
			end
			cpp_class_writer.add_constructor (pointer_constructor (a_descriptor))


			add_default_function

			-- Generate code and file name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)

			cpp_class_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_coclass_c_client
		end

feature {NONE} -- Implementation

	process_interfaces (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process inherited interfaces
		local
			interface_processor: WIZARD_COCLASS_INTERFACE_C_CLIENT_PROCESSOR
		do
			create interface_processor.make (a_coclass_descriptor, Current)
			interface_processor.process_interfaces
			dispatch_interface := interface_processor.dispatch_interface
		end

	destructor (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- Desctructor
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
			non_void_interface_descriptors: a_coclass_descriptor.interface_descriptors /= Void
			not_empty_interface_descriptors: not a_coclass_descriptor.interface_descriptors.empty
		do
			create Result.make (10000)
			Result.append (Tab)
			Result.append (Iunknown_variable_name)
			Result.append (Release_function)
			Result.append (New_line_tab)

			-- Release "excepinfo" if allocated
			if dispatch_interface then
				Result.append (New_line_tab)
				Result.append (Co_task_mem_free)
				Result.append (Space_open_parenthesis)
				Result.append (Open_parenthesis)
				Result.append (C_void_pointer)
				Result.append (Close_parenthesis)
				Result.append (Excepinfo_variable_name)
				Result.append (Close_parenthesis)
				Result.append (Semicolon)
				Result.append (New_line_tab)
			end

			from
				a_coclass_descriptor.interface_descriptors.start
			until
				a_coclass_descriptor.interface_descriptors.off
			loop
				if
					not a_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (Idispatch_type) and
					not a_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (Iunknown_type) and
					not has_descendants_in_coclass (a_coclass_descriptor, a_coclass_descriptor.interface_descriptors.item)
				then
					Result.append (release_interface (a_coclass_descriptor.interface_descriptors.item.name))
				end
				a_coclass_descriptor.interface_descriptors.forth
			end

			Result.append (Co_uninitialize_function)
		ensure
			non_void_destructor: Result /= void
			valid_descructor: not Result.empty
		end

	default_constructor (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
			non_void_interface_descriptors: a_coclass_descriptor.interface_descriptors /= Void
			not_empty_interface_descriptors: not a_coclass_descriptor.interface_descriptors.empty
		local
			constructor_body: STRING
		do
			create Result.make

			create constructor_body.make (1000)
			constructor_body.append (Tab)
			constructor_body.append (Hresult)
			constructor_body.append (Space)
			constructor_body.append (Hresult_variable_name)
			constructor_body.append (Semicolon)
			constructor_body.append (New_line)
			constructor_body.append (co_initialize_ex_function)
			constructor_body.append (examine_hresult (Hresult_variable_name))
			constructor_body.append (New_line)
			constructor_body.append (co_create_instance_ex_function (a_coclass_descriptor))

			from 
				a_coclass_descriptor.interface_descriptors.start
			until
				a_coclass_descriptor.interface_descriptors.off
			loop
				if 
					not a_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (Idispatch_type) and
					not a_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (Iunknown_type) and
					not has_descendants_in_coclass (a_coclass_descriptor, a_coclass_descriptor.interface_descriptors.item)
				then
					constructor_body.append (New_line_tab)
					constructor_body.append (Interface_variable_prepend)
					constructor_body.append (a_coclass_descriptor.interface_descriptors.item.name)
					constructor_body.append (Space_equal_space)
					constructor_body.append (Zero)
					constructor_body.append (Semicolon)
					constructor_body.append (New_line)
				end
				a_coclass_descriptor.interface_descriptors.forth
			end

			if dispatch_interface then
				constructor_body.append (New_line_tab)
				constructor_body.append (Excepinfo_variable_name)
				constructor_body.append (Space_equal_space)
				constructor_body.append (Open_parenthesis)
				constructor_body.append (Excepinfo)
				constructor_body.append (Asterisk)
				constructor_body.append (Close_parenthesis)
				constructor_body.append (Co_task_mem_alloc)
				constructor_body.append (Space_open_parenthesis)
				constructor_body.append (Sizeof)
				constructor_body.append (Space_open_parenthesis)
				constructor_body.append (Excepinfo)
				constructor_body.append (Close_parenthesis)
				constructor_body.append (Close_parenthesis)
				constructor_body.append (Semicolon)
			end

			Result.set_body (constructor_body)
		ensure
			non_void_constructor: Result /= Void
		end

	pointer_constructor (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
			non_void_interface_descriptors: a_coclass_descriptor.interface_descriptors /= Void
			not_empty_interface_descriptors: not a_coclass_descriptor.interface_descriptors.empty
		local
			constructor_body: STRING
			a_signature: STRING
		do
			create Result.make

			create a_signature.make (100)
			a_signature.append (Iunknown)
			a_signature.append (Space)
			a_signature.append (A_pointer)
			Result.set_signature (a_signature)

			create constructor_body.make (1000)
			constructor_body.append (Tab)
			constructor_body.append (Hresult)
			constructor_body.append (Space)
			constructor_body.append (Hresult_variable_name)
			constructor_body.append (Comma_space)
			constructor_body.append (Hresult_variable_name_2)
			constructor_body.append (Semicolon)
			constructor_body.append (New_line)

			constructor_body.append (co_initialize_ex_function)
			constructor_body.append (examine_hresult (Hresult_variable_name))

			constructor_body.append (New_line_tab)
			constructor_body.append (Hresult_variable_name)
			constructor_body.append (Space_equal_space)
			constructor_body.append (A_pointer)
			constructor_body.append (Struct_selection_operator)
			constructor_body.append (Query_interface)
			constructor_body.append (Open_parenthesis)
			constructor_body.append (Iunknown_clsid)
			constructor_body.append (Comma_space)
			constructor_body.append (Open_parenthesis)
			constructor_body.append (C_void_pointer)
			constructor_body.append (Asterisk)
			constructor_body.append (Close_parenthesis)
			constructor_body.append (Ampersand)
			constructor_body.append (Iunknown_variable_name)
			constructor_body.append (Close_parenthesis)
			constructor_body.append (Semicolon)
			constructor_body.append (New_line)
			constructor_body.append (examine_hresult (Hresult_variable_name))
			constructor_body.append (New_line)

			from 
				a_coclass_descriptor.interface_descriptors.start
			until
				a_coclass_descriptor.interface_descriptors.off
			loop
				if
					not a_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (Idispatch_type) and
					not a_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (Iunknown_type) and
					not has_descendants_in_coclass (a_coclass_descriptor, a_coclass_descriptor.interface_descriptors.item)
				then
					constructor_body.append (New_line_tab)
					constructor_body.append (Interface_variable_prepend)
					constructor_body.append (a_coclass_descriptor.interface_descriptors.item.name)
					constructor_body.append (Space_equal_space)
					constructor_body.append (Zero)
					constructor_body.append (Semicolon)

					constructor_body.append (New_line_tab)
					constructor_body.append (Hresult_variable_name)
					constructor_body.append (Space_equal_space)
					constructor_body.append (A_pointer)
					constructor_body.append (Struct_selection_operator)
					constructor_body.append (Query_interface)
					constructor_body.append (Open_parenthesis)
					constructor_body.append (iid_name (a_coclass_descriptor.interface_descriptors.item.name))
					constructor_body.append (Comma_space)
					constructor_body.append (Open_parenthesis)
					constructor_body.append (C_void_pointer)
					constructor_body.append (Asterisk)
					constructor_body.append (Close_parenthesis)
					constructor_body.append (Ampersand)
					constructor_body.append (Interface_variable_prepend)
					constructor_body.append (a_coclass_descriptor.interface_descriptors.item.name)
					constructor_body.append (Close_parenthesis)
					constructor_body.append (Semicolon)
					constructor_body.append (New_line)
					constructor_body.append (examine_hresult (Hresult_variable_name))
					constructor_body.append (New_line)
				end

				a_coclass_descriptor.interface_descriptors.forth
			end

			if dispatch_interface then
				constructor_body.append (New_line_tab)
				constructor_body.append (Excepinfo_variable_name)
				constructor_body.append (Space_equal_space)
				constructor_body.append (Open_parenthesis)
				constructor_body.append (Excepinfo)
				constructor_body.append (Asterisk)
				constructor_body.append (Close_parenthesis)
				constructor_body.append (Co_task_mem_alloc)
				constructor_body.append (Space_open_parenthesis)
				constructor_body.append (Sizeof)
				constructor_body.append (Space_open_parenthesis)
				constructor_body.append (Excepinfo)
				constructor_body.append (Close_parenthesis)
				constructor_body.append (Close_parenthesis)
				constructor_body.append (Semicolon)
			end

			Result.set_body (constructor_body)
		ensure
			non_void_constructor: Result /= Void
		end

	co_create_instance_ex_function (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- CoCreateInstanceEx function call
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			tmp_string: STRING
		do
			create Result.make (1000)
			Result.append (Tab)
			Result.append (multiple_query_interfaces)
			Result.append (New_line_tab)
			Result.append ("hr = CoCreateInstanceEx ")
			Result.append (Open_parenthesis)
			Result.append (clsid_name (a_coclass_descriptor.name))
			Result.append (Comma_space)
			Result.append (Null)
			Result.append (Comma_space)

			if shared_wizard_environment.in_process_server then
				Result.append (Inprocess_server)
			elseif shared_wizard_environment.out_of_process_server then	
				Result.append (Remote_server)
			end

			Result.append (Comma_space)
			Result.append (Null)

			Result.append (Comma_space)
			Result.append (One)
			Result.append (Comma_space)
			Result.append (Ampersand)
			Result.append ("a_qi")
			Result.append (Close_parenthesis)
			Result.append (Semicolon)
			Result.append (New_line)
			Result.append (examine_hresult (Hresult_variable_name))
			Result.append (New_line)
			tmp_string := clone ("a_qi.hr")
			Result.append (examine_hresult (tmp_string))
			Result.append (New_line_tab)
			Result.append (Iunknown_variable_name)
			Result.append (Space_equal_space)
			Result.append ("a_qi")
			Result.append (Dot)
			Result.append ("pItf")
			Result.append (Semicolon)
			Result.append (New_line)

		ensure
			non_void_cocreate_instance: Result /= Void
			valid_cocreate_instance: not Result.empty
		end

	multiple_query_interfaces: STRING is
			-- MULTI_QI
		do
			-- p_unknown = NULL;
			create Result.make (500)
			Result.append (Iunknown_variable_name)
			Result.append (Space_equal_space)
			Result.append (Null)
			Result.append (Semicolon)
			Result.append (New_line_tab)

			-- MULTI_QI a_qi = {&IID_IUnknown, NULL, 0};
			Result.append (Multi_qi)
			Result.append (Space)
			Result.append ("a_qi")
			Result.append (Space_equal_space)
			Result.append (Open_curly_brace)
			Result.append (Ampersand)
			Result.append (Iunknown_clsid)
			Result.append (Comma_space)
			Result.append (Null)
			Result.append (Comma_space)
			Result.append (Zero)
			Result.append (Close_curly_brace)
			Result.append (Semicolon)
			Result.append (New_line)
		ensure
			non_void_multiple_query_interface: Result /= Void
			valid_multiple_query_interface: not Result.empty
		end


end -- class WIZARD_COCLASS_C_CLIENT_GENERATOR

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
