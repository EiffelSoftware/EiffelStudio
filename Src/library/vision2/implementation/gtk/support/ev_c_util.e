class
	EV_C_UTIL

inherit
	C_GSLIST_STRUCT

feature -- Initialization

	enable_ev_gtk_log (a_mode: INTEGER) is
			-- Connect GTK+ logging to Eiffel exception handler.
			-- `a_mode' = 0 means no log messages, 1 = messages, 2 = messages with exceptions.
		external
			"C (EIF_INTEGER) | %"ev_c_util.h%""
		end

feature -- Output

	safe_print (s: STRING) is
			-- Use puts to print a string on the console.
			-- This can safely be used inside `dispose'.
		local
			temp_string: ANY
		do
			temp_string := s.to_c
			puts ($temp_string)
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

  	 eiffel_to_c (o: ANY): POINTER is
			-- Try to convert any eiffel object into
			-- a useful C structrue.
			-- Supports:
			--     STRING -> char*
			--     SEQUENCE [STRING] -> char**
			--| Only use this directly in a function call.
			--|  eg: f (eiffel_to_c (a), b, c)
			--| Never use it if the funtion call it is used in may trigger a GC
			--| cycle. eg: f (eiffel_to_c (a), b, create {FOO}.make)
			--| A create like the one above may cause the structure returned by
			--| eiffel_to_c move before it is passed to f.
			--| You have been warned. Sam 19991209
		local
			a: ANY
			s: STRING
			sl: SEQUENCE [STRING]
			c_sl: ARRAY [POINTER]
		do
			s ?= o
			sl ?= o
			if s /= Void then
				a ?= s.to_c
			elseif sl /= Void then
				create c_sl.make (1, sl.count)
				from sl.start
				until sl.after
				loop
					a ?= sl.item.to_c
					c_sl.put ($a, sl.index)
					sl.forth
				end
				a ?= c_sl.to_c
			end
			if a /= Void then
				Result := p2p ($a)
			end
		end
		
feature {EV_GTK_CALLBACK_MARSHAL}

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

	calloc (nmemb, size: INTEGER): POINTER is
			-- void *calloc(size_t nmemb, size_t size);
		external
			"C (size_t, size_t): void* | <stdlib.h>"
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

