class CHAR_DESC 

inherit
	ATTR_DESC
		redefine
			is_character
		end

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

feature -- Property

	is_wide: BOOLEAN
			-- Is current character a wide one?

	is_character: BOOLEAN is True
			-- Is the attribute a character one ?

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

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			if is_wide then
				buffer.putstring ("SK_WCHAR");
			else
				buffer.putstring ("SK_CHAR");
			end
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[")
			if is_wide then
				io.error.putstring ("WIDE_")
			end
			io.error.putstring ("CHARACTER]");
		end;

end
