-- Class CHARACTER_REF

class CHARACTER_REF_B 

inherit
	CLASS_REF_B
		rename
			make as basic_make
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
	
	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class
		local
			c: CHAR_DESC
		do
			Result := desc.is_character
			if Result then
				c ?= desc
				Result := c.is_wide = is_wide
			end
		end

end
