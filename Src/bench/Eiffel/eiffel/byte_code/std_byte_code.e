indexing
	description	: "Standard Byte code generation for features"
	date		: "$Date$"
	revision	: "$Revision$"

class STD_BYTE_CODE 

inherit
	BYTE_CODE
		redefine
			compound, analyze, generate, finish_compound,
			assigns_to, optimized_byte_node,
			calls_special_features, size,
			inlined_byte_code, pre_inlined_code
		end

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end

	SHARED_ERROR_HANDLER

	SHARED_DECLARATIONS

feature -- Access

	compound: BYTE_LIST [BYTE_NODE]
			-- Compound byte code

feature -- Status

	is_global_once: BOOLEAN is
			-- Is current once compiled in multithreaded mode with global status?
		do
			-- False
		end

feature -- Setting

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c
		end

feature -- Analyzis

	analyze is
			-- Builds a proper context (for C code).
		local
			workbench_mode: BOOLEAN
			type_i: TYPE_I
			feat: FEATURE_I
			have_precond, have_postcond: BOOLEAN
			inh_assert: INHERITED_ASSERTION
			old_exp: UN_OLD_BL
		do
			workbench_mode := context.workbench_mode
			feat := Context.current_feature
			inh_assert := Context.inherited_assertion
			inh_assert.init
			Context.set_origin_has_precondition (True)
			if not Context.associated_class.is_basic and then feat.assert_id_set /= Void then
					--! Do not get inherited pre & post for basic types
				formulate_inherited_assertions (feat.assert_id_set)
			end
			context.set_assertion_type (0)

				-- Enlarge the tree to get some attribute where we
				-- can store information gathered by analyze.
			enlarge_tree

				-- Compute presence or not of pre/postconditions
			if Context.origin_has_precondition then
				have_precond := (precondition /= Void or else inh_assert.has_precondition) and then
						(workbench_mode or else context.assertion_level.check_precond)
			end
			have_postcond := (postcondition /= Void or else inh_assert.has_postcondition) and then
					(workbench_mode or else context.assertion_level.check_postcond)

				-- Check if we need GC hooks for current body.
			Context.compute_need_gc_hooks (have_precond or else have_postcond)

				-- Analyze arguments
			analyze_arguments

				-- Analyze preconditions
			if have_precond then
				if workbench_mode then
					context.add_dt_current
				end
				if inh_assert.has_precondition then
					inh_assert.analyze_precondition
				end	
				if precondition /= Void then
					precondition.analyze
				end
			end

				-- Analyze postconditions
			if have_postcond then
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
						old_exp ?= old_expressions.item -- Cannot fail
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
				if type_i.is_true_expanded or else type_i.is_bit then
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
			if have_postcond then
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
					if arg.is_true_expanded then
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
			type_i: TYPE_I
			internal_name: STRING
			buf: GENERATION_BUFFER
			l_is_once: BOOLEAN
		do
			buf := buffer
			l_is_once := is_once

				-- Generate the header "int foo(Current, args)"
			type_i := real_type (result_type)

				-- Function's name
			internal_name := Encoder.feature_name (
				System.class_type_of_id (context.current_type.type_id).static_type_id,
				body_index)

				-- Add entry in the log file
			add_in_log (internal_name)

				-- If it is a once, performs once declaration.
			if l_is_once then
				generate_once_declaration (internal_name, type_i.c_type.c_string, type_i.c_type.is_void)
			end

			if rescue_clause /= Void then
				buf.putstring ("#undef EIF_VOLATILE")
				buf.new_line
				buf.putstring ("#define EIF_VOLATILE volatile")
				buf.new_line
			end

				-- Generate function signature
			buf.generate_function_signature
				(type_i.c_type.c_string, internal_name, True,
				 Context.header_buffer, argument_names, argument_types)

				-- If it is a global once, performs mutex lock operation
			if is_global_once then
				buf.indent
				buf.putstring ("EIF_GLOBAL_ONCE_MUTEX_LOCK;")
				buf.new_line
				buf.putchar ('{')
				buf.new_line
			end

				-- Starting body of C routine
			buf.indent

			process_expanded

				-- Declaration of all the local entities, such as
				-- Eiffel local variables, Result, temporary registers...
			generate_execution_declarations
			generate_locals
			if system.has_separate then
				search_for_separate_call_in_precondition
				if has_separate_call_in_precondition then
					buf.putstring ("CURDSFC;")
					buf.new_line
				end
			end
				-- If necessary, generate the once stuff (i.e. checks if
				-- the value of the once was already set within the same
				-- thread).  That way we do not enter the body of the
				-- once if it has already been done. Preconditions,
				-- if any, are only tested on the very first call.
			generate_once (internal_name)

				-- Before entering in the code generate GC hooks, i.e. pass
				-- the addresses of all the reference variables.
			context.generate_gc_hooks (False)

				-- Record the locals, arguments and Current address for debugging.
			generate_push_db
			
				-- Clone expanded parameters, raise exception in caller if
				-- needed (void assigned to expanded).
			generate_expanded_cloning

				-- Generate execution trace information (RTEAA)
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
					buf.putstring ("RTTI;")
					buf.new_line
				end
				if profile_enabled then
					buf.putstring ("RTPI;")
					buf.new_line
				end
				buf.putstring ("RTEJ;")
				buf.new_line
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
					buf.putstring ("return;")
					buf.new_line
				end
			end

				-- If there is a rescue clause, generate it now...
			generate_rescue

			buf.exdent

				-- End of C function
			if l_is_once then
				if is_global_once then
					buf.putchar ('}')
					buf.new_line
					buf.exdent
				else
					buf.new_line
					buf.putstring ("#undef Result")
					buf.new_line
				end
			end

				-- Leave a blank line after function definition
			buf.putstring ("}%N%N")

			if rescue_clause /= Void then
				buf.putstring ("#undef EIF_VOLATILE")
				buf.new_line
				buf.putstring ("#define EIF_VOLATILE")
				buf.new_line
			end

			Context.inherited_assertion.wipe_out

debug ("DEBUGGER_HOOK")
		-- ASSERTION TO CHECK THAT `number_of_breakpoint_slots' is correct
	if
		context.workbench_mode and then
		get_current_frozen_debugger_hook + 1 /= context.current_feature.number_of_breakpoint_slots
	then
		io.putstring ("STD_BYTE_CODE: Error in breakable line number computation for: %N")
		io.putstring ("{"+context.original_class_type.associated_class.lace_class.name+"}")
		io.putstring ("."+context.current_feature.feature_name+"%N%N")
	end
end
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
			buf: GENERATION_BUFFER
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
						buf := buffer
						buf.putstring ("/* NOTREACHED */")
						buf.new_line
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
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- Do not forget to remove the GC hooks before returning
				-- if they have already been generated. For instance, when
				-- generating return for a once function, hooks have not
				-- been generated.
			type_i := real_type (result_type)
			finish_compound

			if not result_type.is_void then
				buf.putstring ("return ")
					-- If Result was used, generate it. Otherwise, its value
					-- is simply the initial one (i.e. generic 0).
					-- Note: in workbench, we always return the result. It may
					--       have been changed by the user (see class EDIT_ITEM)
				if context.workbench_mode or else context.result_used then
					buf.putstring ("Result;")
				else
					type_i.c_type.generate_cast (buf)
					buf.putstring ("0;")
				end
				buf.new_line
			end
		end -- generate_return_exp

	generate_once (name: STRING) is
			-- Generate test at the head of once routines
		do
		end

	generate_once_declaration (name, type: STRING; is_procedure: BOOLEAN) is
			-- Generate static variable and their declarations used by
			-- generation of opimized once functions.
		do
		end

	generate_expanded_variables is
			-- Create local expanded variables and Result
		local
			i, count, exp_type_id: INTEGER
			type_i: TYPE_I
			cl_type_i: CL_TYPE_I
			bit_i: BIT_I
			gen_type: GEN_TYPE_I
			creation_feature: FEATURE_I
			class_type: CLASS_TYPE
			written_class: CLASS_C
			written_type: CLASS_TYPE
			c_name: STRING
			buf: GENERATION_BUFFER
			used_upper: INTEGER
		do
			buf := buffer
			if locals /= Void then
				count := locals.count
				from
					i := locals.lower
					used_upper := context.local_vars.upper
				until
					i > count
				loop
					type_i := real_type (locals.item (i))
							-- Generate only if variable used
					if i <= used_upper and then context.local_vars.item(i) then
						if type_i.is_true_expanded then
							cl_type_i ?= type_i

							gen_type  ?= cl_type_i

							if gen_type /= Void then
								generate_block_open
								generate_gen_type_conversion (gen_type)
							end
							context.local_var.set_position (i)
							context.local_var.print_register
							exp_type_id := cl_type_i.expanded_type_id - 1
							if context.workbench_mode then
									-- RTLX is a macro used to create
									-- expanded types
								if gen_type /= Void then
									buf.putstring (" = RTLX(typres")
								else
									buf.putstring (" = RTLX(RTUD(")
									buf.generate_type_id (cl_type_i.associated_class_type.static_type_id)
									buf.putchar (')')
								end
							else
								if gen_type /= Void then
									buf.putstring (" = RTLN(typres")
								else
									buf.putstring (" = RTLN(")
									buf.putint (exp_type_id)
								end
								class_type := cl_type_i.associated_class_type
								creation_feature := class_type.associated_class.creation_feature
								if creation_feature /= Void then
									written_class := System.class_of_id (creation_feature.written_in)
									if written_class.generics = Void then
										written_type := written_class.types.first
									else
										written_type := written_class.meta_type (class_type.type).associated_class_type
									end
									c_name := Encoder.feature_name (written_type.static_type_id, creation_feature.body_index)
									buf.putstring (");%N%T")
									buf.putstring (c_name)
									buf.putchar ('(')
									context.local_var.print_register
									Extern_declarations.add_routine_with_signature (Void_c_type,
										c_name, <<"EIF_REFERENCE">>)
								end
							end
							buf.putstring (gc_rparan_semi_c)

							if gen_type /= Void then
								generate_block_close
							end
							buf.new_line
						elseif type_i.is_bit then
							bit_i ?= type_i -- Cannot fail
							context.local_var.set_position (i)
							context.local_var.print_register
							buf.putstring (" = RTLB(")
							buf.putint (bit_i.size)
							buf.putstring (gc_rparan_semi_c)
							buf.new_line
						end
					end
					i := i + 1
				end
			end
			type_i := real_type (result_type)
			if context.result_used then
				if type_i.is_true_expanded then
					cl_type_i ?= type_i
					exp_type_id := cl_type_i.expanded_type_id - 1

					gen_type  ?= cl_type_i

					if gen_type /= Void then
						generate_block_open
						generate_gen_type_conversion (gen_type)
					end
					context.result_register.print_register
					if context.workbench_mode then
							-- RTLX is a macro used to create
							-- expanded types
						if gen_type /= Void then
							buf.putstring (" = RTLX(typres")
						else
							buf.putstring (" = RTLX(RTUD(")
							buf.generate_type_id (cl_type_i.associated_class_type.static_type_id)
							buf.putchar (')')
						end
					else
						if gen_type /= Void then
							buf.putstring (" = RTLN(typres")
						else
							buf.putstring (" = RTLN(")
							buf.putint (exp_type_id)
						end
						class_type := cl_type_i.associated_class_type
						creation_feature := class_type.associated_class.creation_feature
						if creation_feature /= Void then
							written_class := System.class_of_id (creation_feature.written_in)
							if written_class.generics = Void then
								written_type := written_class.types.first
							else
								written_type := written_class.meta_type (class_type.type).associated_class_type
							end
							c_name := Encoder.feature_name (written_type.static_type_id, creation_feature.body_index)
							buf.putstring (");%N%T")
							buf.putstring (c_name)
							buf.putchar ('(')
							context.result_register.print_register
							Extern_declarations.add_routine_with_signature (Void_c_type,
								c_name, <<"EIF_REFERENCE">>)

						end
					end
					buf.putstring (gc_rparan_semi_c)

					if gen_type /= Void then
						generate_block_close
					end
					buf.new_line
				elseif type_i.is_bit then
					bit_i ?= type_i -- Cannot fail
					context.result_register.print_register
					buf.putstring (" = RTLB(")
					buf.putint (bit_i.size)
					buf.putstring (gc_rparan_semi_c)
					buf.new_line
				end
			end
		end

	generate_expanded_cloning is
			-- Clone expanded parameters
		local
			arg: TYPE_I
			i, count, nb_exp: INTEGER
			buf: GENERATION_BUFFER
		do
			if arguments /= Void then
				from
					i := arguments.lower
					count := arguments.count
					buf := buffer
				until
					i > count
				loop
					arg := real_type (arguments.item (i))
					if arg.is_true_expanded then
						context.arg_var.set_position (i)
						buf.putstring ("if ((EIF_REFERENCE) 0 == ")
						context.arg_var.print_register
						buf.putchar (')')
						buf.new_line
						buf.indent
						buf.putstring ("RTET(%"")
						buf.putstring (feature_name)
						buf.putstring ("%", EN_VEXP);")
						buf.new_line
						buf.exdent
							-- Expanded cloning protocol
						if context.exp_args > 1 then
							buf.putstring ("if (idx[")
							buf.putint (nb_exp)
							buf.putstring ("] == -1L)")
							buf.new_line
							buf.indent
							generate_arg_var_cloning (-1)
							buf.exdent
							buf.putstring ("else")
							buf.new_line
							buf.indent
							generate_arg_var_cloning (nb_exp)
							buf.exdent
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
			buf: GENERATION_BUFFER
		do
			context.arg_var.print_register
			buf := buffer
			buf.putstring (" = RTCL(")
			context.arg_var.print_register
				-- If `idx' is not -1, then the reference was the one for the
				-- enclosing object and it needs adjusting by the expanded
				-- object's offset whithin that bigger object.
			if idx /= -1 then
				buf.putstring (" + idx[")
				buf.putint (idx)
				buf.putchar (']')
			end
			buf.putstring (");")
			buf.new_line
		end

	generate_save_args is
			-- Push the addresses of the arguments on the local variable stack.
		local	
			i		: INTEGER
			count	: INTEGER
			type_i	: TYPE_I
			buf		: GENERATION_BUFFER
		do
			if context.workbench_mode then
				buf := buffer
				DEBUG ("C_DEBUGGER")
					buf.putstring ("GENERATE SAVE ARGS%N")
				end
				if arguments /= Void then
					from
						count := arguments.count
						i := arguments.lower
						DEBUG ("C_DEBUGGER")
							buf.putstring ("The number of arguments is ")
							buf.putint (count)
							buf.putstring ("%NThe lower bound is ")
							buf.putint (i)
							buf.putstring ("%N%N")
						end
					until
						i > count
					loop
						type_i := real_type (arguments.item (i))
							-- Local reference variable are declared via
							-- the local variable array "l[]"
						buf.putstring ("RTLU(")
						type_i.c_type.generate_sk_value (buf)
						buf.putstring (",&arg")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
						i := i + 1
					end
				else
					DEBUG ("C_DEBUGGER")
						buf.putstring ("arguments is void%N")
					end
				end	
				DEBUG ("C_DEBUGGER")
					buf.putstring ("END OF GENERATION%N%N%N")
				end
			end
		end


	generate_save_locals is
			-- Push the addresses of the local variables on the local variable stack.
		local	
			i		: INTEGER
			count	: INTEGER
			type_i	: TYPE_I
			buf		: GENERATION_BUFFER
		do
			if context.workbench_mode then
				buf := buffer
				DEBUG ("C_DEBUGGER")
					buf.putstring ("GENERATE SAVE LOCALS%N")
				end
				if locals /= Void then
					from
						count := locals.count
						i := locals.lower
						DEBUG ("C_DEBUGGER")
							buf.putstring ("/* The number of locals is ")
							buf.putint (count)		
							buf.putstring ("*/%N/* The lower bound is ")
							buf.putint (i)
							buf.putstring ("*/%N%N")
						end
					until
						i > count
					loop
						type_i := real_type (locals.item (i))
							-- Local reference variable are declared via
							-- the local variable array "l[]"
						buf.putstring ("RTLU(")
						type_i.c_type.generate_sk_value (buf)
						buf.putstring (", &loc")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
						i := i + 1
					end
				else
					DEBUG ("C_DEBUGGER")
						buf.putstring ("locals is void%N")
					end
				end	
				DEBUG ("C_DEBUGGER")
					buf.putstring ("END OF GENERATION%N%N%N")
				end
			end
		end

	generate_save_current is
			-- Push the current object address on the local variable stack.
		local
			buf	: GENERATION_BUFFER
		do
			if context.workbench_mode then
				buf := buffer
				buf.putstring ("RTLU (SK_REF, &Current);")	
				buf.new_line
			end
		end

	generate_save_result is
			-- Push the address of Result on the local variable stack.
		local
			buf		: GENERATION_BUFFER
			type_i	: TYPE_I
		do
			if context.workbench_mode then
				buf := buffer
				if (not result_type.is_void) then
					type_i := real_type (context.byte_code.result_type)
					buf.putstring ("RTLU (")
					type_i.c_type.generate_sk_value (buf)
					buf.putstring (", &Result);")
					buf.new_line
				else
					buf.putstring ("RTLU (SK_VOID, NULL);")
					buf.new_line
				end
			end
		end

	generate_push_db is
			-- generate the macros to save the arguments, locals and so of the feature
			-- in the c debug pile.
		local
			buf	: GENERATION_BUFFER
		do
			if context.workbench_mode then 
					-- first we save the Result register
				generate_save_result
					-- then we push the arguments of the function
				generate_save_args
					-- then we push current
				generate_save_current
					-- finally we push the local variables
				generate_save_locals

					-- Now we record the level of the local variable stack
					-- to restore it in case of a rescue.
				if rescue_clause /= Void then
					buf := buffer
					buf.putstring ("RTLXL;")
					buf.new_line
				end
			end
		end			

	generate_locals is
			-- Declare C local variables
		local
			i			: INTEGER
			count		: INTEGER
			type_i		: TYPE_I
			buf			: GENERATION_BUFFER
			used_local	: BOOLEAN
			unused_locals: ARRAYED_LIST [INTEGER]
			wkb_mode	: BOOLEAN
			used_upper: INTEGER
			has_rescue: BOOLEAN
			l_is_once: BOOLEAN
		do
				-- Cache accessed attributes
			buf := buffer
			wkb_mode := context.workbench_mode
			has_rescue := rescue_clause /= Void
			l_is_once := is_once
			
			if locals /= Void then
				from
					count := locals.count
					used_upper := context.local_vars.upper
					i := locals.lower
				until
					i > count
				loop
					type_i := real_type (locals.item (i))
							-- Check whether the variable is used or not.
					if i > used_upper then
						used_local := False
					else
						used_local := context.local_vars.item(i)
					end
					
							-- Generate only if variable used
					if wkb_mode or used_local then
							-- Local reference variable are declared via
							-- the local variable array "l[]".
						if has_rescue and then not wkb_mode and then type_i.is_basic then
							buf.putstring ("EIF_VOLATILE ")
						end
						type_i.c_type.generate (buf)
						buf.putstring ("loc")
						buf.putint (i)
						buf.putstring (" = ")
						type_i.c_type.generate_cast (buf)
						buf.putstring (" 0;")
						buf.new_line
					end

							-- Issue a warning message if the local is not used
							-- (for the moment, we remember the local variable
							-- number and we will issue the warning at the
							-- end of the loop).
					if wkb_mode and (not used_local) then
						if unused_locals = Void then
							create unused_locals.make (2)
						end
						unused_locals.force (i)
					end
					i := i + 1
				end

					-- Issue a warning for each unused local variable.
				if unused_locals /= Void then
					from
						unused_locals.start
					until
						unused_locals.after
					loop
						issue_unused_local_warning (unused_locals.item)
						unused_locals.forth
					end
				end
			end

				-- Generate index table if we have more than one expanded
				-- argument (cloning protocol).
			if context.exp_args > 1 then
				buf.putstring ("long idx[")
				buf.putint (context.exp_args)
				buf.putstring ("];")
				buf.new_line
			end

				-- Generate temporary locals under the control of the GC
			context.generate_temporary_ref_variables

				-- Result is declared only if needed. For onces, it is
				-- accessed via a key allowing us to have them per thread.
			if (not result_type.is_void) and then (wkb_mode or else context.result_used) then 
				generate_result_declaration (has_rescue and then not wkb_mode)
			end
				-- Declare the 'dtype' variable which holds the pre-computed
				-- dynamic type of current. To avoid unnecssary computations,
				-- this is not done in case of a once, before we know we have
				-- to really enter the body of the routine.
			if context.dt_current > 1 then
					-- There has to be more than one usage of the dynamic type
					-- of current in order to have this variable generated.
				if l_is_once then
					buf.putstring ("RTCDD;")
				else
					buf.putstring ("RTCDT;")
				end
				buf.new_line
			end
				-- Generate the int local variable saving the global `nstcall'.
			if wkb_mode or else context.assertion_level.check_invariant then
				buf.putstring ("RTSN;")
				buf.new_line
			end
			if wkb_mode then
					-- Generate local variable for saving the workbench
					-- mode assertion level of the current object.
				buf.putstring ("RTDA;")
				buf.new_line
				if has_rescue then
					buf.putstring ("RTDT;")
					buf.new_line
				end
			end
				-- The local variable array is then declared, based on the
				-- number of reference variable which need to be placed under
				-- GC control (given by `ref_var_used').
			i := context.ref_var_used
			if i > 0 then
				if has_rescue then
					buf.putstring ("RTXD;")
					buf.new_line
				else
					buf.putstring ("RTLD;")
					buf.new_line
				end
			end

				-- Declare the variable local "backup" stack.
			if wkb_mode and then has_rescue then
				buf.putstring ("RTLXD;")
				buf.new_line
			end

				-- Onces are processed via keys. We store a pointer to
				-- Result (or something !=0 if void) to indicate whether
				-- the once was processed or not. If processed, we'll get
				-- the pointer to Result != 0.
				-- Note that even if Result is not used in once functions,
				-- we have to go through the key: we cannot simply return 0
				-- in case some treatment with side effect were done.
			if
				l_is_once and then not is_global_once and then
				(System.has_multithreaded or else not context.final_mode)
			then
				real_type (result_type).c_type.generate (buf)
				buf.putstring ("*PResult = (")
				real_type (result_type).c_type.generate (buf)
				buf.putstring ("*) 0;%N")
			end

				-- Generate temporary non-reference locals declarations
			context.generate_temporary_nonref_variables

				-- Separate declarations and body with a blank line
			buf.new_line
		end

	issue_unused_local_warning (an_index: INTEGER) is
		local
			feature_as	: FEATURE_AS
			routine_as	: ROUTINE_AS
			i			: INTEGER
			id_list		: ARRAYED_LIST [INTEGER]
			rout_locals	: EIFFEL_LIST [TYPE_DEC_AS]
			good_id		: INTEGER
			warning_msg	: UNUSED_LOCAL_WARNING
		do
			feature_as := System.Body_server.item (body_index)
			routine_as ?= feature_as.body.content
			if routine_as /= Void then
				rout_locals := routine_as.locals
				rout_locals.start
				from
					i := 0
				until
					i = an_index or else rout_locals.after
				loop
					id_list := rout_locals.item.id_list
					from
						id_list.start
					until	
						i = an_index or else id_list.after
					loop
						i := i + 1
						if i = an_index then 
							good_id := id_list.item
						end
						id_list.forth
					end
					rout_locals.forth
				end

				if good_id > 0 then
					create warning_msg
					warning_msg.set_associated_local (good_id)
					warning_msg.set_associated_type (context.current_type.type_a)
					warning_msg.set_associated_feature_i (context.current_feature)
					Error_handler.insert_warning (warning_msg)
				end
			end
		end

	generate_result_declaration (may_need_volatile: BOOLEAN) is
			-- Generate the declaration of the Result entity
		local
			ctype: TYPE_C
			type_i: TYPE_I
			buf: GENERATION_BUFFER
			l_global_once: BOOLEAN
		do
			l_global_once := is_global_once
			if not is_once or else l_global_once then
				buf := buffer
				type_i := real_type (result_type)
				ctype := type_i.c_type
				if l_global_once then
					buf.putstring ("static ")
				end
				if may_need_volatile and then type_i.is_basic then
					buf.putstring ("EIF_VOLATILE ")
				end
				ctype.generate (buf)
				buf.putstring ("Result = ")
				ctype.generate_cast (buf)
				buf.putstring (" 0;")
				buf.new_line
				if l_global_once then
					if may_need_volatile then
						buf.putstring ("static EIF_VOLATILE EIF_BOOLEAN done = 0;")
					else
						buf.putstring ("static EIF_BOOLEAN done = 0;")
					end
					buf.new_line
				end
			end
		end

	init_dtype is
			-- Initializes the value of 'dtype' in once routines. For regular
			-- ones, the variable is initialized directly in the declaration.
		local
			buf: GENERATION_BUFFER
		do
			if context.dt_current > 1 then
				buf := buffer
				buf.putstring ("dtype = Dtype(Current);")
				buf.new_line
			end
		end

	generate_precondition is
			-- Generate precondition check if needed
		local
			workbench_mode	: BOOLEAN
			have_assert		: BOOLEAN
			inh_assert		: INHERITED_ASSERTION
			buf				: GENERATION_BUFFER
		do
			context.set_assertion_type (In_precondition)
			workbench_mode := context.workbench_mode
			inh_assert := Context.inherited_assertion
			if Context.origin_has_precondition then
				have_assert := (precondition /= Void or else
								inh_assert.has_precondition) and then
					(workbench_mode or else context.assertion_level.check_precond)
			end
			generate_invariant_before
			if have_assert then
				buf := buffer
				if workbench_mode then
					buf.putstring ("if (RTAL & CK_REQUIRE) {")
					buf.new_line
					buf.indent
				else
					buf.putstring ("if (~in_assertion) {")
					buf.new_line
					buf.indent
				end
				if has_separate_call_in_precondition then
					buf.exdent
					buf.putstring ("check_sep_pre:")
					buf.indent
					buf.new_line
					buf.putstring ("CURCSFC;")
					buf.new_line
				end
			
				Context.set_has_separate_call_in_precondition
					(has_separate_call_in_precondition)

				if inh_assert.has_precondition then
					inh_assert.generate_precondition
				end

				if precondition /= Void then
					Context.set_new_precondition_block (True)
					precondition.generate
				end
	
				buf.putstring ("RTJB;")
				Context.generate_current_label_definition

				if has_separate_call_in_precondition then
					buf.putstring ("if (!CURSFC) {")
					buf.new_line
					buf.indent
					buf.putstring ("RTCF;")
					buf.new_line
					buf.exdent
					buf.putstring ("} else {")
					buf.new_line
					buf.indent
					buf.putstring ("RTCK;")
					buf.new_line
						-- free separate parameters
					free_separate_parameters
						-- Reserve separate parameters
					buf.putstring ("CURCSPFW;")
					buf.new_line
					reserve_separate_parameters
					buf.putstring ("CURCSPF;")
					buf.new_line
					buf.exdent
					buf.putstring ("}")
				else
					buf.putstring ("RTCF;")
				end
				buf.new_line
				buf.exdent
				buf.putchar ('}')
				buf.new_line
			end
		end

	generate_postcondition is
			-- Generate postcondition check if needed
		local
			workbench_mode: BOOLEAN
			have_assert: BOOLEAN
			inh_assert: INHERITED_ASSERTION
			buf: GENERATION_BUFFER
		do
			workbench_mode := context.workbench_mode
			inh_assert := Context.inherited_assertion
			have_assert := (postcondition /= Void or else inh_assert.has_postcondition) and then
					(workbench_mode or else context.assertion_level.check_postcond)
			if have_assert then
				buf := buffer
				context.set_assertion_type (In_postcondition)
				if workbench_mode then
					buf.putstring ("if (RTAL & CK_ENSURE) {")
					buf.new_line
					buf.indent
				else
					buf.putstring ("if (~in_assertion) {")
					buf.new_line
					buf.indent
				end
				if inh_assert.has_postcondition then
					inh_assert.generate_postcondition
				end
				if postcondition /= Void then
					postcondition.generate
				end
				if workbench_mode then
					buf.exdent
					buf.putchar ('}')
					buf.new_line
				else
					buf.exdent
					buf.putchar ('}')
					buf.new_line
				end
			end
			generate_invariant_after
		end

	generate_save_assertion_level is
			-- Generate the instruction for saving the workbench mode
			-- assertion level of the current object.
		require
			workbench_mode: context.workbench_mode
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring ("RTSA(")
			context.generate_current_dtype
			buf.putstring (gc_rparan_semi_c)
			buf.new_line
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
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if context.workbench_mode then
				buf.putstring (tag)
				buf.putchar ('(')
				context.current_register.print_register
				buf.putstring (", RTAL);")
				buf.new_line
			elseif context.assertion_level.check_invariant then
				buf.putstring (tag)
				buf.putchar ('(')
				context.current_register.print_register
				buf.putstring (gc_rparan_semi_c)
				buf.new_line
			end
		end

	generate_rescue is
			-- Generate the rescue clause
		local
			nb_refs: INTEGER
			buf: GENERATION_BUFFER
		do
			if rescue_clause /= Void then
				buf := buffer
				buf.new_line
				buf.exdent
				buf.putstring ("rescue:")
				buf.new_line
				buf.indent
				buf.putstring ("RTEU;")
				buf.new_line
					-- Restore the C operational stack
				if context.workbench_mode then
					buf.putstring ("RTLXE;")
					buf.new_line
				end
					-- Resynchronize local variables stack
				nb_refs := context.ref_var_used
				if nb_refs > 0 then
					buf.putstring ("RTXS(")
					buf.putint (nb_refs)
					buf.putstring (gc_rparan_semi_c)
					buf.new_line
				end
				rescue_clause.generate
				generate_profile_stop
				buf.putstring ("/* NOTREACHED */")
				buf.new_line
				buf.putstring ("RTEF;")
				buf.new_line
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
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if exception_stack_managed or rescue_clause /= Void then
				buf.putstring ("RTEX;")
				buf.new_line
			end
			if rescue_clause /= Void then
				buf.putstring ("RTED;")
				buf.new_line
					-- We only need this for finalized mode...
				if trace_enabled then
					buf.putstring ("RTLT;")
					buf.new_line
				end
				if profile_enabled then
					buf.putstring ("RTLP;")
					buf.new_line
				end
			end
		end

	generate_execution_trace is
			-- Generate the execution trace stack handling
		do
			if exception_stack_managed then
				generate_stack_macro ("RTEAA")
			elseif rescue_clause /= Void then
				buffer.putstring ("RTEV;")
				buffer.new_line
			end
		end

	generate_pop_execution_trace is
			-- Generate the execution trace stack handling at the end of the
			-- routine
		local
			buf: GENERATION_BUFFER
		do
			if rescue_clause /= Void then
				buf := buffer
				buf.putstring ("RTEOK;")
				buf.new_line
			elseif exception_stack_managed then
				buf := buffer
				buf.putstring ("RTEE;")
				buf.new_line
			end
		end

	generate_pop_debug_locals is
			-- Generate the cleaning of the locals stack used by the debugger 
			-- when stopped in a C function
		local
			buf: GENERATION_BUFFER
			i: INTEGER
		do
			if context.workbench_mode then
				-- we have saved at least Result and Current
				i := 2
				if locals /= Void then
					i := i + locals.count
				end
				if arguments /= Void then
					i := i + arguments.count
				end
				buf := buffer
				buf.putstring ("RTLO(")
				buf.putint (i)
				buf.putstring (");")
				buf.new_line
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
			buf: GENERATION_BUFFER
		do
			if profile_enabled then
				buf := buffer
				buf.putstring ("RTXP;")
				buf.new_line
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
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring (macro_name)
			buf.putstring ("(%"")
			buf.putstring (feature_name)
			buf.putstring ("%", ")
			feature_origin (buf)
			buf.putstring (gc_comma)
			buf.putstring (" dtype")
			buf.putstring (gc_rparan_semi_c)
			buf.new_line
		end

	generate_stack_macro (macro_name: STRING) is
			-- Generate a macro call will the feature name, the feature origin,
			-- `Current', the number of locals, the number of arguments and the
			-- real body id of the feature as arguments.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putstring (macro_name)
			buf.putstring ("(%"")
			buf.putstring (feature_name)
			buf.putstring ("%", ")
			feature_origin (buf)
			buf.putstring (gc_comma)
			context.Current_register.print_register
			buf.putstring (gc_comma)
			if locals /= Void then
				buf.putint (locals.count)
			else
				buf.putint (0)
			end
			buf.putstring (gc_comma)
			if arguments /= Void then
				buf.putint (arguments.count)
			else
				buf.putint (0)
			end
			buf.putstring (gc_comma)
			buf.putint (real_body_id - 1)
			buf.putstring (gc_rparan_semi_c)
			buf.new_line
		end

	finish_compound is
			-- Generate the end of the compound routine
		local
			buf: like buffer
		do
				-- Generate the hook corresponding to the end of the feature ("end;")
			generate_frozen_end_debugger_hook

				-- Generate the remove of the GC hooks
			context.remove_gc_hooks
				-- Generate the update of the locals stack used to debug in C
			generate_pop_debug_locals
				-- Generate trace macro (stop)
			generate_trace_stop
				-- Generate profile macro (stop)
			generate_profile_stop
				-- Generate the update of the trace stack before quitting
				-- the routine
			generate_pop_execution_trace

			if is_global_once then
				buf := buffer
				buf.new_line
				buf.exdent
				buf.putchar ('}')
				buf.new_line
				buf.putstring ("EIF_GLOBAL_ONCE_MUTEX_UNLOCK;")
				buf.new_line
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

			if Context.origin_has_precondition then
				if inh_assert.has_precondition then
					inh_assert.make_precondition_byte_code (ba)
				end

				if precondition /= Void then
					Context.set_new_precondition_block (True)
					precondition.make_byte_code (ba)
				end
			end

			if have_assert then
				from
				until
					ba.forward_marks4.count = 0
				loop
					ba.write_forward4
				end

				if has_separate_call_in_precondition then
					ba.append (Bc_sep_raise_prec)
						-- Reserve separeate parameters
					process_sep_paras_in_byte_code (ba, True)
					ba.sep_write_backward
				else
					ba.append (Bc_raise_prec)
				end
				if inh_assert.has_precondition then
					inh_assert.write_forward (ba)
				
					if precondition /= Void then
						ba.write_forward
					end
				end
				ba.write_forward
			end

			has_old := (old_expressions /= Void) or else (inh_assert.has_old_expression)
			if has_old then
				ba.append (Bc_start_eval_old)
				ba.mark_forward
			end

			if postcondition /= Void and then 	
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

				-- Make byte code for postcondition
			if have_assert then
				context.set_assertion_type (In_postcondition)
				ba.append (Bc_postcond)
				ba.mark_forward
			end

			if inh_assert.has_postcondition then
				inh_assert.make_postcondition_byte_code (ba)
			end

			if postcondition /= Void then
				postcondition.make_byte_code (ba)
			end

			if have_assert then
				ba.write_forward
			end

			if system.has_separate and then arguments /= Void then
					-- Reserve separeate parameters
				process_sep_paras_in_byte_code (ba, False)
			end

				-- Generate the hook corresponding to the final end.
			generate_melted_end_debugger_hook (ba)
		end

feature -- Array optimization

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
			if opt_context.array_desc.is_empty then
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
			create array_desc.make
			create safe_array_desc.make
			create Result.make (array_desc, safe_array_desc)
			create g.make
			Result.set_generated_array_desc (g)
			create g.make
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
				create inlined_b
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
			buf: GENERATION_BUFFER
		do
				-- Reserve separate parameters
			if arguments /= Void and then has_separate_call_in_the_feature then
				buf := buffer
				buf.exdent
				Context.inc_reservation_label
				Context.print_reservation_label
				buf.putstring (":")
				buf.indent
				buf.new_line
				create var_name.make(10)
				from 
					create var_name.make(10)
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
						buf.putstring ("if (CURRSO(")
						if reg /= Void then
							reg.print_register
						else
							buf.putstring (var_name)
						end
						buf.putstring (")) {")
						buf.indent
						buf.new_line
						free_partial_sep_paras (i)
						buf.putstring ("CURRSFW;")
						buf.new_line
						buf.putstring ("goto ")
						Context.print_reservation_label
						buf.putstring (";")
						buf.new_line
						buf.exdent
						buf.putstring ("}")
						buf.new_line
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
			buf: GENERATION_BUFFER
		do
				-- Free separate parameters
			if arguments /= Void then
				from 
					create var_name.make(10)
					i := arguments.lower
					count := arguments.count + i - 1
					buf := buffer
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
						buf.putstring ("CURFSO(")
						if reg /= Void then
							reg.print_register
						else
							buf.putstring (var_name)
						end
						buf.putstring (");")
						buf.new_line
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
			buf: GENERATION_BUFFER
		do
				-- Free separate parameters
			if arguments /= Void then
				from 
					create var_name.make(10)
					i := arguments.lower
					count := arguments.count + i - 1
					buf := buffer
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
						buf.putstring ("CURFSO(")
						if reg /= Void then
							reg.print_register
						else
							buf.putstring (var_name)
						end
					  	buf.putstring (");")
					   	buf.new_line
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
				if not ast_sep_call.is_empty then
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
