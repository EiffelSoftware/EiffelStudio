indexing
	description: "Structure describing a registry key value"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY_VALUE

inherit
	WEL_REGISTRY_KEY_VALUE_TYPE
	
	PLATFORM
		export
			{NONE} all
		end

create
	make,
	make_with_value
	
feature -- Initialization

	make (t: like type; v: STRING) is
			-- Create 
		require
			v_not_void: v /= Void
			t_valid: t = Reg_sz
		do
			set_type (t)
			create internal_value.make (v)
		ensure
			type_set: type = t
			value_set: value.is_equal (v)
		end
		
	make_with_value (t: like type; v: like internal_value) is
			-- Create 
		require
			v_not_void: v /= Void
		do
			set_type (t)
			internal_value := v
		ensure
			type_set: type = t
			internal_value_set: internal_value = v
		end

feature -- Access

	type: INTEGER
			-- Type of value
			-- See class WEL_REGISTRY_KEY_VALUE_TYPE for possible
			-- values.
			
	internal_value: WEL_STRING
			-- Storage for Current.

	value, string_value: STRING is
			-- String data.
		require
			valid_type: type = Reg_sz
		do
			Result := internal_value.string
		end

	dword_value: INTEGER is
			-- Data converted as integer.
		require
			valid_type: type = Reg_dword
		do
			($Result).memory_copy (internal_value.item, Integer_32_bytes)
		end

feature -- Element Change

	set_type (t: INTEGER) is
			-- Set type of value with `t'.
			-- See class WEL_REGISTRY_KEY_VALUE_TYPE for possible
			-- values for `t'.
		do
			type := t
		ensure
			type_set: type = t
		end
		
	set_value (v: like value) is
			-- Set `value' with `v'.
		require
			v_not_void: v /= Void
		do
			create internal_value.make (v)
		ensure
			value_set: value.is_equal (v)
		end

end -- class WEL_REGISTRY_KEY_VALUE


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

