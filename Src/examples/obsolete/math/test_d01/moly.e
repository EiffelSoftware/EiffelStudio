note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class 

	EXAMPLE_INTEGRAND_MOLY 
	
inherit
	
	EXAMPLE_INTEGRAND_POLY
		redefine
			f1
		end

feature -- Basic operations

	f1 (x: DOUBLE): DOUBLE
			-- Thrice as good
		do
			Result := 3.0 * x
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EXAMPLE_INTEGRAND_MOLY

