indexing
	description: "Interval byte node for an interval of character values in inspect statement."
	date: "$Date$"
	revision: "$Revision$"

class CHAR_INTER_B 

inherit
	TYPED_INTERVAL_B [CHARACTER]
		redefine
			lower
		end

create
	make
	
feature -- Access

	lower: CHAR_VAL_B
			-- Lower bound

feature {NONE} -- Implementation: C generation

	generate_value (value: CHARACTER) is
			-- Generate single `value'
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("(EIF_CHARACTER) '")
			buf.escape_char (value)
			buf.put_character ('%'')
		end

	next_value (value: CHARACTER): CHARACTER is
			-- Value after given `value'
		do
			Result := value + 1
		end

feature {NONE} -- Implementation: IL code generation

	il_load_value (value: CHARACTER) is
			-- Load `value' to stack.
		do
			il_generator.put_character_constant (value)
		end

	il_load_difference (upper_value, lower_value: CHARACTER) is
			-- Load a difference between `up' and `lo' to stack.
		do
			il_generator.put_integer_32_constant (upper_value |-| lower_value)
		end

end
