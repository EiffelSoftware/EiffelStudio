class
	OPTION_ALL_I 

inherit
	OPTION_I
		redefine
			generate, is_yes, byte_code
		end

feature -- Property

	is_yes: BOOLEAN is True

	byte_code: CHARACTER is 'y'

feature -- Output

	generate (file: INDENT_FILE) is
			-- Generate assertion value in `file'.
		do
			file.putstring ("(int16) 1")
		end

end -- class OPTION_ALL_I
