indexing
	description: "Dispinterface property description"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
class
	WIZARD_PROPERTY_DESCRIPTOR

inherit
	WIZARD_DESCRIPTOR

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
			valid_name: not name.empty
			valid_data_type: data_type /= Void
			non_void_coclass_eiffel_names: coclass_eiffel_names /= Void
		end

feature -- Access

	name: STRING
			-- Field name

	interface_eiffel_name: STRING
			-- Eiffel property name that used in deferrded interface

	coclass_eiffel_names: HASH_TABLE [STRING, STRING]
			-- Eiffel property name that used in coclass.
			-- item: property name
			-- key: Coclass name, `name' in coclass_descriptor.

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

feature -- Basic operations

	add_coclass_eiffel_name (an_eiffel_name, a_coclass_name: STRING) is
			-- Add `an_eiffel_name' to `coclass_eiffel_names' table
			-- with key `a_coclass_name'
		require
			non_void_eiffel_name: an_eiffel_name /= Void
			valid_eiffel_name: not an_eiffel_name.empty
			non_void_coclass_name: a_coclass_name /= Void
			valid_coclass_name: not a_coclass_name.empty
			not_has: not coclass_eiffel_names.has (a_coclass_name)
		do
			coclass_eiffel_names.extend (an_eiffel_name, a_coclass_name)
		end

	set_interface_eiffel_name (a_name: STRING) is
			-- Set `eiffel_name' with `a_name'.
		require
			valid_name: a_name /= Void and then not a_name.empty
		do
			interface_eiffel_name := clone (a_name)
		ensure
			valid_name: interface_eiffel_name /= Void and then not interface_eiffel_name.empty and interface_eiffel_name.is_equal (a_name)
		end

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'
		require
			valid_name: a_name /= Void and then not a_name.empty
		do
			name := clone (a_name)
		ensure
			valid_name: name /= Void and then not name.empty and name.is_equal (a_name)
		end

feature {WIZARD_PROPERTY_DESCRIPTOR_FACTORY}-- Basic operations

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			valid_description: a_description /= Void and then not a_description.empty
		do
			description := clone (a_description)
		ensure
			valid_description: description /= Void and then not description.empty and description.is_equal (a_description)
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

