indexing
	description: "Creator of Record Descriptors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_DESCRIPTOR_CREATOR

inherit
	WIZARD_TYPE_DESCRIPTOR_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_RECORD_DESCRIPTOR is
			-- Initialize `fields'
			-- and `eiffel_class_name'
		require
			non_void_type_info: a_type_info /= Void
			valid_type_info: a_type_info.type_attr.type_kind = Tkind_record or a_type_info.type_attr.type_kind = Tkind_union
			valid_documentation: a_documentation /= Void
		local
			l_type_lib: ECOM_TYPE_LIB
			l_guid: ECOM_GUID
		do
			name := a_documentation.name.twin
			description := a_documentation.doc_string.twin
			type_kind := a_type_info.type_attr.type_kind

			is_union := (type_kind = Tkind_union)
			create guid.make_from_guid (a_type_info.type_attr.guid)
			l_type_lib := a_type_info.containing_type_lib
			l_guid := l_type_lib.library_attributes.guid
			type_library_descriptor := system_descriptor.library_descriptor (l_guid)
			add_type_lib_description (type_library_descriptor)
			if name = Void or else name.is_empty then
				create name.make (100)
				name.append ("struct_")
				name.append (type_library_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end

			namespace := namespace_name (type_library_descriptor.name)

			if prefixed_libraries.has (l_guid) then
				name.prepend (Underscore)
				name.prepend (type_library_descriptor.name)
			end

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

			create_field_descriptors (a_type_info)
			size_of_instance := a_type_info.type_attr.size_instance

			create Result.make (Current)
		ensure then
			non_void_fields: fields /= Void
			non_void_class_name: eiffel_class_name /= Void
		end

	create_field_descriptors (a_type_info: ECOM_TYPE_INFO) is
			-- Create field descriptors
		require
			valid_type_info: a_type_info /= Void
		local
			i, count: INTEGER
			field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR
		do
			count := a_type_info.type_attr.count_variables
			from
				i := 0
				create fields.make
			variant
				count - i
			until
				i = count
			loop
				field_descriptor := record_field_descriptor_factory.create_descriptor (a_type_info, i, system_descriptor)
				fields.force (field_descriptor)
				i := i + 1
			end
		ensure
			fields_created: a_type_info.type_attr.count_variables > 0 implies
					fields /= Void and then
					fields.count = a_type_info.type_attr.count_variables
		end

	initialize_descriptor (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
				-- Intialize Descriptor
			require
				valid_descriptor: a_descriptor /= Void
			do
				set_common_fields (a_descriptor)
				a_descriptor.set_fields (fields)
				a_descriptor.set_size (size_of_instance)
				if description /= Void then
					a_descriptor.set_description (description)
				else
					a_descriptor.set_description ("")
				end
				a_descriptor.set_type_library (type_library_descriptor)
				a_descriptor.set_is_union (is_union)
			end

feature {NONE} -- Implementation

	fields: SORTED_TWO_WAY_LIST [WIZARD_RECORD_FIELD_DESCRIPTOR]
			-- Descriptions of structure's fields

	size_of_instance: NATURAL_32
			-- Size of instance of this type

	type_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			-- Type library descriptor

	is_union: BOOLEAN;
			-- Is union?

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
end -- class WIZARD_RECORD_DESCRIPTOR_CREATOR

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

