indexing
	description: "Representation of a 64-bit manifest integer constant"
	date: "$Date$"
	revision: "$Revision$"

class
	INT64_VAL_B

inherit
	TYPED_INTERVAL_VAL_B [INTEGER_64]
		redefine
			is_allowed_unique_value,
			make_byte_code
		end

create
	make

feature -- Comparison

	infix "<" (other: INT64_VAL_B): BOOLEAN is
			-- Is `other' greater than Current?
		do
			Result := value < other.value
		end

	is_allowed_unique_value: BOOLEAN is
			-- Does `Current' represent an allowed unique value?
		do
			Result := value > 0
		end

feature -- Measurement

	distance (other: like Current): DOUBLE is
			-- Distance between `other' and Current
		do
				-- Convert to result type first to avoid overflow if difference is higher than maximum integer
			Result := other.value
			Result := Result - value
		end
		
feature -- Error reporting

	display (st: STRUCTURED_TEXT) is
		do
			st.add (create {NUMBER_TEXT}.make (value.out))
		end

feature -- Iteration

	do_all (is_included: BOOLEAN; other: like Current; is_other_included: BOOLEAN; action: PROCEDURE [ANY, TUPLE]) is
			-- Apply `action' to all values in range `Current'..`other' where
			-- inclusion of bounds in the range is specified by `is_included' and `is_other_included'.
		local
			i: like value
			j: like value
		do
			i := value
			j := other.value
			if i <= j and then (is_included or else i < i + 1) and then (is_other_included or else j - 1 < j) then
				if not is_included then
					i := i + 1
				end
				if not is_other_included then
					j := j - 1
				end
				if i <= j then
					from
						i := j - i
					until
						i = 0
					loop
						action.call (Void)
						i := i - 1
					end
					action.call (Void)
				end
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant in an interval.
		do
			ba.append (Bc_int64)
			ba.append_integer_64 (value)
		end

feature -- IL code generation

	generate_il_branch_on_greater (is_included: BOOLEAN; label: IL_LABEL; instruction: INSPECT_B) is
			-- Generate branch to `label' if value on IL stack it greater than this value.
			-- Assume that current value is included in lower interval if `is_included' is true.
		do
			instruction.generate_il_load_value
			il_load_value
			if is_included then
				il_generator.branch_on_condition ({MD_OPCODES}.bgt, label)
			else
				il_generator.branch_on_condition ({MD_OPCODES}.bge, label)
			end
		end

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
			if i /= 0 then
				il_generator.put_integer_64_constant (i)
				il_generator.generate_binary_operator ({IL_CONST}.il_minus)
			end
			il_generator.convert_to_natural_32
		end

feature {TYPED_INTERVAL_B} -- IL code generation

	il_load_value is
			-- Load value to IL stack.
		do
			il_generator.put_integer_64_constant (value)
		end

	il_load_difference (other: like Current) is
			-- Load a difference between current and `other' to IL stack.
		do
			il_generator.put_integer_64_constant (value - other.value)
		end

feature {NONE} -- Implementation: C generation

	generate_value (v: like value) is
			-- Generate single value `v'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("RTI64C(")
			buf.put_string (v.out)
			buf.put_character (')')
		end

	next_value (v: like value): like value is
			-- Value after given value `v'
		do
			Result := v + 1
		end

end
