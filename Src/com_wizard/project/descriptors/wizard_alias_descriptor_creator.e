indexing
	description: "Creator of Alias Descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ALIAS_DESCRIPTOR_CREATOR

inherit
	WIZARD_TYPE_DESCRIPTOR_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_ALIAS_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_documentation: a_documentation /= Void and then
				a_documentation.name /= Void
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_alias
		local
			type_desc: ECOM_TYPE_DESC
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
			tmp_lib_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			name := clone (a_documentation.name)
			description := clone (a_documentation.doc_string)
			type_kind := a_type_info.type_attr.type_kind

			tmp_type_lib := a_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid
			tmp_lib_descriptor := system_descriptor.library_descriptor (tmp_guid)
			add_type_lib_description (tmp_lib_descriptor)
			if name = Void or else name.count = 0 then
				create name.make (30)
				name.append ("alias_")
				name.append (tmp_lib_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end
			if prefixed_libraries.has (tmp_guid) then
				name.prepend (Underscore)
				name.prepend (tmp_lib_descriptor.name)
			end

			namespace := namespace_name (tmp_lib_descriptor.name)

			add_c_type
			create eiffel_class_name.make (50)
			eiffel_class_name.append (name_for_class (name, type_kind, False))
			eiffel_class_name.to_upper

			create c_type_name.make (30)
			c_type_name.append (name)
			
			create c_header_file_name.make (30)
			if not Non_generated_type_libraries.has (tmp_lib_descriptor.guid) then
				c_header_file_name.append (clone (Alias_header_file_name))
			end

			type_desc := a_type_info.type_attr.type_alias
			type_descriptor := data_type_descriptor_factory.create_data_type_descriptor 
					(a_type_info, type_desc, system_descriptor)

			if vartype_namer.is_basic (type_descriptor.type) then
				eiffel_class_name := clone (vartype_namer.eiffel_name (type_descriptor.type))
			end

			create Result.make (Current)
		ensure
			valid_descriptor: Result /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
				-- Initialize `a_descriptor' attributes
			require
				valid_descriptor: a_descriptor /= Void
			do
				set_common_fields (a_descriptor)
				a_descriptor.set_type_descriptor (type_descriptor)
			end

feature {NONE} -- Implementation

	type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Description of data type to which this type is alias

end -- class WIZARD_ALIAS_DESCRIPTOR_CREATOR

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

