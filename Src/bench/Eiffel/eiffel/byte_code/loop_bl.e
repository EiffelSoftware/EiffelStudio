-- Enlarged byte code for Eiffel loop

class LOOP_BL 

inherit

	LOOP_B
		redefine
			analyze, generate
		end;

	VOID_REGISTER
		export
			{NONE} all
		end;

	ASSERT_TYPE
		
		export
			{NONE} all
		end;

feature

	analyze is
			-- Builds a proper context (for C code).
		local
			workbench_mode: BOOLEAN;
			check_loop: BOOLEAN;
		do
			if from_part /= Void then
				from_part.analyze;
			end;
			context.init_propagation;
			stop.propagate (No_register);
			stop.analyze;
			workbench_mode := context.workbench_mode;
			check_loop := workbench_mode or else
				context.assertion_level.check_loop;

			if check_loop then
				if invariant_part /= Void then
					if workbench_mode then
						context.add_dt_current;
					end;
					invariant_part.analyze;
				end;
				if variant_part /= Void then
					if workbench_mode then
						context.add_dt_current;
					end;
					variant_part.analyze;
				end;
			end;

			if compound /= Void then
				compound.analyze;
			end;

			if check_loop and then variant_part /= Void then
				variant_part.free_register;
			end;
		end;

	generate is
			-- Generate C code in `generated_file'.
		do
			generate_line_info
			generate_assertions
			generate_loop_body
		end;

	generate_assertions is
		local
			generate_variant, workbench_mode: BOOLEAN;
		do
			workbench_mode := context.workbench_mode;
			if 	workbench_mode
				or else
				context.assertion_level.check_loop
			then
				generate_variant := variant_part /= Void;
			end;
				-- Outstand loop structure
			generated_file.new_line;
			if from_part /= Void then
				from_part.generate;
			end;
			if generate_variant then
				if workbench_mode then
					generate_workbench_test;
					variant_part.generate;
					generate_end_workbench_test;
				else
					generate_final_mode_test;
					variant_part.generate;
					generate_end_final_mode_test
				end;
			end;
		end;

	generate_loop_body is
		local
			generate_invariant, generate_variant, workbench_mode: BOOLEAN;
		do
			workbench_mode := context.workbench_mode;
			if 	workbench_mode
				or else
				context.assertion_level.check_loop
			then
				generate_invariant := invariant_part /= Void;
				generate_variant := variant_part /= Void;
			end;
			stop.generate;
				-- The code for the evaluation of the expression is
				-- generated twice, once before the while and once at
				-- the end of the while body.
				-- FIXME: maybe if the expression is too complex, we should
				-- use the old mechanism (pre 3.2.5) with label and goto
			generated_file.putstring ("while (!(");
			stop.print_register;
			generated_file.putstring (")) {");
			generated_file.new_line;
			generated_file.indent;
			if generate_invariant then
				context.set_assertion_type (In_loop_invariant);
				if workbench_mode then
					generate_workbench_test;
					invariant_part.generate;
					generate_end_workbench_test;
				else
					generate_final_mode_test;
					invariant_part.generate;
					generate_end_final_mode_test;
				end;
			end;
			if generate_variant then
				if workbench_mode then
					generate_workbench_test;
					variant_part.print_register;
					generate_end_workbench_test;
				else
					generate_final_mode_test;
					variant_part.print_register;
					generate_end_final_mode_test;
				end;
			end;
			if compound /= Void then
				compound.generate;
			end;
			stop.generate;
			generated_file.putchar (';');
			generated_file.new_line;
			generated_file.exdent;
			generated_file.putchar ('}');
			generated_file.new_line;
				-- Outstand loop structure
			generated_file.new_line;
		end;

	generate_workbench_test is
			-- Generate dynamic test in workbench mode
		require
			workbench_mode: context.workbench_mode;
			dt_current: context.dt_current > 1;
		do
			generated_file.putstring ("if (RTAL & CK_LOOP) {");
			generated_file.new_line;
			generated_file.indent;
		end;

	generate_end_workbench_test is
			-- Generate end of dynamic test in workbench mode
		require
			context.workbench_mode
		do
			generated_file.exdent;
			generated_file.putchar ('}');
			generated_file.new_line;
		end;

	generate_final_mode_test is
		do
			generated_file.putstring ("if (~in_assertion) {");
			generated_file.new_line;
			generated_file.indent;
		end;

	generate_end_final_mode_test is
		do
			generated_file.exdent;
			generated_file.putchar ('}');
			generated_file.new_line;
		end;

	fill_from (l: LOOP_B) is
			-- Fill in current node
		do
			from_part := l.from_part;
			if from_part /= Void then
				from_part.enlarge_tree;
			end;
			invariant_part := l.invariant_part;
			if invariant_part /= Void then
				invariant_part.enlarge_tree;
			end;
			variant_part := l.variant_part;
			if variant_part /= Void then
				variant_part := variant_part.enlarged;
			end;
			stop := l.stop.enlarged;
			compound := l.compound;
			if compound /= Void then
				compound.enlarge_tree;
			end;
		end;

end
