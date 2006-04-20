indexing
	description: "Implemented interface generator for C client"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_IMPLEMENTED_INTERFACE_C_CLIENT_GENERATOR

inherit
	WIZARD_IMPLEMENTED_INTERFACE_C_GENERATOR

	WIZARD_CPP_FEATURE_GENERATOR
		export
			{NONE} all
		end

	WIZARD_COMPONENT_C_CLIENT_GENERATOR

	WIZARD_SHARED_GENERATORS
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Basic operations

	generate (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- Generate C client for implemented interface.
		local
			l_member: WIZARD_WRITER_C_MEMBER
			l_name, l_type, l_namespace: STRING
		do
			create cpp_class_writer.make
			a_descriptor.set_impl_names (True)
			cpp_class_writer.set_name (a_descriptor.impl_c_type_name (True))
			cpp_class_writer.set_namespace (a_descriptor.namespace)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_declaration_header_file_name (a_descriptor.impl_c_declaration_header_file_name (True))
			cpp_class_writer.set_definition_header_file_name (a_descriptor.impl_c_definition_header_file_name (True))

			cpp_class_writer.add_import (a_descriptor.interface_descriptor.c_definition_header_file_name)
			cpp_class_writer.add_other_source (iid_definition (a_descriptor.interface_descriptor.name, a_descriptor.interface_descriptor.guid))

			create l_member.make
			l_member.set_comment ("Interface pointer")

			create l_name.make (100)
			l_name.append (variable_name (a_descriptor.interface_descriptor.name))
			l_member.set_name (l_name)

			create l_type.make (100)
			l_namespace := a_descriptor.interface_descriptor.namespace
			if l_namespace /= Void and then not l_namespace.is_empty then
				l_type.append (l_namespace)
				l_type.append ("::")
			end
			l_type.append (a_descriptor.interface_descriptor.c_type_name)
			l_type.append (" *")
			l_member.set_result_type (l_type)
			cpp_class_writer.add_member (l_member, Private)

			create l_member.make
			l_member.set_comment ("Default IUnknown interface pointer")
			l_member.set_name ("p_unknown")
			l_member.set_result_type ("IUnknown *")
			cpp_class_writer.add_member (l_member, Private)

			if a_descriptor.interface_descriptor.dispinterface or a_descriptor.interface_descriptor.dual then
				dispatch_interface := True

				-- Add memeber "EXCEPINFO * excepinfo"
				create l_member.make
				l_member.set_name ("excepinfo")
				l_member.set_result_type ("EXCEPINFO *")
				l_member.set_comment ("Exception information")
				cpp_class_writer.add_member (l_member, Private)
				cpp_class_writer.add_function (ccom_last_error_code_function, Public)
				cpp_class_writer.add_function (ccom_last_source_of_exception_function, Public)
				cpp_class_writer.add_function (ccom_last_error_description_function, Public)
				cpp_class_writer.add_function (ccom_last_error_help_file_function, Public)
			end

			C_client_generator.initialize (a_descriptor, a_descriptor.interface_descriptor, cpp_class_writer)
			C_client_generator.generate_functions_and_properties (a_descriptor.interface_descriptor)

			add_default_function
			cpp_class_writer.set_destructor (destructor (a_descriptor))
			cpp_class_writer.add_constructor (pointer_constructor (a_descriptor))

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
			a_factory.process_coclass_c_client
		end

feature {NONE} -- Implementation

	pointer_constructor (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_descriptor: a_descriptor /= Void
			non_void_interface_descriptor: a_descriptor.interface_descriptor /= Void
		local
			l_body, l_interface_name: STRING
		do
			create Result.make
			Result.set_signature ("IUnknown * a_pointer")
			create l_body.make (1000)
			l_interface_name := a_descriptor.interface_descriptor.name
			l_body.append ("%THRESULT hr, hr2;%N")
			l_body.append (co_initialize_ex_function)
			l_body.append (examine_hresult ("hr"))
			l_body.append ("%N%Thr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);%N")
			l_body.append (examine_hresult ("hr"))
			l_body.append ("%N%N%Thr = a_pointer->QueryInterface(")
			l_body.append (iid_name (l_interface_name))
			l_body.append (", (void **)&")
			l_body.append (variable_name (l_interface_name))
			l_body.append (");%N")
			l_body.append (examine_hresult ("hr"))
			l_body.append ("%N")
			l_body.append (excepinfo_initialization)			
			Result.set_body (l_body)
		ensure
			non_void_constructor: Result /= Void
		end

	destructor (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR): STRING is
			-- Desctructor
		require
			non_void_coclass_descriptor: a_descriptor /= Void
			non_void_interface_descriptors: a_descriptor.interface_descriptor /= Void
		do
			create Result.make (1000)
			Result.append ("%Tp_unknown->Release ();%N%T")

			-- Release "excepinfo" if allocated
			if dispatch_interface then
				Result.append ("%N%TCoTaskMemFree ((void *)excepinfo);%N%T")
			end

			Result.append (release_interface (variable_name (a_descriptor.interface_descriptor.name)))
			Result.append ("CoUninitialize ();")
		ensure
			non_void_destructor: Result /= void
			valid_descructor: not Result.is_empty
		end


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
end -- class WIZARD_IMPLEMENTED_INTERFACE_C_CLIENT_GENERATOR

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

