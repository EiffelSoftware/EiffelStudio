-- Standard byte code

class STD_BYTE_CODE 

inherit
	BYTE_CODE
		redefine
			compound, analyze, generate, finish_compound,
			has_loop, assigns_to, optimized_byte_node,
			calls_special_features, size,
			inlined_byte_code, pre_inlined_code
		end

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end

feature 

	compound: BYTE_LIST [BYTE_NODE]
			-- Compound byte code

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c
		end

	analyze is
			-- Builds a proper context (for C code).
		local
			workbench_mode: BOOLEAN
			type_i: TYPE_I
			feat: FEATURE_I
			have_assert: BOOLEAN
			inh_assert: INHERITED_ASSERTION
			old_exp: UN_OLD_BL
			a_class: CLASS_C
		do
			workbench_mode := context.workbench_mode
			a_class := Context.associated_class
			feat := a_class.feature_table.item (feature_name)
			inh_assert := Context.inherited_assertion
			inh_assert.init
			Context.set_origin_has_precondition (True)
			if not a_class.is_basic and then feat.assert_id_set /= Void then
					--! Do not get inherited pre & post for basic types
				formulate_inherited_assertions (feat.assert_id_set)
			end
			context.set_assertion_type (0)

				-- Enlarge the tree to get some attribute where we
				-- can store information gathered by analyze.
			enlarge_tree

				-- Analyze arguments
			analyze_arguments

				-- Analyze preconditions
			if Context.origin_has_precondition then
				have_assert := (precondition /= Void or else inh_assert.has_precondition) and then
						(workbench_mode or else context.assertion_level.check_precond)
			end
			if have_assert then
				if workbench_mode then
					context.add_dt_current
				end
				if precondition /= Void then
					precondition.analyze
				end
				if inh_assert.has_precondition then
					inh_assert.analyze_precondition
				end	
			end
			have_assert := (postcondition /= Void or else inh_assert.has_postcondition) and then
					(workbench_mode or else context.assertion_level.check_postcond)

				-- Analyze postconditions
			if have_assert then
				if workbench_mode then
					context.add_dt_current
				end
				if old_expressions /= Void then
					from
						old_expressions.start
					until
						old_expressions.after
					loop
						--| Need to do a special analyze for the old
						--| expressions so that the registers being used
						--| to store the old values will not be reused.
						old_exp ?= old_expressions.item; -- Cannot fail
						old_exp.special_analyze
						old_expressions.forth
					end
				end
				if inh_assert.has_postcondition then
					inh_assert.analyze_old_expressions
				end	
			end

				-- If result is expanded or a bit, we need to create it anyway
			if not result_type.is_void then
				type_i := context.real_type (result_type)
				if type_i.is_expanded or else type_i.is_bit then
					context.mark_result_used
				end
			end

			if compound /= Void then
					-- Look for all instances of assignments in Result
					-- in last instructions and set `last_in_result' if
					-- all were such assignments.
				if not result_type.is_void and not is_once then
					compound.finish
					compound.item.find_assign_result
					compound.item.mark_last_instruction
				end
				compound.analyze
			end
				-- Analyze postconditions
			if have_assert then
				if workbench_mode then
					context.add_dt_current
				end
				if postcondition /= Void then
					postcondition.analyze
				end
				if inh_assert.has_postcondition then
					inh_assert.analyze_postcondition
				end	
			end
			if rescue_clause /= Void then
				rescue_clause.analyze
			end
			if exception_stack_managed then
					-- For RTEA call
				context.mark_current_used
			end
			if trace_enabled then
					-- For RTTR and RTXT
				context.add_to_dt_current (2)
			end
			if profile_enabled then
					-- For RTPR and RTXP
				context.add_to_dt_current (2)
			end
		end

	analyze_arguments is
			-- Analyze arguments (check for expanded)
		local
			args: like arguments
			i, nb: INTEGER
			arg: TYPE_I
		do
			args := arguments
			if args /= Void then
				from
					i := args.lower
					nb := args.count
				until
					i > nb
				loop
					arg := real_type (args @ 1)
					if arg.is_expanded then
						context.force_gc_hooks
						i := nb + 1
					else
						i := i + 1
					end
				end
			end
		end
			
	add_in_log (encoded_name: STRING) is
		do
			System.used_features_log_file.add (Context.class_type, feature_name, encoded_name)
		end

	generate is
			-- Generate C code.
		local
			assignment: ASSIGN_B
			type_i: TYPE_I
			internal_name: STRING
			f: INDENT_FILE
		do
				-- Generate the header "int foo(Current, args)"
			type_i := real_type (result_type)

				-- Function's name
			internal_name := body_id.feature_name
				(System.class_type_of_id (context.current_type.type_id).id)

				-- Add entry in the log file
			add_in_log (internal_name)

				-- Generate function signature
			f := generated_file
			f.generate_function_signature
				(type_i.c_type.c_string, internal_name, True,
				 Context.extern_declaration_file, argument_names, argument_types)

				-- Starting body of C routine
			f.indent

			process_expanded

				-- Declaration of all the local entities, such as
				-- Eiffel local variables, Result, temporary registers...
			generate_execution_declarations
			generate_locals
			if system.has_separate then
				search_for_separate_call_in_precondition
				if has_separate_call_in_precondition then
					f.putstring ("CURDSFC;")
					f.new_line
				end
			end

				-- If necessary, generate the once stuff (i.e. checks if
				-- the value of the once was already set within the same
				-- thread).  That way we do not enter the body of the
				-- once if it has already been done. Preconditions,
				-- if any, are only tested on the very first call.
			generate_once

				-- Before entering in the code generate GC hooks, i.e. pass
				-- the addresses of all the reference variables.
			context.generate_gc_hooks (False)

				-- Clone expanded parameters, raise exception in caller if
				-- needed (void assigned to expanded).
			generate_expanded_cloning

				-- Generate execution trace information
			generate_execution_trace

				-- Generate trace macro (start)
			generate_trace_start

				-- Generate profile macro (start)
			generate_profile_start

				-- Generate the saving of the workbench mode assertion level
			if context.workbench_mode then
				generate_save_assertion_level
			end
			if system.has_separate then
					-- Reserve separate parameters
				reserve_separate_parameters
			end
				-- Precondition check generation
			generate_precondition
			if Context.has_chained_prec then
					-- For chained precondition (to implement or else...)
				Context.generate_body_label
			end
				-- Generate old variables
			generate_old_variables
			if rescue_clause /= Void then
					-- Generate a `setjmp' C instruction in case of a
					-- rescue clause
				if trace_enabled then
					f.putstring ("RTTI;")
					f.new_line
				end
				if profile_enabled then
					f.putstring ("RTPI;")
					f.new_line
				end
				f.putstring ("RTEJ;")
				f.new_line
			end

				-- Generate local expanded variable creations
			generate_expanded_variables

				-- Now we want the body
			generate_compound

				-- Now the postcondition
			generate_postcondition

			if system.has_separate then
	               	-- Free separate parameters
				free_separate_parameters
			end

			if not result_type.is_void then
					-- Function returns something. So generate the return
					-- expression, if necessary. Otherwise, have some mercy
					-- for lint and highlight the NOTREACHED status...
				generate_return
			else
					-- No return, this is a procedure. However, remove the
					-- GC hooks we've been generated.
				finish_compound
				if rescue_clause /= Void then
					f.putstring ("return;")
					f.new_line
				end
			end

				-- If there is a rescue clause, generate it now...
			generate_rescue

				-- End of C function
			if is_once and then context.result_used then
				f.putstring ("%N#undef Result%N")
			end

			f.exdent

				-- Leave a blank line after function definition
			f.putstring ("}%N%N")
			Context.inherited_assertion.wipe_out
		end

	generate_compound is
			-- Generate the function compound
		do
			if compound /= Void then
				compound.generate
			end
		end

	generate_return is
			-- Generate return Result or hard-coded null
		local
			assignment: ASSIGN_B
			a_creation: CREATION_B
			f: INDENT_FILE
		do
			if compound /= Void then
				compound.finish
					-- If ALL the last statements were assignments in result,
					-- generate a NOTREACHED for lint when last statement was
					-- not of type assignment. Otherwise, the return
					-- statements have already been generated.
				if compound.item.last_all_in_result then
					assignment ?= compound.item
					a_creation ?= compound.item
					if
						assignment = Void and a_creation = Void and
						not context.has_rescue
					then
						f := generated_file
						f.putstring ("/* NOTREACHED */")
						f.new_line
					end
				else
					generate_return_exp
				end
			else
				generate_return_exp
			end
		end

	generate_return_exp is
			-- Generate the return expression
		local
			type_i: TYPE_I
			f: INDENT_FILE
		do
				-- Do not forget to remove the GC hooks before returning
				-- if they have already been generated. For instance, when
				-- generating return for a once function, hooks have not
				-- been generated.
			type_i := real_type (result_type)
			finish_compound
			if not result_type.is_void then
				f := generated_file
				f.putstring ("return ")
					-- If Result was used, generate it. Otherwise, its value
					-- is simply the initial one (i.e. generic 0).
				if context.result_used then
					if real_type (result_type).c_type.is_pointer then
						context.Result_register.print_register_by_name
					else
						f.putstring ("Result")
					end
					f.putchar (';')
				else
					type_i.c_type.generate_cast (f)
					f.putstring ("0;")
				end
				f.new_line
			end
		end; -- generate_return_exp

	generate_once is
			-- Generate test at the head of once routines
		do
			-- Do nothing
		end; -- generate_once

	generate_expanded_variables is
			-- Create local expanded variables and Result
		local
			i, count, exp_type_id: INTEGER
			type_i: TYPE_I
			cl_type_i: CL_TYPE_I
			bit_i: BIT_I
			creation_feature: FEATURE_I
			class_type: CLASS_TYPE
			written_class: CLASS_C
			written_type: CLASS_TYPE
			c_name: STRING
			f: INDENT_FILE
		do
			f := generated_file
			if locals /= Void then
				count := locals.count
				from
					i := locals.lower
				until
					i > count
				loop
					type_i := real_type (locals.item (i))
							-- Generate only if variable used
					if context.local_vars.item(i) then
						if type_i.is_expanded then
							cl_type_i ?= type_i
							context.local_var.set_position (i)
							context.local_var.print_register_by_name
							exp_type_id := cl_type_i.expanded_type_id - 1
							if context.workbench_mode then
									-- RTLX is a macro used to create
									-- expanded types
								f.putstring (" = RTLX(RTUD(")
								f.putstring (cl_type_i.associated_expanded_class_type.id.generated_id)
								f.putchar (')')
							else
								f.putstring (" = RTLN(")
								f.putint (exp_type_id)
								class_type := cl_type_i.associated_class_type
								creation_feature := class_type.associated_class.creation_feature
								if creation_feature /= Void then
									written_class := System.class_of_id (creation_feature.written_in)
									if written_class.generics = Void then
										written_type := written_class.types.first
									else
										written_type := written_class.meta_type (class_type.type).associated_class_type
									end
									c_name := creation_feature.body_id.feature_name (written_type.id)
									f.putstring (");%N%T")
									f.putstring (clone (c_name))
									f.putchar ('(')
									context.local_var.print_register_by_name
								end
							end
							f.putstring (gc_rparan_comma)
							f.new_line
						elseif type_i.is_bit then
							bit_i ?= type_i; -- Cannot fail
							context.local_var.set_position (i)
							context.local_var.print_register_by_name
							f.putstring (" = RTLB(")
							f.putint (bit_i.size)
							f.putstring (gc_rparan_comma)
							f.new_line
						end
					end
					i := i + 1
				end
			end
			type_i := real_type (result_type)
			if context.result_used then
				if type_i.is_expanded then
					cl_type_i ?= type_i
					exp_type_id := cl_type_i.expanded_type_id - 1
					context.result_var.print_register_by_name
					if context.workbench_mode then
							-- RTLX is a macro used to create
							-- expanded types
						f.putstring (" = RTLX(RTUD(")
						f.putstring (cl_type_i.associated_expanded_class_type.id.generated_id)
						f.putchar (')')
					else
						f.putstring (" = RTLN(")
						f.putint (exp_type_id)
						class_type := cl_type_i.associated_class_type
						creation_feature := class_type.associated_class.creation_feature
						if creation_feature /= Void then
							written_class := System.class_of_id (creation_feature.written_in)
							if written_class.generics = Void then
								written_type := written_class.types.first
							else
								written_type := written_class.meta_type (class_type.type).associated_class_type
							end
							c_name := creation_feature.body_id.feature_name (written_type.id)
							f.putstring (");%N%T")
							f.putstring (clone (c_name))
							f.putchar ('(')
							context.local_var.print_register_by_name
						end
					end
					f.putstring (gc_rparan_comma)
					f.new_line
				elseif type_i.is_bit then
					bit_i ?= type_i; -- Cannot fail
					context.result_var.print_register_by_name
					f.putstring (" = RTLB(")
					f.putint (bit_i.size)
					f.putstring (gc_rparan_comma)
					f.new_line
				end
			end
		end

	generate_expanded_cloning is
			-- Clone expanded parameters
		local
			arg: TYPE_I
			i, count, nb_exp: INTEGER
			f: INDENT_FILE
		do
			if arguments /= Void then
				from
					i := arguments.lower
					count := arguments.count
					f := generated_file
				until
					i > count
				loop
					arg := real_type (arguments.item (i))
					if arg.is_expanded then
						context.arg_var.set_position (i)
						f.putstring ("if ((char *) 0 == ")
						context.arg_var.print_register_by_name
						f.putchar (')')
						f.new_line
						f.indent
						f.putstring ("RTET(%"")
						f.putstring (feature_name)
						f.putstring ("%", EN_VEXP);")
						f.new_line
						f.exdent
							-- Expanded cloning protocol
						if context.exp_args > 1 then
							f.putstring ("if (idx[")
							f.putint (nb_exp)
							f.putstring ("] == -1L)")
							f.new_line
							f.indent
							generate_arg_var_cloning (-1)
							f.exdent
							f.putstring ("else")
							f.new_line
							f.indent
							generate_arg_var_cloning (nb_exp)
							f.exdent
							nb_exp := nb_exp + 1
						else
							generate_arg_var_cloning (-1)
						end
					end
					i := i + 1
				end
			end
		end

	generate_arg_var_cloning (idx: INTEGER) is
			-- Generate cloning operation on Arg_var parameter from context
		local
			f: INDENT_FILE
		do
			context.arg_var.print_register_by_name
			f := generated_file
			f.putstring (" = RTCL(")
			context.arg_var.print_register_by_name
				-- If `idx' is not -1, then the reference was the one for the
				-- enclosing object and it needs adjusting by the expanded
				-- object's offset whithin that bigger object.
			if idx /= -1 then
				f.putstring (" + idx[")
				f.putint (idx)
				f.putchar (']')
			end
			f.putstring (");")
			f.new_line
		end

	generate_locals is
			-- Declare C local variables
		local
			i, count: INTEGER
			type_i: TYPE_I
			f: INDENT_FILE
		do
				-- Eiffel local variables.
			f := generated_file
			if locals /= Void then
				from
					count := locals.count
					i := locals.lower
				until
					i > count
				loop
					type_i := real_type (locals.item (i))
							-- Generate only if variable used
					if context.local_vars.item(i) then
							-- Local reference variable are declared via
							-- the local variable array "l[]".
						if not context.need_gc_hooks or else
							not type_i.c_type.is_pointer then
							type_i.c_type.generate (f)
							f.putstring ("loc")
							f.putint (i)
							f.putstring (" = ")
							type_i.c_type.generate_cast (f)
							f.putstring ("0;")
							f.new_line
						end
					end
					i := i + 1
				end
			end

				-- Generate index table if we have more than one expanded
				-- argument (cloning protocol).
			if context.exp_args > 1 then
				f.putstring ("long idx[")
				f.putint (context.exp_args)
				f.putstring ("];")
				f.new_line
			end

				-- Generate temporary locals under the control of the GC
			context.generate_temporary_ref_variables

				-- Result is declared only if needed. For onces, it is
				-- accessed via a key allowing us to have them per thread.
			if (not result_type.is_void) and then context.result_used then
				generate_result_declaration
			end
				-- Declare the 'dtype' variable which holds the pre-computed
				-- dynamic type of current. To avoid unnecssary computations,
				-- this is not done in case of a once, before we know we have
				-- to really enter the body of the routine.
			if context.dt_current > 1 then
					-- There has to be more than one usage of the dynamic type
					-- of current in order to have this variable generated.
				if is_once then
					f.putstring ("int dtype;")
				else
					f.putstring ("int dtype = Dtype(Current);")
				end
				f.new_line
			end
				-- Generate the int local variable saving the global `nstcall'.
			if context.workbench_mode
				or else
				context.assertion_level.check_invariant
			then
				f.putstring ("RTSN;")
				f.new_line
			end
			if context.workbench_mode then
					-- Generate local variable for saving the workbench
					-- mode assertion level of the current object.
				f.putstring ("RTDA;")
				f.new_line
				if rescue_clause /= void then
					f.putstring ("RTDT;")
					f.new_line
				end
			end
				-- The local variable array is then declared, based on the
				-- number of reference variable which need to be placed under
				-- GC control (given by `ref_var_used').
			i := context.ref_var_used
			if i > 0 then
				if rescue_clause /= Void then
					f.putstring ("RTXD;")
					f.new_line
				else
					f.putstring ("RTLD;")
					f.new_line
				end
			end

				-- Onces are processed via keys. We store a pointer to
				-- Result (or something !=0 if void) to indicate whether
				-- the once was processed or not. If processed, we'll get
				-- the pointer to Result != 0.
				-- Note that even if Result is not used in once functions,
				-- we have to go through the key: we cannot simply return 0
				-- in case some treatment with side effect were done.
			if is_once then
				real_type (result_type).c_type.generate (f)
				f.putstring ("*PResult = (")
				real_type (result_type).c_type.generate (f)
				f.putstring ("*) 0;%N")
			end

				-- Generate temporary non-reference locals declarations
			context.generate_temporary_nonref_variables

				-- Separate declarations and body with a blank line
			f.new_line
		end

	generate_result_declaration is
			-- Generate the declaration of the Result entity
		local
			ctype: TYPE_C
			f: INDENT_FILE
		do
			ctype := real_type (result_type).c_type
			if ctype.is_pointer then
					-- The generation is included in the declaration of local
					-- variable array, hehe.
			else
				f := generated_file
				ctype.generate (f)
				f.putstring ("Result = ")
				ctype.generate_cast (f)
				f.putstring ("0;")
				f.new_line
			end
		end

	init_dtype is
			-- Initializes the value of 'dtype' in once routines. For regular
			-- ones, the variable is initialized directly in the declaration.
		local
			f: INDENT_FILE
		do
			if context.dt_current > 1 then
				f := generated_file
				f.putstring ("dtype = Dtype(Current);")
				f.new_line
			end
		end

	generate_precondition is
			-- Generate precondition check if needed
		local
			workbench_mode: BOOLEAN
			feat: FEATURE_I
			have_assert: BOOLEAN
			inh_assert: INHERITED_ASSERTION
			count, i: INTEGER
			f: INDENT_FILE
		do
			context.set_assertion_type (In_precondition)
			workbench_mode := context.workbench_mode
			inh_assert := Context.inherited_assertion
			if Context.origin_has_precondition then
				have_assert := (precondition /= Void or else
								inh_assert.has_precondition) and then
					(workbench_mode or else context.assertion_level.check_precond)
			end
			if have_assert then
				f := generated_file
				if workbench_mode then
					f.putstring ("if (RTAL & CK_REQUIRE) {")
					f.new_line
					f.indent
				else
					f.putstring ("if (~in_assertion) {")
					f.new_line
					f.indent
				end
				generate_invariant_before
				if has_separate_call_in_precondition then
					f.exdent
					f.putstring ("check_sep_pre:")
					f.indent
					f.new_line
					f.putstring ("CURCSFC;")
					f.new_line
				end
				if precondition /= Void then
					context.set_is_prec_first_block (True)
					Context.inc_label
					precondition.generate
					f.putstring ("RTJB;")
					f.new_line
					f.exdent
					if has_separate_call_in_precondition then
						context.print_concurrent_label
						f.putchar (':')
						f.indent
						f.putstring (" CURSSFC;")
						f.new_line
						f.exdent
					end
					context.print_current_label
					f.putchar (':')
					f.new_line
					f.indent
				end
				
				if inh_assert.has_precondition then

					inh_assert.set_has_separate_call_in_precondition (has_separate_call_in_precondition)
					inh_assert.set_std_obj (Current)
					inh_assert.generate_precondition
				end

				if has_separate_call_in_precondition then
					f.putstring ("if (!CURSFC) {")
					f.new_line
					f.indent
					f.putstring ("RTCF;")
					f.new_line
					f.exdent
					f.putstring ("} else {")
					f.new_line
					f.indent
					f.putstring ("RTCK;")
					f.new_line
						-- free separate parameters
					free_separate_parameters
						-- Reserve separate parameters
					f.putstring ("CURCSPFW;")
					f.new_line
					reserve_separate_parameters
					f.putstring ("CURCSPF;")
					f.new_line
					f.exdent
					f.putstring ("}")
				else
					f.putstring ("RTCF;")
				end
				f.new_line
				f.exdent
				f.putchar ('}')
				f.new_line
			else
				generate_invariant_before
			end
		end

	generate_postcondition is
			-- Generate postcondition check if needed
		local
			workbench_mode: BOOLEAN
			have_assert: BOOLEAN
			inh_assert: INHERITED_ASSERTION
			f: INDENT_FILE
		do
			workbench_mode := context.workbench_mode
			inh_assert := Context.inherited_assertion
			have_assert := (postcondition /= Void or else inh_assert.has_postcondition) and then
					(workbench_mode or else context.assertion_level.check_postcond)
			if have_assert then
				f := generated_file
				context.set_assertion_type (In_postcondition)
				if workbench_mode then
					f.putstring ("if (RTAL & CK_ENSURE) {")
					f.new_line
					f.indent
				else
					f.putstring ("if (~in_assertion) {")
					f.new_line
					f.indent
				end
				if postcondition /= Void then
					postcondition.generate
				end
				if inh_assert.has_postcondition then
					inh_assert.generate_postcondition
				end
				generate_invariant_after
				if workbench_mode then
					f.exdent
					f.putchar ('}')
					f.new_line
				else
					f.exdent
					f.putchar ('}')
					f.new_line
				end
			else
				generate_invariant_after
			end
		end

	generate_save_assertion_level is
			-- Generate the instruction for saving the workbench mode
			-- assertion level of the current object.
		require
			workbench_mode: context.workbench_mode
		local
			f: INDENT_FILE
		do
			f := generated_file
			f.putstring ("RTSA(")
			context.generate_current_dtype
			f.putstring (gc_rparan_comma)
			f.new_line
		end

	generate_invariant_before is
			-- Generate invariant check at the entry of the routine.
		do
			generate_invariant ("RTIV")
		end

	generate_invariant_after is
			-- Generate invariant check at the end of the routine.
		do
			generate_invariant ("RTVI")
		end

	generate_invariant (tag: STRING) is
			-- Generate invariant check with tag `tag'.
		local
			f: INDENT_FILE
		do
			f := generated_file
			if context.workbench_mode then
				f.putstring (tag)
				f.putchar ('(')
				context.current_register.print_register_by_name
				f.putstring (", RTAL);")
				f.new_line
			elseif context.assertion_level.check_invariant then
				f.putstring (tag)
				f.putchar ('(')
				context.current_register.print_register_by_name
				f.putstring (gc_rparan_comma)
				f.new_line
			end
		end

	generate_rescue is
			-- Generate the rescue clause
		local
			nb_refs: INTEGER
			f: INDENT_FILE
		do
			if rescue_clause /= Void then
				f := generated_file
				f.new_line
				f.exdent
				f.putstring ("rescue:")
				f.new_line
				f.indent
				f.putstring ("RTEU;")
				f.new_line
					-- Resynchronize local variables stack
				nb_refs := context.ref_var_used
				if nb_refs > 0 then
					f.putstring ("RTXS(")
					f.putint (nb_refs)
					f.putstring (gc_rparan_comma)
					f.new_line
				end
				rescue_clause.generate
				generate_profile_stop
				f.putstring ("/* NOTREACHED */")
				f.new_line
				f.putstring ("RTEF;")
				f.new_line
			end
		end

	exception_stack_managed: BOOLEAN is
			-- Do we have to manage the exception stack
		do
			Result := context.workbench_mode or else
						System.exception_stack_managed
		end

	generate_execution_declarations is
			-- Generate the declarations needed for exception trace handling
		local
			f: INDENT_FILE
		do
			f := generated_file
			if exception_stack_managed or rescue_clause /= Void then
				f.putstring ("RTEX;")
				f.new_line
			end
			if rescue_clause /= Void then
				f.putstring ("RTED;")
				f.new_line
					-- We only need this for finalized mode...
				if trace_enabled then
					f.putstring ("RTLT;%N")
				end
				if profile_enabled then
					f.putstring ("RTLP;%N")
				end
			end
		end

	generate_execution_trace is
			-- Generate the execution trace stack handling
		do
			if exception_stack_managed then
				generate_stack_macro ("RTEA")
			elseif rescue_clause /= Void then
				generated_file.putstring ("RTEV;%N")
			end
		end

	generate_pop_execution_trace is
			-- Generate the execution trace stack handling at the end of the
			-- routine
		local
			f: INDENT_FILE
		do
			if exception_stack_managed or else rescue_clause /= Void then
				f := generated_file
				f.putstring ("RTEE;")
				f.new_line
			end
		end

	trace_enabled: BOOLEAN is
			-- Is the trace enabled for the associated class
			-- in final mode?
		do
			Result := not context.workbench_mode and
				Context.associated_class.trace_level.is_yes
		end

	profile_enabled: BOOLEAN is
			-- Is the profile enabled for the associated class
			-- in final mode?
		do
			Result := not context.workbench_mode and
				Context.associated_class.profile_level.is_yes
		end

	generate_profile_start is
			-- Generate the "start of profile" macro
		do
			if profile_enabled then
				generate_option_macro ("RTPR")
			end
		end

	generate_profile_stop is
			-- Generate the "stop of progile" macro
		local
			f: INDENT_FILE
		do
			if profile_enabled then
				f := generated_file
				f.putstring ("RTXP;")
				f.new_line
			end
		end

	generate_trace_start is
			-- Generate the "start of trace" macro
		do
			if trace_enabled then
				generate_option_macro ("RTTR")
			end
		end

	generate_trace_stop is
			-- Generate the "end of trace" macro
		do
			if trace_enabled then
				generate_option_macro ("RTXT")
			end
		end

	generate_option_macro (macro_name: STRING) is
			-- Generate an option macro call will the feature name, the feature origin
			-- and the "dynamic type" of `Current' as arguments
		require
			dtype_added: context.dt_current > 1
		local
			f: INDENT_FILE
		do
			f := generated_file
			f.putstring (macro_name)
			f.putstring ("(%"")
			f.putstring (feature_name)
			f.putstring ("%", ")
			f.putstring (feature_origin)
			f.putstring (gc_comma)
			f.putstring (" dtype")
			f.putstring (gc_rparan_comma)
			f.new_line
		end

	generate_stack_macro (macro_name: STRING) is
			-- Generate a macro call will the feature name, the feature origin
			-- and `Current' as arguments
		local
			f: INDENT_FILE
		do
			f := generated_file
			f.putstring (macro_name)
			f.putstring ("(%"")
			f.putstring (feature_name)
			f.putstring ("%", ")
			f.putstring (feature_origin)
			f.putstring (gc_comma)
			context.Current_register.print_register_by_name
			f.putstring (gc_rparan_comma)
			f.new_line
		end

	finish_compound is
			-- Generate the end of the compound routine
		do
				-- Generate the removela of the GC hooks
			context.remove_gc_hooks
				-- Generate the update of the trace stack before quitting
				-- the routine
			generate_pop_execution_trace
				-- Generate trace macro (stop)
			generate_trace_stop

				-- Generate profile macro (stop)
			generate_profile_stop

			if rescue_clause /= Void then
				generated_file.putstring ("RTOK;%N")
			end
		end

feature -- Byte code generation

	make_body_code (ba: BYTE_ARRAY) is
			-- Generate compound byte code
		local
			have_assert, has_old: BOOLEAN
			inh_assert: INHERITED_ASSERTION
		do
			if system.has_separate and then arguments /= Void then
					-- Reserve separeate parameters
				process_sep_paras_in_byte_code (ba, True)
				search_for_separate_call_in_precondition
			end
			inh_assert := Context.inherited_assertion
			if Context.origin_has_precondition then
				have_assert := (precondition /= Void or else inh_assert.has_precondition)
			end
			if have_assert then
				context.set_assertion_type (In_precondition)
				ba.append (Bc_precond)
				ba.mark_forward
				if has_separate_call_in_precondition then
					ba.sep_mark_backward
					ba.append (Bc_sep_unset)
				end
			end
			if Context.origin_has_precondition and then (precondition /= Void) then
				context.set_is_prec_first_block (True)
				precondition.make_byte_code (ba)
				from
				until
					ba.forward_marks4.count = 0
				loop
					ba.write_forward4
				end
				ba.append (Bc_goto_body)
				ba.mark_forward
			end

			if Context.origin_has_precondition and then inh_assert.has_precondition then
				inh_assert.make_precondition_byte_code (ba)
			end

			if have_assert then
				if has_separate_call_in_precondition then
					ba.append (Bc_sep_raise_prec)
						-- Reserve separeate parameters
					process_sep_paras_in_byte_code (ba, True)
					ba.sep_write_backward
				else
					ba.append (Bc_raise_prec)
				end
				if precondition /= Void then
					ba.write_forward
				end
				if inh_assert.has_precondition then
					inh_assert.write_forward (ba)
				end
				ba.write_forward
			end

			has_old := (old_expressions /= Void) or else (inh_assert.has_old_expression)
			if has_old then
				ba.append (Bc_start_eval_old)
				ba.mark_forward
			end

			if 	postcondition /= Void and then 	
				old_expressions /= Void then
					-- Make byte code for old expression
					--! Order is important since interpretor pops expression
					--! bottom up.
				from
					old_expressions.start
				until
					old_expressions.after
				loop
					old_expressions.item.make_initial_byte_code (ba)
					old_expressions.forth
				end
			end

				-- Make byte code for inherited old expressions
			have_assert := postcondition /= Void or else inh_assert.has_postcondition
			if have_assert then
				if inh_assert.has_postcondition then
					inh_assert.make_old_exp_byte_code (ba)
				end
			end

			if has_old then
				ba.append (Bc_end_eval_old)
				ba.write_forward
			end
				-- Go to point for old expressions

			if compound /= Void then
				compound.make_byte_code (ba)
			end

			make_breakable (ba)

				-- Make byte code for postcondition
			if have_assert then
				context.set_assertion_type (In_postcondition)
				ba.append (Bc_postcond)
				ba.mark_forward
			end

			if postcondition /= Void then
				postcondition.make_byte_code (ba)
			end

			if inh_assert.has_postcondition then
				inh_assert.make_postcondition_byte_code (ba)
			end

			if have_assert then
				ba.write_forward
			end

			if system.has_separate and then arguments /= Void then
					-- Reserve separeate parameters
				process_sep_paras_in_byte_code (ba, False)
			end
		end

feature -- Array optimization

	has_loop: BOOLEAN is
		do
			Result := (compound /= Void and then compound.has_loop)
				or else (rescue_clause /= Void and then rescue_clause.has_loop)
		end

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := (compound /= Void and then compound.assigns_to (i))
				or else (rescue_clause /= Void and then rescue_clause.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (compound /= Void and then compound.calls_special_features (array_desc))
				or else (rescue_clause /= Void and then rescue_clause.calls_special_features (array_desc))
		end

	optimized_byte_node: like Current is
		local
			opt_context: OPTIMIZATION_CONTEXT
			optimizer: ARRAY_OPTIMIZER
		do
			Result := Current
			opt_context := initial_optimization_context
			if opt_context.array_desc.empty then
					-- No entity calls a special feature
			else
				optimizer := System.remover.array_optimizer
				optimizer.push_optimization_context (opt_context)
				if compound /= Void then
					compound := compound.optimized_byte_node
				end
				if rescue_clause /= Void then
					rescue_clause := rescue_clause.optimized_byte_node
				end
				optimizer.pop_optimization_context
			end
		end

	initial_optimization_context: OPTIMIZATION_CONTEXT is
			-- Record the descendants of array for
			-- arguments(>0); Result(=0); local(<0)
			-- but only if the routine calls a special routine
			-- for this entity
		local
			i, n: INTEGER
			safe_array_desc, array_desc, g: TWO_WAY_SORTED_SET [INTEGER]
		do
			!!array_desc.make
			!!safe_array_desc.make
			!!Result.make (array_desc, safe_array_desc)
			!!g.make
			Result.set_generated_array_desc (g)
			!!g.make
			Result.set_generated_offsets (g)
			if arguments /= Void then
				from
					n := arguments.count
					i := 1
				until
					i > n
				loop
					if arguments.item (i).conforms_to_array and then
						calls_special_features (i)
					then
						array_desc.extend (i)
						safe_array_desc.extend (i)
					end
					i := i + 1
				end
			end
			if locals /= Void then
				from
					n := locals.count
					i := 1
				until
					i > n
				loop
					if locals.item (i).conforms_to_array and then
						calls_special_features (-i)
					then
						array_desc.extend (-i)
					end
					i := i + 1
				end
			end
			if result_type /= Void and then
				result_type.conforms_to_array and then
				calls_special_features (0)
			then
				array_desc.extend (0)
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			if compound /= Void then
				Result := compound.size
			end
			if rescue_clause /= Void then
				Result := Result + rescue_clause.size
			end
		end

	pre_inlined_code: like Current is
		local
			old_bc: BYTE_CODE
		do
			check
				no_rescue: rescue_clause = Void
			end

			old_bc := Context.byte_code
			Context.set_byte_code (Current)
			Result := Current
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
			Context.set_byte_code (old_bc)
		end

	inlined_byte_code: STD_BYTE_CODE is
		local
			inlined_b: INLINED_BYTE_CODE
			inliner: INLINER
		do
			if compound /= Void then
				compound := compound.inlined_byte_code
			end
			if rescue_clause /= Void then
				rescue_clause := rescue_clause.inlined_byte_code
			end
			inliner := System.remover.inliner
			if inliner.current_feature_inlined then
					-- If something has been inlined, create
					-- a new byte code
				!!inlined_b
				inlined_b.fill_from (Current)
				Result := inlined_b

					-- Reset the flags in INLINER
				inliner.reset
			else
				Result := Current
			end
		end

feature -- Concurrent Eiffel

	has_separate_call_in_precondition: BOOLEAN 
			-- is there separate feature call in the prtecondition?

	search_for_separate_call_in_precondition is
		local
			tmp: BOOLEAN
			inh_pre: LINKED_LIST [BYTE_LIST [BYTE_NODE]]
			inh_assert: INHERITED_ASSERTION
		do
			if precondition /= Void then
				tmp := precondition.has_separate_call
			else
				tmp := False
			end
			inh_assert := Context.inherited_assertion
			if inh_assert.has_precondition then
				from
					inh_pre := inh_assert.precondition_list
					inh_pre.start
				until
					tmp or inh_pre.after
				loop
					tmp := inh_pre.item.has_separate_call;		
					inh_pre.forth
				end
			end
			has_separate_call_in_precondition := tmp
		end

	reserve_separate_parameters is
			-- generate codes for reserving separate parameters of a feature
			-- whose indexes are less than "idx".
		local
			i, count: INTEGER
			var_name: STRING
			reg: REGISTRABLE
			f: INDENT_FILE
		do
				-- Reserve separate parameters
			if arguments /= Void and then has_separate_call_in_the_feature then
				f := generated_file
				f.exdent
				Context.inc_reservation_label
				Context.print_reservation_label
				f.putstring (":")
				f.indent
				f.new_line
				!!var_name.make(10)
				from 
					!!var_name.make(10)
					i := arguments.lower
					count := arguments.count + i - 1
				until
					i > count
				loop
					if real_type(arguments.item(i)).is_separate 
						and then separate_call_on_argument (i) then
						var_name.wipe_out
						var_name.append("arg")
						var_name.append(i.out);							
						reg := context.associated_register_table.item(var_name)
						f.putstring ("if (CURRSO(")
						if reg /= Void then
							reg.print_register_by_name
						else
							f.putstring (var_name)
						end
						f.putstring (")) {")
						f.indent
						f.new_line
						free_partial_sep_paras (i)
						f.putstring ("CURRSFW;")
						f.new_line
						f.putstring ("goto ")
						Context.print_reservation_label
						f.putstring (";")
						f.new_line
						f.exdent
						f.putstring ("}")
						f.new_line
					end
					i := i + 1
				end
			end
		end

	free_separate_parameters is 
			-- generate codes for freeing separate parameters of a feature
		local
			i, count: INTEGER
			var_name: STRING
			reg: REGISTRABLE
			f: INDENT_FILE
		do
            	-- Free separate parameters
            if arguments /= Void then
                from 
					!!var_name.make(10)
                    i := arguments.lower
                    count := arguments.count + i - 1
					f := generated_file
                until
                    i > count
                loop
                    if
						real_type(arguments.item(i)).is_separate 
						and then separate_call_on_argument (i)
					then
                        var_name.wipe_out
                        var_name.append("arg")
                        var_name.append(i.out);                            
                        reg := context.associated_register_table.item(var_name)
	                    f.putstring ("CURFSO(")
                        if reg /= Void then
                            reg.print_register_by_name
						else
                        	f.putstring (var_name)
						end
                        f.putstring (");")
                        f.new_line
                    end
                    i := i + 1
                end
            end
		end

	free_partial_sep_paras (idx: INTEGER) is 
			-- generate codes for freeing separate parameters of a feature
			-- whose indexes are less than "idx".
		local
			i, count: INTEGER
			var_name: STRING
			reg: REGISTRABLE
			f: INDENT_FILE
		do
            	-- Free separate parameters
            if arguments /= Void then
                from 
					!!var_name.make(10)
                    i := arguments.lower
                    count := arguments.count + i - 1
					f := generated_file
                until
                    i >= idx or i > count
                loop
                    if
						real_type(arguments.item(i)).is_separate 
						and then separate_call_on_argument (i)
					then
                        var_name.wipe_out
                        var_name.append("arg")
                        var_name.append(i.out);                            
                        reg := context.associated_register_table.item(var_name)
	                    f.putstring ("CURFSO(")
                        if reg /= Void then
                            reg.print_register_by_name
						else
                        	f.putstring (var_name)
                        end
                      	f.putstring (");")
                       	f.new_line
                    end
                    i := i + 1
                end
            end
		end

	separate_call_on_argument (i: INTEGER): BOOLEAN is
            -- Is argument `i' used in a separate call?
		local
			s: like separate_calls
        do
			s := separate_calls
            if s /= Void and then i>= s.lower and i <= s.upper then
                Result := s @ i
            end
        end

	separate_calls: ARRAY [BOOLEAN]
			-- Record separate calls on arguments

	record_separate_calls_on_arguments is
			-- Record separate calls on arguments
		local
			ast_sep_call: ARRAY [BOOLEAN]
		do
			if System.has_separate then
				ast_sep_call := Ast_context.separate_calls
				if not ast_sep_call.empty then
					separate_calls := clone (ast_sep_call)
				end
			end
		end

	has_separate_call_in_the_feature: BOOLEAN is
		local
			i: INTEGER
			s: like separate_calls
		do
			s := separate_calls
			if s /= Void then
				i := s.lower
			end
			from 
			until
				Result or (s = Void or else i > s.upper)
			loop
				Result := s.item (i)
				i := i + 1
			end
		end

	process_sep_paras_in_byte_code (ba: BYTE_ARRAY; reserve: BOOLEAN) is
			-- generate codes for reserving/freeing separate parameters of a feature
		local
			i, count: INTEGER
			s: like separate_calls
		do
			s := separate_calls
			if s /= Void then
				i := s.lower
			end
			from 
			until
				s = Void or else i > s.upper
			loop
				if s.item(i) then
					count := count + 1
				end
				i := i + 1
			end
			if count > 0 then
				if reserve then
					ba.append (Bc_sep_reserve)
				else
					ba.append (Bc_sep_free)
				end
				ba.append_short_integer (count)
				from
					i := s.lower
				until
					i > s.upper
				loop
					if s.item (i) then
						ba.append_short_integer (i - 1)
					end
					i := i + 1
				end
			end
		end

end
