indexing
	description: "Implemented interface generator for C client"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_C_CLIENT_GENERATOR

inherit
	WIZARD_IMPLEMENTED_INTERFACE_C_GENERATOR

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_CPP_FEATURE_GENERATOR
		export
			{NONE} all
		end

	WIZARD_COMPONENT_C_CLIENT_GENERATOR

feature -- Basic operations

	generate (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate C client for implemented interface.
		local
			data_member: WIZARD_WRITER_C_MEMBER
			tmp_string: STRING
		do
			create cpp_class_writer.make
			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_header_file_name (a_descriptor.c_header_file_name)

			cpp_class_writer.add_import (a_descriptor.interface_descriptor.c_header_file_name)
			cpp_class_writer.add_other_source (iid_definition (a_descriptor.interface_descriptor.name, a_descriptor.interface_descriptor.guid))

			create data_member.make
			data_member.set_comment (Interface_pointer_comment)

			-- Variable name
			tmp_string := clone (Interface_variable_prepend)
			tmp_string.append (a_descriptor.interface_descriptor.c_type_name)
			data_member.set_name (tmp_string)

			-- Variable type
			tmp_string := clone (a_descriptor.interface_descriptor.c_type_name)
			tmp_string.append (Space)
			tmp_string.append (Asterisk)
			data_member.set_result_type (tmp_string)

			cpp_class_writer.add_member (data_member, Private)


			create data_member.make
			data_member.set_comment (Default_iunknown_variable_comment)

			-- Variable name
			data_member.set_name (Iunknown_variable_name)

			-- Variable type
			data_member.set_result_type (Iunknown_pointer)

			cpp_class_writer.add_member (data_member, Private)

			if 
				a_descriptor.interface_descriptor.dispinterface and not  
				a_descriptor.interface_descriptor.dual 
			then
				dispatch_interface := True

				-- Add memeber "EXCEPINFO * excepinfo"
				create data_member.make
				data_member.set_name (clone (Excepinfo_variable_name))
				tmp_string := clone (Excepinfo)
				tmp_string.append (Space)
				tmp_string.append (Asterisk)
				data_member.set_result_type (tmp_string)
				data_member.set_comment (Excepinfo_variable_comment)
				cpp_class_writer.add_member (data_member, Private)
				cpp_class_writer.add_function (ccom_last_error_code_function, Public)
				cpp_class_writer.add_function (ccom_last_source_of_exception_function, Public)
				cpp_class_writer.add_function (ccom_last_error_description_function, Public)
				cpp_class_writer.add_function (ccom_last_error_help_file_function, Public)

			end

			generate_functions_and_properties (a_descriptor, a_descriptor.interface_descriptor, a_descriptor.interface_descriptor.name)

			add_default_function
			cpp_class_writer.set_destructor (destructor (a_descriptor))
			cpp_class_writer.add_constructor (pointer_constructor (a_descriptor))

			-- Generate code and file name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
		ensure then
			non_void_cpp_class_writer: cpp_class_writer /= Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_coclass_c_client
		end

feature {NONE} -- Implementation

	pointer_constructor (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_interface_descriptor: a_descriptor.interface_descriptor /= Void
		local
			constructor_body: STRING
			a_signature: STRING
		do
			create Result.make

			create a_signature.make (100)
			a_signature.append (Iunknown_pointer)
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

			constructor_body.append (New_line_tab)
			constructor_body.append (Hresult_variable_name)
			constructor_body.append (Space_equal_space)
			constructor_body.append (A_pointer)
			constructor_body.append (Struct_selection_operator)
			constructor_body.append (Query_interface)
			constructor_body.append (Open_parenthesis)
			constructor_body.append ("IID_")
			constructor_body.append (a_descriptor.interface_descriptor.name)
			constructor_body.append (Comma_space)
			constructor_body.append (Open_parenthesis)
			constructor_body.append (C_void_pointer)
			constructor_body.append (Asterisk)
			constructor_body.append (Close_parenthesis)
			constructor_body.append (Ampersand)
			constructor_body.append (Interface_variable_prepend)
			constructor_body.append (a_descriptor.interface_descriptor.name)
			constructor_body.append (Close_parenthesis)
			constructor_body.append (Semicolon)
			constructor_body.append (New_line)
			constructor_body.append (examine_hresult (Hresult_variable_name))
			constructor_body.append (New_line)

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

	destructor (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): STRING is
			-- Desctructor
		require
			non_void_coclass_descriptor: a_descriptor /= Void
			non_void_interface_descriptors: a_descriptor.interface_descriptor /= Void
		do
			Result := clone (Tab)
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

			Result.append (release_interface (a_descriptor.interface_descriptor.name))
		ensure
			non_void_destructor: Result /= void
			valid_descructor: not Result.empty
		end


end -- class WIZARD_IMPLEMENTED_INTERFACE_C_CLIENT_GENERATOR

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
