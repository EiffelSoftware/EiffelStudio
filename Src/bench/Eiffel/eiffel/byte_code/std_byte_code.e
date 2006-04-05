indexing
	description	: "Standard Byte code generation for features"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature -- Access

	generated_c_feature_name: STRING is
			-- Name of generated routine in C generated code
		do
			Result := Encoder.feature_name (
				System.class_type_of_id (context.current_type.type_id).static_type_id,
				body_index)
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
			have_precond, have_postcond, has_invariant: BOOLEAN
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

				-- Let's check if some invariants are going to be generated.
				-- It is important to know for `compute_need_gc_hooks' which will
				-- not try to optimize GC hooks if we are checking invariants.
			has_invariant := context.workbench_mode or else context.assertion_level.check_invariant

				-- Compute presence or not of pre/postconditions
			if Context.origin_has_precondition then
				have_precond := (precondition /= Void or else inh_assert.has_precondition) and then
						(workbench_mode or else context.assertion_level.check_precond)
			end
			have_postcond := (postcondition /= Void or else inh_assert.has_postcondition) and then
					(workbench_mode or else context.assertion_level.check_postcond)

				-- Check if we need GC hooks for current body.
			Context.compute_need_gc_hooks (have_precond or have_postcond or has_invariant)

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
				context.add_dt_current
				context.add_dt_current
			end
			if profile_enabled then
					-- For RTPR and RTXP
				context.add_dt_current
				context.add_dt_current
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
					arg := real_type (args.item (i))
					if arg.is_true_expanded then
							-- Force GC hook and its usage even if not used within
							-- body of current routine.
							-- See FIXME of `generate_expanded_arguments_cloning'
							-- for possible improvement.
						context.force_gc_hooks
						arg_var.set_position (i)
						context.set_local_index (arg_var.register_name, arg_var.enlarged)
					end
					i := i + 1
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
			type_c: TYPE_C
			internal_name: STRING
			name: STRING
			extern: BOOLEAN
			buf: GENERATION_BUFFER
			l_is_once: BOOLEAN
			args: like argument_names
			i: INTEGER
		do
			buf := buffer
			l_is_once := is_once

				-- Generate the header "int foo(Current, args)"
			type_c := real_type (result_type).c_type

				-- Function's name
			internal_name := generated_c_feature_name

				-- Add entry in the log file
			add_in_log (internal_name)

				-- If it is a once, performs once declaration.
			if l_is_once then
				generate_once_declaration (internal_name, type_c)
			end

				-- Generate reference to once manifest string field
			context.generate_once_manifest_string_import (once_manifest_string_count)

			if rescue_clause /= Void then
				buf.put_string ("#undef EIF_VOLATILE")
				buf.put_new_line
				buf.put_string ("#define EIF_VOLATILE volatile")
				buf.put_new_line
			end

				-- Generate function signature
			extern := True
			name := internal_name
			if l_is_once and then context.is_once_call_optimized then
					-- Once routines should be protected against exceptions.
					-- C compiler generates inefficient code for functions that catch exceptions.
					-- Therefore two functions are generated instead of one
					-- when feature-call assertions are not involved.
					-- One routine contains an exception block and the
					-- other one either returns the result if it is ready
					-- or calls the first one to evaluate it:
					-- 	RESULT_TYPE aaa_body (arguments) {...}
					--  RESULT_TYPE aaa (arguments) { return RTOxCy (aaa, aaa_body, (arguments));}
				name := internal_name + "_body"
				extern := False
			end
			args := argument_names
			buf.generate_function_signature
				(type_c.c_string, name, extern,
				 Context.header_buffer, args, argument_types)

				-- Starting body of C routine
			buf.indent

				-- Declaration of all the local entities, such as
				-- Eiffel local variables, Result, temporary registers...
			generate_execution_declarations
			generate_locals

				-- Declare variables required for once routines.
			generate_once_data (internal_name)

				-- Clone expanded parameters.
			generate_expanded_initialization

				-- Before entering in the code generate GC hooks, i.e. pass
				-- the addresses of all the reference variables.
			context.generate_gc_hooks (False)

				-- Record the locals, arguments and Current address for debugging.
			generate_push_db

				-- Generate execution trace information (RTEAA)
			generate_execution_trace

				-- Generate trace macro (start)
			generate_trace_start

				-- Generate profile macro (start)
			generate_profile_start

				-- Generate GC synchronization macro
			if not is_external and context.need_gc_hook then
					-- No need to generate a synchronization point before
					-- calling an external or a small routine that does not
					-- have GC hooks as it could mess up the references to
					-- Eiffel object that this routine might have.
					-- For blocking externals, if it is needed, then it is
					-- using the `blocking' keyword in its specification.
				buf.put_string ("RTGC;")
				buf.put_new_line
			end

				-- Allocate memory for once manifest strings if required
			context.generate_once_manifest_string_allocation (once_manifest_string_count)

				-- Generate the saving of the workbench mode assertion level
			if context.workbench_mode then
				generate_save_assertion_level
			end

				-- Precondition check generation
			generate_precondition
			if Context.has_chained_prec then
					-- For chained precondition (to implement or else...)
				Context.generate_body_label
			end

				-- If necessary, generate the once stuff (i.e. check if
				-- the value of the once was already set within the same
				-- thread).  That way we do not enter the body of the
				-- once if it has already been done. Preconditions,
				-- if any, are tested for all calls.
			generate_once_prologue (internal_name)

			if rescue_clause /= Void then
					-- Generate a `setjmp' C instruction in case of a
					-- rescue clause
				if trace_enabled then
					buf.put_string ("RTTI;")
					buf.put_new_line
				end
				if profile_enabled then
					buf.put_string ("RTPI;")
					buf.put_new_line
				end
				buf.put_string ("RTE_T")
				buf.put_new_line
			end

				-- Generate local expanded variable creations
			generate_expanded_variables

				-- Generate old variables
			generate_old_variables

				-- Now we want the body
			generate_compound

				-- Now the postcondition
			generate_postcondition

			if not type_c.is_void then
					-- Function returns something. This can be done
					-- by inner returns, so have some mercy
					-- for lint and highlight the NOTREACHED status...
				generate_return_not_reached
			end

				-- If there is a rescue clause, generate it now...
			generate_rescue

				-- Generate termination for once routine
			generate_once_epilogue (generated_c_feature_name)

			if compound = Void or else not compound.last.last_all_in_result then
					-- Remove the GC hooks we've been generated.
				finish_compound
				-- Generate final "return Result", if required
				generate_return_exp
			end

			buf.exdent

				-- End of C function
			if l_is_once then
				buf.put_new_line
				buf.put_string ("#undef Result")
				buf.put_new_line
			end

				-- Leave a blank line after function definition
			buf.put_string ("}%N%N")

			if rescue_clause /= Void then
				buf.put_string ("#undef EIF_VOLATILE")
				buf.put_new_line
				buf.put_string ("#define EIF_VOLATILE")
				buf.put_new_line
			end

			if l_is_once and then context.is_once_call_optimized then
					-- Generate optimized stub for once routine.
				buf.generate_function_signature
					(type_c.c_string, internal_name, True,
					 Context.header_buffer, args, argument_types)
				buf.indent
				if not type_c.is_void then
					buf.put_string ("return ")
				end
				context.generate_once_optimized_call_start (type_c, body_index, is_global_once, buf)
				buf.put_string (name)
				buf.put_string (",(")
				from
					i := 1
				until
					i > args.count
				loop
					if i > 1 then
						buf.put_character (',')
					end
					buf.put_string (args.item (i))
					i := i + 1
				end
				buf.exdent
				buf.put_string ("));%N}%N%N")
			end

			Context.inherited_assertion.wipe_out

debug ("DEBUGGER_HOOK")
		-- ASSERTION TO CHECK THAT `number_of_breakpoint_slots' is correct
	if
		context.workbench_mode and then
		get_current_frozen_debugger_hook + 1 /= context.current_feature.number_of_breakpoint_slots
	then
		io.put_string ("STD_BYTE_CODE: Error in breakable line number computation for: %N")
		io.put_string ("{"+context.original_class_type.associated_class.lace_class.name+"}")
		io.put_string ("."+context.current_feature.feature_name+"%N%N")
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

	generate_return_not_reached is
			-- Generate a mark that the final return is not reached
		local
			assignment: ASSIGN_B
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
					if
						assignment = Void and
						not context.has_rescue
					then
						buf := buffer
						buf.put_string ("/* NOTREACHED */")
						buf.put_new_line
					end
				end
			end
		end

	generate_return_exp is
			-- Generate the return expression
		local
			type_i: TYPE_I
			buf: GENERATION_BUFFER
		do
				-- Do not forget to remove the GC hooks before returning
				-- if they have already been generated. For instance, when
				-- generating return for a once function, hooks have not
				-- been generated.
			type_i := real_type (result_type)
			if not result_type.is_void then
				buf := buffer
				buf.put_string ("return ")
					-- If Result was used, generate it. Otherwise, its value
					-- is simply the initial one (i.e. generic 0).
					-- Note: in workbench, we always return the result. It may
					--       have been changed by the user (see class EDIT_ITEM)
				if context.workbench_mode or else context.result_used then
					buf.put_string ("Result;")
				else
					type_i.c_type.generate_cast (buf)
					buf.put_string ("0;")
				end
				buf.put_new_line
			end
		end -- generate_return_exp

	generate_once_declaration (a_name: STRING; a_type: TYPE_C) is
			-- Generate static variable and their declarations used by
			-- generation of opimized once functions.
		require
			a_name_not_void: a_name /= Void
			a_type_not_void: a_type /= Void
		do
		end

	generate_once_data (a_name: STRING) is
			-- Generate data for once routines.
		require
			a_name_not_void: a_name /= Void
		do
		end

	generate_once_prologue (a_name: STRING) is
			-- Generate start of a once block that will ensure that body is not re-executed.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
		end

	generate_once_epilogue (a_name: STRING) is
			-- Generate end of a once block.
		require
			a_name_not_void: a_name /= Void
		do
		end

	generate_expanded_arguments is
			-- Generate declaration for locals `earg' that will hold a copy of passed
			-- arguments.
		local
			l_arguments: like arguments
			i, nb: INTEGER
			l_buf: like buffer
			l_has_expanded: BOOLEAN
			l_type: CL_TYPE_I
			l_arg_name: STRING
			l_class_type: CLASS_TYPE
		do
			l_arguments := arguments
			if l_arguments /= Void then
				from
					i := l_arguments.lower
					nb := l_arguments.upper
					l_buf := buffer
				until
					i > nb
				loop
					l_type ?= real_type (l_arguments.item (i))
					if l_type /= Void and then l_type.is_true_expanded then
						create l_arg_name.make (6)
						l_arg_name.append ("sarg")
						l_arg_name.append_integer (i)
						l_class_type := l_type.associated_class_type
						l_class_type.generate_expanded_structure_declaration (l_buf, l_arg_name)
						l_buf.put_new_line
						l_buf.put_string ("EIF_REFERENCE earg")
						l_buf.put_integer (i)
						l_buf.put_string (" = (EIF_REFERENCE) (")
						l_buf.put_string (l_arg_name)
						l_buf.put_string (".data")
						l_class_type.generate_expanded_overhead_size (l_buf)
						l_buf.put_string (");")
						l_buf.put_new_line
						l_has_expanded := True
					end
					i := i + 1
				end
			end
		end

	generate_expanded_initialization is
			-- Clone expanded parameters and initialize local expanded objects.
		local
			l_type: CL_TYPE_I
			i, count: INTEGER
			buf: GENERATION_BUFFER
			l_list: ARRAY [TYPE_I]
			l_class_type: CLASS_TYPE
			l_loc_name: STRING
		do
			l_list := arguments
			if l_list /= Void then
				from
					i := l_list.lower
					count := l_list.count
					buf := buffer
				until
					i > count
				loop
					l_type ?= real_type (l_list.item (i))
					if l_type /= Void and then l_type.is_true_expanded then
							-- FIXME: Manu: 05/10/2004: if argument is not
							-- used and if associated type does not redefine `copy'
							-- then we could skip this call for more efficiency.
							-- See `analyze_arguments' too as the above fixme is related
							-- to what `analyze_arguments' does to mark the expanded
							-- arguments used.
							-- FIXME: Manu: 05/11/2004: We need to call `copy' if it
							-- is redefined, not the equivalent of `standard_copy'.
							-- Note: Safe to use `memcpy' since target is allocated on the
							-- stack and no one can have a reference to it.
						l_class_type := l_type.associated_class_type
						buf.put_string ("memcpy (sarg")
						buf.put_integer (i)
						buf.put_string (".data, HEADER(arg")
						buf.put_integer (i)
						buf.put_string ("), ")
						if context.workbench_mode then
							l_class_type.skeleton.generate_workbench_size (buf)
						else
							l_class_type.skeleton.generate_size (buf)
						end
						l_class_type.generate_expanded_overhead_size (buf)
						buf.put_string (");")
						buf.put_new_line
						buf.put_string ("((union overhead *) sarg")
						buf.put_integer (i)
						buffer.put_string (".data)->ov_size = ")
						if context.workbench_mode then
							l_class_type.skeleton.generate_workbench_size (buf)
						else
							l_class_type.skeleton.generate_size (buf)
						end
						buffer.put_character (';')
						buf.put_new_line
					end
					i := i + 1
				end
			end

			l_list := locals
			if locals /= Void then
				from
					i := l_list.lower
					count := l_list.count
					buf := buffer
				until
					i > count
				loop
					l_type ?= real_type (l_list.item (i))
					if l_type /= Void and then l_type.is_true_expanded then
							-- FIXME: Manu: 05/12/2004: if local is not
							-- used and if associated type does not redefine `default_create'
							-- then we could skip this call for more efficiency.

							-- First we reset the memory to `0'.
						create l_loc_name.make (6)
						l_loc_name.append ("sloc")
						l_loc_name.append_integer (i)

						buf.put_string ("memset (")
						buf.put_string (l_loc_name)
						buf.put_string (".data, 0, ")
						l_class_type := l_type.associated_class_type
						if context.workbench_mode then
							l_class_type.skeleton.generate_workbench_size (buf)
						else
							l_class_type.skeleton.generate_size (buf)
						end
						l_class_type.generate_expanded_overhead_size (buf)
						buf.put_string (");")
						buf.put_new_line

							-- Then we update the type information
						l_class_type.generate_expanded_type_initialization (buf, l_loc_name)
					end
					i := i + 1
				end
			end
		end

	generate_expanded_variables is
			-- Create local expanded variables and Result
		local
			i, count: INTEGER
			type_i: TYPE_I
			used_upper: INTEGER
			l_buffer: like buffer
			is_workbench: BOOLEAN
		do
			l_buffer := buffer
			is_workbench := context.workbench_mode
			if locals /= Void then
				from
					i := locals.lower
					count := locals.count
					used_upper := context.local_vars.upper
				until
					i > count
				loop
							-- Generate only if variable used
					if i <= used_upper and then (is_workbench or context.local_vars.item(i)) then
						type_i := real_type (locals.item (i))
						if type_i.is_true_expanded then
							local_var.set_position (i)
							type_i.generate_expanded_initialization (l_buffer, local_var.register_name)
						elseif type_i.is_bit then
							local_var.set_position (i)
							type_i.generate_expanded_creation (l_buffer, local_var.register_name)
						end
					end
					i := i + 1
				end
			end
			if context.result_used then
				type_i := real_type (result_type)
				if type_i.is_true_expanded or type_i.is_bit then
					type_i.generate_expanded_creation (l_buffer,
						context.result_register.register_name)
					type_i.generate_expanded_initialization (l_buffer,
						context.result_register.register_name)
				end
			end
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
					buf.put_string ("GENERATE SAVE ARGS%N")
				end
				if arguments /= Void then
					from
						count := arguments.count
						i := arguments.lower
						DEBUG ("C_DEBUGGER")
							buf.put_string ("The number of arguments is ")
							buf.put_integer (count)
							buf.put_string ("%NThe lower bound is ")
							buf.put_integer (i)
							buf.put_string ("%N%N")
						end
					until
						i > count
					loop
						type_i := real_type (arguments.item (i))
							-- Local reference variable are declared via
							-- the local variable array "l[]"
						buf.put_string ("RTLU(")
						type_i.c_type.generate_sk_value (buf)
						if type_i.is_true_expanded then
							buf.put_string (",&earg")
						else
							buf.put_string (",&arg")
						end
						buf.put_integer (i)
						buf.put_string (");")
						buf.put_new_line
						i := i + 1
					end
				else
					DEBUG ("C_DEBUGGER")
						buf.put_string ("arguments is void%N")
					end
				end
				DEBUG ("C_DEBUGGER")
					buf.put_string ("END OF GENERATION%N%N%N")
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
					buf.put_string ("GENERATE SAVE LOCALS%N")
				end
				if locals /= Void then
					from
						count := locals.count
						i := locals.lower
						DEBUG ("C_DEBUGGER")
							buf.put_string ("/* The number of locals is ")
							buf.put_integer (count)
							buf.put_string ("*/%N/* The lower bound is ")
							buf.put_integer (i)
							buf.put_string ("*/%N%N")
						end
					until
						i > count
					loop
						type_i := real_type (locals.item (i))
							-- Local reference variable are declared via
							-- the local variable array "l[]"
						buf.put_string ("RTLU(")
						type_i.c_type.generate_sk_value (buf)
						buf.put_string (", &loc")
						buf.put_integer (i)
						buf.put_string (");")
						buf.put_new_line
						i := i + 1
					end
				else
					DEBUG ("C_DEBUGGER")
						buf.put_string ("locals is void%N")
					end
				end
				DEBUG ("C_DEBUGGER")
					buf.put_string ("END OF GENERATION%N%N%N")
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
				buf.put_string ("RTLU (SK_REF, &Current);")
				buf.put_new_line
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
					buf.put_string ("RTLU (")
					type_i.c_type.generate_sk_value (buf)
					buf.put_string (", &Result);")
					buf.put_new_line
				else
					buf.put_string ("RTLU (SK_VOID, NULL);")
					buf.put_new_line
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
					buf.put_string ("RTLXL;")
					buf.put_new_line
				end
			end
		end

	generate_locals is
			-- Declare C local variables
		local
			i: INTEGER
			count: INTEGER
			type_i: TYPE_I
			buf: GENERATION_BUFFER
			used_local: BOOLEAN
			wkb_mode: BOOLEAN
			used_upper: INTEGER
			has_rescue: BOOLEAN
			l_is_once: BOOLEAN
			l_loc_name: STRING
			l_type: CL_TYPE_I
			l_class_type: CLASS_TYPE
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
					if wkb_mode or (used_local or type_i.is_true_expanded) then
							-- Local reference variable are declared via
							-- the local variable array "l[]".
						if type_i.is_true_expanded then
							create l_loc_name.make (6)
							l_loc_name.append ("sloc")
							l_loc_name.append_integer (i)
							l_type ?= type_i
							check
									-- Only a CL_TYPE_I could be an expanded
								l_type_not_void: l_type /= Void
							end
							l_class_type := l_type.associated_class_type
							l_class_type.generate_expanded_structure_declaration (buf, l_loc_name)
							buf.put_new_line
						end
						type_i.c_type.generate (buf)
						if has_rescue then
							buf.put_string ("EIF_VOLATILE ")
						end
						buf.put_string ("loc")
						buf.put_integer (i)
						buf.put_string (" = ")
						if type_i.is_true_expanded then
							type_i.c_type.generate_cast (buf)
							buf.put_string (" (")
							buf.put_string (l_loc_name)
							buf.put_string (".data")
							l_class_type.generate_expanded_overhead_size (buf)
							buf.put_string (");")
							buf.put_new_line
						else
							type_i.c_type.generate_cast (buf)
							buf.put_string (" 0;")
							buf.put_new_line
						end
					end
					i := i + 1
				end
			end

			generate_expanded_arguments

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
			if context.dftype_current > 1 then
					-- There has to be more than one usage of the dynamic type
					-- of current in order to have this variable generated.
				if l_is_once then
					buf.put_string ("RTCFDD;")
				else
					buf.put_string ("RTCFDT;")
				end
				buf.put_new_line
			end
			if context.dt_current > 1 then
					-- There has to be more than one usage of the full dynamic type
					-- of current in order to have this variable generated.
				if l_is_once then
					buf.put_string ("RTCDD;")
				else
					buf.put_string ("RTCDT;")
				end
				buf.put_new_line
			end
				-- Generate the int local variable saving the global `nstcall'.
			if wkb_mode or else context.assertion_level.check_invariant then
				buf.put_string ("RTSN;")
				buf.put_new_line
			end
			if wkb_mode then
					-- Generate local variable for saving the workbench
					-- mode assertion level of the current object.
				buf.put_string ("RTDA;")
				buf.put_new_line
				if has_rescue then
					buf.put_string ("RTDT;")
					buf.put_new_line
				end
			end
				-- The local variable array is then declared, based on the
				-- number of reference variable which need to be placed under
				-- GC control (given by `ref_var_used').
			i := context.ref_var_used
			if i > 0 then
				if has_rescue then
					buf.put_string ("RTXD;")
					buf.put_new_line
				else
					buf.put_string ("RTLD;")
					buf.put_new_line
				end
			end

				-- Declare the variable local "backup" stack.
			if wkb_mode and then has_rescue then
				buf.put_string ("RTLXD;")
				buf.put_new_line
			end

				-- Separate declarations and body with a blank line
			buf.put_new_line
		end

	generate_result_declaration (may_need_volatile: BOOLEAN) is
			-- Generate the declaration of the Result entity
		local
			ctype: TYPE_C
			type_i: TYPE_I
			buf: GENERATION_BUFFER
		do
			if not is_once then
				buf := buffer
				type_i := real_type (result_type)
				ctype := type_i.c_type
				if may_need_volatile and then type_i.is_basic then
					buf.put_string ("EIF_VOLATILE ")
				end
				ctype.generate (buf)
				buf.put_string ("Result = ")
				ctype.generate_cast (buf)
				buf.put_string (" 0;")
				buf.put_new_line
			end
		end

	init_dftype is
			-- Initializes the value of 'dftype' in once routines. For regular
			-- ones, the variable is initialized directly in the declaration.
		local
			buf: GENERATION_BUFFER
		do
			if context.dftype_current > 1 then
				buf := buffer
				buf.put_string ("dftype = Dftype(Current);")
				buf.put_new_line
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
				buf.put_string ("dtype = Dtype(Current);")
				buf.put_new_line
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
					buf.put_string ("if (RTAL & CK_REQUIRE) {")
					buf.put_new_line
					buf.indent
				else
					buf.put_string ("if (~in_assertion) {")
					buf.put_new_line
					buf.indent
				end

				if inh_assert.has_precondition then
					inh_assert.generate_precondition
				end

				if precondition /= Void then
					Context.set_new_precondition_block (True)
					precondition.generate
				end

				buf.put_string ("RTJB;")
				Context.generate_current_label_definition

				buf.put_string ("RTCF;")
				buf.put_new_line
				buf.exdent
				buf.put_character ('}')
				buf.put_new_line
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
					buf.put_string ("if (RTAL & CK_ENSURE) {")
					buf.put_new_line
					buf.indent
				else
					buf.put_string ("if (~in_assertion) {")
					buf.put_new_line
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
					buf.put_character ('}')
					buf.put_new_line
				else
					buf.exdent
					buf.put_character ('}')
					buf.put_new_line
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
			buf.put_string ("RTSA(")
			context.generate_current_dtype
			buf.put_string (gc_rparan_semi_c)
			buf.put_new_line
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
				buf.put_string (tag)
				buf.put_character ('(')
				context.current_register.print_register
				buf.put_string (", RTAL);")
				buf.put_new_line
			elseif context.assertion_level.check_invariant then
				buf.put_string (tag)
				buf.put_character ('(')
				context.current_register.print_register
				buf.put_string (gc_rparan_semi_c)
				buf.put_new_line
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
				buf.put_new_line
				buf.put_string ("RTE_E")
				buf.put_new_line
					-- Restore the C operational stack
				if context.workbench_mode then
					buf.put_string ("RTLXE;")
					buf.put_new_line
				end
					-- Resynchronize local variables stack
				nb_refs := context.ref_var_used
				if nb_refs > 0 then
					buf.put_string ("RTXS(")
					buf.put_integer (nb_refs)
					buf.put_string (gc_rparan_semi_c)
					buf.put_new_line
				end
				rescue_clause.generate
				generate_profile_stop
				buf.put_string ("/* NOTREACHED */")
				buf.put_new_line
				buf.put_string ("RTE_EE")
				buf.put_new_line
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
			if exception_stack_managed or else rescue_clause /= Void or else is_once then
				buf := buffer
				buf.put_string ("RTEX;")
				buf.put_new_line
				if rescue_clause /= Void then
					buf.put_string ("RTED;")
					buf.put_new_line
						-- We only need this for finalized mode...
					if trace_enabled then
						buf.put_string ("RTLT;")
						buf.put_new_line
					end
					if profile_enabled then
						buf.put_string ("RTLP;")
						buf.put_new_line
					end
				end
			end
		end

	generate_execution_trace is
			-- Generate the execution trace stack handling
		do
			if exception_stack_managed then
				generate_stack_macro ("RTEAA")
			elseif rescue_clause /= Void or else is_once then
					-- Prepare execution stack to catch exceptions
					--   explicitly by a rescue clause
					--   implicitly by a code of once routine
				buffer.put_string ("RTEV;")
				buffer.put_new_line
			end
		end

	generate_pop_execution_trace is
			-- Generate the execution trace stack handling at the end of the
			-- routine
		local
			buf: GENERATION_BUFFER
		do
			if rescue_clause = Void and then (exception_stack_managed or else is_once) then
				buf := buffer
				buf.put_string ("RTEE;")
				buf.put_new_line
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
				buf.put_string ("RTLO(")
				buf.put_integer (i)
				buf.put_string (");")
				buf.put_new_line
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
				buf.put_string ("RTXP;")
				buf.put_new_line
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
			buf.put_string (macro_name)
			buf.put_character ('(')
			buf.put_string_literal (feature_name)
			buf.put_string (gc_comma)
			feature_origin (buf)
			buf.put_string (gc_comma)
			buf.put_string (" dtype")
			buf.put_string (gc_rparan_semi_c)
			buf.put_new_line
		end

	generate_stack_macro (macro_name: STRING) is
			-- Generate a macro call will the feature name, the feature origin,
			-- `Current', the number of locals, the number of arguments and the
			-- real body id of the feature as arguments.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string (macro_name)
			buf.put_character ('(')
			buf.put_string_literal (feature_name)
			buf.put_string (gc_comma)
			feature_origin (buf)
			buf.put_string (gc_comma)
			context.Current_register.print_register
			buf.put_string (gc_comma)
			if locals /= Void then
				buf.put_integer (locals.count)
			else
				buf.put_integer (0)
			end
			buf.put_string (gc_comma)
			if arguments /= Void then
				buf.put_integer (arguments.count)
			else
				buf.put_integer (0)
			end
			buf.put_string (gc_comma)
			buf.put_real_body_id (real_body_id)
			buf.put_string (gc_rparan_semi_c)
			buf.put_new_line
		end

	finish_compound is
			-- Generate the end of the compound routine
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
		end

feature -- Byte code generation

	make_body_code (ba: BYTE_ARRAY; a_generator: MELTED_GENERATOR) is
			-- Generate compound byte code
		local
			have_assert, has_old: BOOLEAN
			inh_assert: INHERITED_ASSERTION
		do
				-- Allocate memory for once manifest strings if required
			context.make_once_string_allocation_byte_code (ba, context.byte_code.once_manifest_string_count)

			inh_assert := Context.inherited_assertion
			if Context.origin_has_precondition then
				have_assert := (precondition /= Void or else inh_assert.has_precondition)
			end

			if have_assert then
				context.set_assertion_type (In_precondition)
				ba.append (Bc_precond)
				ba.mark_forward
			end

			if Context.origin_has_precondition then
				if inh_assert.has_precondition then
					inh_assert.make_precondition_byte_code (a_generator, ba)
				end

				if precondition /= Void then
					Context.set_new_precondition_block (True)
					a_generator.generate (ba, precondition)
				end
			end

			if have_assert then
				from
				until
					ba.forward_marks4.count = 0
				loop
					ba.write_forward4
				end

				ba.append (Bc_raise_prec)
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
					a_generator.generate_old_expression_initialization (ba, old_expressions.item)
					old_expressions.forth
				end
			end

				-- Make byte code for inherited old expressions
			have_assert := postcondition /= Void or else inh_assert.has_postcondition
			if have_assert then
				if inh_assert.has_postcondition then
					inh_assert.make_old_exp_byte_code (a_generator, ba)
				end
			end

			if has_old then
				ba.append (Bc_end_eval_old)
				ba.write_forward
			end
				-- Go to point for old expressions

			if compound /= Void then
				a_generator.generate (ba, compound)
			end

				-- Make byte code for postcondition
			if have_assert then
				context.set_assertion_type (In_postcondition)
				ba.append (Bc_postcond)
				ba.mark_forward
			end

			if inh_assert.has_postcondition then
				inh_assert.make_postcondition_byte_code (a_generator, ba)
			end

			if postcondition /= Void then
				a_generator.generate (ba, postcondition)
			end

			if have_assert then
				ba.write_forward
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
			i, nb: INTEGER
		do
			check
				no_rescue: rescue_clause = Void
			end

			old_bc := Context.byte_code
			Context.set_byte_code (Current)
			Result := Current
			result_type := real_type (result_type)
			if locals /= Void then
				from
					i := locals.lower
					nb := locals.upper
				until
					i > nb
				loop
					locals.put (real_type (locals.item (i)), i)
					i := i + 1
				end
			end
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

feature {NONE} -- Convenience

	local_var: LOCAL_B is
			-- Instance used to generate local variable name
		once
			create Result
		end

	arg_var: ARGUMENT_B is
			-- Instance used to generate local variable name
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
