indexing
	description: "Compiler representation of CHARACTER_REF class"
	date: "$Date$"
	revision: "$Revision$"

class CHARACTER_REF_B 

inherit
	CLASS_REF_B
		rename
			make as basic_make
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

feature -- Status report

	is_wide: BOOLEAN
			-- Is current character a wide one?
	
	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class
		local
			l_char_desc: CHAR_DESC
		do
			l_char_desc ?= desc
			if l_char_desc /= Void then
				Result := l_char_desc.is_wide = is_wide
			end
		end

end
