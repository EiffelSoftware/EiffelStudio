indexing
	description: "Interval byte node for an interval of 64-bit integer values in inspect statement."
	date: "$Date$"
	revision: "$Revision$"

class INT64_INTER_B

inherit
	TYPED_INTERVAL_B [INTEGER_64]
		redefine
			lower
		end

create
	make

feature -- Access

	lower: INT64_VAL_B
			-- Lower bound

feature {NONE} -- Implementation: C generation

	generate_value (value: INTEGER_64) is
			-- Generate single `value'
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("RTI64C(")
			buf.put_string (value.out)
			buf.put_character (')')
		end

	next_value (value: INTEGER_64): INTEGER_64 is
			-- Value after given `value'
		do
			Result := value + 1
		end

feature {NONE} -- Implementation: IL code generation

	il_load_value (value: INTEGER_64) is
			-- Load `value' to stack.
		do
			il_generator.put_integer_64_constant (value)
		end

	il_load_difference (upper_value, lower_value: INTEGER_64) is
			-- Load a difference between `up' and `lo' to stack.
		do
			il_generator.put_integer_64_constant (upper_value - lower_value)
		end

end
