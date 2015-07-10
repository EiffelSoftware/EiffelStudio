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

	make (c: like condition; t: like then_expression; l: like elsif_list; e: like else_expression; a: like end_location)
		do
			condition := c
			then_expression := t
			elsif_list := l
			else_expression := e
			end_location := a
		ensure
			condition_set: condition = c
			then_expression_set: then_expression = t
			elsif_list_set: elsif_list = l
			else_expression_set: else_expression = e
			end_location_set: end_location = a
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

	end_location: LOCATION_AS
			-- Line number where `end' keyword is located

	type: TYPE_A
			-- <Precursor>
		do
			Result := then_expression.type
		end

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
			get_register
			context.init_propagation
			condition.propagate (No_register)
			condition.analyze
			condition.free_register
			then_expression.propagate (No_register)
			then_expression.analyze
			then_expression.free_register
			if attached elsif_list as l then
				l.analyze
			end
			else_expression.propagate (No_register)
			else_expression.analyze
			else_expression.free_register
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
		do
			buf := buffer

			condition.generate

			buf.put_new_line
			buf.put_string ({C_CONST}.if_conditional)
			buf.put_two_character (' ', '(')
			condition.print_register
			buf.put_three_character (')', ' ', '{')
			buf.indent
				-- Generate the hook for Then_part.
			generate_frozen_debugger_hook
			then_expression.generate
			buf.put_new_line
			print_register
			buf.put_three_character (' ', '=', ' ')
			then_expression.print_register
			buf.put_character (';')
			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
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
					buf.put_three_character (')', ' ', '{')
					buf.indent
					c.item.generate_frozen_debugger_hook
					c.item.expression.generate
					buf.put_new_line
					print_register
					buf.put_three_character (' ', '=', ' ')
					c.item.expression.print_register
					buf.put_character (';')
					buf.exdent
					buf.put_new_line
					buf.put_character ('}')
				end
			end
			buf.put_character (' ')
			buf.put_string ({C_CONST}.else_conditional)
			buf.put_two_character (' ', '{')
			buf.indent
			generate_frozen_debugger_hook
			else_expression.generate
			buf.put_new_line
			print_register
			buf.put_three_character (' ', '=', ' ')
			else_expression.print_register
			buf.put_character (';')
			buf.exdent
			buf.put_new_line
			buf.put_character ('}')
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
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
