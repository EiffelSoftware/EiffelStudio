indexing
	description: "Representation of a manifest integer constant"
	date: "$Date$"
	revision: "$Revision$"

class
	INT_VAL_B 

inherit
	INTERVAL_VAL_B
		redefine
			make_byte_code
		end

create
	make

feature {NONE} -- Initialization

	make (i: INTEGER) is
			-- Initialize `value' with `i'.
		do
			value := i
		ensure
			value_set: value = i
		end

feature -- Access

	value: INTEGER
			-- Constant value.

feature -- Comparison

	infix "<" (other: INT_VAL_B): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := value < other.value
		end

feature -- Error reporting

	display (st: STRUCTURED_TEXT) is
		do
			st.add_int (value)
		end

feature -- Code generation

	generation_value: INTEGER is
			-- Value to generate
		do
			Result := value
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant in an
			-- interval
		do
			ba.append (Bc_int)
			ba.append_integer (generation_value)
		end

end
