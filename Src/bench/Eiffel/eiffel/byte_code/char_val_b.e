indexing
	description: "Representation of a manifest constant constant"
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_VAL_B 

inherit
	INTERVAL_VAL_B
		redefine
			make_byte_code
		end

create
	make

feature {NONE} -- Initialization

	make (c: CHARACTER) is
			-- Initialize `value' with `c'.
		do
			value := c
		ensure
			value_set: value = c
		end

feature -- Access

	value: CHARACTER
			-- Integer value

feature -- Comparison

	infix "<" (other: CHAR_VAL_B): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := value < other.value
		end

feature -- Error reporting

	display (st: STRUCTURED_TEXT) is
		do
			st.add_char ('%'')
			st.add_char (value)
			st.add_char ('%'')
		end

feature -- Code generation

	generation_value: CHARACTER is
			-- Value to generate
		do
			Result := value
		end

feature --- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a character constant in an
			-- interval
		do
			ba.append (Bc_char)
			ba.append (generation_value)
		end

end
