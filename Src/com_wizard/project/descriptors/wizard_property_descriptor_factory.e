indexing
	description: "Factory of Property Descriptors"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROPERTY_DESCRIPTOR_FACTORY

inherit
	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; an_index: INTEGER): WIZARD_PROPERTY_DESCRIPTOR is
			-- Initialize
		require
			valid_type_info: a_type_info /= Void
		local
			a_var_desc: ECOM_VAR_DESC
			a_type_desc: ECOM_TYPE_DESC
			a_documentation: ECOM_DOCUMENTATION
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
			tmp_lib_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			a_var_desc := a_type_info.var_desc (an_index)
			member_id := a_var_desc.member_id
			var_kind := a_var_desc.var_kind
			var_flags := a_var_desc.var_flags
			a_documentation := a_type_info.documentation (a_var_desc.member_id)
			if a_documentation.name = Void or else a_documentation.name.count = 0 then
				tmp_type_lib := a_type_info.containing_type_lib
				tmp_guid := tmp_type_lib.library_attributes.guid
				tmp_lib_descriptor := system_descriptor.library_descriptor (tmp_guid)
				create name.make (100)
				name.append ("property_")
				name.append (tmp_lib_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
				name.append ("_")
				name.append_integer (member_id)
			else
				name := clone (a_documentation.name)
			end

			eiffel_name := name_for_feature_with_keyword_check (name)

			if is_forbidden_c_word (name) and not shared_wizard_environment.new_eiffel_project then
				name.prepend ("a_")
			end
			description := clone (a_documentation.doc_string)
			if description.empty then
				description := clone (No_description_available)
			end
			a_type_desc := a_var_desc.elem_desc.type_desc
			data_type := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, a_type_desc, system_descriptor)

			create Result.make (Current)
		ensure
			valid_name: name /= Void and then name.count /= 0
			valid_data_type: data_type /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Initialize `a_descriptor' atributes.
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			a_descriptor.set_description (description)
			a_descriptor.set_data_type (data_type)
			a_descriptor.set_member_id (member_id)
			a_descriptor.set_var_kind (var_kind)
			a_descriptor.set_var_flags (var_flags)
			a_descriptor.set_interface_eiffel_name (eiffel_name)
		end

feature {NONE} -- Implementation

	name: STRING
			-- Field name

	eiffel_name: STRING
			-- Eiffel name

	description: STRING
			-- Help string

	data_type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Field's type

	member_id: INTEGER
			-- Member ID

	var_kind: INTEGER
			-- See class ECOM_VAR_KIND for values

	var_flags: INTEGER
			-- See class ECOM_VAR_FLAGS for values

end -- class WIZARD_PROPERTY_DESCRIPTOR_FACTORY

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

