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

	WIZARD_SHARED_GENERATION_ENVIRONMENT
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

feature -- Status report

	eiffel_name (a_component: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- Eiffel name in `a_component'.
		require
			non_void_component: a_component /= Void
			non_void_component_name: a_component.name /= Void
			valid_component_name: not a_component.name.is_empty
		do
			if coclass_eiffel_names.has (a_component.name) then
				Result := clone (coclass_eiffel_names.item (a_component.name))
			else
				Result := clone (interface_eiffel_name)
			end
		ensure
			non_void_name: Result /= Void
			valid_name: not Result.is_empty
		end

feature -- Transformation

	disambiguate_names (an_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR;
				a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Disambiguate names for coclass.
		require
			non_void_interface_descriptor: an_interface_descriptor /= Void
			non_void_coclass_descriptor: a_coclass_descriptor /= Void
		local
			tmp_name, tmp_precondition_name: STRING
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
			tmp_precondition_name := clone (tmp_name)
			tmp_precondition_name.append ("_user_precondition")
			if 
				a_coclass_descriptor.feature_eiffel_names.has (tmp_name) or
				a_coclass_descriptor.feature_eiffel_names.has (tmp_precondition_name)
			then
				tmp_name.prepend (Underscore)
				tmp_name.prepend (an_interface_descriptor.name)
				tmp_name := name_for_feature (tmp_name)
				from
				until
					not a_coclass_descriptor.feature_eiffel_names.has (tmp_name) and
					not a_coclass_descriptor.feature_eiffel_names.has (tmp_precondition_name)
				loop
					tmp_name.append (One)
					tmp_precondition_name := clone (tmp_name)
					tmp_precondition_name.append ("_user_precondition")
				end
				add_coclass_eiffel_name (tmp_name, a_coclass_descriptor.name)
			end
			a_coclass_descriptor.feature_eiffel_names.force (clone (tmp_name))
			tmp_precondition_name := clone (tmp_name)
			tmp_precondition_name.append ("_user_precondition")
			a_coclass_descriptor.feature_eiffel_names.force (tmp_precondition_name)
			
			a_coclass_descriptor.feature_c_names.force (clone (name))
			an_interface_descriptor.feature_c_names.force (clone (name))
		end

	disambiguate_eiffel_names (an_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Disambiguate names for interface.
		require
			non_void_interface: an_interface_descriptor /= Void
		local
			tmp_string, tmp_string2: STRING
		do
			if system_descriptor.c_types.has (name) then
				name.prepend ("a_")
			end
			tmp_string := clone (interface_eiffel_name)
			tmp_string.to_lower
			tmp_string2 := clone (tmp_string)
			tmp_string2.append ("_user_precondition")
			if 
				an_interface_descriptor.feature_eiffel_names.has (tmp_string) or
				an_interface_descriptor.feature_eiffel_names.has (tmp_string2) or
				eiffel_key_words.has (tmp_string)
			then
				interface_eiffel_name.append_integer (counter)
			end
			tmp_string := clone (interface_eiffel_name)
			tmp_string2 := clone (tmp_string)
			tmp_string2.append ("_user_precondition")
			an_interface_descriptor.feature_eiffel_names.force (tmp_string)
			an_interface_descriptor.feature_eiffel_names.force (tmp_string2)
		end

feature -- Basic operations

	add_coclass_eiffel_name (an_eiffel_name, a_coclass_name: STRING) is
			-- Add `an_eiffel_name' to `coclass_eiffel_names' table
			-- with key `a_coclass_name'
		require
			non_void_eiffel_name: an_eiffel_name /= Void
			valid_eiffel_name: not an_eiffel_name.is_empty
			non_void_coclass_name: a_coclass_name /= Void
			valid_coclass_name: not a_coclass_name.is_empty
			not_has: not coclass_eiffel_names.has (a_coclass_name)
		do
			coclass_eiffel_names.extend (an_eiffel_name, a_coclass_name)
		end


	set_interface_eiffel_name (a_name: STRING) is
			-- Set `eiffel_name' with `a_name'.
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			interface_eiffel_name := clone (a_name)
		ensure
			valid_name: interface_eiffel_name /= Void and then not interface_eiffel_name.is_empty and interface_eiffel_name.is_equal (a_name)
		end

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'.
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			name := clone (a_name)
		ensure
			valid_name: name /= Void and then not name.is_empty and name.is_equal (a_name)
		end

feature {NONE} -- Implementation

	counter: INTEGER is
			-- Counter
		do
			Result := counter_impl.item
			counter_impl.set_item (Result + 1)
		end

	counter_impl: INTEGER_REF is
			-- Global counter
		once
			create Result
			Result.set_item (1)
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
