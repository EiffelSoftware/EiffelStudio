indexing
	description: "Factory of Parameter Descriptors"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PARAMETER_DESCRIPTOR_FACTORY

inherit
	WIZARD_DESCRIPTOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	ECOM_PARAM_FLAGS
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

feature -- Basic operations

	create_descriptor (a_name: STRING; a_type_info: ECOM_TYPE_INFO;
				an_elem_desc: ECOM_ELEM_DESC; 
				a_system_descriptor: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_PARAM_DESCRIPTOR is
			-- Initialize
		require
			valid_name: a_name /= Void and then a_name.count /= 0
			valid_type_info: a_type_info /= Void
			valid_elem_desc: an_elem_desc /= Void
			valid_system_descriptor: a_system_descriptor /= Void
		local
			tmp_string: STRING
		do
			name := clone (a_name)
			if is_forbidden_c_word (name)  then
				name.prepend ("a_")
			end
			tmp_string := clone (name)
			tmp_string.to_lower
			if eiffel_key_words.has (tmp_string) then
				name.prepend ("a_")
			end

			type := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, an_elem_desc.type_desc,
					a_system_descriptor)
			flags := an_elem_desc.param_desc.flags
			if has_fopt_and_fhasdefault (flags) then
				default_value := an_elem_desc.param_desc.default_value.default_value.out
			end
			create Result.make (Current)
		ensure
			valid_name: name /= Void and then name.count /= 0
			valid_type: type /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_PARAM_DESCRIPTOR) is
			-- Initialize `a_descriptor' arguments.
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			a_descriptor.set_type (type)
			a_descriptor.set_flags (flags)
			a_descriptor.set_description (description)
		end

feature {NONE} -- Implementation

	name: STRING
			-- Argument name

	default_value: STRING
			-- Default value.

	description: STRING is
			-- Type description
		do
			create Result.make (0)
			if has_fopt_and_fhasdefault (flags) then
				Result.append ("Optional, default value = ")
				Result.append (default_value)
				Result.append (".")
			end
		end

	type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Argument type

	flags: INTEGER
			-- Argument flags
			-- See class ECOM_PARAM_FLAGS for values

end -- class WIZARD_PARAMETER_DESCRIPTOR_FACTORY

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

