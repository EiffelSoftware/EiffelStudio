-- Byte code for Eiffel loop

class LOOP_B 

inherit

	INSTR_B
		redefine
			need_enlarging, enlarged, make_byte_code,
			has_loop, assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features
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

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (from_part /= Void and then from_part.calls_special_features (array_desc))
				or else loop_calls_special_features (array_desc)
		end;

	loop_calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (compound /= Void and then compound.calls_special_features (array_desc))
				or else (invariant_part /= Void and then invariant_part.calls_special_features (array_desc))
				or else (variant_part /= Void and then variant_part.calls_special_features (array_desc))
				or else stop.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := (from_part /= Void and then from_part.is_unsafe)
				or else loop_is_unsafe
		end;

	loop_is_unsafe: BOOLEAN is
		do
			Result := (compound /= Void and then compound.is_unsafe)
				or else (invariant_part /= Void and then invariant_part.is_unsafe)
				or else (variant_part /= Void and then variant_part.is_unsafe)
				or else stop.is_unsafe
		end

	new_optimization_context: OPTIMIZATION_CONTEXT is
		local
			old_context: OPTIMIZATION_CONTEXT;
			array_desc: TWO_WAY_SORTED_SET [INTEGER]
			old_safe_array_desc: TWO_WAY_SORTED_SET [INTEGER]
			safe_array_desc: TWO_WAY_SORTED_SET [INTEGER]
			id: INTEGER;
		do
			old_context := optimizer.optimization_context;
			array_desc := old_context.array_desc;
			old_safe_array_desc := old_context.safe_array_desc;
			safe_array_desc := deep_clone (old_safe_array_desc);

			from
				array_desc.start
			until
				array_desc.after
			loop
				id := array_desc.item
				if not (safe_array_desc.has (id)) then
					check
						id <= 0
					end;
						-- It is safe to optimize if
						--	- no assignment is done
						--	- some special features are called
					if not (compound /= Void and then compound.assigns_to (id)) and then
						loop_calls_special_features (id)
					then
							-- This local/Result is not assigned to
						safe_array_desc.extend (id)
					end;
				end
				array_desc.forth
			end

			!!Result.make (array_desc, safe_array_desc);
			Result.set_generated_array_desc (deep_clone (old_context.generated_array_desc));
		end

	optimized_byte_node: like Current is
		local
			opt_loop: OPT_LOOP_B
			opt_context: OPTIMIZATION_CONTEXT;
			safe_array_desc, generated_array_desc: TWO_WAY_SORTED_SET [INTEGER];
			id: INTEGER
		do
			opt_context := new_optimization_context;
			optimizer.push_optimization_context (opt_context);

			if  not loop_is_unsafe then
					-- It is safe to optimize array accesses

					-- Create an optimized loop byte_code
				!!opt_loop;

					-- The from part must be optimized with the `old' context, i.e.
					-- the new generated arrays cannot be used
				if from_part /= Void then
					opt_loop.set_from_part (from_part.optimized_byte_node)
				end;

					-- Check to see if the new safe array types can
					-- be generated at this level (they must be generated at
					-- the highest pssible level but onl if they are used!!)
				from
					generated_array_desc := opt_context.generated_array_desc;
					safe_array_desc := opt_context.safe_array_desc
					safe_array_desc.start
				until
					safe_array_desc.after
				loop
					id := safe_array_desc.item;
					if not generated_array_desc.has (id) then
						generated_array_desc.extend (id);
						opt_loop.add_array_to_generate (id);
					end
					safe_array_desc.forth
				end

					-- The new generated arrays can be used now

				if compound /= Void then
					opt_loop.set_compound (compound.optimized_byte_node)
				end;
				if invariant_part /= Void then
					opt_loop.set_invariant_part (invariant_part.optimized_byte_node)
				end;
				opt_loop.set_stop (stop.optimized_byte_node)
				if variant_part /= Void then
					opt_loop.set_variant_part (variant_part.optimized_byte_node)
				end;
				Result := opt_loop
			else
					-- The loop cannot be optimized but the `safe arrays' can be propagated
					-- deeper in the code: once they are marked as safe, no processing is
					-- needed deeper in the code
				Result := Current;

					-- Only the from_part and the compound can be optimized
					-- (the other parts don't contain any loop anyway)
				if from_part /= Void then
					from_part := from_part.optimized_byte_node
				end;
				if compound /= Void then
					compound := compound.optimized_byte_node
				end
			end;

			optimizer.pop_optimization_context
		end;

feature {NONE} -- Array optimization

	optimizer: ARRAY_OPTIMIZER is
		do
			Result := System.remover.array_optimizer
		end

end
