indexing
	description: "Dispinterface property description"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
class
	WIZARD_PROPERTY_DESCRIPTOR

inherit
	WIZARD_FEATURE_DESCRIPTOR
		redefine
			disambiguate_names,
			disambiguate_eiffel_names
		end

	ECOM_VAR_KIND
		export
			{WIZARD_PROPERTY_DESCRIPTOR_FACTORY} all
		end

	ECOM_VAR_FLAGS
		export
			{WIZARD_PROPERTY_DESCRIPTOR_FACTORY} all
		end

creation
	make

feature -- Initialization

	make (a_creator: WIZARD_PROPERTY_DESCRIPTOR_FACTORY) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
			create coclass_eiffel_names.make (5)
		ensure
			non_void_name: name /= Void 
			valid_name: not name.is_empty
			valid_data_type: data_type /= Void
			non_void_coclass_eiffel_names: coclass_eiffel_names /= Void
		end

feature -- Access

	data_type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Field's type

	var_kind: INTEGER
			-- See class ECOM_VAR_KIND for values

	var_flags: INTEGER
			-- See class ECOM_VAR_FLAGS for values

	to_string: STRING is
			-- String representation used for output
		do
			Result := clone (name)
			Result.append (Colon)
			Result.append (Space)
			Result.append (data_type.name)
			Result.append (Space)
			Result.append (Open_parenthesis)
			Result.append (member_id.out)
			Result.append (Close_parenthesis)
		end

feature -- Status Report

	is_equal_property (other: WIZARD_PROPERTY_DESCRIPTOR): BOOLEAN is
			--
		require
			non_void_other: other /= Void
		do
			Result := name.is_equal (other.name) and 
				data_type.is_equal_data_type (other.data_type)
		ensure
			symmetric: Result implies other.is_equal_property (Current)
		end

feature -- Transformation

	disambiguate_names (an_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR;
				a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Disambiguate names for coclass.
		local
			tmp_name: STRING
		do
		{WIZARD_FEATURE_DESCRIPTOR} Precursor (an_interface_descriptor, a_coclass_descriptor)
			tmp_name := clone (interface_eiffel_name)
			tmp_name.prepend ("set_")
			a_coclass_descriptor.feature_eiffel_names.force  (tmp_name)
			tmp_name := clone (interface_eiffel_name)
			tmp_name.prepend ("set_ref_")
			a_coclass_descriptor.feature_eiffel_names.force  (tmp_name)
			if coclass_eiffel_names.has (a_coclass_descriptor.name) then
				tmp_name := clone (coclass_eiffel_names.item (a_coclass_descriptor.name))
				tmp_name.prepend ("set_")
				a_coclass_descriptor.feature_eiffel_names.force  (tmp_name)
				tmp_name := clone (coclass_eiffel_names.item (a_coclass_descriptor.name))
				tmp_name.prepend ("set_ref_")
				a_coclass_descriptor.feature_eiffel_names.force  (tmp_name)
			end
			tmp_name := clone (name)
			tmp_name.prepend ("set_")
			a_coclass_descriptor.feature_c_names.force (tmp_name)
			tmp_name := clone (name)
			tmp_name.prepend ("set_ref_")
			a_coclass_descriptor.feature_c_names.force (tmp_name)
		end

	disambiguate_eiffel_names (an_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Disambiguate names for interface.
		local
			tmp_string, tmp_string2, set_tmp_string, set_tmp_string2, set_ref_tmp_string, set_ref_tmp_string2: STRING
		do
			tmp_string := clone (interface_eiffel_name)
			tmp_string.to_lower
			tmp_string2 := clone (tmp_string)
			tmp_string2.append ("_user_precondition")

			set_tmp_string := clone (tmp_string)
			set_tmp_string.prepend ("set_")
			set_tmp_string2 := clone (set_tmp_string)
			set_tmp_string2.append ("_user_precondition")

			set_ref_tmp_string := clone (tmp_string)
			set_ref_tmp_string.prepend ("set_ref_")
			set_ref_tmp_string2 := clone (set_ref_tmp_string)
			set_ref_tmp_string2.append ("_user_precondition")
			if 
				an_interface_descriptor.feature_eiffel_names.has (tmp_string) or
				an_interface_descriptor.feature_eiffel_names.has (tmp_string2) or
				an_interface_descriptor.feature_eiffel_names.has (set_tmp_string) or
				an_interface_descriptor.feature_eiffel_names.has (set_tmp_string2) or
				an_interface_descriptor.feature_eiffel_names.has (set_ref_tmp_string) or
				an_interface_descriptor.feature_eiffel_names.has (set_ref_tmp_string2) or
				eiffel_key_words.has (tmp_string)
			then
				interface_eiffel_name.append_integer (counter)
			end
			tmp_string := clone (interface_eiffel_name)
			tmp_string2 := clone (tmp_string)
			tmp_string2.append ("_user_precondition")

			set_tmp_string := clone (tmp_string)
			set_tmp_string.prepend ("set_")
			set_tmp_string2 := clone (set_tmp_string)
			set_tmp_string2.append ("_user_precondition")

			set_ref_tmp_string := clone (tmp_string)
			set_ref_tmp_string.prepend ("set_ref_")
			set_ref_tmp_string2 := clone (set_ref_tmp_string)
			set_ref_tmp_string2.append ("_user_precondition")

			set_tmp_string := clone (tmp_string)
			set_tmp_string.prepend ("set_")
			set_tmp_string2 := clone (set_tmp_string)
			set_tmp_string2.append ("_user_precondition")

			set_ref_tmp_string := clone (tmp_string)
			set_ref_tmp_string.prepend ("set_ref_")
			set_ref_tmp_string2 := clone (set_ref_tmp_string)
			set_ref_tmp_string2.append ("_user_precondition")

			an_interface_descriptor.feature_eiffel_names.force (tmp_string)
			an_interface_descriptor.feature_eiffel_names.force (tmp_string2)

			an_interface_descriptor.feature_eiffel_names.force (set_tmp_string)
			an_interface_descriptor.feature_eiffel_names.force (set_tmp_string2)

			an_interface_descriptor.feature_eiffel_names.force (set_ref_tmp_string)
			an_interface_descriptor.feature_eiffel_names.force (set_ref_tmp_string2)
		end

feature {WIZARD_PROPERTY_DESCRIPTOR_FACTORY}-- Basic operations

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			valid_description: a_description /= Void and then not a_description.is_empty
		do
			description := clone (a_description)
		ensure
			valid_description: description /= Void and then not description.is_empty and description.is_equal (a_description)
		end

	set_data_type (a_data_type: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `data_type' with `a_data_type'.
		require
			valid_data_type: a_data_type /= Void
			do
				data_type := a_data_type
			ensure
				valid_data_type: data_type /= Void and data_type = a_data_type
			end

	set_member_id (a_member_id: INTEGER) is
			-- Set `member_id' with `a_member_id'.
		do
			member_id := a_member_id
		ensure
			valid_member_id: member_id = a_member_id
		end

	set_var_kind (a_kind: INTEGER) is
			-- Set `var_kind' with `a_kind'.
		require
			valid_kind: is_valid_var_kind (a_kind)
		do
			var_kind := a_kind
		ensure
			valid_var_kind: is_valid_var_kind (var_kind) and var_kind = a_kind
		end

	set_var_flags (some_flags: INTEGER) is
			-- Set `var_flags' with `some_flags'.
		require
			valid_flags: is_valid_varflag (some_flags)
		do
			var_flags := some_flags
		ensure
			valid_var_flags: is_valid_varflag (var_flags) and var_flags = some_flags
		end

end -- class WIZARD_PROPERTY_DESCRIPTOR

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

