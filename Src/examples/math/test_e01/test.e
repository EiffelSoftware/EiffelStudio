indexing
	description: "Tester of interpolation/approximation classes";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	INTERPOLATION_TEST 
	
create
	make 


feature -- Initialization

	make is
			-- tests of interpolation/approximation classes			
		local
			c_hermite: CURVE_HERMITE_INTERPOLATOR_TEST;
			c_interpol: CURVE_SPLINE_INTERPOLATOR_TEST;
			c_approxim: CURVE_SPLINE_APPROXIMATOR_TEST;
			s_interpol: SURFACE_SPLINE_INTERPOLATOR_TEST;
			s_approxim: SURFACE_SPLINE_APPROXIMATOR_TEST;
			s_scat_interpol: SCATTERED_SURFACE_INTERPOLATOR_TEST;
			s_scat_approxim: SCATTERED_SURFACE_SPLINE_APPROXIMATOR_TEST;
		do
			create c_hermite.make;
			create c_interpol.make;
			create c_approxim.make;
			create s_interpol.make;
			create s_approxim.make;
			create s_scat_interpol.make
			create s_scat_approxim.make
		end;
		
end -- class INTERPOLATION_TEST

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
