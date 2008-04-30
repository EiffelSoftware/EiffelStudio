indexing
	description: "Coclass c server generator"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_C_SERVER_GENERATOR

inherit
	WIZARD_COCLASS_C_GENERATOR

	WIZARD_COMPONENT_C_SERVER_GENERATOR
		redefine
			generate,
			constructor_addition,
			destructor_addition
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	WIZARD_SOURCE_INTERFACE_HELPER
		export
			{NONE} all
		end

	ANY

feature -- Access

	default_dispinterface (a_coclass: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_INTERFACE_DESCRIPTOR is
			-- Default dispinterface.
		local
			l_coclass_descriptor: like coclass_descriptor
		do
			from
				l_coclass_descriptor := coclass_descriptor (a_coclass)
				l_coclass_descriptor.interface_descriptors.start
			until
				l_coclass_descriptor.interface_descriptors.after
			loop
				if l_coclass_descriptor.interface_descriptors.item.c_type_name.is_equal (default_dispinterface_name (a_coclass)) then
					Result := l_coclass_descriptor.interface_descriptors.item
				end
				l_coclass_descriptor.interface_descriptors.forth
			end
		end

	source: BOOLEAN
			-- Is coclass source of events?

feature -- Basic operations

	generate (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate c server for coclass.
		local
			a_class_object: WIZARD_CLASS_OBJECT_GENERATOR
			l_string: STRING
		do
			Precursor {WIZARD_COMPONENT_C_SERVER_GENERATOR} (a_coclass)
			create {ARRAYED_LIST [STRING]} interface_names.make (20)

			if environment.is_out_of_process then
				create l_string.make (500)
				l_string.append (a_coclass.c_type_name)
				l_string.append ("_factory.h")
				cpp_class_writer.add_import (l_string)
			end

			-- Add clsid of the coclass
			cpp_class_writer.add_other (clsid_declaration (a_coclass.c_type_name))
			cpp_class_writer.add_other_source (clsid_definition (a_coclass.c_type_name, a_coclass.guid))

			process_interfaces	(a_coclass)

			if dispatch_interface then
				dispatch_interface_features (a_coclass)
			else
				-- Add type library id
				cpp_class_writer.add_other_source (libid_definition (a_coclass.type_library_descriptor.name, a_coclass.type_library_descriptor.guid))
			end
			cpp_class_writer.add_parent ("IProvideClassInfo2", Void, Public)

			if source then
				cpp_class_writer.add_parent ("IConnectionPointContainer", Void, Public)
				add_source_functions (a_coclass)
			end

			standard_functions (a_coclass)
			cpp_class_writer.add_function (get_class_info_function (a_coclass), Public)
			cpp_class_writer.add_function (get_guid_function (a_coclass), Public)

			check
				valid_cpp_class_writer: cpp_class_writer.can_generate
			end

			-- Generate code and save name.
			Shared_file_name_factory.create_file_name (Current, cpp_class_writer)
			cpp_class_writer.save_file (Shared_file_name_factory.last_created_file_name)
			cpp_class_writer.save_declaration_header_file (Shared_file_name_factory.last_created_declaration_header_file_name)
			cpp_class_writer.save_definition_header_file (Shared_file_name_factory.last_created_header_file_name)

			cpp_class_writer := Void

			-- Generate code for class object factory.
			create a_class_object
			a_class_object.generate (a_coclass)
		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
		do
			a_factory.process_coclass_c_server
		end

	default_dispinterface_name (a_coclass_descriptor: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Name of default dispinterface.
		local
			l_coclass_descriptor: like coclass_descriptor
		do
			l_coclass_descriptor := coclass_descriptor (a_coclass_descriptor)
			if l_coclass_descriptor.default_dispinterface_name /= Void and then not l_coclass_descriptor.default_dispinterface_name.is_empty then
				Result := l_coclass_descriptor.default_dispinterface_name.twin
			elseif dispinterface_names /= Void then
				Result := dispinterface_names.first.twin
			end
		end

feature {NONE} -- Implementation

	coclass_descriptor (a_descriptor: WIZARD_COMPONENT_DESCRIPTOR): WIZARD_COCLASS_DESCRIPTOR is
		require
			a_descriptor_not_void: a_descriptor /= Void
			a_valid_type: valid_descriptor (a_descriptor)
		do
			Result ?= a_descriptor
		ensure
			coclass_descriptor_not_void: Result /= Void
		end

	valid_descriptor (a_descriptor: WIZARD_COMPONENT_DESCRIPTOR): BOOLEAN is
		do
			Result := {l_desc: WIZARD_COCLASS_DESCRIPTOR} a_descriptor
		end

	process_interfaces (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process inherited interfaces
		require
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			interface_processor: WIZARD_COCLASS_INTERFACE_C_SERVER_PROCESSOR
		do
			create interface_processor.make (a_coclass_descriptor, Current)
			if (dispinterface_names = Void) then
				create {ARRAYED_LIST [STRING]} dispinterface_names.make (20)
			end
			interface_processor.process_interfaces
			dispatch_interface := interface_processor.dispatch_interface
			source := interface_processor.source
		end

	default_source_dispinterface_name (a_coclass_descriptor: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Name of default dispinterface.
		local
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			l_descriptor: WIZARD_INTERFACE_DESCRIPTOR
		do
			l_descriptors := coclass_descriptor (a_coclass_descriptor).source_interface_descriptors
			if l_descriptors /= Void then
				from
					l_descriptors.start
				until
					l_descriptors.after or
					Result /= Void
				loop
					l_descriptor := l_descriptors.item
					if l_descriptor.dispinterface or l_descriptor.dual then
						Result := l_descriptor.name.twin
					end
					l_descriptors.forth
				end
			end
		end

	constructor_addition (a_coclass: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Constructor addition.
		local
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
		do
			create Result.make (0)
			l_descriptors := coclass_descriptor (a_coclass).source_interface_descriptors
			if l_descriptors /= Void then
				from
					l_descriptors.start
				until
					l_descriptors.after
				loop
					Result.append ("%N%T" +
							connection_point_attrubute_name
								(l_descriptors.item, cpp_class_writer) +
							" = new " + connection_point_inner_class_name
								(l_descriptors.item, cpp_class_writer) +
							" (this, eiffel_object, type_id);")
					l_descriptors.forth
				end
			end
		end

	destructor_addition (a_coclass: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Destructor addition.
		local
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
		do
			create Result.make (0)
			l_descriptors := coclass_descriptor (a_coclass).source_interface_descriptors
			if l_descriptors /= Void then
				from
					l_descriptors.start
				until
					l_descriptors.after
				loop
					Result.append ("%N%Tdelete ")
					Result.append (connection_point_attrubute_name (l_descriptors.item, cpp_class_writer))
					Result.append (";")
					l_descriptors.forth
				end
			end
		end

	add_constructor (a_coclass: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add constructor.
		local
			l_writer: WIZARD_WRITER_CPP_CONSTRUCTOR
			l_body: STRING
		do
			create l_writer.make
			l_writer.set_signature ("EIF_TYPE_ID tid")
			create l_body.make (1000)
			l_body.append ("%Ttype_id = tid;")
			l_body.append (constructor_body (a_coclass))
			l_writer.set_body (l_body)
			cpp_class_writer.add_constructor (l_writer)
		end

	add_query_interface (a_coclass_descriptor: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Add function 'QueryInterface'
		local
			l_writer: WIZARD_WRITER_C_FUNCTION
			l_body: STRING
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			l_coclass_descriptor: like coclass_descriptor
		do
			l_coclass_descriptor := coclass_descriptor (a_coclass_descriptor)
			create l_writer.make

			l_writer.set_name (Query_interface)
			l_writer.set_comment ("Query Interface.")
			l_writer.set_result_type ("STDMETHODIMP")
			l_writer.set_signature ("REFIID riid, void ** ppv")

			create l_body.make (10000)
			l_body.append ("%T")

			if not l_coclass_descriptor.interface_descriptors.is_empty then
				l_interface := l_coclass_descriptor.interface_descriptors.first
				l_body.append (case_body_in_query_interface (l_interface.c_type_name, l_interface.namespace, Iunknown_clsid))
			else
				l_body.append (case_body_in_query_interface ("IProvideClassInfo2", Void, Iunknown_clsid))
			end

			l_body.append (" ")
			l_body.append (case_body_in_query_interface ("IProvideClassInfo2", Void, iid_name ("IProvideClassInfo")))

			l_body.append (" ")
			l_body.append (case_body_in_query_interface ("IProvideClassInfo2", Void, iid_name ("IProvideClassInfo2")))

			if dispatch_interface then
				l_body.append (" ")
				l_body.append (case_body_in_query_interface (default_dispinterface_name (l_coclass_descriptor), l_coclass_descriptor.interface_descriptors.first.namespace, iid_name (Idispatch_type)))
			end

			l_descriptors := l_coclass_descriptor.interface_descriptors
			from
				l_descriptors.start
			until
				l_descriptors.off
			loop
				l_interface := l_descriptors.item
				if not l_interface.is_iunknown and not l_interface.is_idispatch then
					l_body.append (" ")
					l_body.append (case_body_in_query_interface (l_interface.c_type_name, l_interface.namespace, iid_name (l_interface.name)))
				end
				l_descriptors.forth
			end

			if source then
				l_body.append (" ")
				l_body.append (case_body_in_query_interface ("IConnectionPointContainer", Void, iid_name ("IConnectionPointContainer")))
			end
			l_body.append ("%N%Treturn (*ppv = 0), E_NOINTERFACE;%N%N%T")
			l_body.append ("reinterpret_cast<IUnknown *>(*ppv)->AddRef ();%N%T")
			l_body.append ("return S_OK;")
			l_writer.set_body (l_body)
			cpp_class_writer.add_function (l_writer, Public)
		end

	add_source_functions (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add source functions.
		require
			source: source
			non_void_coclass: a_coclass /= Void
		do
			cpp_class_writer.add_function (enum_connection_points_function, Public)
			cpp_class_writer.add_function (find_connection_point_function (a_coclass), Public)
		end

	enum_connection_points_function: WIZARD_WRITER_C_FUNCTION is
			-- EnumConnectionPoints
		require
			source: source
		local
			body: STRING
		do
			create Result.make
			Result.set_name ("EnumConnectionPoints")
			Result.set_comment ("EnumConnectionPoints of IConnectionPointContainer.")
			Result.set_result_type ("STDMETHODIMP")
			Result.set_signature ("/* [out] */ IEnumConnectionPoints ** ppEnum")
			create body.make (100)
			body.append ("%Treturn E_NOTIMPL;")
			Result.set_body (body)
		ensure
			non_void_function: Result /= Void
			can_generate: Result.can_generate
		end

	find_connection_point_function (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_C_FUNCTION is
			-- FindConnectionPoin
		require
			source: source
			non_void_coclass: a_coclass_descriptor /= Void
		local
			l_body: STRING
			l_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
		do
			create Result.make
			Result.set_name ("FindConnectionPoint")
			Result.set_comment ("FindConnectionPoint of IConnectionPointContainer.")
			Result.set_result_type ("STDMETHODIMP")
			Result.set_signature ("/* [in] */ REFIID riid, /* [out] */ IConnectionPoint ** ppCP")
			create l_body.make (100)
			l_body.append ("%T")
			l_descriptors := a_coclass_descriptor.source_interface_descriptors
			from
				l_descriptors.start
			until
				l_descriptors.after
			loop
				l_body.append (case_body_in_find_connection_point (l_descriptors.item, iid_name (l_descriptors.item.name)))
				l_descriptors.forth
			end
			l_body.append ("%N%T{%N%T%T*ppCP = NULL;%N%T%Treturn CONNECT_E_NOCONNECTION;%N%T}%N%T")
			l_body.append ("(*ppCP)->AddRef ();%N%T")
			l_body.append ("return S_OK;")
			Result.set_body (l_body)
		ensure
			non_void_function: Result /= Void
			can_generate: Result.can_generate
		end

	case_body_in_find_connection_point (an_interface: WIZARD_INTERFACE_DESCRIPTOR; interface_id: STRING): STRING is
			-- Case body in FindConnectionPoint function implemenatation.
		require
			non_void_interface: an_interface /= Void
			non_void_interface_id: interface_id /= Void
			valid_interface_id: not interface_id.is_empty
		do
			create Result.make (200)
			Result.append ("if (riid == ")
			Result.append (interface_id)
			Result.append (")%N%T%T* ppCP = ")
			Result.append (connection_point_attrubute_name (an_interface, cpp_class_writer))
			Result.append (";%N%Telse ")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty
		end

	get_class_info_function (a_coclass: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_C_FUNCTION is
			-- GetClassInfo of IProvideClassInfo.
		local
			l_body: STRING
		do
			create Result.make
			Result.set_comment ("GetClassInfo")

			Result.set_name ("GetClassInfo")
			Result.set_result_type ("STDMETHODIMP")
			Result.set_signature ("ITypeInfo ** ppti")
			create l_body.make (1000)
			l_body.append ("%Tif (ppti == NULL)%N%T%T%
								%return E_POINTER;%N%T%
							%ITypeLib * ptl = NULL;%N%T%
							%HRESULT hr = LoadRegTypeLib (")
			l_body.append (libid_name (a_coclass.type_library_descriptor.name))
			l_body.append (", 1, 0, 0, &ptl);%N%T%
							%if (SUCCEEDED (hr))%N%T%
							%{%N%T%T%
								%hr = ptl->GetTypeInfoOfGuid (" + clsid_name (a_coclass.name) + ", ppti);%N%T%T%
								%ptl->Release ();%N%T%
							%}%N%T%
							%return hr;")
			Result.set_body (l_body)
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
		end

	get_guid_function (a_coclass: WIZARD_COCLASS_DESCRIPTOR): WIZARD_WRITER_C_FUNCTION is
			-- GetGUID of IProvideClassInfo.
		local
			body, source_name: STRING
		do
			create Result.make
			Result.set_comment ("GetGUID")

			Result.set_name ("GetGUID")
			Result.set_result_type ("STDMETHODIMP")

			Result.set_signature ("DWORD dwKind, GUID * pguid")

			create body.make (200)
			body.append ("%Tif ((dwKind != GUIDKIND_DEFAULT_SOURCE_DISP_IID) ||(!pguid))%N%T%T%
									%return E_INVALIDARG;%N%T")
			body.append ("*pguid = ")
			source_name := default_source_dispinterface_name (a_coclass)
			if
				source_name /= Void and then
				not source_name.is_empty
			then
				body.append (iid_name (source_name))
			else
				body.append ("IID_NULL")
			end

			body.append (";%N%Treturn S_OK;")
			Result.set_body (body)
		ensure
			non_void: Result /= Void
			valid: Result.can_generate
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
end -- class WIZARD_COCLASS_C_SERVER_GENERATOR


