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

	WIZARD_FORBIDDEN_NAMES
		export
			{NONE} all
		end

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; a_index: INTEGER): WIZARD_PROPERTY_DESCRIPTOR is
			-- Initialize
		require
			valid_type_info: a_type_info /= Void
		local
			l_var_desc: ECOM_VAR_DESC
			l_type_desc: ECOM_TYPE_DESC
			l_documentation: ECOM_DOCUMENTATION
			l_type_lib: ECOM_TYPE_LIB
			l_guid: ECOM_GUID
			l_lib_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			l_var_desc := a_type_info.var_desc (a_index)				
			member_id := l_var_desc.member_id
			is_read_only := is_varflag_freadonly (l_var_desc.var_flags)
			l_type_desc := l_var_desc.elem_desc.type_desc
			l_documentation := a_type_info.documentation (member_id)
			if l_documentation.name = Void or else l_documentation.name.count = 0 then
				l_type_lib := a_type_info.containing_type_lib
				l_guid := l_type_lib.library_attributes.guid
				l_lib_descriptor := system_descriptor.library_descriptor (l_guid)
				create name.make (100)
				name.append ("property_")
				name.append (l_lib_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
				name.append ("_")
				name.append_integer (member_id)
			else
				name := l_documentation.name.twin
			end

			eiffel_name := name_for_feature_with_keyword_check (name)

			if is_forbidden_c_word (name) and not environment.is_eiffel_interface then
				name.prepend ("x_")
			end
			description := l_documentation.doc_string.twin
			data_type := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, l_type_desc, system_descriptor)

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
			a_descriptor.set_is_read_only (is_read_only)
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

	is_read_only: BOOLEAN
			-- Is property read only?

end -- class WIZARD_PROPERTY_DESCRIPTOR_FACTORY

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

