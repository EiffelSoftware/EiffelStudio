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

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end

feature -- Access

	default_dispinterface (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_INTERFACE_DESCRIPTOR is
			-- Default dispinterface.
		do
			Result := a_interface.interface_descriptor
		end

feature -- Basic operations

	generate (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate C server for implemented interface.
		local
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			Precursor {WIZARD_COMPONENT_C_SERVER_GENERATOR} (a_interface)
			cpp_class_writer.set_name (a_interface.impl_c_type_name (False))
			cpp_class_writer.set_namespace (a_interface.namespace)
			cpp_class_writer.set_definition_header_file_name (a_interface.impl_c_definition_header_file_name (False))
			cpp_class_writer.set_declaration_header_file_name (a_interface.impl_c_declaration_header_file_name (False))

			a_interface.set_impl_names (False)

			l_interface := a_interface.interface_descriptor
			cpp_class_writer.add_parent (l_interface.c_type_name, l_interface.namespace, Public)
			cpp_class_writer.add_import (l_interface.c_definition_header_file_name)

			from
			until
				l_interface = Void or else l_interface.is_iunknown or else l_interface.is_idispatch
			loop
				cpp_class_writer.add_other_source (iid_definition (l_interface.name, l_interface.guid))
				l_interface := l_interface.inherited_interface
			end

			l_interface := a_interface.interface_descriptor
			C_server_generator.initialize (a_interface, l_interface, cpp_class_writer)
			C_server_generator.generate_functions_and_properties (l_interface)

			dispatch_interface := a_interface.interface_descriptor.is_idispatch_heir

			if dispatch_interface then
				dispatch_interface_features (a_interface)
			end

			standard_functions (a_interface)
			check
				valid_cpp_class_writer: cpp_class_writer.can_generate
			end

			-- Generate code and file name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_declaration_header_file (Shared_file_name_factory.last_created_declaration_header_file_name)
			cpp_class_writer.save_definition_header_file (Shared_file_name_factory.last_created_header_file_name)

			cpp_class_writer := Void
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_coclass_c_server
		end

feature {NONE} -- Implementation

	add_constructor (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Add constructor.
		do

		end

	constructor (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_descriptor: a_interface /= Void
			non_void_interface_descriptor: a_interface.interface_descriptor /= Void
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
			a_constructor_body.append (a_interface.impl_eiffel_class_name (False))
			a_constructor_body.append (Double_quote)
			a_constructor_body.append (Close_parenthesis)
			a_constructor_body.append (Semicolon)

			a_constructor_body.append (constructor_body (a_interface))

			Result.set_body (a_constructor_body)
		ensure
			non_void_constructor: Result /= Void
		end

	default_dispinterface_name (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): STRING is
			-- Name of default dispinterface.
		do
			Result := a_interface.interface_descriptor.c_type_name
		end

	add_query_interface (a_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Add function 'QueryInterface'
		local
			l_writer: WIZARD_WRITER_C_FUNCTION
			l_body: STRING
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			create l_writer.make

			l_writer.set_name (Query_interface)
			l_writer.set_comment ("Query Interface")
			l_writer.set_result_type (Std_method_imp)
			l_writer.set_signature (Query_interface_signature)

			create l_body.make (1000)
			l_body.append (Tab)

			l_interface := a_interface.interface_descriptor
			l_body.append (case_body_in_query_interface (l_interface.c_type_name, l_interface.namespace, Iunknown_clsid))

			if dispatch_interface then
				l_body.append (Space)
				l_body.append (case_body_in_query_interface (l_interface.c_type_name, l_interface.namespace, iid_name (Idispatch_type)))
			end
			
			from
			until
				l_interface = Void or else l_interface.is_iunknown or else l_interface.is_idispatch
			loop
				l_body.append (" ")
				l_body.append (case_body_in_query_interface (l_interface.c_type_name, l_interface.namespace, iid_name (l_interface.c_type_name)))
				l_interface := l_interface.inherited_interface
			end
			
			l_body.append (New_line_tab_tab)
			l_body.append (Return)
			l_body.append (Space_open_parenthesis)
			l_body.append (Star_ppv)
			l_body.append (Space_equal_space)
			l_body.append (Zero)
			l_body.append (Close_parenthesis)
			l_body.append (Comma_space)
			l_body.append (E_no_interface)
			l_body.append (Semicolon)
			l_body.append (New_line)
			l_body.append (New_line_tab)
			l_body.append (Reinterpret_cast)
			l_body.append (Less)
			l_body.append (Iunknown)
			l_body.append (More)
			l_body.append (Open_parenthesis)
			l_body.append (Star_ppv)
			l_body.append (Close_parenthesis)
			l_body.append (Add_reference_function)
			l_body.append (New_line_tab)
			l_body.append (Return_s_ok)

			l_writer.set_body (l_body)

			check
				valid_func_writer: l_writer.can_generate
			end

			cpp_class_writer.add_function (l_writer, Public)

			check
				writer_added: cpp_class_writer.functions.item (Public).has (l_writer)
			end
		end

end -- class WIZARD_IMPLEMENTED_INTERFACE_C_SERVER_GENERATOR

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

