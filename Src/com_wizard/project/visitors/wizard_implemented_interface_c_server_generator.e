indexing
	description: "Implemented interface generator for C server"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_C_SERVER_GENERATOR

inherit
	WIZARD_IMPLEMENTED_INTERFACE_C_GENERATOR

	WIZARD_COMPONENT_C_SERVER_GENERATOR
		redefine
			generate
		end

feature -- Access

	default_dispinterface (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_INTERFACE_DESCRIPTOR is
			-- Default dispinterface.
		do
			Result := an_interface.interface_descriptor
		end

feature -- Basic operations

	generate (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate C server for implemented interface.
		local
			interface_generator: WIZARD_COMPONENT_INTERFACE_C_SERVER_GENERATOR
		do
			Precursor {WIZARD_COMPONENT_C_SERVER_GENERATOR} (an_interface)
			cpp_class_writer.set_name (an_interface.impl_c_type_name (False))
			cpp_class_writer.set_namespace (an_interface.namespace)
			cpp_class_writer.set_header_file_name (an_interface.impl_c_header_file_name (False))

			an_interface.set_impl_names (False)

			cpp_class_writer.add_parent (an_interface.interface_descriptor.c_type_name,
					an_interface.interface_descriptor.namespace, Public)
			cpp_class_writer.add_import (an_interface.interface_descriptor.c_header_file_name)
			cpp_class_writer.add_other_source (iid_definition (an_interface.interface_descriptor.name, an_interface.interface_descriptor.guid))

			create interface_generator.make (an_interface, an_interface.interface_descriptor, cpp_class_writer)
			interface_generator.generate_functions_and_properties (an_interface.interface_descriptor)

			if 
				an_interface.interface_descriptor.inherit_from_dispatch
			then
				dispatch_interface := True
			end

			if dispatch_interface then
				dispatch_interface_features (an_interface)
			end

			standard_functions (an_interface)
			check
				valid_cpp_class_writer: cpp_class_writer.can_generate
			end

			-- Generate code and file name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)

			cpp_class_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_coclass_c_server
		end

feature {NONE} -- Implementation

	add_constructor (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Add constructor.
		do
			cpp_class_writer.add_constructor (constructor (an_interface))
		end

	constructor (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_descriptor: an_interface /= Void
			non_void_interface_descriptor: an_interface.interface_descriptor /= Void
		local
			a_constructor_body: STRING
			a_signature: STRING
		do
			create Result.make

			create a_signature.make (100)
			create a_constructor_body.make (1000)
			a_constructor_body.append (Tab)
			a_constructor_body.append 	(Type_id)
			a_constructor_body.append (Space_equal_space)
			a_constructor_body.append (Eif_type_id_function_name)
			a_constructor_body.append (Space_open_parenthesis)
			a_constructor_body.append (Double_quote)
			a_constructor_body.append (an_interface.impl_eiffel_class_name (False))
			a_constructor_body.append (Double_quote)
			a_constructor_body.append (Close_parenthesis)
			a_constructor_body.append (Semicolon)

			a_constructor_body.append (constructor_body (an_interface))

			Result.set_body (a_constructor_body)
		ensure
			non_void_constructor: Result /= Void
		end

	default_dispinterface_name (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): STRING is
			-- Name of default dispinterface.
		do
			Result := an_interface.interface_descriptor.c_type_name
		end

	add_query_interface (an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
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

			create tmp_body.make (1000)
			tmp_body.append (Tab)

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
			tmp_body.append (an_interface.interface_descriptor.c_type_name)
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
				tmp_body.append (an_interface.interface_descriptor.c_type_name)
				tmp_body.append (Asterisk)
				tmp_body.append (More)
				tmp_body.append (Open_parenthesis)
				tmp_body.append (This)
				tmp_body.append (Close_parenthesis)
				tmp_body.append (Semicolon)
				tmp_body.append (New_line_tab)
				tmp_body.append (Else_keyword)
			end

			tmp_body.append (Space)
			tmp_body.append (If_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Riid)
			tmp_body.append (C_equal)
			tmp_body.append (iid_name (an_interface.interface_descriptor.c_type_name))
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab)
			tmp_body.append (Star_ppv)
			tmp_body.append (Space_equal_space)
			tmp_body.append (Static_cast)
			tmp_body.append (Less)
			tmp_body.append (an_interface.interface_descriptor.c_type_name)
			tmp_body.append (Asterisk)
			tmp_body.append (More)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (This)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Semicolon)
			tmp_body.append (New_line_tab)
			tmp_body.append (Else_keyword)

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

invariant
	invariant_clause: -- Your invariant here

end -- class WIZARD_IMPLEMENTED_INTERFACE_C_SERVER_GENERATOR

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
