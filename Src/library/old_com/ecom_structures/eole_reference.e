indexing

	description: "Reference on a variable; used by EOLE_VARIANT"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_REFERENCE

inherit
	EOLE_VARTYPE

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

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
