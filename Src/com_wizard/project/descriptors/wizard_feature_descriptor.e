indexing
	description: "Feature descriptor"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_FEATURE_DESCRIPTOR

inherit
	WIZARD_DESCRIPTOR

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Access

	name: STRING
			-- Feature name.

	interface_eiffel_name: STRING
			-- Eiffel function name that used in deferrded interface.

	coclass_eiffel_names: HASH_TABLE [STRING, STRING]
			-- Eiffel function name that used in coclass.
			-- item: function name
			-- key: Coclass name, `name' in coclass_descriptor.

	description: STRING
			-- Help String.

	member_id: INTEGER
			-- Member ID.

feature -- Transformation

	disambiguate_names (an_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR;
				a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Disambiguate names for coclass.
		require
			non_void_interface_descriptor: an_interface_descriptor /= Void
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			tmp_name: STRING
		do
			if a_coclass_descriptor.feature_c_names.has (name) then
				name.prepend (Underscore)
				name.prepend (an_interface_descriptor.name)
				from
				until
					not a_coclass_descriptor.feature_c_names.has (name)
				loop
					name.append (One)
				end
			end
			tmp_name := clone (interface_eiffel_name)
			if a_coclass_descriptor.feature_eiffel_names.has (tmp_name) then
				tmp_name.prepend (Underscore)
				tmp_name.prepend (an_interface_descriptor.name)
				tmp_name := name_for_feature (tmp_name)
				from
				until
					not a_coclass_descriptor.feature_eiffel_names.has (tmp_name)
				loop
					tmp_name.append (One)
				end
				add_coclass_eiffel_name (tmp_name, a_coclass_descriptor.name)
			end
			a_coclass_descriptor.feature_eiffel_names.force (clone (tmp_name))
			a_coclass_descriptor.feature_c_names.force (clone (name))
			an_interface_descriptor.feature_c_names.force (clone (name))
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
			-- Set `name' with `a_name'.
		require
			valid_name: a_name /= Void and then not a_name.empty
		do
			name := clone (a_name)
		ensure
			valid_name: name /= Void and then not name.empty and name.is_equal (a_name)
		end

end -- class WIZARD_FEATURE_DESCRIPTOR

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
