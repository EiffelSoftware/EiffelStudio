-- Integer constants, as used for polynomials

class POLY_INTEGER 

inherit

	INT_CONSTANT
		redefine
			action
		end;

	POLYNOM
		undefine
			copy, is_equal
		end

create

	make

feature {NONE}

	action is
		do
			info.set_child_value (token.string_value.to_integer)
		end -- action

end -- class INT_CONSTANT

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel.
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

