indexing
	description: "Creator of Enumeration Description"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_DESCRIPTOR_CREATOR

inherit
	WIZARD_TYPE_DESCRIPTOR_CREATOR

	EXCEPTIONS
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

	WIZARD_SHARED_DESCRIPTOR_FACTORIES

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_ENUM_DESCRIPTOR is
			-- Initialize `elements'
			-- and `eiffel_class_name'
		require
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_enum
			valid_documentation: a_documentation /= Void
		local
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
			tmp_lib_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			name := clone (a_documentation.name)
			description := clone (a_documentation.doc_string)
			type_kind := a_type_info.type_attr.type_kind
			create guid.make_from_guid (a_type_info.type_attr.guid)

			tmp_type_lib := a_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid
			tmp_lib_descriptor := system_descriptor.library_descriptor (tmp_guid)
			add_type_lib_description (tmp_lib_descriptor)
			if name = Void or else name.count = 0 then
				create name.make (100)
				name.append ("enum_")
				name.append (tmp_lib_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end
			namespace := namespace_name (tmp_lib_descriptor .name)

			if prefixed_libraries.has (tmp_guid) then
				name.prepend (Underscore)
				name.prepend (tmp_lib_descriptor.name)
			end
			add_c_type

			create eiffel_class_name.make (100)
			eiffel_class_name.append ("ECOM_")
			eiffel_class_name.append (name_for_class (name, type_kind, False))
			eiffel_class_name.to_upper
			create_element_descriptors (a_type_info)

			create c_type_name.make (100)
			c_type_name.append (name)

			size_of_instance := a_type_info.type_attr.size_instance

			create Result.make (Current)
		ensure then
			non_void_elements: elements /= Void
			non_void_class_name: eiffel_class_name /= Void
		end

	create_element_descriptors (a_type_info: ECOM_TYPE_INFO) is
			-- Create element descriptors
		local
			i, element_count: INTEGER
			element_description: WIZARD_ENUM_ELEMENT_DESCRIPTOR
			a_documentation: ECOM_DOCUMENTATION
			member_id, a_value: INTEGER
			elem_name: STRING
			a_variant: ECOM_VARIANT
		do
			create elements.make
			element_count := a_type_info.type_attr.count_variables
			from
				i := 0
			variant
				element_count - i
			until
				i = element_count
			loop
				member_id := a_type_info.var_desc (i).member_id
				a_documentation := a_type_info.documentation (member_id)
				elem_name := clone (a_documentation.name)
				if elem_name = Void or else elem_name.count = 0 then
					create elem_name.make (100)
					elem_name.append (name)
					elem_name.append ("_element_")
					elem_name.append_integer(i + 1)
					a_documentation.set_name (elem_name)
				end
				a_variant := a_type_info.var_desc (i).constant_variant
				if a_variant.is_integer2 (a_variant.variable_type) then
					a_value := a_variant.integer2
				elseif a_variant.is_integer4 (a_variant.variable_type) then
					a_value := a_variant.integer4
				else
					raise ("Unknown element type")
				end
				element_description := enum_element_factory.create_descriptor (a_documentation, a_value)
				elements.force (element_description)
				i := i + 1
			end
		ensure
			non_void_elements: elements /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_ENUM_DESCRIPTOR) is
				-- Initialize descriptor
			require
				valid_descriptor: a_descriptor /= Void
			do
				c_header_file_name := ""
				c_type_name := ""
				set_common_fields (a_descriptor)
				a_descriptor.set_elements (elements)
				a_descriptor.set_size (size_of_instance)
			end

feature {NONE} -- Implementation

	elements: LINKED_LIST[WIZARD_ENUM_ELEMENT_DESCRIPTOR]
			-- list of element descriptors

	size_of_instance: INTEGER
			-- Size of instance of this type

end -- class WIZARD_ENUM_DESCRIPTOR_CREATOR

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

