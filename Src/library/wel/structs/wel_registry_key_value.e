indexing

	description: "Structure describing a registry key value"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY_VALUE

inherit
	WEL_REGISTRY_KEY_VALUE_TYPE

create
	make
	
feature -- Initialization

	make (t: like type; v: like value) is
			-- Create 
		require
			v_not_void: v /= Void
		do
			set_type (t)
			set_value (v)
		ensure
			type_set: type = t
			value_set: value = v
		end

feature -- Access

	type: INTEGER
			-- Type of value
			-- See class WEL_REGISTRY_KEY_VALUE_TYPE for possible
			-- values.
			
	value: STRING
			-- Data.

	string_value: STRING is
			-- 	Data converted as string.
		require
			valid_type: type = Reg_sz
		do
			Result := value
		end
		
	dword_value: INTEGER is
			-- Data converted as integer.
		require
			valid_type: type = Reg_dword
		do
			Result := value.to_integer
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
			value := v
		ensure
			value_set: value = v
		end
		
end -- class WEL_REGISTRY_KEY_VALUE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

