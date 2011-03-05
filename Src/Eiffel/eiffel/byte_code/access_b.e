note
	description: "Abstract class for access: Current, Result, local, argument, feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ACCESS_B

inherit
	CALL_B
		redefine
			enlarged, free_register, print_register,
			has_gcable_variable, propagate, generate, unanalyze,
			optimized_byte_node, inlined_byte_code
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Access

	parameters: BYTE_LIST [PARAMETER_B]
		do
			-- no parameters
		end

	target: ACCESS_B
			-- Ourselves as part of a message applied to a target
		do
			Result := Current
		end

	context_type: TYPE_A
			-- Context type of the access (properly instantiated)
		local
			a_parent: NESTED_B
			l_context: like context
		do
			if parent = Void then
				Result := context.context_cl_type
			elseif is_message then
				l_context := context
				Result := l_context.real_type (parent.target.type)
				if Result.is_multi_constrained then
					check has_multi_constraint_static: has_multi_constraint_static end
					Result := l_context.real_type (multi_constraint_static)
				end
			else
				a_parent := parent.parent
				if a_parent = Void then
					Result := context.context_cl_type
				else
					l_context := context
					Result := l_context.real_type (a_parent.target.type)
					if Result.is_multi_constrained then
						check has_multi_constraint_static: has_multi_constraint_static end
						Result := l_context.real_type (multi_constraint_static)
					end
				end
			end
		ensure
			not_result_is_multiconstraint_formal: not Result.is_multi_constrained
		end

	enlarged: ACCESS_B
			-- Redefined only for type check
		do
			Result := Current
		end

	enlarged_on (type_i: TYPE_A): ACCESS_B
			-- Enlarged byte node evaluated in the context of `type_i'.
		require
			type_i_not_void: type_i /= Void
		do
				-- Fallback to default implementation.
			Result := enlarged
		ensure
			result_not_void: Result /= Void
		end

	sub_enlarged (p: NESTED_BL): ACCESS_B
			-- Enlarge node and set parent to `p'
		do
			Result := enlarged
			Result.set_parent (p)
		end

feature -- Status

	read_only: BOOLEAN
			-- Is the access a read-only one ?
		do
			Result := True
		end

	current_needed_for_access: BOOLEAN
			-- Is current needed for a true access ?
		do
			Result := is_predefined implies is_current
		end

	has_gcable_variable: BOOLEAN
			-- Is the access using a GCable variable ?
		local
			expr_b: EXPR_B
			is_in_register: BOOLEAN
			i, nb: INTEGER
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
		do
			is_in_register := register /= Void and register /= No_register
			if is_in_register and register.c_type.is_reference then
					-- Access is stored in a pointer register
				Result := True
			else
				if parent = Void or else parent.target.is_current then
						-- True access: we may need Current.
					Result := (current_needed_for_access and not is_in_register)
						or (is_result and c_type.is_reference)
				end
					-- Check the parameters if needed, i.e. if there are
					-- any and if the access is not already stored in a
					-- register (which can't be a pointer, otherwise it would
					-- have been handled by the first "if").
				l_parameters := parameters
				if not is_in_register and l_parameters /= Void then
					from
						l_area := l_parameters.area
						nb := l_parameters.count
					until
						i = nb or Result
					loop
						expr_b := l_area.item (i)
						Result := expr_b.has_gcable_variable
						i := i + 1
					end
				end
			end
		end

	used (r: REGISTRABLE): BOOLEAN
			-- Is register `r' used in local access ?
		local
			expr: EXPR_B
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
			l_parameters: BYTE_LIST [EXPR_B]
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb or Result
				loop
					expr := l_area.item (i)
					Result := expr.used(r)
					i := i + 1
				end
			end
		end

	is_single: BOOLEAN
			-- Is access a single one ?
		local
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
			l_parameters: BYTE_LIST [EXPR_B]
			expr_b: EXPR_B
		do
				-- If it is predefined, then it is single.
			Result := is_predefined
			if not Result then
				Result := True
					-- It is not predefined. If it has parameters, then none
					-- of them may have a call or allocate memory (manifest arrays,
					-- strings, ...).
				l_parameters := parameters
				if l_parameters /= Void then
					from
						l_area := l_parameters.area
						nb := l_parameters.count
					until
						i = nb or not Result
					loop
						expr_b := l_area.item (i)
						Result := not expr_b.allocates_memory and not expr_b.has_call
						i := i + 1
					end
				end
			end
		end

	is_polymorphic: BOOLEAN
			-- Is the access polymorphic ?
		do
			Result := False
		end

	has_one_signature: BOOLEAN
			-- Is the access always using the same signature regardless of the version
			-- being called polymorphically?
		do
			Result := True
		end

feature -- Element change

	propagate (r: REGISTRABLE)
			-- Propagate register across access
		do
			if (register = Void) and not context_type.is_basic then
				if 	(real_type (type).c_type.same_class_type (r.c_type)
					or
					(	r = No_register
						and
						(	(parent = Void or else parent.target.is_current)
							or parameters = Void))
					)
					and
					(r = No_register implies context.propagate_no_register)
				then
					set_register (r)
					context.set_propagated
				end
			end
		end

feature -- Setting

	set_parameters (p: like parameters)
		do
			-- Do nothing
		end

	set_is_attachment
			-- Flag that a feature is used as a target of an attachment operation.
		do
		end

feature -- C generation

	print_register
			-- Print register or generate if there are no register.
		do
			if register /= No_register then
				Precursor {CALL_B}
			else
				generate_access
			end
		end

	free_register
			-- Free register used by last call expression. If No_register was
			-- propagated, also frees the registers used by target and
			-- last message.
		do
			Precursor {CALL_B}
				-- Free those registers which where kept because No_register
				-- was propagated, hence call was meant to be expanded in-line.
			if perused then
				free_param_registers
			end
		end

	perused: BOOLEAN
			-- See if the expression we are computing is going to be expanded
			-- on-line for later perusal: for instance, when computing the
			-- expression f(g(y), h(x)), the register used by the parameters
			-- must NOT be freed if the call is expanded, i.e. if register is
			-- No_register for f() as soon as the call is analyzed. If f() is
			-- indeed part of the parameters of another function, it would be
			-- a disaster...
		do
			Result := register = No_register or else
				(parent /= Void and then parent.register = No_register)
		end

	unanalyze_parameters
			-- Undo the analysis on parameters
		local
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			expr_b: EXPR_B
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb
				loop
					expr_b := l_area.item (i)
					expr_b.unanalyze
					i := i + 1
				end
			end
		end

	free_param_registers
			-- Free registers used by parameters
		local
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			expr_b: EXPR_B
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb
				loop
					expr_b := l_area.item (i)
					expr_b.free_register
					i := i + 1
				end
			end
		end

	unanalyze
			-- Undo the analysis
		do
			set_register (Void)
			unanalyze_parameters
		end

	Current_register: REGISTRABLE
			-- The "Current" entity
		do
			Result := Context.Current_register
		end

	analyze_on (reg: REGISTRABLE)
			-- Analyze access on `reg'
		do
				-- This will be redefined where needed. By default, run
				-- a simple analyze and forget about the parameter.
			analyze
		end

	generate
			-- Generate C code for the access.
		local
			buf: GENERATION_BUFFER
		do
			generate_parameters (current_register)
			if register /= No_register then
				buf := buffer
						-- Procedures have a void return type
				if register /= Void then
					buf.put_new_line
					register.print_register
					buf.put_three_character (' ', '=', ' ')
				else
					buf.put_new_line
				end
				generate_access
				buf.put_character (';')
			end
		end

	generate_on (reg: REGISTRABLE)
			-- Generate access using `reg' as "Current"
		do
		end

feature {NONE} -- C code generation: separate call

	generate_separate_call (s: detachable REGISTER; r: detachable REGISTRABLE; t: REGISTRABLE)
			-- Generate a call on target register `t' using register `s' to pass arguments
			-- and storing result (if any) in `r'.
		do
			buffer.put_new_line
			buffer.put_string ("/* Separate call is not implemented for " + generating_type + " */")
		end

feature -- C generation

	generate_access
			-- Generation of the C code for access
		do
		end

	generate_parameters (reg: REGISTRABLE)
			-- Generate code for parameters computation.
			-- `reg' ("Current") is not used except for
			-- inlining
		require
			reg_not_void: reg /= Void
		do
			if parameters /= Void then
				parameters.generate
			end
		end

	generate_call (s: detachable REGISTER; is_exactly_separate: BOOLEAN; r: detachable REGISTRABLE; t: REGISTRABLE)
			-- Generate a call on target register `t' using register `s' to pass arguments
			-- if the call may be separate (it cannot be non-separate if `is_exactly_separate' is 'True')
			-- and storing result (if any) in `r'.
		require
			t_attached: attached t
			is_exactly_separate_consistent: is_exactly_separate implies attached s
		local
			buf: GENERATION_BUFFER
			p: like parameters
			n: like parameters.count
			a: PARAMETER_B
		do
			buf := buffer
			if attached s then
					-- Generate a call on a separate target as follows:
					--    if (EIF_IS_DIFFERENT_PROCESSOR (Current, target)) {
					--        ... // Prepare arguments to pass in args.
					--        RTS_Cxy (feature_data, target, arguments, result);
					--    } else {
					--        ... // Make non-separate call.
					--    }
				if not is_exactly_separate then
						-- The call may be non-separate, this is determined at tun-time.
					buf.put_new_line
					buf.put_string ("if (EIF_IS_DIFFERENT_PROCESSOR (Current, ")
					t.print_register
					buf.put_four_character (')', ')', ' ', '{')
					buf.indent
				end
					-- Allocate a container to pass arguments to a scheduler.
				buf.put_new_line
				buf.put_string ("RTS_AC (")
					-- Calculate the number of arguments to be passed.
				p := parameters
				if attached p then
					n := p.count
				end
				buf.put_integer (n)
				buf.put_two_character (',', ' ')
				t.print_register
				buf.put_two_character (',', ' ')
				s.print_register
				buf.put_two_character (')', ';')
				if attached p then
						-- Register arguments to be passed to the scheduler in the allocated container.
					from
					until
						n <= 0
					loop
						buf.put_new_line
						a := p [n]
						if real_type (a.attachment_type).is_basic then
								-- The argument is passed without any additional checks.
							buf.put_string ("RTS_AA (")
						else
								-- The argument needs to be checked if it is controlled or not.
								-- If the argument is controlled, the call needs to be synchronous.
							buf.put_string ("RTS_AS (")
						end
						a.print_register
						buf.put_two_character (',', ' ')
						a.c_type.generate_typed_field (buf)
						buf.put_two_character (',', ' ')
						a.c_type.generate_sk_value (buf)
						buf.put_two_character (',', ' ')
						buf.put_integer (n)
						buf.put_two_character (',', ' ')
						s.print_register
						buf.put_two_character (')', ';')
						n := n - 1
					end
				end
					-- Register a call in a scheduler.
				generate_separate_call (s, r, t)
				if not is_exactly_separate then
						-- The call may be non-separate.
					buf.exdent
					buf.put_new_line
					buf.put_string ("} else {")
					buf.indent
				end
			end
			if not is_exactly_separate then
					-- The call may be non-separate.
					-- Now if there is a result for the call and the result
					-- has to be stored in a real register, do generate the
					-- assignment.
				buf.put_new_line
				if not attached r then
						-- Call to a procedure.
					generate_on (t)
				elseif not attached {AGENT_CALL_B} Current then
						-- Call to a simple function.
					r.print_register
					buf.put_three_character (' ', '=', ' ')
					generate_on (t)
				else
						-- Call to an agent function.
					generate_on (t)
					buf.put_character (';')
					buf.put_new_line
					r.print_register
					buf.put_string (" = ")
					register.print_register
				end
				buf.put_character (';')
				if attached s then
						-- Close else part of a separate conditional.
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
				end
			end
		end

feature -- Conveniences

	same (other: ACCESS_B): BOOLEAN
			-- Is `other' the same access as Current ?
		deferred
		end

	is_assignable: BOOLEAN
			-- Can current be assigned to?
		do
			Result := is_local or is_current or is_attribute or is_result
		end

	is_message: BOOLEAN
			-- is the access a message ?
		require
			parent_exists: parent /= Void
		do
			Result := parent.message.canonical = Current
		end

	is_feature: BOOLEAN
			-- Is Current an access to an Eiffel feature ?
		do
		end

	is_creatable: BOOLEAN
			-- Can the access be a target of a creation ?
		do
		end

	is_first: BOOLEAN
			-- Is the access the first one in a multi-dot expression ?
		local
			p: like parent
			p_target: ACCESS_B
			constant_b: CONSTANT_B
		do
			p := parent
			if p = Void then
				Result := True
			else
				p_target := p.target
				if (p_target = Current and then p.parent = Void) then
					Result := True
				else
						-- Bug fix: CONSTANT_B has a special construct
						-- for nested calls
					constant_b ?= p_target
					Result := constant_b /= Void and then
						constant_b.access = Current and then p.parent = Void
				end
			end
		end

feature -- Code generation

	argument_types: ARRAY [STRING]
			-- Array of C types for the arguments
		local
			p: like parameters
			i, j, nb: INTEGER
		do
			p := parameters
			if p = Void then
				Result := <<"EIF_REFERENCE">>
			else
				from
					i := 1
					nb := p.count
					create Result.make (1, nb + 1)
					Result.put ("EIF_REFERENCE", 1)
					j := 2
				until
					i > nb
				loop
					Result.put (p [i].target_type_name, j)
					i := i +1
					j := j +1
				end
			end
		end

feature -- Byte code generation

	bit_assign_code: CHARACTER
			-- Bits assignment byte code
			-- (By default it is the assign_code)
		do
			Result := assign_code
		end

	assign_code: CHARACTER
			-- Simple assignment byte code
		do
			-- Do nothing
		end

	expanded_assign_code: CHARACTER
			-- Expanded assignment byte code
		do
			-- Do nothing
		end

	reverse_code: CHARACTER
			-- Reverse assignment byte code	
		do
			-- Do nothing
		end

feature -- Array optimization

	optimized_byte_node: like Current
			-- Redefined for type check
		do
			Result := Current
		end

	conforms_to_array_opt: BOOLEAN
		do
			Result := (is_argument or else is_local or else is_result)
				and then type.conforms_to_array
		end

	array_descriptor: INTEGER
			-- Array description
			-- argument:<0; Result:0; local:>0
		do
		end

feature -- Multi constraint suport

	set_multi_constraint_static (a_type: TYPE_A)
			-- `formal_multi_constraint_static' to `a_type'
		do
			multi_constraint_static := a_type
		ensure
			multi_constraint_static_set: multi_constraint_static = a_type
		end

	multi_constraint_static: TYPE_A;
			-- Static type of recipient of access message.
			--| In the multi constraint there is more then one recipient for a message.
			--| `multi_constraint_static' states to which type out of the type set exactly it should be sent.

	has_multi_constraint_static: BOOLEAN
			-- Does current access send it's message to a multi constraint?
			-- If true it means that this message is sent to the type represented by `multi_constraint_static'
		do
			Result := multi_constraint_static /= Void
		end

feature -- Inlining

	inlined_byte_code: ACCESS_B
			-- Redefined for type check
		do
			Result := Current
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
