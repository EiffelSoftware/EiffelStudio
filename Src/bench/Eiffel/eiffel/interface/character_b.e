-- Internal representation of class CHARACTER

class CHARACTER_B 

inherit
	CLASS_B
		rename
			make as basic_make
		redefine
			actual_type
		end

create
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

end
