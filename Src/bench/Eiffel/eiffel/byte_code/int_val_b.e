indexing
	description: "Representation of a manifest integer constant"
	date: "$Date$"
	revision: "$Revision$"

class
	INT_VAL_B 

inherit
	INTERVAL_VAL_B
		redefine
			is_equal,
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

	is_equal (other: INT_VAL_B): BOOLEAN is
			-- Is `other' equal to Current?
		do
			Result := value = other.value
		end

	infix "<" (other: INT_VAL_B): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := value < other.value
		end

	is_next (other: like Current): BOOLEAN is
			-- Is `other' next to Current?
		do
			Result := other.value = value + 1
		end

feature -- Measurement

	distance (other: like Current): DOUBLE is
			-- Distance between `other' and Current
		do
				-- Convert to result type first to avoid overflow if difference is higher than maximum integer
			Result := other.value
			Result := (Result - value).abs
		end
		
feature -- Error reporting

	display (st: STRUCTURED_TEXT) is
		do
			st.add_int (value)
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
			ba.append (Bc_int32)
			ba.append_integer (generation_value)
		end

feature -- IL code generation

	generate_il_branch_on_greater (is_included: BOOLEAN; label: IL_LABEL; instruction: INSPECT_B) is
			-- Generate branch to `label' if value on IL stack it greater than this value.
			-- Assume that current value is included in lower interval if `is_included' is true.
		do
			instruction.generate_il_load_value
			il_generator.put_integer_32_constant (generation_value)
			if is_included then
				il_generator.branch_on_condition (feature {MD_OPCODES}.bgt, label)
			else
				il_generator.branch_on_condition (feature {MD_OPCODES}.bge, label)
			end
		end

	generate_il_subtract (is_included: BOOLEAN) is
			-- Generate code to subtract this value if `is_included' is true or next value if `is_included' is false from top of IL stack.
		local
			i: like generation_value
		do
			i := generation_value
			if not is_included then
				i := i + 1
			end
			if i /= 0 then
				il_generator.put_integer_32_constant (i)
				il_generator.generate_binary_operator (feature {IL_CONST}.il_minus)
			end
		end

end
