class 

	EXAMPLE_INTEGRAND_MOLY 
	
inherit
	
	EXAMPLE_INTEGRAND_POLY
		redefine
			f1
		end

feature -- Basic operations

	f1 (x: DOUBLE): DOUBLE is
			-- Thrice as good
		do
			Result := 3.0 * x
		end;

end -- class EXAMPLE_INTEGRAND_MOLY

--|----------------------------------------------------------------
--| EiffelMath: library of reusable components for numerical
--| computation ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
