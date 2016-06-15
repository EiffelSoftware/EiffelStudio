note
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
			inlined_byte_code, pre_inlined_code,
			process
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER

	SHARED_DECLARATIONS


feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_std_byte_code (Current)
		end

feature -- Access

	compound: BYTE_LIST [BYTE_NODE]
			-- Compound byte code

feature -- Status

	is_process_relative_once: BOOLEAN
			-- Is current once compiled in multithreaded mode with global status?
		do
			-- False
		end

	is_thread_relative_once: BOOLEAN
			-- Is current once to be generated in multithreaded mode has a once per thread (default)?
		do
			Result := not (is_process_relative_once or is_object_relative_once)
		end

feature -- Access

	generated_c_feature_name: STRING
			-- Name of generated routine in C generated code
		do
			Result := Encoder.feature_name (context.class_type.type_id, body_index)
		end

feature -- Setting

	set_compound (c: like compound)
			-- Assign `c' to `compound'.
		do
			compound := c
		end

feature {NONE} -- Analysis

	detect_request_chain
			-- Detect if request chain is required and set `context.has_request_chain'.
		do
			if
				system.is_scoop and then
				attached arguments as a and then
				across a as argument some real_type (argument.item).is_separate end
			then
					-- Record that a request chain is required to lock arguments.
				context.set_has_request_chain
			end
		end

	detect_wait_condition
			-- Check if there are wait conditions and set `context.has_wait_condition'.
		local
			inh_assert: INHERITED_ASSERTION
			has_wait_condition: BOOLEAN
		do
			if context.has_request_chain and then context.origin_has_precondition then
				context.set_assertion_type (In_precondition)
				separate_target_collector.clean
				if attached precondition as p then
						-- There is an immediate precondition.
					p.process (separate_target_collector)
					has_wait_condition := separate_target_collector.has_separate_target
				end
				if not has_wait_condition then
					inh_assert := Context.inherited_assertion
					if inh_assert.has_precondition then
							-- There are inherited preconditions.
						inh_assert.process_precondition (separate_target_collector)
						has_wait_condition := separate_target_collector.has_separate_target
					end
				end
				if has_wait_condition then
					context.set_has_wait_condition
				end
				context.set_assertion_type (0)
			end
		end

feature -- Analyzis

	analyze
			-- Builds a proper context (for C code).
		local
			workbench_mode, keep_assertions: BOOLEAN
			type_i: TYPE_A
			feat: FEATURE_I
			have_precond, have_postcond: BOOLEAN
			inh_assert: INHERITED_ASSERTION
			old_exp: UN_OLD_BL
			l_context: like context
		do
			l_context := context
			workbench_mode := l_context.workbench_mode
			keep_assertions := workbench_mode or else l_context.system.keep_assertions
			feat := l_context.current_feature
				-- Check if request chain is required.
			detect_request_chain
				-- Evaluate assertions if requested or there could be wait conditions.
			if keep_assertions or else context.has_request_chain then
				l_context.set_origin_has_precondition (True)
				inh_assert := l_context.inherited_assertion
				inh_assert.init
				if not l_context.associated_class.is_basic and feat.assert_id_set /= Void then
						--! Do not get inherited pre & post for basic types
					formulate_inherited_assertions (feat.assert_id_set)
				end
			end
			l_context.set_assertion_type (0)

				--| Check if this is a object relative once, since the generated code is using dtype more than once
				--| See ONCE_BYTE_CODE.generate_once_prologue and generate_once_epilogue
			if is_object_relative_once then
				context.add_dt_current
				context.add_dt_current
			end

				-- Local variables should be recorded because their types
				-- are used to evaluate types of object test locals.
			setup_local_variables (False)

				-- Compute presence or not of pre/postconditions
			if keep_assertions then
					-- Assertions are kept on request.
				if l_context.origin_has_precondition then
					have_precond := precondition /= Void or else inh_assert.has_precondition
				end
				have_postcond := postcondition /= Void or else inh_assert.has_postcondition
			end

				-- Check if there is a wait condition.
			detect_wait_condition
				-- Update `have_precond' if there are wait conditions.
			if not have_precond and then context.has_wait_condition then
				have_precond := True
					-- Update `keep_assertions' that is used later to compute if GC hooks are required.
				keep_assertions := True
			end

				-- Enlarge the tree to get some attribute where we
				-- can store information gathered by analyze.
			enlarge_body_tree (have_precond, have_postcond)

				-- Check if we need GC hooks for current body.
			l_context.compute_need_gc_hooks (keep_assertions)

				-- Analyze arguments
			analyze_arguments

				-- Analyze preconditions
			if have_precond then
				if workbench_mode then
					l_context.add_dt_current
				end
				l_context.set_assertion_type (In_precondition)
				if inh_assert.has_precondition then
					inh_assert.analyze_precondition
				end
				if precondition /= Void then
					precondition.analyze
				end
				l_context.set_assertion_type (0)
			end

				-- Analyze postconditions
			if have_postcond then
				if workbench_mode then
					l_context.add_dt_current
				end
				l_context.set_assertion_type (In_postcondition)
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
				l_context.set_assertion_type (0)
			end

				-- If result is expanded or a bit, we need to create it anyway
			if not result_type.is_void then
				type_i := l_context.real_type (result_type)
				if type_i.is_true_expanded then
					l_context.mark_result_used
				else
					l_context.analyze_external_result
				end
			end

			if compound /= Void then
					-- Look for all instances of assignments in Result
					-- in last instructions and set `last_in_result' if
					-- all were such assignments.
				if
					not result_type.is_void and then
					not compound.is_empty and then
					not is_process_or_thread_relative_once
				then
					compound.finish
					compound.item.find_assign_result
					compound.item.mark_last_instruction
				end
				compound.analyze
			end
				-- Analyze postconditions
			if have_postcond then
				l_context.set_assertion_type (In_postcondition)
				if workbench_mode then
					l_context.add_dt_current
				end
				if postcondition /= Void then
					postcondition.analyze
				end
				if inh_assert.has_postcondition then
					inh_assert.analyze_postcondition
				end
				l_context.set_assertion_type (0)
			end
			if
				rescue_clause /= Void and
				not is_object_relative_once
			then
				rescue_clause.analyze
			end
			if exception_stack_managed then
					-- For RTEA call
				l_context.mark_current_used
			end
			if context.final_mode then
				if trace_enabled then
						-- For RTTR
					l_context.add_dt_current
					l_context.add_dftype_current
						-- For RTXT
					l_context.add_dt_current
					l_context.add_dftype_current
				end
				if profile_enabled then
						-- For RTPR and RTXP
					l_context.add_dt_current
					l_context.add_dt_current
				end
			end

		end

	analyze_arguments
			-- Analyze arguments (check for expanded)
		local
			args: like arguments
			i, nb: INTEGER
			arg: TYPE_A
			l_cl_type: CL_TYPE_A
			l_arg: ARGUMENT_BL
			l_is_catcall_checking_enabled, l_enable_hooks: BOOLEAN
			l_name_id, l_any_class_id: INTEGER
			l_context: like context
			l_has_request_chain: BOOLEAN
		do
			args := arguments
			if args /= Void then
				from
					l_context := context
					if l_context.has_request_chain then
							-- We must make sure that `Current' is marked if there is a request chain.
						l_has_request_chain := True
						l_context.mark_current_used
					end

					i := args.lower
					nb := args.count
					if l_context.workbench_mode or system.check_for_catcall_at_runtime then
						l_name_id := l_context.current_feature.feature_name_id
						l_any_class_id := system.any_id
						l_is_catcall_checking_enabled :=
							l_context.current_feature.written_in /= l_any_class_id or
							l_name_id /= {PREDEFINED_NAMES}.equal_name_id or
							l_name_id /= {PREDEFINED_NAMES}.standard_equal_name_id
					end
				until
					i > nb
				loop
					arg := real_type (args.item (i))
					l_enable_hooks := l_has_request_chain and then arg.c_type.is_reference
						-- If we have a request chain then we need to protect references as a request chain may trigger a GC cycle.
					if not l_enable_hooks then
						if l_is_catcall_checking_enabled and then arg.c_type.is_reference then
							l_cl_type ?= args.item (i)
									-- Only generate a catcall detection if the expected argument is different
									-- than ANY since ANY is the ancestor to all types.
							if l_cl_type = Void or else l_cl_type.class_id /= l_any_class_id then
								l_enable_hooks := True
							else
								l_enable_hooks := False
							end
						else
								-- See FIXME of `generate_expanded_initialization'
								-- for possible improvement in the case of `true_expanded'.
							l_enable_hooks := arg.is_true_expanded
						end
					end
					if l_enable_hooks then
							-- Force GC hook and its usage even if not used within
							-- body of current routine.
						l_context.force_gc_hooks
						if l_arg = Void then
							create l_arg
						end
						l_arg.set_position (i)
						l_context.set_local_index (l_arg.register_name, l_arg)
					end
					i := i + 1
				end
			end
		end

	add_in_log (encoded_name: STRING)
		do
			System.used_features_log_file.add (Context.class_type, feature_name, encoded_name)
		end

	generate
			-- Generate C code.
		local
			type_c: TYPE_C
			internal_name: STRING
			name: STRING
			extern: BOOLEAN
			buf: GENERATION_BUFFER
			l_is_process_or_thread_relative_once: BOOLEAN
			return_type_name: STRING
			args: like argument_names
			i: INTEGER
			keep: BOOLEAN
			l_context: like context
		do
			buf := buffer
			l_is_process_or_thread_relative_once := is_process_or_thread_relative_once
			l_context := context
			keep := l_context.workbench_mode or else l_context.system.keep_assertions

				-- Generate the header "int foo(Current, args)"
			type_c := real_type (result_type).c_type

				-- Function's name
			internal_name := generated_c_feature_name

				-- Add entry in the log file
			add_in_log (internal_name)

				-- If it is a once, performs once declaration.
			if l_is_process_or_thread_relative_once then
				generate_once_declaration (internal_name, type_c)
			end

				-- Generate reference to once manifest string field
			generate_once_manifest_string_import

			if rescue_clause /= Void then
				buf.put_new_line_only
				buf.put_string ("#undef EIF_VOLATILE")
				buf.put_new_line_only
				buf.put_string ("#define EIF_VOLATILE volatile")
			end

				-- Generate function signature
			extern := True
			name := internal_name
			if
				l_is_process_or_thread_relative_once and then
				l_context.is_once_call_optimized or else
				context.current_feature.is_attribute
			then
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
			if not type_c.is_void and then l_context.workbench_mode then
				return_type_name := once "EIF_TYPED_VALUE"
			else
				return_type_name := type_c.c_string
			end
			buf.generate_function_signature
				(return_type_name, name, extern,
				 l_context.header_buffer, args, argument_types)

				-- Starting body of C routine
			buf.generate_block_open
			buf.put_gtcx

				-- Declaration of all the local entities, such as
				-- Eiffel local variables, Result, temporary registers...
			generate_execution_declarations
			generate_locals

				-- Declare variables required for once routines.
			generate_once_data (internal_name)

				-- Ensure the arguments are of the expected type
			generate_argument_checks

				-- Clone expanded parameters.
			generate_expanded_initialization

				-- Before entering in the code generate GC hooks, i.e. pass
				-- the addresses of all the reference variables.
			l_context.generate_gc_hooks (False)

				-- Record the locals, arguments and Current address for debugging.
			l_context.generate_push_debug_locals (result_type, arguments)

				-- Separate declaration from the rest.
			buf.put_new_line

				-- Generate execution trace information (RTEAA)
			generate_execution_trace

				-- Generate the saving of the assertion level
			if keep then
				generate_save_assertion_level
			end

				-- Generate monitoring start for profiling and tracing
			generate_monitoring_start

				-- Generate GC synchronization macro
			if not is_external and l_context.need_gc_hook then
					-- No need to generate a synchronization point before
					-- calling an external or a small routine that does not
					-- have GC hooks as it could mess up the references to
					-- Eiffel object that this routine might have.
					-- For blocking externals, if it is needed, then it is
					-- using the `blocking' keyword in its specification.
				buf.put_new_line
				buf.put_string ("RTGC;")
			end

				-- Allocate memory for once manifest strings if required
			l_context.generate_once_manifest_string_allocation (once_manifest_string_count)

				-- Record enter feature execution
			generate_rtdbgd_enter

				-- Check cat calls
			generate_catcall_check

				-- Generate variables for used in request chain generation (for SCOOP).
			generate_control_information

				-- Generate code to lock separate arguments in a request group. (for SCOOP).
			generate_request_group_initialization

				-- Precondition check generation
			generate_precondition
			if l_context.has_chained_prec then
					-- For chained precondition (to implement or else...)
				l_context.generate_body_label
			end


			if not is_object_relative_once then
					-- If necessary, generate the once stuff (i.e. check if
					-- the value of the once was already set within the same
					-- thread).  That way we do not enter the body of the
					-- once if it has already been done. Preconditions,
					-- if any, are tested for all calls.
				generate_once_prologue (internal_name)
			end

				-- Generate old variables
			generate_old_variables

			if not is_object_relative_once then
				generate_rescue_prologue
			end

				-- Generate local expanded variable creations
			generate_expanded_variables

				-- Now we want the body
			generate_compound

				-- Now the postcondition
			generate_postcondition

				-- Restore the caller_assertion_level
			if keep then
				buf.put_new_line
				buf.put_string ("RTRS;")
			end

			if not type_c.is_void then
					-- Function returns something. This can be done
					-- by inner returns, so have some mercy
					-- for lint and highlight the NOTREACHED status...
				generate_return_not_reached
			end

			if not is_object_relative_once then
				-- If there is a rescue clause, generate it now...
				generate_rescue

					-- Generate termination for once routine
				generate_once_epilogue (generated_c_feature_name)
			end

			if compound = Void or else compound.is_empty or else not compound.last.last_all_in_result then
					-- Remove the GC hooks we've been generated.
				finish_compound
					-- Generate final "return Result", if required.
				generate_return_exp
			end

				-- Undefines all macros defined for temporary locals.
			context.generate_temporary_ref_macro_undefintion

				-- End of C function
			if l_is_process_or_thread_relative_once then
				buf.put_new_line_only
				buf.put_string ("#undef Result")
			end

			if l_context.workbench_mode then
				from
					i := argument_count
				until
					i <= 0
				loop
					buf.put_new_line_only
					buf.put_string ("#undef arg")
					buf.put_integer (i)
					i := i - 1
				end
			end
			buf.generate_block_close

			if rescue_clause /= Void then
				buf.put_new_line_only
				buf.put_string ("#undef EIF_VOLATILE")
				buf.put_new_line_only
				buf.put_string ("#define EIF_VOLATILE")
			end

				-- Leave a blank line after function definition
			buf.put_new_line

			if l_is_process_or_thread_relative_once and then l_context.is_once_call_optimized then
					-- Generate optimized stub for once routine.
				buf.generate_function_signature
					(return_type_name, internal_name, True,
					 l_context.header_buffer, args, argument_types)
				buf.generate_block_open
				buf.put_gtcx
				buf.put_new_line
				if not type_c.is_void then
					buf.put_string ("return ")
				end
				l_context.generate_once_optimized_call_start (type_c, body_index, is_process_relative_once, is_object_relative_once, buf)
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
				buf.put_string ("));")
				buf.generate_block_close
				buf.put_new_line
			end

			l_context.inherited_assertion.wipe_out

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

	generate_compound
			-- Generate the function compound
		do
			if attached compound as c then
				c.generate
			end
		end

	generate_return_not_reached
			-- Generate a mark that the final return is not reached.
		local
			assignment: ASSIGN_B
			buf: GENERATION_BUFFER
		do
			if
				attached compound as c and then
				not c.is_empty
			then
				c.finish
					-- If ALL the last statements were assignments in result,
					-- generate a NOTREACHED for lint when last statement was
					-- not of type assignment. Otherwise, the return
					-- statements have already been generated.
				if c.item.last_all_in_result then
					assignment ?= c.item
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

	generate_return_exp
			-- Generate the return expression
		local
			type_c: TYPE_C
			buf: GENERATION_BUFFER
		do
				-- Do not forget to remove the GC hooks before returning
				-- if they have already been generated. For instance, when
				-- generating return for a once function, hooks have not
				-- been generated.
			if not result_type.is_void then
				type_c := real_type (result_type).c_type
				buf := buffer
				buf.put_new_line
				if context.workbench_mode then
						-- Note: in workbench, we always return the result. It may
						--       have been changed by the user (see class EDIT_ITEM)
					buf.put_string (once "{ EIF_TYPED_VALUE r; r.")
					type_c.generate_typed_tag (buf)
					buf.put_string (once "; r.")
					type_c.generate_typed_field (buf)
					buf.put_string (once " = Result; return r; }")
				else
					buf.put_string (once "return ")
						-- If Result was used, generate it. Otherwise, its value
						-- is simply the initial one (i.e. generic 0).
					if context.result_used then
						buf.put_string (once "Result;")
					else
						type_c.generate_cast (buf)
						buf.put_two_character ('0', ';')
					end
				end
			end
		end -- generate_return_exp

	generate_once_declaration (a_name: STRING; a_type: TYPE_C)
			-- Generate static variable and their declarations used by
			-- generation of opimized once functions.
		require
			a_name_not_void: a_name /= Void
			a_type_not_void: a_type /= Void
		do
		end

	generate_once_data (a_name: STRING)
			-- Generate data for once routines.
		require
			a_name_not_void: a_name /= Void
		do
		end

	generate_once_prologue (a_name: STRING)
			-- Generate start of a once block that will ensure that body is not re-executed.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
		end

	generate_once_epilogue (a_name: STRING)
			-- Generate end of a once block.
		require
			a_name_not_void: a_name /= Void
		do
		end

	generate_argument_initialization
			-- Generate declaration for locals `earg' that will hold a copy of passed
			-- arguments.
		local
			t: TYPE_A
			l_arguments: like arguments
			i, nb: INTEGER
			l_buf: like buffer
			l_arg_name: STRING
			l_class_type: CLASS_TYPE
			w: BOOLEAN
		do
			l_arguments := arguments
			if l_arguments /= Void then
				from
					i := l_arguments.lower
					nb := l_arguments.upper
					l_buf := buffer
					w := context.workbench_mode
				until
					i > nb
				loop
					t := real_type (l_arguments.item (i))
					if w then
							-- Generate definitions for arguments that are passed
						l_buf.put_new_line_only
						l_buf.put_string ("#define arg")
						l_buf.put_integer (i)
						l_buf.put_four_character (' ', 'a', 'r', 'g')
						l_buf.put_integer (i)
						l_buf.put_two_character ('x', '.')
						t.c_type.generate_typed_field (l_buf)
					end
					if attached {CL_TYPE_A} t as l_type and then l_type.is_true_expanded then
						create l_arg_name.make (6)
						l_arg_name.append ("sarg")
						l_arg_name.append_integer (i)
						l_class_type := l_type.associated_class_type (context.context_class_type.type)
						l_class_type.generate_expanded_structure_declaration (l_buf, l_arg_name)
						l_buf.put_new_line
						l_buf.put_string ("EIF_REFERENCE earg")
						l_buf.put_integer (i)
						l_buf.put_string (" = (EIF_REFERENCE) ")
						l_buf.put_string (l_arg_name)
						l_buf.put_string (".data")
						l_buf.put_character (';')
						l_buf.put_new_line
					elseif context.has_request_chain and then t.is_separate then
							-- Declare a variable that tells whether an argument is uncontrolled.
						l_buf.put_new_line
						l_buf.put_string ("EIF_BOOLEAN uarg")
						l_buf.put_integer (i)
						l_buf.put_character (';')
					end
					i := i + 1
				end
				if context.has_request_chain then
						-- Declare a variable that tells whether a request chain is required.
					l_buf.put_new_line
					l_buf.put_string ("EIF_BOOLEAN uarg;")
				end
			end
		end

	generate_expanded_initialization
			-- Clone expanded parameters and initialize local expanded objects.
		local
			l_adapted_type: CL_TYPE_A
			l_type: TYPE_A
			i, count: INTEGER
			buf: GENERATION_BUFFER
			l_list: ARRAY [TYPE_A]
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
					l_type := l_list.item (i)
					l_adapted_type ?= real_type (l_type)
					if l_adapted_type /= Void and then l_adapted_type.is_true_expanded then
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
						buf.put_string ("memcpy (&sarg")
						buf.put_integer (i)
						buf.put_string (".overhead, HEADER(arg")
						buf.put_integer (i)
						buf.put_string ("), ")
						l_class_type := l_adapted_type.associated_class_type (context.context_class_type.type)
						if context.workbench_mode then
							l_class_type.skeleton.generate_workbench_size (buf)
						else
							l_class_type.skeleton.generate_size (buf, True)
						end
						l_class_type.generate_expanded_overhead_size (buf)
							-- We reset the flags since now we have an expanded on the C stack,
							-- thus it cannot move hence the EO_STACK flag.
						buf.put_string (");")
						buf.put_new_line
						buf.put_string ("sarg")
						buf.put_integer (i)
						buffer.put_string (".overhead.ov_flags = EO_EXP | EO_STACK")
						if l_class_type.has_creation_routine then
								-- Class has an expanded attribute we need to give it the EO_COMP flag.							
							buffer.put_string (" | EO_COMP;")
						else
							buffer.put_character (';')
						end
						buf.put_new_line
						buf.put_string ("sarg")
						buf.put_integer (i)
						buffer.put_string (".overhead.ov_size = 0;")
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
					l_type := l_list.item (i)
					l_adapted_type ?= real_type (l_type)
					if l_adapted_type /= Void and then l_adapted_type.is_true_expanded then
							-- FIXME: Manu: 05/12/2004: if local is not
							-- used and if associated type does not redefine `default_create'
							-- then we could skip this call for more efficiency.

							-- First we reset the memory to `0'.
						create l_loc_name.make (6)
						l_loc_name.append ("sloc")
						l_loc_name.append_integer (i)

						buf.put_new_line
						buf.put_string ("memset (&")
						buf.put_string (l_loc_name)
						buf.put_string (".overhead, 0, OVERHEAD + ")
						l_class_type := l_adapted_type.associated_class_type (context.context_class_type.type)
						if context.workbench_mode then
							l_class_type.skeleton.generate_workbench_size (buf)
						else
							l_class_type.skeleton.generate_size (buf, True)
						end
						buf.put_string (");")

							-- Then we update the type information
						l_class_type.generate_expanded_type_initialization (buf, l_loc_name, l_type, context.class_type)
					end
					i := i + 1
				end
			end
		end

	generate_expanded_variables
			-- Create local expanded variables and Result
		local
			i, count: INTEGER
			type_i: TYPE_A
			used_upper: INTEGER
			l_buffer: like buffer
			is_workbench: BOOLEAN
			l_class_type: CLASS_TYPE
			l_name: STRING
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
							l_class_type := type_i.associated_class_type (context.context_cl_type)
							l_name := local_var.register_name
							l_class_type.generate_expanded_initialization (l_buffer, l_name, l_name, True)
						end
					end
					i := i + 1
				end
			end
			if context.result_used then
				type_i := real_type (result_type)
				if type_i.is_true_expanded then
						-- If we have a C external returning an expanded, we let the external
						-- create the expanded, and if it fails then it will perform the allocation
						-- after calling it (done in {EXT_BYTE_CODE}.generate_return_exp).
					if not is_external then
						l_class_type := type_i.associated_class_type (context.context_class_type.type)
						l_name := context.result_register.register_name
						l_class_type.generate_expanded_creation (l_buffer, l_name, result_type, context.context_class_type)
						l_class_type.generate_expanded_initialization (l_buffer, l_name, l_name, True)
					end
				end
			end
		end

	generate_locals
			-- Declare C local variables
		local
			i: INTEGER
			buf: GENERATION_BUFFER
			wkb_mode: BOOLEAN
			has_rescue: BOOLEAN
			l_is_process_or_thread_relative_once: BOOLEAN
		do
				-- Cache accessed attributes
			buf := buffer
			wkb_mode := context.workbench_mode
			has_rescue := rescue_clause /= Void
			l_is_process_or_thread_relative_once := is_process_or_thread_relative_once

			context.generate_local_declaration (local_count, has_rescue)

				-- Generate local declaration for storing exception object.
			if has_rescue then
				buf.put_new_line
				buf.put_string ("EIF_REFERENCE EIF_VOLATILE saved_except = (EIF_REFERENCE) 0;")
				context.set_local_index ("saved_except", create {NAMED_REGISTER}.make ("saved_except", reference_c_type))
			end

			generate_argument_initialization

			context.generate_request_chain_declaration

				-- Generate temporary locals under the control of the GC
			context.generate_temporary_ref_variables

				-- Result is declared only if needed. For onces, it is
				-- accessed via a key allowing us to have them per thread.
			if (not result_type.is_void) and then (wkb_mode or else context.result_used or else is_object_relative_once) then
				generate_result_declaration (has_rescue and then not wkb_mode)
			end

				-- Generate dynamic type of Current.
			context.generate_dtype_declaration (l_is_process_or_thread_relative_once)

			if wkb_mode or else context.system.keep_assertions then
					-- Generate the int local variable saving the global `nstcall'.
				buf.put_new_line
				buf.put_string ("RTSN;")
					-- Generate local variable for assertion level of the current object.
				buf.put_new_line
				buf.put_string ("RTDA;")
			end

			if wkb_mode and then has_rescue then
				buf.put_new_line
				buf.put_string ("RTDT;")
			end
				-- The local variable array is then declared, based on the
				-- number of reference variable which need to be placed under
				-- GC control (given by `ref_var_used').
			i := context.ref_var_used
			if i > 0 then
				buf.put_new_line
				buf.put_string ("RTLD;")
				if has_rescue then
					buf.put_new_line
					buf.put_string ("RTXD;")
				end
			end

				-- Declare the variable local "backup" stack.
			if wkb_mode and then has_rescue then
				buf.put_new_line
				buf.put_string ("RTLXD;")
			end
				-- Separate declarations and body with a blank line
			buf.put_new_line
		end

	generate_argument_checks
			-- Generate checks that ensure that arguments are of the expected type.
		local
			i: INTEGER
			types: like arguments
			c_type: TYPE_C
			buf: like buffer
		do
			if context.workbench_mode then
				i := argument_count
				if i > 0 then
					from
						buf := buffer
						types := arguments
					until
						i <= 0
					loop
						c_type := context.real_type (types [i]).c_type
						if not c_type.is_reference then
								-- The argument type is not reference, so it might be boxed.
							buf.put_new_line
							buf.put_string ("if ((arg")
							buf.put_integer (i)
							buf.put_string ("x.type & SK_HEAD) == SK_REF) arg")
							buf.put_integer (i)
							buf.put_two_character ('x', '.')
							c_type.generate_typed_field (buf)
							buf.put_five_character (' ', '=', ' ', '*', ' ')
							c_type.generate_access_cast (buf)
							buf.put_four_character (' ', 'a', 'r', 'g')
							buf.put_integer (i)
							buf.put_two_character ('x', '.')
							reference_c_type.generate_typed_field (buf)
							buf.put_character (';')
						end
						i := i - 1
					end
					buf.put_new_line
				end
			end
		end

	generate_result_declaration (may_need_volatile: BOOLEAN)
			-- Generate the declaration of the Result entity
		local
			ctype: TYPE_C
			type_i: TYPE_A
			buf: GENERATION_BUFFER
		do
			if not is_process_or_thread_relative_once then
				buf := buffer
				type_i := real_type (result_type)
				ctype := type_i.c_type
				buf.put_new_line
				if may_need_volatile and then type_i.is_basic then
					buf.put_string ("EIF_VOLATILE ")
				end
				ctype.generate (buf)
				buf.put_character (' ')
				buf.put_string ({C_CONST}.result_name)
				buf.put_three_character (' ', '=', ' ')
				ctype.generate_default_value (buffer)
				buf.put_character (';')
				buf.put_new_line
			end
		end

	init_dftype
			-- Initializes the value of 'dftype' in once routines. For regular
			-- ones, the variable is initialized directly in the declaration.
		local
			buf: GENERATION_BUFFER
		do
			if context.dftype_current > 1 then
				buf := buffer
				buf.put_new_line
				buf.put_string ("dftype = Dftype(Current);")
			end
		end

	init_dtype
			-- Initializes the value of 'dtype' in once routines. For regular
			-- ones, the variable is initialized directly in the declaration.
		local
			buf: GENERATION_BUFFER
		do
			if context.dt_current > 1 then
				buf := buffer
				buf.put_new_line
				buf.put_string ("dtype = Dtype(Current);")
			end
		end

	generate_once_manifest_string_import
			-- Generate declarations for once manifest strings that are used in the routine.
		local
			a: INHERITED_ASSERTION
			w: BOOLEAN
		do
			context.generate_once_manifest_string_import (once_manifest_string_count)
			a := Context.inherited_assertion
			w := context.workbench_mode or else context.system.keep_assertions
				-- Figure out if there are inherited preconditions.
				-- Preconditions are always generated in workbench mode.
				-- In finalized mode they are generated if requested by user
				-- or when there are uncontrolled arguments.
			if
				context.origin_has_precondition and then
				a.has_precondition and then
				(w or else context.has_wait_condition)
			then
					-- Generate once manifest string declarations for inherited preconditions.
				context.set_assertion_type (in_precondition)
				a.generate_precondition_import
				context.set_assertion_type (0)
			end
				-- Figure out if there are inherited postconditions.
			if w and then a.has_postcondition then
					-- Generate once manifest string declarations for inherited postconditions.
				context.set_assertion_type (in_postcondition)
				a.generate_postcondition_import
				context.set_assertion_type (0)
			end
		end

	generate_precondition
			-- Generate precondition check if needed
		local
			workbench_mode: BOOLEAN
			have_assert: BOOLEAN
			inh_assert: INHERITED_ASSERTION
			buf: GENERATION_BUFFER
			has_wait_condition: BOOLEAN
		do
			buf := buffer
				-- Generate class invariant if requried.
			generate_invariant_before
			context.set_assertion_type (In_precondition)
				-- Figure out if there are preconditions and wait conditions.
			inh_assert := Context.inherited_assertion
			has_wait_condition := context.has_wait_condition
			if Context.origin_has_precondition then
				have_assert := attached precondition or else inh_assert.has_precondition
			end
			if has_wait_condition then
					-- There are wait conditions.
					-- If they fail, the precondition needs to be re-eveluated.
					-- The generated code looks like
					--    for (;;) {
					--       int has_wait_condition = 0
					--       ... // Allocate request chain (see below).
					--       ... // Evaluate preconditions and set has_wait_condition if wait conditions are involved.
					--       if (!has_wait_condition) break;
					--       RTCK; // Remove a stack item pushed when entering a precondition.
					--       RTS_SRF (Current); // Free request chain to let the scheduler reschedule this call.
					--    }
					--    RTCF; // Raise exception
				buf.put_new_line
				buf.put_string ("for (;;) {")
				buf.indent
				buf.put_new_line
				buf.put_string ("int has_wait_condition = 0;")
			end
			workbench_mode := context.workbench_mode
				-- Preconditions are always generated in workbench mode.
				-- In finalized mode they are generated if requested by user
				-- or when there are uncontrolled arguments.
			if
				have_assert and then
				(workbench_mode or else context.system.keep_assertions or else has_wait_condition)
			then
					-- Precondition has to be checked all the time if there is a wait condition..
				if not context.has_request_chain then
						-- The precondition is checked on demand only.
					buf.put_new_line
					buf.put_string ("if ((RTAL & CK_REQUIRE) || RTAC) {")
					buf.indent
				end

				if inh_assert.has_precondition then
					inh_assert.generate_precondition
				end

				if precondition /= Void then
					Context.set_new_precondition_block (True)
					precondition.generate
				end

				buf.put_new_line
				buf.put_string ("RTJB;")
				Context.generate_current_label_definition

				if has_wait_condition then
						-- End part of the loop that checks wait conditions.
					buf.put_new_line
					buf.put_string ("if (!has_wait_condition) break;")
					buf.put_new_line
					buf.put_string ("RTCK;")
					context.generate_request_chain_wait_condition_failure
					buf.generate_block_close
				end
				buf.put_new_line
				buf.put_string ("RTCF;")
				if not context.has_request_chain then
						-- Close on-demand check block.
					buf.generate_block_close
				end
			end
			context.set_assertion_type (0)
		end

	generate_postcondition
			-- Generate postcondition check if needed
		local
			workbench_mode: BOOLEAN
			have_assert: BOOLEAN
			inh_assert: INHERITED_ASSERTION
			buf: GENERATION_BUFFER
		do
			workbench_mode := context.workbench_mode
			if workbench_mode or else context.system.keep_assertions then
				inh_assert := Context.inherited_assertion
				have_assert := postcondition /= Void or else inh_assert.has_postcondition
				if have_assert then
					buf := buffer
					context.set_assertion_type (In_postcondition)
					buffer.put_new_line
					buf.put_string ("if (RTAL & CK_ENSURE) {")
					buf.indent

					if inh_assert.has_postcondition then
						inh_assert.generate_postcondition
					end
					if postcondition /= Void then
						postcondition.generate
					end
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
					if context.current_feature.is_failing then
							-- Postcondition violation should be triggered in any case
							-- because the compiler expects this routine to fail.
						buf.put_new_line
						buf.put_string ("RTEC (EN_POST);")
					end
					context.set_assertion_type (0)
				end
				generate_invariant_after
			elseif context.current_feature.is_failing then
					-- Postcondition violation should be triggered in any case
					-- because the compiler expects this routine to fail.
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTEC (EN_POST);")
			end
		end

	generate_save_assertion_level
			-- Generate the instruction for saving the workbench mode
			-- assertion level of the current object.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("RTSA(")
			context.generate_current_dtype
			buf.put_two_character (')', ';')
			buf.put_new_line
			buf.put_string ("RTSC;")
		end

	generate_invariant_before
			-- Generate invariant check at the entry of the routine.
		do
			generate_invariant ("RTIV")
		end

	generate_invariant_after
			-- Generate invariant check at the end of the routine.
		do
			generate_invariant ("RTVI")
		end

	generate_invariant (tag: STRING)
			-- Generate invariant check with tag `tag'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if context.workbench_mode or else context.system.keep_assertions then
				buf.put_new_line;
				buf.put_string (tag)
				buf.put_character ('(')
				context.current_register.print_register
				buf.put_string (", RTAL);")
			end
		end

	generate_rescue_prologue
			-- Generate a `setjmp' C instruction in case of a
			-- rescue clause
		local
			buf: GENERATION_BUFFER
		do
			if rescue_clause /= Void then
				buf := buffer
					-- Generate a `setjmp' C instruction in case of a
					-- rescue clause
				if context.final_mode then
					if trace_enabled then
						buf.put_new_line
						buf.put_string ("RTTI;")
					end
					if profile_enabled then
						buf.put_new_line
						buf.put_string ({C_CONST}.rtpi)
						buf.put_character (';')
					end
				end
				buf.put_new_line
				buf.put_string ("RTE_T")
			end
		end

	generate_rescue
			-- Generate the rescue clause
		local
			buf: GENERATION_BUFFER
		do
			if rescue_clause = Void then
				context.generate_external_result_check
			else
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTE_E")
					-- Restore the C operational stack
				if context.workbench_mode then
					buf.put_new_line
					buf.put_string ("RTLXE;")
				end
					-- Resynchronize local variables stack
				buf.put_new_line
				buf.put_string ("RTXSC;")
				context.generate_request_chain_restore
				rescue_clause.generate
				generate_monitoring_stop
				buf.put_new_line
				buf.put_string ("/* NOTREACHED */")
				buf.put_new_line
				buf.put_string ("RTE_EE")
			end
		end

	exception_stack_managed: BOOLEAN
			-- Do we have to manage the exception stack
		do
			Result :=
				context.workbench_mode or else
				System.exception_stack_managed or else
				context.is_result_checked
		end

	generate_execution_declarations
			-- Generate the declarations needed for exception trace, profiling and tracing handling
		local
			buf: GENERATION_BUFFER
			l_count: INTEGER
		do
			buf := buffer
			if context.workbench_mode then
					-- We always buffer the routine name.
				l_count := 2
			else
				if exception_stack_managed then
					l_count := 1
				end
				if trace_enabled then
					l_count := l_count + 1
				end
				if profile_enabled then
					l_count := l_count + 1
				end
				if system.check_for_catcall_at_runtime then
					l_count := l_count + argument_count
				end
			end
			if l_count > 1 then
				context.set_has_feature_name_stored (True)
				buf.put_new_line
				buf.put_string ("char *")
				buf.put_string ({BYTE_CONTEXT}.feature_name_local)
				buf.put_three_character (' ', '=', ' ')
				buf.put_string_literal (feature_name)
				buf.put_character (';')
			else
				context.set_has_feature_name_stored (False)
			end
			if exception_stack_managed or else rescue_clause /= Void or else is_once then
				buf.put_new_line
				buf.put_string ("RTEX;")
				if rescue_clause /= Void then
					buf.put_new_line
					buf.put_string ("RTED;")
						-- We only need this for finalized mode...
					if context.final_mode then
						if trace_enabled then
							buf.put_new_line
							buf.put_string ("RTLT;")
						end
						if profile_enabled then
							buf.put_new_line
							buf.put_string ({C_CONST}.rtlp)
							buf.put_character (';')
						end
					end
				end
			end
		end

	generate_execution_trace
			-- Generate the execution trace stack handling
		do
			if exception_stack_managed then
				generate_stack_macro ("RTEAA")
			elseif rescue_clause /= Void or else is_once then
					-- Prepare execution stack to catch exceptions
					--   explicitly by a rescue clause
					--   implicitly by a code of once routine
				buffer.put_new_line
				buffer.put_string ("RTEV;")
			end
		end

	generate_rtdbgd_enter
			-- Generate the execution recording for enter feature
		local
			buf: GENERATION_BUFFER
		do
			if context.workbench_mode then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTDBGEAA")
				buf.put_character ('(')
				feature_origin (buf)
				buf.put_string ({C_CONST}.comma_space)
				context.current_register.print_register
				buf.put_string ({C_CONST}.comma_space)
				buf.put_real_body_id (real_body_id)
				buf.put_two_character (')', ';')
			end
		end

	generate_rtdbgd_leave
			-- Generate the execution recording for leave feature
		local
			buf: GENERATION_BUFFER
		do
			if context.workbench_mode then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTDBGLE;")
			end
		end

	generate_pop_execution_trace
			-- Generate the execution trace stack handling at the end of the
			-- routine
		local
			buf: GENERATION_BUFFER
		do
			if rescue_clause = Void and then (exception_stack_managed or else is_once) then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTEE;")
			end
		end

	trace_enabled: BOOLEAN
			-- Is the trace enabled for the associated class in final mode?
		require
			in_final_mode: context.final_mode
		do
			Result := Context.associated_class.trace_level.is_yes
		end

	profile_enabled: BOOLEAN
			-- Is the profile enabled for the associated class in final mode?
		require
			in_final_mode: context.final_mode
		do
			Result := Context.associated_class.profile_level.is_yes
		end

	generate_monitoring_start
			-- Generate the start of various monitoring facilities.
		local
			buf: like buffer
		do
			if context.workbench_mode then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTME(")
				context.generate_current_dtype
				buf.put_two_character (',', ' ')
					-- Externals routines cannot perform tracing
					-- as it could invalidate pointer values that correspond
					-- to Eiffel object via the $ operator (see eweasel test#exec333)
				if is_external then
					buf.put_integer (1)
				else
					buf.put_integer (0)
				end
				buf.put_two_character (')', ';')
			else
				if trace_enabled and not is_external then
					generate_option_macro ("RTTR", True)
				end
				if profile_enabled then
					generate_option_macro ("RTPR", False)
				end
			end
		end

	generate_monitoring_stop
			-- Generate the stop of various monitoring facilities.
		local
			buf: like buffer
		do
			if context.workbench_mode then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTMD(")
					-- Externals routines cannot perform tracing
					-- as it could invalidate pointer values that correspond
					-- to Eiffel object via the $ operator (see eweasel test#exec333)
				if is_external then
					buf.put_integer (1)
				else
					buf.put_integer (0)
				end
				buf.put_two_character (')', ';')
			else
				if trace_enabled and not is_external then
					generate_option_macro ("RTXT", True)
				end
				if profile_enabled then
					buffer.put_new_line
					buffer.put_string ("RTXP;")
				end
			end
		end

	generate_option_macro (macro_name: STRING; has_dftype: BOOLEAN)
			-- Generate an option macro call will the feature name, the feature origin
			-- and the "dynamic type" of `Current' as arguments and its full dynamic type if requested.
		require
			dtype_added: context.dt_current > 1
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string (macro_name)
			buf.put_character ('(')
			context.generate_feature_name (buf)
			buf.put_string ({C_CONST}.comma_space)
			feature_origin (buf)
			buf.put_string ({C_CONST}.comma_space)
			buf.put_string ({C_CONST}.dtype_name)
			if has_dftype then
				buf.put_string ({C_CONST}.comma_space)
				buf.put_string ({C_CONST}.dftype_name)
			end
			buf.put_two_character (')', ';')
		end

	generate_stack_macro (macro_name: STRING)
			-- Generate a macro call will the feature name, the feature origin,
			-- `Current', the number of locals, the number of arguments and the
			-- real body id of the feature as arguments.
		require
			has_exception_stack: exception_stack_managed
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string (macro_name)
			buf.put_character ('(')
			context.generate_feature_name (buf)
			buf.put_string ({C_CONST}.comma_space)
			feature_origin (buf)
			buf.put_string ({C_CONST}.comma_space)
			context.Current_register.print_register
			buf.put_string ({C_CONST}.comma_space)
			buf.put_integer (context.local_list.count)
			buf.put_string ({C_CONST}.comma_space)
			if arguments /= Void then
				buf.put_integer (arguments.count)
			else
				buf.put_integer (0)
			end
			buf.put_string ({C_CONST}.comma_space)
			buf.put_real_body_id (real_body_id)
			buf.put_two_character (')', ';')
		end

	finish_compound
			-- Generate the end of the compound routine
		do
				-- Generate the hook corresponding to the end of the feature ("end;")
			generate_frozen_debugger_hook

			generate_rtdbgd_leave

				-- Stop monitoring before releasing the GC hooks
			generate_monitoring_stop

				-- Release request chain.
			release_request_chain

				-- Generate the remove of the GC hooks
			context.remove_gc_hooks
				-- Generate the update of the locals stack used to debug in C
			context.generate_pop_debug_locals (arguments)
				-- Generate the update of the trace stack before quitting
				-- the routine
			generate_pop_execution_trace
		end

	generate_catcall_check
			-- Add a check for catcall at runtime.
		local
			i, nb: INTEGER
			l_argument_types: like arguments
			l_type: TYPE_A
			l_any_type: CL_TYPE_A
			l_any_class_id, l_name_id: INTEGER
			l_arg: ARGUMENT_BL
			l_optimize_like_current: BOOLEAN
		do
			l_argument_types := arguments
			if l_argument_types /= Void and then context.workbench_mode or system.check_for_catcall_at_runtime then
				nb := l_argument_types.count
				if nb > 0 then
						-- We do not have to generate a catcall detection for some features of ANY
						-- which are properly handled at runtime.
					l_name_id := context.current_feature.feature_name_id
					l_any_class_id := system.any_id
					if
						context.current_feature.written_in /= l_any_class_id or else
						(l_name_id /= {PREDEFINED_NAMES}.equal_name_id or
						l_name_id /= {PREDEFINED_NAMES}.standard_equal_name_id)
					then
						from
							i := l_argument_types.lower
						until
							i > nb
						loop
							l_type := l_argument_types [i]
								-- We instantiate `l_type' in current context to see if it is
								-- really a reference
							if context.real_type (l_type).c_type.is_reference then
								l_any_type ?= l_type
									-- Only generate a catcall detection if the expected argument is different
									-- than ANY since ANY is the ancestor to all types.
								if l_any_type = Void or else l_any_type.class_id /= l_any_class_id then
									if l_arg = Void then
										create l_arg
											-- See eweasel test#catcall006 and test#incr330 for a case where it is important
											-- to detect such assignments.
											-- See eweasel test#catcall006 and test#incr330 for a case where it is important
											-- to detect such assignments.
										l_optimize_like_current := not attribute_assignment_detector.has_attribute_assignment (Current)
									end
									l_arg.set_position (i)
									context.generate_catcall_check (l_arg, l_type, i, l_optimize_like_current)
								end
							end
							i := i + 1
						end
					end
				end
			end
		end

feature {NONE} -- C code generation

	release_request_chain
			-- Generate code to release request chain if required.
		do
			if context.has_request_chain then
				buffer.put_new_line
				buffer.put_string ("if (uarg) ")
				buffer.generate_construct_block_open
				context.generate_request_chain_removal
				buffer.generate_block_close
			end
		end

	generate_control_information
			-- Generate code to compute information about controlled and uncontrolled arguments.
		local
			i: INTEGER
			nb: INTEGER
			l_buf: GENERATION_BUFFER
			uarg: STRING
		do
			if attached arguments as a and then context.has_request_chain then
				from
						-- The variable that tells if an argument is uncontrolled
						-- is generated in the form "uargK = (EIF_BOOLEAN) RTS_OU (argK);"
						-- The variable to detect if a request chain is required
						-- is generated in the form "uarg = uargA || uargB || ... || uargZ;".
					uarg := ""
					i := a.lower
					nb := a.upper
					l_buf := buffer
				until
					i > nb
				loop
					if real_type (a [i]).is_separate then
							-- Initialize a variable that tells whether an argument is uncontrolled.
						l_buf.put_new_line
						l_buf.put_string ("uarg")
						l_buf.put_integer (i)
						l_buf.put_string (" = (EIF_BOOLEAN) RTS_OU (arg")
						l_buf.put_integer (i)
						l_buf.put_two_character (')', ';')
							-- Update expression to compute a variable that tells whether a request chain is required.
						if uarg.is_empty then
								-- This is the first factor of "uarg" expression.
							uarg := "uarg = uarg"
						else
								-- This is the next factor of "uarg" expression.
							uarg.append_string (" || uarg")
						end
						uarg.append_integer (i)
					end
					i := i + 1
				end
				l_buf.put_new_line
				l_buf.put_string (uarg)
				l_buf.put_character (';')
			end
		end

	generate_request_group_initialization
			-- Generate code to lock separate arguments in a request group.
		local
			buf: like buffer
			i: INTEGER
		do
			buf := buffer
			if attached arguments as a and then context.has_request_chain then
					-- There are separate arguments.
					-- They should be locked if they are not controlled yet.
					-- Locking is done for all the uncontrolled arguments at once.
					-- A request group is created for that.
					-- If argument is controlled, there is no need to lock it again.
					-- The generated code looks like
					--    if (uarg) {
					--       RTS_RC[X];     // Create request chain.
					--       RTS_RS (argN); // Register argument in the chain.
					--       ...            // Repeat for other arguments.
					--       RTS_RW;        // Wait until all arguments are locked.
					--    }
				buf.put_new_line
				buf.put_string ("if (uarg) ")
				buf.generate_construct_block_open
				context.generate_request_chain_creation
				from
					i := a.count
				until
					i <= 0
				loop
					if real_type (a [i]).is_separate then
							-- Register uncontrolled argument in the request chain.
						buf.put_new_line
						buf.put_string ("RTS_RS (arg")
						buf.put_integer (i)
						buf.put_two_character (')', ';')
					end
					i := i - 1
				end
				buf.put_new_line
				buf.put_string ("RTS_RW;");
				buf.generate_block_close
			end
		end

feature -- Byte code generation

	make_body_code (ba: BYTE_ARRAY; a_generator: MELTED_GENERATOR)
			-- Generate compound byte code
		local
			inh_assert: INHERITED_ASSERTION
		do
				-- Allocate memory for once manifest strings if required
			context.make_once_string_allocation_byte_code (ba, context.byte_code.once_manifest_string_count)

				-- Generate catcall check
			make_catcall_check (ba)

			inh_assert := Context.inherited_assertion
			if Context.origin_has_precondition and then (precondition /= Void or else inh_assert.has_precondition) then
				context.set_assertion_type (In_precondition)
				ba.append (Bc_precond)
				ba.mark_forward

				if inh_assert.has_precondition then
					inh_assert.make_precondition_byte_code (a_generator, ba)
				end

				if precondition /= Void then
					Context.set_new_precondition_block (True)
					a_generator.generate (ba, precondition)
				end

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
				context.set_assertion_type (0)
			end

			if old_expressions /= Void or else inh_assert.has_old_expression then
				context.set_assertion_type (In_postcondition)
				ba.append (Bc_start_eval_old)
					-- Mark offset for the end of old expression evaluation.
				ba.mark_forward
					-- Mark offset for next BC_OLD
				ba.mark_forward

				if postcondition /= Void and then old_expressions /= Void then
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

				if inh_assert.has_postcondition then
					inh_assert.make_old_exp_byte_code (a_generator, ba)
				end

					-- Write position for the last old expression evaluation.
				ba.write_forward
				ba.append (Bc_end_eval_old)
				ba.write_forward
				context.set_assertion_type (0)
			end
				-- Go to point for old expressions

				-- Record position to retry in case of rescue.
			ba.mark_retry

			if compound /= Void then
				a_generator.generate (ba, compound)
			end

				-- Make byte code for postcondition
			if postcondition /= Void or else inh_assert.has_postcondition then
				context.set_assertion_type (In_postcondition)
				ba.append (Bc_postcond)
				ba.mark_forward
				if inh_assert.has_postcondition then
					inh_assert.make_postcondition_byte_code (a_generator, ba)
				end
				if postcondition /= Void then
					a_generator.generate (ba, postcondition)
				end
				ba.write_forward
				if context.current_feature.is_failing then
						-- Postcondition violation should be triggered in any case
						-- because the compiler expects this routine to fail.
					ba.append (bc_postfail)
				end
				context.set_assertion_type (0)
			end
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN
		do
			Result := (compound /= Void and then compound.assigns_to (i))
				or else (rescue_clause /= Void and then rescue_clause.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := (compound /= Void and then compound.calls_special_features (array_desc))
				or else (rescue_clause /= Void and then rescue_clause.calls_special_features (array_desc))
		end

	optimized_byte_node: like Current
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

	initial_optimization_context: OPTIMIZATION_CONTEXT
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

	size: INTEGER
		do
			if compound /= Void then
				Result := compound.size
			end
			if rescue_clause /= Void then
				Result := Result + rescue_clause.size
			end
		end

	pre_inlined_code: like Current
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

	inlined_byte_code: STD_BYTE_CODE
		local
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
				create {like inlined_byte_code_type} Result.make (Current)

					-- Reset the flags in INLINER
				inliner.reset
			else
				Result := Current
			end
		end

feature {NONE} -- Typing

	inlined_byte_code_type: INLINED_BYTE_CODE
			-- For typing purposes to create the proper kind of INLINED_BYTE_CODE
			-- in `inlined_byte_code'.
		do
		end

feature {NONE} -- Convenience

	local_var: LOCAL_B
			-- Instance used to generate local variable name
		once
			create Result
		end

feature {NONE} -- C code generation: wait conditions

	separate_target_collector: SEPARATE_TARGET_COLLECTOR
			-- Visitor to detect wait conditions.
		once
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
