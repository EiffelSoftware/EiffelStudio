indexing
	description: "Creator of Coclass descriptor"
	status: "See notice at end of class"
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

feature -- Basic operations

	create_descriptor  (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_COCLASS_DESCRIPTOR is
			-- Initialize descriptor
		require
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_coclass
			valid_documentation: a_documentation /= Void
		local
			tmp_type_attr: ECOM_TYPE_ATTR
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
		do
			name := clone (a_documentation.name)
			description := clone (a_documentation.doc_string)
			type_kind := a_type_info.type_attr.type_kind
			flags := a_type_info.type_attr.flags

			create_interface_descriptors (a_type_info)
			tmp_type_attr := a_type_info.type_attr
			create guid.make_from_guid (tmp_type_attr.guid)
			lcid := tmp_type_attr.lcid

			tmp_type_lib := a_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid
			type_library_descriptor := system_descriptor.library_descriptor (tmp_guid)

			add_type_lib_description (type_library_descriptor)

			if name = Void or else name.empty then
				create name.make (100)
				name.append ("coclass_")
				name.append (type_library_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end
			if prefixed_libraries.has (tmp_guid) then
				name.prepend (Underscore)
				name.prepend (type_library_descriptor.name)
			end

			namespace := namespace_name (type_library_descriptor.name)

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

	add_interface_descriptor (an_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Add `an_interface_descriptor' to `interface_descriptors'.
		require
			non_void_interface_descriptor: an_interface_descriptor /= Void
		do
			interface_descriptors.force (an_interface_descriptor)
		end

	add_source_interface_descriptor (an_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Add `an_interface_descriptor' to `source_interface_descriptors'.
		require
			non_void_interface_descriptor: an_interface_descriptor /= Void
		do
			source_interface_descriptors.force (an_interface_descriptor)
		end

	create_interface_descriptors (a_type_info: ECOM_TYPE_INFO) is
			-- Create interface descriptors
		require
			valid_type_info: a_type_info /= void
		local
			i, count, a_handle: INTEGER;
			tmp_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR;
			tmp_documentation: ECOM_DOCUMENTATION;
			tmp_type_info: ECOM_TYPE_INFO;
			tmp_descriptor_index: INTEGER;
			tmp_type_lib: ECOM_TYPE_LIB;
			tmp_guid: ECOM_GUID;
			tmp_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			tmp_impl_flag: INTEGER
			non_resticted_interfaces: LINKED_LIST [WIZARD_INTERFACE_DESCRIPTOR]
		do
			count := a_type_info.type_attr.count_implemented_types
			create {LINKED_LIST [WIZARD_INTERFACE_DESCRIPTOR]} interface_descriptors.make
			create {LINKED_LIST [WIZARD_INTERFACE_DESCRIPTOR]} source_interface_descriptors.make
			create non_resticted_interfaces.make

			from
				i := 0
			variant
				count - i
			until
				i = count
			loop
				tmp_impl_flag := a_type_info.impl_type_flag (i)
				
				a_handle := a_type_info.ref_type_of_impl_type (i)
				tmp_type_info := a_type_info.type_info (a_handle)
				check
					is_interface: tmp_type_info.type_attr.type_kind = Tkind_interface or
						tmp_type_info.type_attr.type_kind = Tkind_dispatch
				end
				tmp_descriptor_index := tmp_type_info.index_in_type_lib + 1
				tmp_type_lib := tmp_type_info.containing_type_lib
				tmp_guid := tmp_type_lib.library_attributes.guid
				if system_descriptor.has_library (tmp_guid) then
					tmp_library_descriptor := system_descriptor.library_descriptor (tmp_guid)
				else
					create tmp_library_descriptor.make (tmp_type_lib)
					system_descriptor.add_library_descriptor (tmp_library_descriptor)
					tmp_library_descriptor.generate
				end
				if tmp_library_descriptor.descriptors.item (tmp_descriptor_index) = Void then
					tmp_documentation := tmp_type_lib.documentation (tmp_type_info.index_in_type_lib)
					tmp_interface_descriptor ?= type_descriptor_factory.create_type_descriptor (tmp_documentation, tmp_type_info)
					tmp_library_descriptor.add_descriptor (tmp_interface_descriptor, tmp_descriptor_index)
				else
					tmp_interface_descriptor ?= tmp_library_descriptor.descriptors.item (tmp_descriptor_index)
				end
				check
					interface_descriptor: tmp_interface_descriptor /= Void
				end
				
				
				if is_fsource (tmp_impl_flag) then
					add_source_interface_descriptor (tmp_interface_descriptor)
					if is_fdefault (tmp_impl_flag) then
						if 
							(tmp_type_info.type_attr.type_kind = Tkind_dispatch) 
						then
							default_source_dispinterface_name := clone (tmp_interface_descriptor.c_type_name)
						end
					end
				else
					if not tmp_interface_descriptor.c_type_name.is_equal (Iunknown_type) then
						add_interface_descriptor (tmp_interface_descriptor)
					else
						number_unknown_interfaces := number_unknown_interfaces + 1
					end
					if is_fdefault (tmp_impl_flag) then
						default_interface_descriptor := tmp_interface_descriptor
						if 
							(tmp_type_info.type_attr.type_kind = Tkind_dispatch) 
						then
							default_dispinterface_name := clone (tmp_interface_descriptor.c_type_name)
						end
					end
					if not is_frestricted (tmp_impl_flag) then
						non_resticted_interfaces.force (tmp_interface_descriptor)
					end
				end
				i := i + 1
			end
			
			if default_interface_descriptor = Void then
				default_interface_descriptor := non_resticted_interfaces.first
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
				a_descriptor.set_interface_descriptors (interface_descriptors)
				a_descriptor.set_lcid (lcid)
				a_descriptor.set_type_library (type_library_descriptor)
				if default_dispinterface_name /= Void and then not default_dispinterface_name.empty then
					a_descriptor.set_default_dispinterface (default_dispinterface_name)
				end
				if default_source_dispinterface_name /= Void and then not default_source_dispinterface_name.empty then
					a_descriptor.set_default_source_dispinterface_name (default_source_dispinterface_name)
				end
				a_descriptor.set_default_interface (default_interface_descriptor)
				if 
					source_interface_descriptors /= Void and then 
					not source_interface_descriptors.empty
				then
					a_descriptor.set_source_interface_descriptors (source_interface_descriptors)
				end
				a_descriptor.set_flags (flags)
			end

feature {NONE} -- Implementation

	interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Coclass interfaces descriptors

	source_interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Interfaces to call back on client implementations,
			-- not empty implies that coclass supports IConnectionPointConteiner.

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

	number_unknown_interfaces: INTEGER
			-- Number of IUnknown interfaces on Coclass.

end -- class WIZARD_COCLASS_DESCRIPTOR_CREATOR

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

