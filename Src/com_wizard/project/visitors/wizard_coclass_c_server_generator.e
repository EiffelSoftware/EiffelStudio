indexing
	description: "Coclass c server generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_C_SERVER_GENERATOR
	
inherit
	WIZARD_COCLASS_C_GENERATOR

	WIZARD_COMPONENT_C_SERVER_GENERATOR

	ECOM_VAR_TYPE
		export
			{NONE} all
		end
	
feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate c server for coclass.
		local
			member_writer: WIZARD_WRITER_C_MEMBER
			a_class_object: WIZARD_CLASS_OBJECT_GENERATOR
			tmp_string: STRING
		do
			create cpp_class_writer.make
			create interface_names.make

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_header_file_name (a_descriptor.c_header_file_name)

			-- Import header file
			cpp_class_writer.add_import (Ecom_server_rt_globals_h)

			if shared_wizard_environment.out_of_process_server then
				tmp_string := clone (a_descriptor.c_type_name)
				tmp_string.append (Underscore)
				tmp_string.append (Factory)
				tmp_string.append (Header_file_extension)
				cpp_class_writer.add_import (tmp_string)
			end

			-- Add clsid of the coclass
			-- const CLSID CLSID_'coclass_name'
			cpp_class_writer.add_other (clsid_declaration (a_descriptor.c_type_name))
			cpp_class_writer.add_other_source (clsid_definition (a_descriptor.c_type_name, a_descriptor.guid))

			-- Add jmp_buf variable and integer value
			cpp_class_writer.add_other_source ("int return_hr_value;")
			cpp_class_writer.add_other_source ("jmp_buf exenv;")

			-- member (LONG Ref_count)
			create member_writer.make
			member_writer.set_name (Ref_count)
			member_writer.set_result_type (Long_macro)
			member_writer.set_comment ("Reference counter")
			cpp_class_writer.add_member (member_writer, Private)

			-- member (EIF_OBJECT eiffel_object)
			create member_writer.make
			member_writer.set_name (Eiffel_object)
			member_writer.set_result_type (Eif_object)
			member_writer.set_comment ("Corresponding Eiffel object")
			cpp_class_writer.add_member (member_writer, Private)

			-- member (EIF_TYPE_ID type_id)
			create member_writer.make
			member_writer.set_name (Type_id)
			member_writer.set_result_type (Eif_type_id)
			member_writer.set_comment ("Eiffel type id")
			cpp_class_writer.add_member (member_writer, Private)

			-- Process functions
			process_interfaces	(a_descriptor)			

			if dispatch_interface then
				-- Add type library id
				cpp_class_writer.add_other (libid_declaration (a_descriptor.type_library_descriptor.name))
				cpp_class_writer.add_other_source (libid_definition (a_descriptor.type_library_descriptor.name, a_descriptor.type_library_descriptor.guid))


				-- member (ITypeInfo * pTypeInfo)
				create member_writer.make
				member_writer.set_name (Type_info_variable_name)
				member_writer.set_result_type (Type_info)
				member_writer.set_comment ("Type information")
				cpp_class_writer.add_member (member_writer, Private)

				add_get_type_info_function (a_descriptor)
				add_get_type_info_count_function (a_descriptor)
				add_get_ids_of_names_function (a_descriptor)
				dispatch_invoke_function (a_descriptor)
			end

			add_constructor
			add_destructor


			-- Implement IUnknown interface
			add_release_function
			add_addref_function
			add_query_interface (a_descriptor)

			check
				valid_cpp_class_writer: cpp_class_writer.can_generate
			end

			-- Generate code and save name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)

			cpp_class_writer := Void

			-- Generate code for class object factory.
			create a_class_object
			a_class_object.generate (a_descriptor)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_c_server
		end

feature {NONE} -- Implementation

	process_interfaces (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process inherited interfaces
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			interface_processor: WIZARD_COCLASS_INTERFACE_C_SERVER_PROCESSOR
		do
			create interface_processor.make (a_coclass_descriptor, Current)
			if (dispinterface_names = Void) then
				create dispinterface_names.make
			end
			interface_processor.process_interfaces
			dispatch_interface := interface_processor.dispatch_interface
		end


	default_dispinterface_name (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- Name of default dispinterface.
		do
			if 
				a_coclass_descriptor.default_dispinterface_name /= Void and then
				not a_coclass_descriptor.default_dispinterface_name.empty
			then
				Result := clone (a_coclass_descriptor.default_dispinterface_name)
			elseif (dispinterface_names /= Void) then
				Result := clone (dispinterface_names.first)
			end
		end

	add_query_interface (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add function 'QueryInterface'
		local
			func_writer: WIZARD_WRITER_C_FUNCTION
			tmp_body: STRING
		do
			create func_writer.make

			func_writer.set_name (Query_interface)
			func_writer.set_comment ("Query Interface")
			func_writer.set_result_type (Std_method_imp)
			func_writer.set_signature (Query_interface_signature)

			tmp_body := clone (Tab)

			tmp_body.append (If_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Riid)
			tmp_body.append (C_equal)
			tmp_body.append (Iunknown_clsid)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Star_ppv)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Static_cast)
			tmp_body.append (Less)
			tmp_body.append (interface_names.first)
			tmp_body.append (Asterisk)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (This)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Else_keyword)

			if dispatch_interface then
				tmp_body.append (Space)
				tmp_body.append (If_keyword)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Riid)
				tmp_body.append (C_equal)
				tmp_body.append (iid_name (Idispatch_type))
				tmp_body.append (Close_parenthesis)
				tmp_body.append (New_line_tab_tab)
				tmp_body.append (Star_ppv)
				tmp_body.append (Space_equal_space)
				tmp_body.append (Static_cast)
				tmp_body.append (Less)
				tmp_body.append (default_dispinterface_name (a_coclass_descriptor))
				tmp_body.append (Asterisk)
				tmp_body.append (More)
				tmp_body.append (Open_parenthesis)
				tmp_body.append (This)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab)
				tmp_body.append (Else_keyword)
			end

			from
				interface_names.start
			until
				interface_names.off
			loop
				tmp_body.append (Space)
				tmp_body.append (If_keyword)
				tmp_body.append (Space_open_parenthesis)
				tmp_body.append (Riid)
				tmp_body.append (C_equal)
				tmp_body.append (iid_name (interface_names.item))
				tmp_body.append (Close_parenthesis)
				tmp_body.append (New_line_tab_tab)
				tmp_body.append (Star_ppv)
				tmp_body.append (Space_equal_space)
				tmp_body.append (Static_cast)
				tmp_body.append (Less)
				tmp_body.append (interface_names.item)
				tmp_body.append (Asterisk)
				tmp_body.append (More)
				tmp_body.append (Open_parenthesis)
				tmp_body.append (This)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab)
				tmp_body.append (Else_keyword)
				interface_names.forth
			end

			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Return)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Star_ppv)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Zero)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Comma_space)
			tmp_body.append (E_no_interface)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line)
			tmp_body.append (New_line_tab)
			tmp_body.append (Reinterpret_cast)
			tmp_body.append (Less)
			tmp_body.append (Iunknown)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Star_ppv)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Add_reference_function)
			tmp_body.append (New_line_tab)
			tmp_body.append (Return_s_ok)

			func_writer.set_body (tmp_body)

			check
				valid_func_writer: func_writer.can_generate
			end

			cpp_class_writer.add_function (func_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (func_writer)
			end
		end


end -- class WIZARD_COCLASS_C_SERVER_GENERATOR

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
