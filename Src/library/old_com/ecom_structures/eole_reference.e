indexing

	description: "Reference on a variable; used by EOLE_VARIANT"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_REFERENCE

inherit
	EOLE_VAR_TYPE

feature -- Element change

	set_type (t: INTEGER) is
			-- Set `type' with `t'
			-- See class EOLE_VARTYPE for `t' value.
		require
			valid_type: is_valid_type (t)
		do
			type := t
		end

	set_ptr (p: POINTER) is
			-- Set `ptr' with `p'
		do
			ptr := p
		end

feature -- Access
	
	type: INTEGER
			-- Type of variable referenced by `ptr'
			-- See class EOLE_VARTYPE for `type' value
	
	ptr: POINTER
			-- pointer on variable
			
	is_valid_type (t: INTEGER): BOOLEAN is
			-- Is `t' a valid vartype?
			-- (not all types can be referenced)
			-- Since Vt constants are not true
			-- constants, we cannot use `inspect'.
		do
			Result := t = Vt_i2 or t = Vt_i4
				or t = Vt_r4 or t = Vt_r8
				or t = Vt_cy or t= Vt_date
				or t = Vt_bstr or t = Vt_dispatch
				or t = Vt_error or t = Vt_bool
				or t = Vt_variant or t = Vt_unknown
				or t = Vt_ui1
		end
	
end -- class EOLE_REFERENCE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
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

