class 

	EXAMPLE_INTEGRAND_FOLY 
	
inherit

	EXAMPLE_INTEGRAND_POLY
		redefine
			f1
		end
	
feature -- Basic operations

	f1 (x: DOUBLE): DOUBLE is
			-- quad
		do
			Result := 4.0 * x
		end;

end -- class EXAMPLE_INTEGRAND_FOLY

--|----------------------------------------------------------------
--| EiffelMath: library of reusable components for ISE Eiffel.
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

