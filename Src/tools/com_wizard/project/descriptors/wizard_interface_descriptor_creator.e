indexing
	description: "Creator of Interface descriptors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INTERFACE_DESCRIPTOR_CREATOR

inherit
	WIZARD_TYPE_DESCRIPTOR_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_INVOKE_KIND
		export
			{NONE} all
		end

	WIZARD_GUIDS
		export
			{NONE} all
		end

	WIZARD_FILE_NAME_FACTORY
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_INTERFACE_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_documentation: a_documentation /= Void and then a_documentation.name /= Void
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_interface
						or a_type_info.type_attr.type_kind = Tkind_dispatch
		local
			l_handle: NATURAL_32
			l_type_info: ECOM_TYPE_INFO
			l_creator: WIZARD_INTERFACE_DESCRIPTOR_CREATOR
		do
			name := a_documentation.name.twin
			add_c_type

			description := a_documentation.doc_string.twin
			type_kind := a_type_info.type_attr.type_kind
			dispinterface := type_kind = Tkind_dispatch
			flags := a_type_info.type_attr.flags
			dual := is_typeflag_fdual (flags)

			if dual and dispinterface then

			-- From MSDN:
			-- If the TKIND_DISPATCH type description is for a dual interface,
			-- the TKIND_INTERFACE type description can be obtained by calling
			-- GetRefTypeOfImplType with an index of –1, and by passing the
			-- returned pRefType handle to GetRefTypeInfo to retrieve the type
			-- information.

				l_handle := a_type_info.ref_type_of_impl_type (-1)
				l_type_info := a_type_info.type_info (l_handle)
				type_kind := l_type_info.type_attr.type_kind
				dispinterface := False
				create l_creator
				dispinterface_descriptor := l_creator.create_dispinterface_descriptor (a_documentation, a_type_info, c_type_name)
			else
				l_type_info := a_type_info
			end
			Result := interface_descriptor (l_type_info)
		end

	create_dispinterface_descriptor  (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO; a_c_type_name: STRING): WIZARD_INTERFACE_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_documentation: a_documentation /= Void and then a_documentation.name /= Void
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_interface
						or a_type_info.type_attr.type_kind = Tkind_dispatch
		do
			name := a_documentation.name.twin
			c_type_name := a_c_type_name
			description := a_documentation.doc_string.twin
			type_kind := a_type_info.type_attr.type_kind
			dispinterface := type_kind = Tkind_dispatch
			flags := a_type_info.type_attr.flags
			dual := is_typeflag_fdual (flags)
			Result := interface_descriptor (a_type_info)
		ensure
			non_void_dispinterface: Result /= Void
		end

	interface_descriptor (a_type_info: ECOM_TYPE_INFO): WIZARD_INTERFACE_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_interface
						or a_type_info.type_attr.type_kind = Tkind_dispatch
		local
			l_type_attr: ECOM_TYPE_ATTR
			l_type_lib: ECOM_TYPE_LIB
			l_guid: ECOM_GUID
		do
			l_type_lib := a_type_info.containing_type_lib
			l_guid := l_type_lib.library_attributes.guid
			l_type_attr := a_type_info.type_attr
			create guid.make_from_guid (l_type_attr.guid)

			type_library_descriptor := system_descriptor.library_descriptor (l_guid)
			add_type_lib_description (type_library_descriptor)

			if name = Void or else name.is_empty then
				create name.make (100)
				name.append ("interface_")
				name.append (type_library_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end

			if prefixed_libraries.has (l_guid) then
				name.prepend (Underscore)
				name.prepend (type_library_descriptor.name)
			end

			if not is_well_known_interface_guid (guid) then
				namespace := namespace_name (type_library_descriptor.name)
				eiffel_class_name := name_for_class (name, type_kind, False)

				create c_header_file_name.make (100)
				if not Non_generated_type_libraries.has (type_library_descriptor.guid) then
					c_header_file_name := header_name (namespace, name)
				end
			else
				eiffel_class_name := Ecom_interface.twin
				create c_header_file_name.make (0)
				create namespace.make (0)
			end

			lcid := l_type_attr.lcid
			vtbl_size := l_type_attr.vtbl_size

			if a_type_info.type_attr.count_implemented_types > 0 then
				create_inherited_interface (a_type_info)
			end

			create feature_names.make
			create_function_descriptors (a_type_info)
			create_property_descriptors (a_type_info)
			create Result.make (Current)
		ensure then
			valid_guid: guid /= Void
			valid_functions: a_type_info.type_attr.count_func > 0 implies function_table /= Void
			valid_properties: a_type_info.type_attr.count_variables > 0 implies properties /= Void
			valid_interface: a_type_info.type_attr.count_implemented_types > 0 implies
						inherited_interface /= Void or inherited_interface_descriptor /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
				-- Initialize Descriptor
			require
				valid_descriptor: a_descriptor /= Void
			do
				set_common_fields (a_descriptor)
				a_descriptor.set_c_declaration_header_file_name (declaration_header_file_name (c_header_file_name))
				a_descriptor.set_function_table (function_table)
				a_descriptor.set_properties (properties)
				a_descriptor.set_inherited_interface (inherited_interface)
				a_descriptor.set_inherited_interface_descriptor (inherited_interface_descriptor)
				a_descriptor.set_dispinterface_descriptor (dispinterface_descriptor)
				a_descriptor.set_dual (dual)
				a_descriptor.set_dispinterface (dispinterface)
				a_descriptor.set_lcid (lcid)
				a_descriptor.set_vtbl_size (vtbl_size)
				a_descriptor.set_flags (flags)
				a_descriptor.set_type_library (type_library_descriptor)
				a_descriptor.set_is_iunknown (guid.is_equal (Iunknown_guid))
				a_descriptor.set_is_idispatch (guid.is_equal (Idispatch_guid))
			end

	create_function_descriptors (a_type_info: ECOM_TYPE_INFO) is
			-- Create function descriptors
		require
			valid_type_info: a_type_info /= Void
		local
			i, l_count: INTEGER
			l_func_descriptor: WIZARD_FUNCTION_DESCRIPTOR
			l_desc: ECOM_FUNC_DESC
			l_func_factory: WIZARD_FUNCTION_DESCRIPTOR_FACTORY
			l_name: STRING
		do
			l_count := a_type_info.type_attr.count_func
			from
				create {ARRAYED_LIST [WIZARD_FUNCTION_DESCRIPTOR]} function_table.make (l_count)
			variant
				l_count - i
			until
				i = l_count
			loop
				l_desc := a_type_info.func_desc (i)
				l_name := a_type_info.names (l_desc.member_id, 1).item (1)
				if name.is_equal (Iunknown_type) or name.is_equal (Idispatch_type) or not well_known_functions.has (l_name) then
					-- We don't want to generate IUnknown and IDispatch functions
					-- This test is needed because some dispinterface include definiton
					-- for all IDispatch methods (see Excel example)
					create l_func_factory
					l_func_descriptor := l_func_factory.create_descriptor (a_type_info, l_desc)
					l_name := unique_identifier (l_func_descriptor.name, agent feature_names.has)
					l_func_descriptor.set_name (l_name)
					function_table.force (l_func_descriptor)
					feature_names.extend (l_name)
				end
				i := i + 1
			end
		ensure
			non_void_function_table: function_table /= Void
		end

	create_property_descriptors (a_type_info: ECOM_TYPE_INFO) is
			-- Create property descriptors
		require
			valid_type_info: a_type_info /= Void
		local
			i, l_count: INTEGER
			l_descriptor: WIZARD_PROPERTY_DESCRIPTOR
			l_factory: WIZARD_PROPERTY_DESCRIPTOR_FACTORY
			l_name: STRING
		do
			l_count := a_type_info.type_attr.count_variables
			from
				i := 0
				create {ARRAYED_LIST [WIZARD_PROPERTY_DESCRIPTOR]} properties.make (20)
			variant
				l_count - i
			until
				i = l_count
			loop
				create l_factory
				l_descriptor := l_factory.create_descriptor (a_type_info, i)
				l_name := unique_identifier (l_descriptor.name, agent feature_names.has)
				l_descriptor.set_name (l_name)
				feature_names.extend (l_name)
				properties.force (l_descriptor)
				i := i + 1
			end
		ensure
			valid_properties: a_type_info.type_attr.count_variables > 0 implies properties /= Void
		end

	create_inherited_interface (a_type_info: ECOM_TYPE_INFO) is
			-- Create inherited interface descriptors
		require
			valid_type_info: a_type_info /= void
			have_inherited_interface: a_type_info.type_attr.count_implemented_types > 0
		local
			l_handle: NATURAL_32
			l_type_info: ECOM_TYPE_INFO
			l_index: INTEGER
			l_type_lib: ECOM_TYPE_LIB
			l_guid: ECOM_GUID
			l_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			l_type: WIZARD_TYPE_DESCRIPTOR
		do
			l_handle := a_type_info.ref_type_of_impl_type (0)
			l_type_info := a_type_info.type_info (l_handle)

			l_index := l_type_info.index_in_type_lib + 1
			l_type_lib := l_type_info.containing_type_lib
			l_guid := l_type_lib.library_attributes.guid
			if system_descriptor.has_library (l_guid) then
				l_library_descriptor := system_descriptor.library_descriptor (l_guid)
			else
				create l_library_descriptor.make (l_type_lib)
				system_descriptor.add_library_descriptor (l_library_descriptor)
				l_library_descriptor.generate
			end
			l_type := l_library_descriptor.descriptors.item (l_index)
			if l_type = Void then
				create inherited_interface_descriptor.make (l_library_descriptor, l_index)
			else
				inherited_interface ?= l_type
			end
		ensure
			valid_interfaces: inherited_interface /= Void or inherited_interface_descriptor /= Void
		end

feature {NONE} -- Implementation

	function_table: LIST [WIZARD_FUNCTION_DESCRIPTOR]
			-- Table of interface functions

	properties: LIST [WIZARD_PROPERTY_DESCRIPTOR]
			-- Descriptions of interface's properties

	inherited_interface: WIZARD_INTERFACE_DESCRIPTOR
			-- Description of inherited interface

	inherited_interface_descriptor: WIZARD_INHERITED_INTERFACE_DESCRIPTOR
			-- Interface descriptor.

	dual: BOOLEAN
			-- Is dual interface?

	dispinterface: BOOLEAN
			-- Is dispinterface?

	dispinterface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- If interface is dual, then it has dual description as dispinterface.

	lcid: INTEGER
			-- Locale of member names and doc strings.

	vtbl_size: INTEGER
			-- Size of type's VTBL

	flags: INTEGER
			-- See ECOM_TYPE_FLAGS for values.

	feature_names: SORTED_TWO_WAY_LIST [STRING]
			-- Names of functions and features.

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

feature {NONE} -- Implementation

	counter: INTEGER is
			-- Counter
		do
			Result := counter_impl.item
			counter_impl.set_item (Result + 1)
		end

	counter_impl: INTEGER_REF is
			-- Global counter
		once
			create Result
			Result.set_item (1)
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
end -- class WIZARD_INTERFACE_DESCRIPTOR_CREATOR

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

