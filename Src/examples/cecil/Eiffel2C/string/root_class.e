class
	ROOT_CLASS

creation
	make

feature -- Initialization

	make is 
		local
			c_str: ANY
		do
			io.put_string ("Enter a string to convert into a C string: %N")
			io.read_line
			eiffel_str := clone (io.last_string)
			c_str := eiffel_str.to_c
			c_printf ($c_str)
		end
						
	
feature {NONE} -- Access
	
	eiffel_str: STRING

feature -- External

	c_printf (ptr: POINTER) is
		external
			"C | %"fext.h%""
		end

end -- STRING_CONVERTER

