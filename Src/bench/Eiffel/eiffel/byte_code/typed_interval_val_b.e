indexing
	description: "Abstract representation of an inspect value of a particular type."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPED_INTERVAL_VAL_B [H]

inherit
	INTERVAL_VAL_B
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make (v: H) is
			-- Initialize `value' with `v'.
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current?
		do
			Result := value = other.value
		end

	is_next (other: like Current): BOOLEAN is
			-- Is `other' next to Current?
		do
			Result := other.value = next_value (value)
		end

feature {TYPED_INTERVAL_B, TYPED_INTERVAL_VAL_B} -- Data

	value: H
			-- Constant value

feature {TYPED_INTERVAL_B} -- C code generation

	generate_interval (other: like Current) is
			-- Generate interval Current..`other'.
		local
			lo, up: H
			buf: GENERATION_BUFFER
		do
				-- Do not use `lo > up' as exit test since `lo'
				-- will be out of bounds when `up' is the greatest
				-- allowed value.
			from
				buf := buffer
				lo := value
				up := other.value
				buf.put_string ("case ")
				generate_value (lo)
				buf.put_character (':')
				buf.put_new_line
			until
				lo = up
			loop
				lo := next_value (lo)
				buf.put_string ("case ")
				generate_value (lo)
				buf.put_character (':')
				buf.put_new_line
			end
		end

feature {NONE} -- Implementation: C code generation

	generate_value (v: like value) is
			-- Generate single value `v'.
		require
			value_not_void: value /= Void
		deferred
		end

	next_value (v: like value): like value is
			-- Value after given value `v'
		require
			value_not_void: value /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
end
