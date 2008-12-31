note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	ROOT_CLASS

create
	make

feature -- Initialization

	make 
		local
			c_str: ANY
		do
			io.put_string ("Enter a string to convert into a C string: %N")
			io.read_line
			eiffel_str := io.last_string.twin
			c_str := eiffel_str.to_c
			c_printf ($c_str)
		end
						
	
feature {NONE} -- Access
	
	eiffel_str: STRING

feature -- External

	c_printf (ptr: POINTER)
		external
			"C | %"fext.h%""
		end

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


end -- STRING_CONVERTER


