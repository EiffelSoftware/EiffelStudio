indexing
	description: "Creator of Enumeration Description"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			name := a_documentation.name.twin
			description := a_documentation.doc_string.twin
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
			create {ARRAYED_LIST [WIZARD_ENUM_ELEMENT_DESCRIPTOR]} elements.make (20)
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
				elem_name := a_documentation.name.twin
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

	elements: LIST [WIZARD_ENUM_ELEMENT_DESCRIPTOR]
			-- list of element descriptors

	size_of_instance: INTEGER;
			-- Size of instance of this type

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
end -- class WIZARD_ENUM_DESCRIPTOR_CREATOR

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

