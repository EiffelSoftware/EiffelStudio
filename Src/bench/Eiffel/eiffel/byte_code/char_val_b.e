indexing
	description: "Representation of a manifest constant constant"
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_VAL_B 

inherit
	TYPED_INTERVAL_VAL_B [CHARACTER]
		redefine
			make_byte_code
		end

create
	make

feature -- Comparison

	infix "<" (other: CHAR_VAL_B): BOOLEAN is
			-- Is `other' greater than Current?
		do
			Result := generation_value < other.generation_value
		end

	is_next (other: like Current): BOOLEAN is
			-- Is `other' next to Current?
		do
			Result := other.generation_value = generation_value + 1
		end

feature -- Measurement

	distance (other: like Current): DOUBLE is
			-- Distance between `other' and Current
		do
			Result := (other.generation_value |-| generation_value).abs
		end
		
feature -- Evaluation

	inspect_interval (upper: like Current): CHAR_INTER_B is
			-- Interval with lower set to `Current' and upper set to `upper'
		do
			create Result.make (Current, upper)
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
				i := other.generation_value |-| generation_value + 1
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

feature --- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a character constant in an
			-- interval
		do
			ba.append (Bc_char)
			ba.append (generation_value)
		end

feature -- IL code generation

	generate_il_branch_on_greater (is_included: BOOLEAN; label: IL_LABEL; instruction: INSPECT_B) is
			-- Generate branch to `label' if value on IL stack it greater than this value.
			-- Assume that current value is included in lower interval if `is_included' is true.
		do
			instruction.generate_il_load_value
			il_generator.put_character_constant (generation_value)
			if is_included then
				il_generator.branch_on_condition ({MD_OPCODES}.bgt_un, label)
			else
				il_generator.branch_on_condition ({MD_OPCODES}.bge_un, label)
			end
		end

	generate_il_subtract (is_included: BOOLEAN) is
			-- Generate code to subtract this value if `is_included' is true or
			-- next value if `is_included' is false from top of IL stack.
			-- Ensure that resulting value on the stack is UInt32.
		local
			i: like generation_value
		do
			i := generation_value
			if not is_included then
				i := i + 1
			end
			if i /= '%U' then
				il_generator.put_character_constant (i)
				il_generator.generate_binary_operator ({IL_CONST}.il_minus)
			end
		end

end
