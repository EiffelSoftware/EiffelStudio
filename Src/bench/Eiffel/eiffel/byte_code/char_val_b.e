indexing
	description: "Representation of a manifest constant constant"
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_VAL_B

inherit
	TYPED_INTERVAL_VAL_B [CHARACTER]

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_char_val_b (Current)
		end

feature -- Comparison

	infix "<" (other: CHAR_VAL_B): BOOLEAN is
			-- Is `other' greater than Current?
		do
			Result := value < other.value
		end

feature -- Measurement

	distance (other: like Current): DOUBLE is
			-- Distance between `other' and Current
		do
			Result := other.value |-| value
		end

feature -- Error reporting

	display (st: STRUCTURED_TEXT) is
		do
			st.add_char ('%'')
			st.add_char (value)
			st.add_char ('%'')
		end

feature -- Iteration

	do_all (is_included: BOOLEAN; other: like Current; is_other_included: BOOLEAN; action: PROCEDURE [ANY, TUPLE]) is
			-- Apply `action' to all values in range `Current'..`other' where
			-- inclusion of bounds in the range is specified by `is_included' and `is_other_included'.
		local
			i: INTEGER
		do
			from
				i := other.value |-| value + 1
				if not is_included then
					i := i - 1
				end
				if not is_other_included then
					i := i - 1
				end
			until
				i <= 0
			loop
				action.call (Void)
				i := i - 1
			end
		end

feature -- IL code generation

	generate_il_subtract (is_included: BOOLEAN) is
			-- Generate code to subtract this value if `is_included' is true or
			-- next value if `is_included' is false from top of IL stack.
			-- Ensure that resulting value on the stack is UInt32.
		local
			i: like value
		do
			i := value
			if not is_included then
				i := i + 1
			end
			if i /= '%U' then
				il_generator.put_character_constant (i)
				il_generator.generate_binary_operator ({IL_CONST}.il_minus)
			end
		end

feature {TYPED_INTERVAL_B} -- IL code generation

	il_load_value is
			-- Load value to IL stack.
		do
			il_generator.put_character_constant (value)
		end

	il_load_difference (other: like Current) is
			-- Load a difference between current and `other' to IL stack.
		do
			il_generator.put_integer_32_constant (value |-| other.value)
		end

feature {NONE} -- Implementation: C generation

	generate_value (v: like value) is
			-- Generate single value `v'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("(EIF_CHARACTER) '")
			buf.escape_char (v)
			buf.put_character ('%'')
		end

	next_value (v: like value): like value is
			-- Value after given value `v'
		do
			Result := v + 1
		end

end
