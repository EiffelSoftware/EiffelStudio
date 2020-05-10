note
	description	: "Byte code for conditional expression."

class IF_EXPRESSION_B

inherit
	EXPR_B
		redefine
			allocates_memory,
			analyze,
			calls_special_features,
			enlarged,
			enlarge_tree,
			free_register,
			generate,
			has_call,
			has_gcable_variable,
			inlined_byte_code,
			is_unsafe,
			optimized_byte_node,
			pre_inlined_code,
			register,
			set_register,
			size,
			unanalyze
		end

create
	make

feature {NONE} -- Creation

	make (condition_expression: like condition; then_part: like then_expression; elseif_parts: like elsif_list; else_part: like else_expression; common_type: like type; location: like end_location)
			-- Initialize byte node with condition `contiion_expression`, Then_part `then_part`, a list of Elseif clauses `elseif_parts`, Else_part `else_part`, computed common type `common_type` and final location `location`.
		do
			condition := condition_expression
			then_expression := then_part
			elsif_list := elseif_parts
			else_expression := else_part
			type := common_type
			end_location := location
		ensure
			condition_set: condition = condition_expression
			then_expression_set: then_expression = then_part
			elsif_list_set: elsif_list = elseif_parts
			else_expression_set: else_expression = else_part
			type_set: type = common_type
			end_location_set: end_location = location
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- <Precursor>
		do
			v.process_if_expression_b (Current)
		end

feature -- Access

	condition: EXPR_B
			-- Conditional expression

	then_expression: EXPR_B
			-- Byte node for Then_part.

	elsif_list: detachable BYTE_LIST [ELSIF_EXPRESSION_B]
			-- Alternatives {list of ELSIF_B}

	else_expression: EXPR_B
			-- Byte node for Else_part.

	end_location: detachable LOCATION_AS
			-- Line number where `end' keyword is located

	type: TYPE_A
			-- <Precursor>

feature -- Status report

	has_gcable_variable: BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.has_gcable_variable or else
				then_expression.has_gcable_variable or else
				else_expression.has_gcable_variable or else
				attached elsif_list as l and then across l as c some c.item.has_gcable_variable end
		end

	has_call: BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.has_call or else
				then_expression.has_call or else
				else_expression.has_call or else
				attached elsif_list as l and then across l as c some c.item.has_call end
		end

	allocates_memory: BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.allocates_memory or else
				then_expression.allocates_memory or else
				else_expression.allocates_memory or else
				attached elsif_list as l and then across l as c some c.item.allocates_memory end
		end

	has_breakpoints: BOOLEAN
			-- Can breakpoints be put inside the expression?
		do
				-- Breakpoints should not be generated if the conditional expression
				-- replaces some boolean connective.
			Result := attached end_location
		end

feature -- Code generation: C

	used (r: REGISTRABLE): BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.used (r) or else
				then_expression.used (r) or else
				else_expression.used (r) or else
				attached elsif_list as l and then across l as c some c.item.used (r) end
		end

	enlarged: EXPR_B
			-- <Precursor>
		local
			l_value: VALUE_I
			l_elseif_b: ELSIF_EXPRESSION_B
			l_expr: EXPR_B
		do
			condition := condition.enlarged
			then_expression := then_expression.enlarged
			else_expression := else_expression.enlarged
			if attached elsif_list as l then
				across
					l as c
				loop
					c.item.enlarge_tree
				end
			end
			if context.final_mode then
				l_value := condition.evaluate
				if l_value.is_boolean then
					if l_value.boolean_value then
						Result := then_expression
					elseif not attached elsif_list as l then
						Result := else_expression
					else
						check
							not_elsif_list_empty: not l.is_empty
						end

							-- Now remove useless `elseif' statements.
						from
							l.start
						until
							l.after
						loop
							l_elseif_b := l.item
							l_expr := l_elseif_b.condition
							l_value := l_expr.evaluate
							if l_value.is_boolean then
								if l_value.boolean_value then
										-- Code will always be executed, get rid of remaining items.
									else_expression := l_elseif_b.expression
									from
									until
										l.after
									loop
										l.remove
									end
								else
										-- Code will never be executed, get rid of it.
									l.remove
								end
							else
								l.forth
							end
						end

							-- Create new node.
						if not l.is_empty then
							l_elseif_b := l.first
							l.start
							l.remove
							if not l.is_empty then
								elsif_list := Void
							end
							condition := l_elseif_b.condition
							then_expression := l_elseif_b.expression
							Result := Current
						else
							Result := else_expression
						end
					end
				else
						-- We could not simplify first if statment, let's see if we can simplifiy
						-- remaining `elsif_list'.
					Result := Current
					if attached elsif_list as l then
						check
							not_elsif_list_empty: not l.is_empty
						end

							-- Now remove useless `elseif' statements.
						from
							l.start
						until
							l.after
						loop
							l_elseif_b := l.item
							l_expr := l_elseif_b.condition
							l_value := l_expr.evaluate
							if l_value.is_boolean then
								if l_value.boolean_value then
										-- Code will always be executed, get rid of remaining items.
									else_expression := l_elseif_b.expression
									from
									until
										l.after
									loop
										l.remove
									end
								else
										-- Code will never be executed, get rid of it.
									l.remove
								end
							else
								l.forth
							end
						end

						if l.is_empty then
							elsif_list := Void
						end
					end
				end
			else
				Result := Current
			end
		end

	enlarge_tree
			-- <Precursor>
		do
			condition := condition.enlarged
			then_expression := then_expression.enlarged
			if attached elsif_list as l then
				l.enlarge_tree
			end
			else_expression := else_expression.enlarged
		end

	analyze
			-- <Precursor>
		do
			analyze_expression (condition)
			analyze_expression (then_expression)
				-- A register will be required after computing a result of Then_branch
				-- to store the result of the whole comditional expression.
			get_register
			if attached elsif_list as es then
				across
					es as e
				loop
					analyze_expression (e.item)
				end
			end
			analyze_expression (else_expression)
		end

	analyze_expression (e: EXPR_B)
			-- Analyze expression `e`.
		do
			context.init_propagation
			e.propagate (No_register)
			e.analyze
			e.free_register
		end

	set_register (r: REGISTRABLE)
			-- <Precursor>
		do
			register := r
		end

	free_register
			-- <Precursor>
		do
			register.free_register
		end

	unanalyze
			-- <Precursor>
		do
			condition.unanalyze
			then_expression.unanalyze
			else_expression.unanalyze
			if attached elsif_list as l then
				across
					l as c
				loop
					c.item.unanalyze
				end
			end
			register := Void
		end

	generate
			-- <Precursor>
		local
			buf: GENERATION_BUFFER
			t: TYPE_A
		do
			t := context.real_type (type)
			buf := buffer
			condition.generate
			buf.put_new_line
			buf.put_string ({C_CONST}.if_conditional)
			buf.put_two_character (' ', '(')
			condition.print_register
			buf.put_character (')')
			generate_one_branch (then_expression, t)
			if attached elsif_list as l then
				across
					l as c
				loop
					buf.put_character (' ')
					buf.put_string ({C_CONST}.else_conditional)
					buf.put_two_character (' ', '{')
					c.item.generate_line_info
					buf.indent
						-- Generate a hook for the evaluation/test of the condition.
					c.item.generate_frozen_debugger_hook
					c.item.condition.generate
					buf.put_new_line
					buf.put_string ({C_CONST}.if_conditional)
					buf.put_two_character (' ', '(')
					c.item.condition.print_register
					buf.put_character (')')
					generate_one_branch (c.item.expression, t)
				end
			end
			buf.put_character (' ')
			buf.put_string ({C_CONST}.else_conditional)
			generate_one_branch (else_expression, t)
			generate_closing_brakets
		end

	generate_closing_brakets
			-- Generate one closing braket for each generated elsif
		local
			i: INTEGER
			buf: GENERATION_BUFFER
		do
			if attached elsif_list as l then
				from
					buf := buffer
					i := l.count
				until
					i = 0
				loop
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
					i := i - 1
				end
			end
		end

feature {NONE} -- Code generation: C

	register: REGISTRABLE
			-- Register to keep result of the conditional expression.

	generate_one_branch (e: EXPR_B; t: TYPE_A)
			-- Generate code for a single branch `e`.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- There is a leading test, so put a space before opening a brace.
			buf.put_two_character (' ', '{')
			buf.indent
			if has_breakpoints then
					-- Generate the hook for the branch.
				generate_frozen_debugger_hook
			end
				-- Assign result of a expression `e` to `register` of type `t`.
			e.generate_for_attachment (register, t)
			buf.generate_block_close
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.calls_special_features (array_desc) or else
				then_expression.calls_special_features (array_desc) or else
				else_expression.calls_special_features (array_desc) or else
				attached elsif_list as l and then l.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
			-- <Precursor>
		do
			Result :=
				condition.is_unsafe or else
				then_expression.is_unsafe or else
				else_expression.is_unsafe or else
				attached elsif_list as l and then l.is_unsafe
		end

	optimized_byte_node: like Current
			-- <Precursor>
		do
			Result := Current
			condition := condition.optimized_byte_node
			then_expression := then_expression.optimized_byte_node
			if attached elsif_list as l then
				elsif_list := l.optimized_byte_node
			end
			else_expression := else_expression.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER
			-- <Precursor>
		do
			Result := 1 + condition.size
			Result := Result + then_expression.size
			if attached elsif_list as l then
				Result := Result + l.size
			end
			Result := Result + else_expression.size
		end

	pre_inlined_code: like Current
			-- <Precursor>
		do
			Result := Current
			condition := condition.pre_inlined_code
			then_expression := then_expression.pre_inlined_code
			if attached elsif_list as l then
				elsif_list := l.pre_inlined_code
			end
			else_expression := else_expression.pre_inlined_code
		end

	inlined_byte_code: like Current
			-- <Precursor>
		do
			Result := Current
			condition := condition.inlined_byte_code
			then_expression := then_expression.inlined_byte_code
			if attached elsif_list as l then
				elsif_list := l.inlined_byte_code
			end
			else_expression := else_expression.inlined_byte_code
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
