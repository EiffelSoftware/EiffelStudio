-- Enlarged Creation

class CREATION_BL 

inherit

	CREATION_B
		redefine
			analyze, generate,
			last_all_in_result, find_assign_result,
			mark_last_instruction
		end;
	VOID_REGISTER
		redefine
			register, print_register,
			get_register
		end;
	
feature

	last_in_result: BOOLEAN;
			-- Is this the last creation in Result ?

	last_instruction: BOOLEAN;
			-- Is this instruction the last instruction ?

	last_all_in_result: BOOLEAN is
			-- Are all the function exit points an assignment to Result ?
		do
			Result := last_in_result;
		end;

	find_assign_result is
			-- Check whether this is an assignment to Result
		do
			last_in_result := target.is_result and
				not context.byte_code.is_once and
				not context.has_postcondition and
				not context.has_invariant;
		ensure then
			last_in_result = (target.is_result and
				not context.byte_code.is_once and
				not context.has_postcondition and
				not context.has_invariant);
		end;

	mark_last_instruction is
			-- Signals this assignment is an exit point for the routine
		do
			last_instruction := not context.has_postcondition and
				not context.has_invariant;
		end;

	register: REGISTRABLE;
			-- Where result is stored

	print_register is
			-- Print register
		do
			register.print_register;
		end;

	ref_type: REFERENCE_I is
			-- Dummy type for register creation
		once
			!!Result;
		end;

	get_register is
			-- Get a register
		local
			tmp_register: REGISTER;
		do
			!!tmp_register.make (ref_type);
			register := tmp_register;
		end;
		
	analyze is
			-- Analyze creation node
		local
			access_reg: ACCESS_REG_B;
		do
			target.set_register (No_register);
			target.analyze;
			target.free_register;
			info.analyze;
				-- A Result.Create often implies Result is used
			if target.is_result and not last_in_result then
				context.mark_result_used;
			end;
			if not target.is_predefined or
				(call /= Void and then call.message.used (target))
			then
				get_register;
			else
				register := target;
			end;
			if call /= Void then
				!!access_reg;
				access_reg.set_register (register);
				access_reg.set_type (target.type);
				call.set_target (access_reg);
				call.set_need_invariant (False);
				call.analyze;
				call.free_register;
			else
				free_register;
			end;
			if target.is_result and (not last_in_result or call /= Void) then
				context.mark_result_used;
			end;
		end;

	generate is
			-- Genrate the creation
		local
			target_type: TYPE_I;
			is_expanded: BOOLEAN;
			gen_type   : GEN_TYPE_I
		do
			generate_line_info;

			target_type := Context.real_type (target.type);
			gen_type    ?= target_type

			info.generate_start (Current);
			info.generate_gen_type_conversion (Current);

			if target.is_result and last_in_result then
					-- This is the generation of a last !!Result with a
					-- possible creation routine attached to it.
					-- NB: there is no need to call `generate_assignment' as
					-- the assignment is implicitely done by the "return".
				if target_type.is_separate then
					generate_creation_for_separate_object(target_type);
				end;
				if call /= Void then
					if target_type.is_separate then
						generated_file.putstring ("while (CURRSO(");
						print_register;
						generated_file.putstring (")) {};");
						generated_file.new_line;
						call.generate;
						generated_file.putstring ("CURFSO(");
						print_register;
						generated_file.putstring (");");
						generated_file.new_line;
					elseif target_type.is_basic then
						generate_register_assignment;
						target_type.c_type.generate_cast (generated_file);
						generated_file.putstring ("0;");
						generated_file.new_line;
					elseif target_type.is_expanded then
						generated_file.putstring ("RTXA(");
						generated_file.putstring ("RTLN(");
						info.generate;
						generated_file.putstring ("), ");
						print_register;
						generated_file.putstring (gc_rparan_comma);
						generated_file.new_line;
						call.generate_creation_call;
					else
						generate_register_assignment;
						generate_creation;
						call.generate;
					end;
				end;
				context.byte_code.finish_compound;
				check
					compound_not_void: context.byte_code.compound /= Void
				end;
					-- Always separate a last return from body, if there is
					-- more than one instruction anyway and there is no creation
					-- routine called
				if last_instruction and
					(context.byte_code.compound.first /= Current
					or call /= Void)
				then
					generated_file.new_line;
				end;
				generated_file.putstring ("return ");
				if call /= Void then
					print_register;
					generated_file.putchar (';');
					generated_file.new_line;
				else
					generate_creation;
				end;
			else
				if target_type.is_separate then
					generate_creation_for_separate_object(target_type);
					if call /= Void then
						generated_file.putstring ("while (CURRSO(");
						print_register;
						generated_file.putstring (")) {};");
						generated_file.new_line;
						call.generate_creation_call;
						generated_file.putstring ("CURFSO(");
						print_register;
						generated_file.putstring (");");
						generated_file.new_line;
					end;
						-- We had to get a register because RTAR evaluates its
						-- arguments more than once.
					if not target.is_predefined then
							-- Target is an attribute then
						generated_file.putstring ("RTAR(");
						print_register;
						generated_file.putstring (gc_comma);
						context.Current_register.print_register_by_name;
						generated_file.putchar (')');
						generated_file.putchar (';');
						generated_file.new_line;
					end;
					generate_assignment (is_expanded);
				elseif not target_type.is_basic then
					is_expanded := target_type.is_expanded;
					if not is_expanded then
						generate_register_assignment;
						generate_creation;
					elseif target.is_predefined then
						-- For expanded copy value.
						generated_file.putstring ("RTXA(");
						generated_file.putstring ("RTLN(");
						info.generate;
						generated_file.putstring ("), ");
						print_register;
						generated_file.putstring (gc_rparan_comma);
						generated_file.new_line;
					else
						-- We had to get a regiser because RTAR evaluates its
						-- arguments more than once.
						-- We create the expanded and assign it to the
						-- register.
						print_register;
						generated_file.putstring (" = RTLN(");
						info.generate;
						generated_file.putstring (gc_rparan_comma);
						generated_file.new_line;
					end;
					if call /= Void then
						call.generate_creation_call;
					end;
						-- We had to get a regiser because RTAR evaluates its
						-- arguments more than once.
					if not target.is_predefined then
							-- Target is an attribute then
						generated_file.putstring ("RTAR(");
						print_register;
						generated_file.putstring (gc_comma);
						context.Current_register.print_register_by_name;
						generated_file.putchar (')');
						generated_file.putchar (';');
						generated_file.new_line;
					end;
					generate_assignment (is_expanded);
					generate_creation_invariant;	
				else
					generate_register_assignment;
					target_type.c_type.generate_cast (generated_file);
					generated_file.putstring ("0;");
					generated_file.new_line;
				end;
			end
			info.generate_end (Current)
		end;

	generate_creation_invariant is
		do
			if context.workbench_mode or else
				context.assertion_level.check_invariant
			then
				generated_file.putstring ("RTCI(");
				print_register;
				generated_file.putstring (gc_rparan_comma);
				generated_file.new_line;
			end
		end;

	generate_register_assignment is
			-- Generate the register assignment left side
		do
			print_register;
			generated_file.putstring (" = ");
		end;

	generate_creation is
			-- Generate the creation in register
		do
			generated_file.putstring ("RTLN(");
			info.generate;
			generated_file.putstring (gc_rparan_comma);
			generated_file.new_line;
		end;

	generate_assignment (is_expanded: BOOLEAN) is
			-- Generate the assignment in the target, in case we had to get
			-- a temporary register.
		do
			if register /= target then
				if not is_expanded then
					target.print_register;
					generated_file.putstring (" = ");
					print_register;
				else
					generated_file.putstring ("RTXA(");
					print_register;
					generated_file.putstring (gc_comma);
					target.print_register;
					generated_file.putchar (')');
				end;
				generated_file.putchar (';');
				generated_file.new_line;
			end;
		end;

feature -- Concurrent Eiffel

	generate_creation_for_separate_object(target_type: TYPE_I) is
		-- generate codes for creating separate object
		local 
			cl_type: CL_TYPE_I;
			feat: FEATURE_B
		do
			generated_file.putstring ("CURCCI(%"");
			cl_type ?= target_type -- can't be failed 
			check
				is_cl_type_i: cl_type /= Void
			end;
			generated_file.putstring (cl_type.associated_class_type.associated_class.name_in_upper);
			generated_file.putstring ("%", %"");
			if call /= Void then
				feat ?= call.message;
				generated_file.putstring (feat.feature_name);
			else 
				generated_file.putstring ("_no_cf");
			end;
			generated_file.putstring ("%");");
			generated_file.new_line;
			generated_file.putstring ("CURCC(");
			print_register;
			generated_file.putstring (");");
			generated_file.new_line
	end

end
