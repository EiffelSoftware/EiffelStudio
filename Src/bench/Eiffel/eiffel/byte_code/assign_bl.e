indexing
	description: "Enlarged byte code for assignment"
	date: "$Date$"
	revision: "$Revision$"

class ASSIGN_BL

inherit

	ASSIGN_B
		redefine
			analyze, generate,
			last_all_in_result, find_assign_result,
			mark_last_instruction
		end
	VOID_REGISTER
		redefine
			register, get_register, print_register
		end

create
	make

feature {NONE} -- Initialization

	make (other: ASSIGN_B) is
			-- Create new instance from `other'.
		require
			other_not_void: other /= Void
		do
			target := other.target.enlarged
			source := other.source.enlarged
			line_number := other.line_number
		end

feature

	target_propagated: BOOLEAN
			-- Has target been propagated ?

	expand_return: BOOLEAN
			-- Do we have to expand the assignment in Result ?

	is_bit_assignment: BOOLEAN
			-- Do we have an assignment to a bit?

	register: REGISTRABLE
			-- Where result is stored, for case where an entity is
			-- assigned to a manifest string. Usually those are expanded
			-- inline, but the RTAP macro for aging test evaluates its
			-- arguments more than once.

	register_for_metamorphosis: BOOLEAN
			-- Is register used to held metamorphosed value as opposed to the
			-- result of RTMS (for manifest strings)?

	print_register is
			-- Print register
		require else
			register_exists: register /= Void
		do
			register.print_register
		end

	get_register is
			-- Get a register for string constants
		do
			create {REGISTER} register.make (target.c_type)
		end

	last_in_result: BOOLEAN
			-- Is this the last assignment in Result ?

	last_instruction: BOOLEAN
			-- Is this assignment the very last instruction ?

	simple_op_assignment: INTEGER
			-- Records state of simple operations with assignments

	find_assign_result is
			-- Check whether this is an assignment in Result, candidate for
			-- final 'return' optimization. This won't be done if result is
			-- expanded or if there are some postconditions which might use
			-- it or there is a rescue clause...
		local
			source_type: TYPE_I
			target_type: TYPE_I
		do
			if target.is_result and
				not context.has_postcondition and
				not context.has_invariant and
				not context.has_rescue and
				not context.current_feature.is_once and then
				source.is_simple_expr
			then
				target_type := context.real_type (target.type)
				source_type := context.real_type (source.type)
				last_in_result :=
					not target_type.is_true_expanded and
						-- No optimization if metamorphosis
					(target_type.is_basic or else source_type.is_reference)
			else
				last_in_result := False
			end
		end

	last_all_in_result: BOOLEAN is
			-- Are all the function exit points an assignment to Result ?
		do
			Result := last_in_result
		ensure then
			Result = last_in_result
		end

	mark_last_instruction is
			-- Signals this assigment is an exit point for the routine.
		do
			last_instruction := not context.has_postcondition
				and not context.has_invariant
		end

	No_simple_op: INTEGER is Unique
			-- There is no simple operation assignment.

	Left_simple_op: INTEGER is Unique
			-- The left part of the source is affected by a simple operation.

	Right_simple_op: INTEGER is Unique
			-- The right part of the source is affected by a simple operation.

	analyze_simple_assignment is
			-- Take care of the simple operation assigments and sets
			-- `simple_op_assigment' accordingly.
		local
			binary: BINARY_B
			access: ACCESS_B
		do
			binary ?= source
			if binary /= Void and then binary.is_simple then
				access ?= binary.left
				if access /= Void and then access.same (target) then
						-- We found x := x - f
					simple_op_assignment := Left_simple_op
						-- Expand right leaf
					context.init_propagation
					binary.right.propagate (No_register)
						-- Avoid need of a register for left leaf
					context.init_propagation
					binary.left.propagate (No_register)
				elseif binary.is_commutative then
					access ?= binary.right
					if access /= Void and then access.same (target) then
							-- We found x := f + x
						simple_op_assignment := Right_simple_op
							-- Expand left leaf
						context.init_propagation
						binary.left.propagate (No_register)
							-- Avoid need of a register for right leaf
						context.init_propagation
						binary.right.propagate (No_register)
					end
				end
			end
		end

	analyze is
			-- Analyze assignment
		local
			string_b: STRING_B
			source_has_gcable: BOOLEAN
			result_used: BOOLEAN
			source_type: TYPE_I
			target_type: TYPE_I
			call_b: CALL_B
			expr_b: EXPR_B
			saved_context: like context
		do
				-- The target is always expanded in-line for de-referencing.
			context.init_propagation

				-- Propagation of `No_register' in any generation mode
			target.set_register (No_register)
			context.set_propagated

			target.analyze
				-- If we are not in the case "last assignment in Result" then
				-- look whether it is a simple operator assignment which could
				-- be generated nicely and efficiently in C (like c++ :-).
			simple_op_assignment := No_simple_op
			if not last_in_result then
				analyze_simple_assignment
			end
			create saved_context.make_from_context (context)
			if simple_op_assignment = No_simple_op then
				source_type := context.real_type (source.type)
				target_type := context.real_type (target.type)
				if target.is_predefined then
					result_used := target.is_result
						-- We won't attempt a propagation of the target if the
						-- target is a reference and the source is a basic type
						-- or an expanded.
					context.init_propagation
					if not target_type.is_expanded and source_type.is_expanded then
							-- Expand source but grab a register to hold cloned
							-- or metamorphosed value as aging tests might have
							-- to be performed.
						source.propagate (No_register)
						register := target
						register_for_metamorphosis := True
					elseif target_type.is_bit and then source_type.is_bit then
						is_bit_assignment := True
					else
							-- Do not propagate something expanded as the
							-- routines in NESTED_BL and friends won't know
							-- how to deal with that (they do real assignments,
							-- not copies). In case target is expanded, we
							-- do not propagate anything in the source.
						if not target_type.is_true_expanded then
								-- If there is invariant checking and the target
								-- is used in the source, do not propagate.
								-- Case: p := p.right in a list and p becomes
								-- void...
							if not ((context.workbench_mode or else
								context.assertion_level.check_invariant) and
								source.used (target))
							then
								source.propagate (target)
								target_propagated := context.propagated
							end
						end
					end
				else
						-- This is an assignment in an attribute.
					context.init_propagation
					if not target_type.is_expanded and source_type.is_expanded then
							-- Expand source but grab a register to hold cloned
							-- or metamorphosed value as aging tests might have
							-- to be performed.
						source.propagate (No_register)
						get_register
						register_for_metamorphosis := True
					elseif target_type.is_bit then
						is_bit_assignment := True
					else
							-- I can't expand because of the aging tests.
							-- (macro RTAP evaluates its argument more than
							-- once). This of course if target is a reference.
						if not target.c_type.is_pointer then
							source.propagate (No_register)
						end
					end
					if target.c_type.is_pointer then
							-- Mark current as used for RTAP.
						context.mark_current_used
					end
				end
			elseif target.is_result then
				context.mark_result_used
			end
				-- Analyze the source given the current propagations.
			source.analyze
			source.free_register
			if register_for_metamorphosis then
				register.free_register
			end
				-- If the source is a string constant and the target is not
				-- predefined, then a RTAP will be generated and the RTMS
				-- must NOT be expanded in line (side effect in macro).
			if not target.is_predefined then
				string_b ?= source
				if string_b /= Void and then string_b.register = No_register
				then
						-- Take a register to hold the value of the string.
					get_register
					register.free_register
				end
			end
				-- If source has GCable variables and is not a single call or
				-- access, then we cannot expand that in a return after the
				-- GC hooks have been removed.
			call_b ?= source
			if call_b /= Void and then call_b.is_single then
				source_has_gcable := call_b.has_gcable_variable and not
					call_b.is_simple_expr
			else
				expr_b ?= source
 				source_has_gcable := expr_b.has_call or expr_b.allocates_memory
			end

				-- Mark Result used only if not the last instruction (in which
				-- case we'll generate a direct return, hence Result won't be
				-- needed).
			if last_in_result and target.is_result and not source_has_gcable
			then
				context.restore (saved_context)
				source.unanalyze
				context.init_propagation
				source.propagate (No_register)
					-- If Result is already used, then propagate it. Otherwise,
					-- we won't need it. Note that if the result is an expanded
					-- entity, we need it.
				if context.result_used then
						-- Propagation of Result may avoid a register allocation
					context.init_propagation
					source.propagate (target)
				else
						-- We won't need Result after all...
					result_used := False
				end
				source.analyze
				source.free_register
					-- We may expand the return in line, once the GC hooks
					-- have been removed.
				expand_return := True
			else
					-- Force usage of Result
				last_in_result := False
			end
			if result_used then
				context.mark_result_used
			end
		end

	generate is
			-- Generate assignment
		do
			generate_line_info
			generate_frozen_debugger_hook

			if last_in_result then
					-- Assignement in Result is the last expression and
					-- the source does not use GCable variable, or only in
					-- an "atomic" way in a simple call.
				generate_last_return
			elseif simple_op_assignment /= No_simple_op then
				generate_simple_assignment
			else
				generate_assignment
			end
		end

	Simple_assignment: INTEGER is unique
			-- Simple assignment wanted

	Metamorphose_assignment: INTEGER is unique
			-- Metamorphose of source is necessary

	Clone_assignment: INTEGER is unique
			-- Clone of source is needed

	Copy_assignment: INTEGER is unique
			-- Copy source into target, raise exception if source is Void

	source_print_register is
			-- Generate source (the True one or the metamorphosed one)
		do
			if register_for_metamorphosis then
				print_register
			else
				source.print_register
			end
		end

	generate_assignment is
			-- Generate a non-optimized assignment
		local
			target_type: TYPE_I
			source_type: TYPE_I
			buf: GENERATION_BUFFER
		do
			buf := buffer
			target_type := context.real_type (target.type)
			source_type := context.real_type (source.type)
			if target_type.is_expanded and source_type.is_none then
					-- Assigning Void to expanded.
				buf.put_string ("RTEC(EN_VEXP);")
				buf.put_new_line
			elseif target_type.is_true_expanded then
					-- Reattachment of expanded types.
				generate_regular_assignment (Copy_assignment)
			elseif target_type.is_basic or else source_type.is_reference then
					-- Reattachment of basic type to basic type or
					-- of reference type to reference type.
				generate_regular_assignment (Simple_assignment)
			elseif source_type.is_basic then
					-- Reattachment of basic type to reference.
				generate_regular_assignment (Metamorphose_assignment)
			else
					-- Reattachment of expanded type to reference.
				generate_regular_assignment (Clone_assignment)
			end
		end

	generate_regular_assignment (how: INTEGER) is
			-- Generate the assignment
		do
			source.generate
				-- If target has been propagated, then the assignment is
				-- generated by `generate' itself only when the source is a
				-- simple expression.
				-- Note that this does not mean the target was predefined
				-- (e.g. with a Result := "string").
			if not (target_propagated and source.stored_register = target) then
				generate_normal_assignment (how)
			end
		end

	generate_special (how: INTEGER) is
			-- Generate special pre-treatment
		local
			basic_source_type: BASIC_I
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if how = Metamorphose_assignment then
				basic_source_type ?= context.real_type (source.type)
				basic_source_type.metamorphose
					(register, source, buf, context.workbench_mode)
				buf.put_character (';')
				buf.put_new_line
			elseif how = Clone_assignment then
				print_register
				buf.put_string (" = ")
				buf.put_string ("RTCL(")
				source.print_register
				buf.put_string (gc_rparan_semi_c)
				buf.put_new_line
			end
		end

	generate_normal_assignment (how: INTEGER) is
			-- Genrate assignment not taken care of by target propagation
		local
			need_aging_tests: BOOLEAN
			buf: GENERATION_BUFFER
			target_c_type: TYPE_C
			target_type: CL_TYPE_I
		do
			buf := buffer
			generate_special (how)

				-- Find out C type of `target'.
			target_c_type := target.c_type

				-- No aging tests if target is not a reference. Of course, if
				-- the target is also pre-defined, aging tests are not needed.
				-- If it is an assignment copy, RTXA will take care of the
				-- aging test for references within the expanded
			need_aging_tests :=
				how /= copy_assignment and
				not target.is_predefined and target_c_type.is_pointer
			if need_aging_tests then
					-- For strings constants, we have to be careful. Put its
					-- address in a temporary register before RTAR can
					-- handle it (it evaluates its arguments more than once).
				if register /= Void and not register_for_metamorphosis then
					print_register
					buf.put_string (" = ")
					source.print_register
					buf.put_character (';')
					buf.put_new_line
					buf.put_string ("RTAR(")
					context.Current_register.print_register
					buf.put_string (gc_comma)
					print_register
					buf.put_character (')')
					buf.put_character (';')
					buf.put_new_line
				else
					buf.put_string ("RTAR(")
					context.Current_register.print_register
					buf.put_string (gc_comma)
					source_print_register
					buf.put_character (')')
					buf.put_character (';')
					buf.put_new_line
				end
			end
			if how = Copy_assignment then
				if not target.is_predefined and target_c_type.is_pointer then
						-- Assignment on attribute. We need aging test, thus we use RTXA.
						-- FIXME: Optimization for attributes which are known to not have
						-- references in final mode, we should just do a `memmove' which
						-- is much faster.
					buf.put_string ("RTXA(")
	                if register /= Void then
	                    print_register
	                    buf.put_string (" = ")
	                    source.print_register
	                else
	                    source.print_register
	                end
	                buf.put_string (gc_comma)
	                target.print_register
	                buf.put_character (')')
	                buf.put_character (';')
	                buf.put_new_line
				else
						-- FIXME: Manu: 05/24/2004: We need to call `copy' if it
						-- is redefined, not the equivalent of `standard_copy'.
					buf.put_string ("memmove(")
					target.print_register
					buf.put_string (gc_comma)
					if register /= Void then
						print_register
						buf.put_string (" = ")
						source.print_register
					else
						source.print_register
					end
					buf.put_string (gc_comma)
					target_type ?= context.real_type (target.type)
					check
							-- An expanded is a valid class type.
						target_type_not_void: target_type /= Void
					end
					if context.workbench_mode then
						target_type.associated_class_type.skeleton.generate_workbench_size (buf)
					else
						target_type.associated_class_type.skeleton.generate_size (buf)
					end
					buf.put_character (')')
					buf.put_character (';')
					buf.put_new_line
				end
			else
				if how = Simple_assignment or need_aging_tests then
					if is_bit_assignment then
						-- Otherwize, copy bit since I know that
						-- bits have a default value.
						buf.put_string ("RTXB(")
						source_print_register
					else
						target.print_register
						buf.put_string (" = ")
							-- Always ensure that we perform a cast to type of target.
							-- Cast in case of basic type will never loose information
							-- as it has been validated by the Eiffel compiler.
						target_c_type.generate_cast (buf)
					end
				end
				if need_aging_tests then
					if register /= Void and not register_for_metamorphosis then
						print_register
					else
						if is_bit_assignment then
							buf.put_string (gc_comma)
							target.print_register
							buf.put_character (')')
						else
							source_print_register
						end
					end
					buf.put_character (';')
					buf.put_new_line
				else
					if how = Simple_assignment or need_aging_tests then
						if is_bit_assignment then
							buf.put_string (gc_comma)
							target.print_register
							buf.put_character (')')
						else
							source_print_register
						end
						buf.put_character (';')
						buf.put_new_line
					end
				end
			end
		end

	generate_last_return is
			-- Generate last assignment in Result (i.e. a return)
		require
			no_postcondition: not context.has_postcondition
			no_invariant: not context.has_invariant
		local
			target_type: TYPE_I
			source_type: TYPE_I
			buf: GENERATION_BUFFER
		do
			target_type := context.real_type (target.type)
			source_type := context.real_type (source.type)
				-- Target (Result) cannot be expanded
			if target_type.is_expanded and source_type.is_none then
				buf := buffer
				buf.put_string ("RTEC(EN_VEXP);")
				buf.put_new_line
			elseif target_type.is_basic or else source_type.is_reference then
					-- Reattachment of basic type to basic type or
					-- of reference type to reference type.
				generate_last_assignment (Simple_assignment)
			elseif source_type.is_basic then
					-- Reattachment of basic type to reference type.
				generate_last_assignment (Metamorphose_assignment)
			else
					-- Reattachment of expanded type to reference type.
				generate_last_assignment (Clone_assignment)
			end
		end

	generate_last_assignment (how: INTEGER) is
			-- Generate last assignment in Result
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			source.generate
			generate_special (how)
			context.byte_code.finish_compound
				-- Add a blank line before the return only if it
				-- is the last instruction.
			if last_instruction and context.byte_code.compound.count > 1 then
				buf.put_new_line
			end
			buf.put_string ("return ")
				-- Always ensure that we perform a cast to type of target.
				-- Cast in case of basic type will never loose information
				-- as it has been validated by the Eiffel compiler.
			target.c_type.generate_cast (buf)
			source_print_register
			buf.put_character (';')
			buf.put_new_line
		end

	generate_simple_assignment is
			-- Generates a simple assignment in target.
		require
			simple_assignment: simple_op_assignment = Left_simple_op or
				simple_op_assignment = Right_simple_op
		local
			binary: BINARY_B
			other: EXPR_B
			int: INTEGER_CONSTANT
			buf: GENERATION_BUFFER
		do
			buf := buffer
			binary ?= source;	-- Cannot fail
			inspect
				simple_op_assignment
			when Left_simple_op then
				other := binary.right
			when Right_simple_op then
				other := binary.left
			end
				-- Generate the other side of the expression
			other.generate
			if not target.is_predefined then
				buf.put_character ('(')
				target.print_register
				buf.put_character (')')
			else
				target.print_register
			end
				-- Detection of <expr> +/- 1
			int ?= other
			if
				binary.is_additive and then not (int = Void)
				and then int.is_one
			then
				binary.generate_plus_plus
			else
				binary.generate_simple
				other.print_register
			end
			buf.put_character (';')
			buf.put_new_line
		end

end
