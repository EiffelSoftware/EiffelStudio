indexing
	description: "Character description."
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_DESC

inherit
	ATTR_DESC

create
	make

feature -- Initialization

	make (w: BOOLEAN) is
			-- Create instance of CHAR_DESC. If `w' a normal character.
			-- Otherwise a wide character.
		do
			is_wide := w
		ensure
			is_wide_set: is_wide = w
		end

feature -- Access

	is_wide: BOOLEAN
			-- Is current character a wide one?

	level: INTEGER is
			-- Comparison criteria
		do
			if is_wide then
				Result := Wide_char_level
			else
				Result := Character_level
			end
		end

	sk_value: INTEGER is
		do
			if is_wide then
				Result := Sk_wchar
			else
				Result := Sk_char
			end
		end

	type_i: TYPE_I is
			-- Corresponding TYPE_I instance.
		do
			if is_wide then
				Result := Wide_char_c_type
			else
				Result := Char_c_type
			end
		end
			
		
feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			if is_wide then
				buffer.putstring ("SK_WCHAR")
			else
				buffer.putstring ("SK_CHAR")
			end
		end

feature -- Debug

	trace is
		do
			io.error.putstring (attribute_name)
			io.error.putstring ("[")
			if is_wide then
				io.error.putstring ("WIDE_")
			end
			io.error.putstring ("CHARACTER]")
		end

end
