indexing
	description: "Creator of Union Descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_UNION_DESCRIPTOR_CREATOR

inherit
	WIZARD_TYPE_DESCRIPTOR_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_UNION_DESCRIPTOR is
			-- Initialize `fields'
			-- and `eiffel_class_name'
		require
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_union
			valid_documentation: a_documentation /= Void
		do
			name := clone (a_documentation.name)
			if name = Void or else name.is_empty then
				create name.make (100)
				name.append ("union_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end

			description := clone (a_documentation.doc_string)
			type_kind := a_type_info.type_attr.type_kind

			create eiffel_class_name.make (100)
			eiffel_class_name.append (name_for_class (name, type_kind, False))
			eiffel_class_name.to_upper

			if is_forbidden_c_word (name) then
				name.prepend ("a_")
			end
			create c_type_name.make (100)
			c_type_name.append (name)
			system_descriptor.add_c_type (name)
			
			create c_header_file_name.make (100)
				c_header_file_name := header_name (namespace, name)

		--	create_field_descriptors (a_type_info)
		--	size_of_instance := a_type_info.type_attr.size_instance

		--	create Result.make (Current)
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
				fields.make
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
			fields_created: fields /= Void and then 
					fields.count = a_type_info.type_attr.count_variables
		end

	initialize_descriptor (a_descriptor: WIZARD_UNION_DESCRIPTOR) is
				-- Initialize descriptor
			require
				valid_descriptor: a_descriptor /= Void
			do
				set_common_fields (a_descriptor)
				a_descriptor.set_fields (fields)
				a_descriptor.set_size (size_of_instance)
			end

feature {NONE} -- Implementation

	fields: LINKED_LIST[WIZARD_RECORD_FIELD_DESCRIPTOR]
			-- Descriptions of structure's fields

	size_of_instance: INTEGER
			-- Size of instance of this type

end -- class WIZARD_UNION_DESCRIPTOR_CREATOR

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

