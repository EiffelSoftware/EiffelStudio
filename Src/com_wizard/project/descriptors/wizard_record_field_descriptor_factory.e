indexing
	description: "Factory of Structure Field Descriptors"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_FIELD_DESCRIPTOR_FACTORY

inherit
	WIZARD_SHARED_DESCRIPTOR_FACTORIES
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

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; an_index: INTEGER; 
				a_system_descriptor: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_RECORD_FIELD_DESCRIPTOR is
			-- Initialize
		local
			a_var_desc: ECOM_VAR_DESC
			a_type_desc: ECOM_TYPE_DESC
			a_documentation: ECOM_DOCUMENTATION
		do
			a_var_desc := a_type_info.var_desc (an_index)
			a_documentation := a_type_info.documentation (a_var_desc.member_id)
			if a_documentation.name = Void or else a_documentation.name.count = 0 then
				create name.make (100)
				name.append ("field_")
				name.append_integer (an_index + 1)
			else
				name := a_documentation.name
			end

			if is_forbidden_c_word (name) then
				name.prepend ("a_")
			end

			description := a_documentation.doc_string
			a_type_desc := a_var_desc.elem_desc.type_desc
			data_type := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, a_type_desc, a_system_descriptor)
			offset := a_var_desc.instance_offset

			create Result.make (Current)
		ensure
			valid_name: name /= Void and then name.count /= 0
			valid_data_type: data_type /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR) is
			-- Initialize descriptor
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			a_descriptor.set_description (description)
			a_descriptor.set_data_type (data_type)
			a_descriptor.set_offset (offset)
		end


feature {NONE} -- Implementation

	name: STRING
			-- Field name

	description: STRING
			-- Help string

	data_type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Field's type

	offset: INTEGER
			-- Offeset of field within structure

end -- class WIZARD_RECORD_FIELD_DESCRIPTOR_FACTORY

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

