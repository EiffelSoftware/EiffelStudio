indexing
	description	: "Byte code for instruction inside a loop variant"
	date		: "$Date$"
	revision	: "$Revision$"

class VARIANT_B 

inherit
	ASSERT_B
		redefine
			enlarged, byte_for_end
		end

feature -- Access

	enlarged: VARIANT_BL is
			-- Enlarge current node
		do
			create Result
			Result.fill_from (Current)
		end

	byte_for_end: CHARACTER is
            -- Byte mark for end of assertion
        do
            Result := Bc_end_variant
        end

feature -- IL code generation

	generate_il_variant_init (a_local: INTEGER) is
			-- Initialize variant computation.
		require
			a_local_not_negative: a_local > 0
		do
			check
				expr_exists: expr /= Void
				not_in_precondition: context.assertion_type /= In_precondition
			end

			generate_il_line_info (True)

				-- Generate expression, duplicate top to perform checking,
				-- and store it in `a_local'.
			expr.generate_il
			il_generator.duplicate_top
			il_generator.generate_local_assignment (a_local)
			il_generator.put_integer_32_constant (0)
			il_generator.generate_binary_operator ({IL_CONST}.il_ge)
			
			if tag = Void then
				il_generator.generate_assertion_check (context.assertion_type, "")
			else
				il_generator.generate_assertion_check (context.assertion_type, tag)
			end
		end

	generate_il_variant_check (a_local: INTEGER) is
			-- Compute new variant and raise an assertion violation if not satisfied.
		require
			a_local_not_negative: a_local > 0
		do
			check
				expr_exists: expr /= Void
				not_in_precondition: context.assertion_type /= In_precondition
			end

			generate_il_line_info (True)

			expr.generate_il

				-- We need 3 times the new value on top:
				-- 1 - to compare it with old value stored in `a_local' and
				--     make sure it is decreasing.
				-- 2 - for storing new value of variant in `a_local'.
				-- 3 - to make sure it is a positive value.
			il_generator.duplicate_top
			il_generator.duplicate_top
			
			il_generator.generate_local (a_local)
			il_generator.generate_binary_operator ({IL_CONST}.Il_lt)

			if tag = Void then
				il_generator.generate_assertion_check (context.assertion_type, "")
			else
				il_generator.generate_assertion_check (context.assertion_type, tag)
			end

			il_generator.generate_local_assignment (a_local)
			il_generator.put_integer_32_constant (0)
			il_generator.generate_binary_operator ({IL_CONST}.il_ge)
			
			if tag = Void then
				il_generator.generate_assertion_check (context.assertion_type, "")
			else
				il_generator.generate_assertion_check (context.assertion_type, tag)
			end
		end
		
end
