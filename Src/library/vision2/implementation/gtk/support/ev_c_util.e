class
	EV_C_UTIL

feature -- Output

	safe_print (s: STRING) is
			-- Use puts to print a string on the console.
			-- This can safely be used inside `dispose'.
		local
			a_gs: GEL_STRING
		do
			create a_gs.make (s)
			puts (a_gs.item)
		end

	puts (s: POINTER) is
		external
			"C | <stdio.h>"
		end

feature -- Measurement

	NULL: POINTER is
		external
			"C [macro <stdio.h>]"
		alias
			"NULL"
		end

feature -- Conversion

	pointer_to_integer (pointer: POINTER): INTEGER is
			-- int pointer_to_integer (void* pointer) {
			--     return (int) pointer;
			-- }
			-- Hack used for Result = ((EIF_INTEGER)(pointer)), blank alias avoids parser rules.
		external
			"C [macro <stdio.h>] (EIF_POINTER): EIF_INTEGER"
		alias
			" "
		end

	-- FIXME this is a hack and needs to be thought over.
		
feature -- C externals

	C: EV_C_EXTERNALS is
			-- Access to external C functions.
		once
			create Result
		end

feature {NONE} -- Nasty hack

	p2p (p: POINTER): POINTER is
			-- Because Result := $x causes a syntax error.
		do
			Result := p
		end

	c_free (ptr: POINTER) is
			-- free (void* ptr);
		external
			"C (void*) | <stdlib.h>"
		alias
			"free"
		end

end


--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

