indexing
	description: "Interval byte node for an interval of integer values in inspect statement."
	date: "$Date$"
	revision: "$Revision$"

class INT_INTER_B 

inherit
	TYPED_INTERVAL_B [INTEGER]
		redefine
			lower
		end

create
	make

feature -- Access

	lower: INT_VAL_B
			-- Lower bound

feature {NONE} -- Implementation: C generation

	generate_value (value: INTEGER) is
			-- Generate single `value'
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_integer (value)
			buf.put_character ('L')
		end

	next_value (value: INTEGER): INTEGER is
			-- Value after given `value'
		do
			Result := value + 1
		end

feature {NONE} -- Implementation: IL code generation

	il_load_value (value: INTEGER) is
			-- Load `value' to stack.
		do
			il_generator.put_integer_32_constant (value)
		end

	il_load_difference (upper_value, lower_value: INTEGER) is
			-- Load a difference between `up' and `lo' to stack.
		do
			il_generator.put_integer_32_constant (upper_value - lower_value)
		end

end
