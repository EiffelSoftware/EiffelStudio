-- Byte code for Eiffel loop

class LOOP_B 

inherit

	INSTR_B
		redefine
			need_enlarging, enlarged, make_byte_code,
			has_loop, assigns_to
		end;
	ASSERT_TYPE
		export
			{NONE} all
		end;
	
feature 

	from_part: BYTE_LIST [BYTE_NODE];
			-- From part {list of INSTR_B}: can be Void

	invariant_part: BYTE_LIST [BYTE_NODE];
			-- Invariant part {list of ASSERT_B}: can be Void

	variant_part: VARIANT_B;
			-- Variant

	stop: EXPR_B;
			-- Loop test

	compound: BYTE_LIST [BYTE_NODE];
			-- Compound {list of INSTR_B}; can be Void

	set_from_part (f: like from_part) is
			-- Assign `f' to `from_part'.
		do
			from_part := f;
		end;

	set_invariant_part (i: like invariant_part) is
			-- Assign `i' to `invariant_part'.
		do
			invariant_part := i;
		end;

	set_stop (s: like stop) is
			-- Assign `s' to `stop'.
		do
			stop := s;
		end;

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c;
		end;

	set_variant_part (v: like variant_part) is
			-- Assign `v' to `variant_part'.
		do
			variant_part := v;
		end;

	need_enlarging: BOOLEAN is true;
			-- This node needs enlarging

	enlarged: LOOP_BL is
			-- Enlarge current node
		do
			!!Result;
			Result.fill_from (Current);
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for Eiffel loop
		local
			local_list: LINKED_LIST [TYPE_I];
			variant_local_number: INTEGER;
		do
			make_breakable (ba)

			if from_part /= Void then
					-- Generate byte code for the from part
				from_part.make_byte_code (ba);
			end;
			make_breakable (ba)

			if variant_part /= Void then
					-- Initialization of the variant control variable
				local_list := context.local_list;
				context.add_local (Long_c_type);
				variant_local_number := local_list.count;
				ba.append (Bc_init_variant);
				ba.append_short_integer (variant_local_number);
			end;
				-- Generate byte code for exit expression
			ba.mark_backward;
			stop.make_byte_code (ba);

				-- Generate a test
			ba.append (Bc_jmp_t);

				-- Deferred writing of the jump relative value
			ba.mark_forward;

			if not (invariant_part = Void and then variant_part = Void) then
					-- Set the assertion type
				context.set_assertion_type (In_loop_invariant);

				ba.append (Bc_loop);
					-- In case the loop assertion are not checked, we
					-- have to put a jump value.
				ba.mark_forward;

					-- Invariant loop byte code
				if invariant_part /= Void then
					context.set_assertion_type (In_loop_invariant);
					invariant_part.make_byte_code (ba);
				end;
					-- Variant loop byte code
				if variant_part /= Void then
					context.set_assertion_type (In_loop_variant);
					variant_part.make_byte_code (ba);
					ba.append_short_integer (variant_local_number);
				end;

					-- Evaluation of the jump value
				ba.write_forward;
			end;

			if compound /= Void then
				compound.make_byte_code (ba);
			end;
			make_breakable (ba)

				-- Generate an unconditional jump
			ba.append (Bc_jmp);
				-- Write offset value for unconditinal jump
			ba.write_backward;

				-- Write jump value for conditional exit
			ba.write_forward;
		end;

feature -- Array optimization

	has_loop: BOOLEAN is True

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := (from_part /= Void and then from_part.assigns_to (i))
				or else (compound /= Void and then compound.assigns_to (i))
		end

end
