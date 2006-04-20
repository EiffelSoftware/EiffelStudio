indexing
	description: "Creator of Coclass descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_DESCRIPTOR_CREATOR

inherit
	WIZARD_TYPE_DESCRIPTOR_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES

	EXCEPTIONS
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

	ECOM_IMPL_TYPE_FLAGS
		export
			{NONE} all
		end

	WIZARD_FILE_NAME_FACTORY
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor  (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_COCLASS_DESCRIPTOR is
			-- Initialize descriptor
		require
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_coclass
			valid_documentation: a_documentation /= Void
		local
			l_type_attr: ECOM_TYPE_ATTR
			l_type_lib: ECOM_TYPE_LIB
			l_guid: ECOM_GUID
			l_new_name, l_name: STRING
		do
			name := a_documentation.name.twin
			description := a_documentation.doc_string.twin
			type_kind := a_type_info.type_attr.type_kind
			flags := a_type_info.type_attr.flags

			create_interface_descriptors (a_type_info)
			l_type_attr := a_type_info.type_attr
			create guid.make_from_guid (l_type_attr.guid)
			lcid := l_type_attr.lcid

			l_type_lib := a_type_info.containing_type_lib
			l_guid := l_type_lib.library_attributes.guid
			type_library_descriptor := system_descriptor.library_descriptor (l_guid)

			add_type_lib_description (type_library_descriptor)

			l_name := type_library_descriptor.name
			if name = Void or else name.is_empty then
				create name.make (100)
				name.append ("coclass_")
				name.append (l_name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end
			if prefixed_libraries.has (l_guid) then
				create l_new_name.make (240)
				l_new_name.append (l_name)
				l_new_name.append_character ('_')
				l_new_name.append (name)
				name := l_new_name
			end

			namespace := namespace_name (l_name)

			add_c_type
			create eiffel_class_name.make (100)
			eiffel_class_name.append (name_for_class (name, type_kind, False))
			eiffel_class_name.to_upper

			create c_type_name.make (100)
			c_type_name.append (name)

			create c_header_file_name.make (100)
			if not Non_generated_type_libraries.has (type_library_descriptor.guid) then
				c_header_file_name := header_name (namespace, name)
			end

			create Result.make (Current)

			if not non_generated_type_libraries.has (Result.type_library_descriptor.guid) then
				system_descriptor.add_coclass (Result)
			end
		ensure then
			non_void_interface_descriptors: interface_descriptors /= Void
			valid_interface_descriptors: (interface_descriptors.count + source_interface_descriptors.count)  =
				(a_type_info.type_attr.count_implemented_types - number_unknown_interfaces)
		end

	create_interface_descriptors (a_type_info: ECOM_TYPE_INFO) is
			-- Create interface descriptors
		require
			valid_type_info: a_type_info /= void
		local
			i, l_count: INTEGER
			l_handle: NATURAL_32
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
			l_documentation: ECOM_DOCUMENTATION
			l_type_info: ECOM_TYPE_INFO
			l_index: INTEGER
			l_type_lib: ECOM_TYPE_LIB
			l_guid: ECOM_GUID
			l_library: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			l_flag: INTEGER
			l_interfaces: ARRAYED_LIST [WIZARD_INTERFACE_DESCRIPTOR]
		do
			l_count := a_type_info.type_attr.count_implemented_types
			create {ARRAYED_LIST [WIZARD_INTERFACE_DESCRIPTOR]} interface_descriptors.make (20)
			create {ARRAYED_LIST [WIZARD_INTERFACE_DESCRIPTOR]} source_interface_descriptors.make (5)
			create l_interfaces.make (20)

			from
			variant
				l_count - i
			until
				i = l_count
			loop
				l_flag := a_type_info.impl_type_flag (i)
				l_handle := a_type_info.ref_type_of_impl_type (i)
				l_type_info := a_type_info.type_info (l_handle)
				check
					is_interface: l_type_info.type_attr.type_kind = Tkind_interface or
						l_type_info.type_attr.type_kind = Tkind_dispatch
				end
				l_index := l_type_info.index_in_type_lib + 1
				l_type_lib := l_type_info.containing_type_lib
				l_guid := l_type_lib.library_attributes.guid
				if system_descriptor.has_library (l_guid) then
					l_library := system_descriptor.library_descriptor (l_guid)
				else
					create l_library.make (l_type_lib)
					system_descriptor.add_library_descriptor (l_library)
					l_library.generate
				end
				l_interface ?= l_library.descriptors.item (l_index)
				if l_interface = Void then
					l_documentation := l_type_lib.documentation (l_type_info.index_in_type_lib)
					l_interface ?= type_descriptor_factory.create_type_descriptor (l_documentation, l_type_info)
					l_library.add_descriptor (l_interface, l_index)
				end

				if is_fsource (l_flag) then
					source_interface_descriptors.force (l_interface)
					if is_fdefault (l_flag) and l_type_info.type_attr.type_kind = Tkind_dispatch then
						default_source_dispinterface_name := l_interface.c_type_name.twin
					end
				else
					if not l_interface.is_iunknown then
						interface_descriptors.force (l_interface)
					else
						number_unknown_interfaces := number_unknown_interfaces + 1
					end
					if is_fdefault (l_flag) then
						default_interface_descriptor := l_interface
						if  l_type_info.type_attr.type_kind = Tkind_dispatch then
							default_dispinterface_name := l_interface.c_type_name.twin
						end
					end
					if not is_frestricted (l_flag) then
						l_interfaces.force (l_interface)
					end
				end
				i := i + 1
			end

			if default_interface_descriptor = Void then
				default_interface_descriptor := l_interfaces.first
			end
		ensure
			valid_interface_count: (interface_descriptors.count + source_interface_descriptors.count) =
									(a_type_info.type_attr.count_implemented_types - number_unknown_interfaces)
			non_void_default_interface: default_interface_descriptor /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
				-- Initialize `a_descriptor' attributes.
			require
				valid_descriptor: a_descriptor /= Void
			do
				set_common_fields (a_descriptor)
				a_descriptor.set_c_declaration_header_file_name (declaration_header_file_name (c_header_file_name))
				a_descriptor.set_interface_descriptors (interface_descriptors)
				a_descriptor.set_lcid (lcid)
				a_descriptor.set_type_library (type_library_descriptor)
				if default_dispinterface_name /= Void and then not default_dispinterface_name.is_empty then
					a_descriptor.set_default_dispinterface (default_dispinterface_name)
				end
				if default_source_dispinterface_name /= Void and then not default_source_dispinterface_name.is_empty then
					a_descriptor.set_default_source_dispinterface_name (default_source_dispinterface_name)
				end
				a_descriptor.set_default_interface (default_interface_descriptor)
				if source_interface_descriptors /= Void and then not source_interface_descriptors.is_empty then
					a_descriptor.set_source_interface_descriptors (source_interface_descriptors)
				end
				a_descriptor.set_flags (flags)
			end

feature {NONE} -- Implementation

	interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Coclass interfaces descriptors

	source_interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Interfaces to call back on client implementations,
			-- not is_empty implies that coclass supports IConnectionPointConteiner.

	lcid: INTEGER
			-- Locale of member names and doc strings.

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	default_dispinterface_name: STRING
			-- Name of default interface.

	default_source_dispinterface_name: STRING
			-- Name of default source interface.

	default_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR
			-- Descriptor of default interface.

	flags: INTEGER
			-- See ECOM_TYPE_FLAGS for values.

	number_unknown_interfaces: INTEGER;
			-- Number of IUnknown interfaces on Coclass.

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
end -- class WIZARD_COCLASS_DESCRIPTOR_CREATOR

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

