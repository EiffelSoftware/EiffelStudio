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

			create_interface_descriptors (a_type_info)
			tmp_type_attr := a_type_info.type_attr
			create guid.make_from_guid (tmp_type_attr.guid)
			lcid := tmp_type_attr.lcid

			tmp_type_lib := a_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid
			type_library_descriptor := system_descriptor.library_descriptor (tmp_guid)
			if name = Void or else name.empty then
				create name.make (0)
				name.append ("coclass_")
				name.append (type_library_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end

			create eiffel_class_name.make (0)
			eiffel_class_name.append (name_for_class (name, type_kind, False))
			eiffel_class_name.to_upper

			create c_type_name.make (0)
			c_type_name.append (name)
			
			create c_header_file_name.make (0)
			if not Non_generated_type_libraries.has (type_library_descriptor.guid) then
				c_header_file_name.append ("ecom_")
				c_header_file_name.append (name)
				c_header_file_name.append (".h")
			end

			create Result.make (Current)

			system_descriptor.add_coclass (Result)
		ensure then
			valid_interface_descriptors: interface_descriptors /= Void and then
				interface_descriptors.count = a_type_info.type_attr.count_implemented_types
		end

	add_interface_descriptor (an_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Add `an_interface_descriptor' to `interface_descriptors'.
		require
			non_void_interface_descriptor: an_interface_descriptor /= Void
		do
			interface_descriptors.force (an_interface_descriptor)
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
			debugg: INTEGER
		do
			count := a_type_info.type_attr.count_implemented_types;
			create {LINKED_LIST [WIZARD_INTERFACE_DESCRIPTOR]} interface_descriptors.make;
			from
				i := 0
			variant
				count - i
			until
				i = count
			loop
				a_handle := a_type_info.ref_type_of_impl_type (i)
				tmp_type_info := a_type_info.type_info (a_handle)
				debugg := tmp_type_info.type_attr.type_kind
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
				end;
				if tmp_library_descriptor.descriptors.item (tmp_descriptor_index) = Void then
					tmp_documentation := tmp_type_lib.documentation (tmp_type_info.index_in_type_lib)
					tmp_interface_descriptor ?= type_descriptor_factory.create_type_descriptor (tmp_documentation, tmp_type_info)
					check
						interface_descriptor: tmp_interface_descriptor /= Void
					end
					tmp_library_descriptor.add_descriptor (tmp_interface_descriptor, tmp_descriptor_index)
				else
					tmp_interface_descriptor ?= tmp_library_descriptor.descriptors.item (tmp_descriptor_index)
					check
						interface_descriptor: tmp_interface_descriptor /= Void
					end
				end;
				add_interface_descriptor (tmp_interface_descriptor);
				i := i + 1
				debugg := a_type_info.type_attr.count_implemented_types
			end
		ensure 
			valid_interface_count: interface_descriptors.count = a_type_info.type_attr.count_implemented_types
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
			end

feature {NONE} -- Implementation

	interface_descriptors: LIST [WIZARD_INTERFACE_DESCRIPTOR]
			-- Coclass interfaces descriptors

	lcid: INTEGER
			-- Locale of member names and doc strings.

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

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

