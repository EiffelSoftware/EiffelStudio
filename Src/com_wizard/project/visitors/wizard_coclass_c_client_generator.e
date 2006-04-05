indexing
	description: "Coclass c client generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end
	
feature -- Basic operations

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate c client for coclass.
		local
			l_member: WIZARD_WRITER_C_MEMBER
		do
			create cpp_class_writer.make
			create {ARRAYED_LIST [STRING]} interface_names.make (20)

			cpp_class_writer.set_name (a_descriptor.c_type_name)
			cpp_class_writer.set_namespace (a_descriptor.namespace)
			cpp_class_writer.set_header (a_descriptor.description)
			cpp_class_writer.set_definition_header_file_name (a_descriptor.c_definition_header_file_name)
			cpp_class_writer.set_declaration_header_file_name (a_descriptor.c_declaration_header_file_name)
			cpp_class_writer.add_other_source (clsid_definition (a_descriptor.name, a_descriptor.guid))

			process_interfaces (a_descriptor)
			cpp_class_writer.parents.wipe_out
			
			-- Add default member "p_unknown"
			create l_member.make
			l_member.set_name ("p_unknown")
			l_member.set_result_type ("IUnknown *")
			l_member.set_comment ("Default IUnknown interface pointer")
			cpp_class_writer.add_member (l_member, Private)

			-- Add member "EXCEPINFO * excepinfo" if is not normal interface and
			-- function "set_exception_information"
			if dispatch_interface then

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

			cpp_class_writer.set_destructor (destructor (a_descriptor))
			if is_typeflag_fcancreate (a_descriptor.flags) then
				cpp_class_writer.add_constructor (default_constructor (a_descriptor))
			end
			cpp_class_writer.add_constructor (pointer_constructor (a_descriptor))


			add_default_function

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
		local
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
		do
			create Result.make (10000)
			Result.append ("%Tp_unknown->Release ();%N%T")

			-- Release "excepinfo" if allocated
			if dispatch_interface then
				Result.append ("%N%TCoTaskMemFree ((void *)excepinfo);%N%T")
			end

			l_descriptors := a_coclass_descriptor.interface_descriptors
			from
				l_descriptors.start
			until
				l_descriptors.after
			loop
				l_interface := l_descriptors.item
				if not l_interface.is_iunknown and not l_interface.is_idispatch and l_interface.is_implementing_coclass (a_coclass_descriptor) then
					Result.append (release_interface (variable_name (l_interface.name)))
				end
				l_descriptors.forth
			end

			Result.append ("CoUninitialize ();")
		ensure
			non_void_destructor: Result /= void
			valid_descructor: not Result.is_empty
		end

	default_constructor (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
			non_void_interface_descriptors: a_coclass_descriptor.interface_descriptors /= Void
		local
			l_constructor: STRING
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			create Result.make

			create l_constructor.make (1000)
			l_constructor.append ("%THRESULT hr;%N")
			l_constructor.append (co_initialize_ex_function)
			l_constructor.append (examine_hresult ("hr"))
			l_constructor.append ("%N")
			l_constructor.append (co_create_instance_ex_function (a_coclass_descriptor))

			l_descriptors := a_coclass_descriptor.interface_descriptors
			from 
				l_descriptors.start
			until
				l_descriptors.off
			loop
				l_interface := l_descriptors.item
				if not l_interface.is_idispatch and not l_interface.is_iunknown and l_interface.is_implementing_coclass (a_coclass_descriptor) then
					l_constructor.append ("%N%Tp_")
					l_constructor.append (l_interface.name)
					l_constructor.append (" = 0;%N")
				end
				l_descriptors.forth
			end

			l_constructor.append (excepinfo_initialization)

			Result.set_body (l_constructor)
		ensure
			non_void_constructor: Result /= Void
		end

	pointer_constructor (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_CPP_CONSTRUCTOR is
			-- Constructor.
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
			non_void_interface_descriptors: a_coclass_descriptor.interface_descriptors /= Void
		local
			l_constructor: STRING
			l_signature: STRING
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			create Result.make

			create l_signature.make (100)
			l_signature.append ("IUnknown * a_pointer")
			Result.set_signature (l_signature)

			create l_constructor.make (1000)
			l_constructor.append ("%T HRESULT hr, hr2;%N")
			l_constructor.append (co_initialize_ex_function)
			l_constructor.append (examine_hresult ("hr"))

			l_constructor.append ("%N%Thr = a_pointer->QueryInterface(IID_IUnknown, (void**)&p_unknown);%N")
			l_constructor.append (examine_hresult ("hr"))
			l_constructor.append ("%N")

			l_descriptors := a_coclass_descriptor.interface_descriptors
			from 
				l_descriptors.start
			until
				l_descriptors.off
			loop
				l_interface := l_descriptors.item
				if not l_interface.is_idispatch and not l_interface.is_iunknown and l_interface.is_implementing_coclass (a_coclass_descriptor) then
					l_constructor.append ("%N%Tp_")
					l_constructor.append (l_interface.name)
					l_constructor.append (" = 0;%N%Thr = a_pointer->QueryInterface(")
					l_constructor.append (iid_name (l_interface.name))
					l_constructor.append (", (void**)&")
					l_constructor.append (variable_name (l_interface.name))
					l_constructor.append (");%N")
					l_constructor.append (examine_hresult ("hr"))
					l_constructor.append ("%N")
				end
				l_descriptors.forth
			end

			l_constructor.append (excepinfo_initialization)
			Result.set_body (l_constructor)
		ensure
			non_void_constructor: Result /= Void
		end

	co_create_instance_ex_function (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): STRING is
			-- CoCreateInstanceEx function call
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		do
			create Result.make (1000)
			Result.append ("%T")
			Result.append (multiple_query_interfaces)
			Result.append ("%N%Thr = CoCreateInstanceEx ")
			Result.append (Open_parenthesis)
			Result.append (clsid_name (a_coclass_descriptor.name))
			Result.append (", NULL, ")

			if environment.is_in_process then
				Result.append ("CLSCTX_INPROC_SERVER")
			elseif environment.is_out_of_process then	
				Result.append ("CLSCTX_LOCAL_SERVER|CLSCTX_REMOTE_SERVER")
			end

			Result.append (", NULL, 1, &a_qi);%N")
			Result.append (examine_hresult (Hresult_variable_name))
			Result.append ("%N")
			Result.append (examine_hresult ("a_qi.hr"))
			Result.append ("%N%Tp_unknown = a_qi.pItf;%N")
		ensure
			non_void_cocreate_instance: Result /= Void
			valid_cocreate_instance: not Result.is_empty
		end

	multiple_query_interfaces: STRING is "p_unknown = NULL;%N%TMULTI_QI a_qi = {&IID_IUnknown, NULL, 0};%N";
			-- MULTI_QI

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
end -- class WIZARD_COCLASS_C_CLIENT_GENERATOR

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

