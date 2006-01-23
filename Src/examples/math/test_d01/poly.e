indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class 

	EXAMPLE_INTEGRAND_POLY
	
inherit 

	FUNCTION_TABLE
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Register f1 in function table.
		do
			register_function ("f1", $f1)
		end;

feature -- Basic operations

	f1 (x: DOUBLE): DOUBLE is
			-- Twice as good
		do
			Result := 2.0 * x
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


end -- class EXAMPLE_INTEGRAND_POLY

