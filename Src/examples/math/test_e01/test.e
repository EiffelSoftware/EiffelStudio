indexing
	description: "Tester of interpolation/approximation classes"
	legal: "See notice at end of class.";
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
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class INTERPOLATION_TEST

