-- Internal representation of class CHARACTER

class CHARACTER_B 

inherit
	CLASS_B
		rename
			make as basic_make
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

creation
	make

feature -- Initialization

	make (l: CLASS_I; w: BOOLEAN) is
			-- Create instance of CHARACTER_A. If `w' a normal character.
			-- Otherwise a wide character.
		do
			basic_make (l)
			is_wide := w
		ensure
			is_wide_set: is_wide = w
		end

feature -- Property

	is_wide: BOOLEAN
			-- Is current character a wide one?

feature -- Access

	actual_type: CHARACTER_A is
			-- Actual character type
		do
			if is_wide then
				Result := Wide_char_type
			else
				Result := Character_type
			end
		end

	generate_cecil_value is
			-- Generate Cecil type value
		do
			if is_wide then
				generation_buffer.putstring ("SK_WCHAR")
			else
				generation_buffer.putstring ("SK_CHAR")
			end
		end

	cecil_value: INTEGER is
			-- Cecil value
		do
			if is_wide then
				Result := Sk_wchar
			else
				Result := Sk_char
			end
		end

end
