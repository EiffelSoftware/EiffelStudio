indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Byte code for "or else"

class B_OR_ELSE_B

inherit

	BOOL_BINARY_B
		redefine
			built_in_enlarged, generate_operator,
			is_commutative
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_or_else_b (Current)
		end

feature -- Status report

	is_or: BOOLEAN is
			-- Is Current just `or', i.e. order does not matter?
		do
		end

feature -- Enlarging

	built_in_enlarged: EXPR_B is
			-- Enlarge node. Try to get rid of useless code if possible.
		local
			l_b_or_else_bl: B_OR_ELSE_BL
			l_attr: ATTRIBUTE_B
			l_bool_val: VALUE_I
			l_is_normal: BOOLEAN
		do
			left := left.enlarged
			right := right.enlarged
			if context.final_mode then
				l_bool_val := left.evaluate
				if l_bool_val.is_boolean then
					if l_bool_val.boolean_value then
							-- Expression will always be True.
							-- case of: True_expression or XXX
							--       or True_expression or else XXX
						create {BOOL_CONST_B} Result.make (True)
					else
						Result := right
					end
				else
					l_bool_val := right.evaluate
					if l_bool_val.is_boolean then
						if l_bool_val.boolean_value then
								-- case of: XXX or True
								--       or XXX or else True
							l_attr ?= left
							if is_or or left.is_predefined or (l_attr /= Void) then
									-- No harm by not evaluating XXX if either condition is met:
									-- 1 - we have a `is_or', therefore compiler is authorized to
									--     change the evaluation order
									-- 2 - XXX is predefined (meaning by not evaluating we do not
									--     change the semantic)
									-- 3 - XXX is an attribute and therefore behaves as if it was
									--     a predefined entity
									-- In this case, we always return a True expression.
								create {BOOL_CONST_B} Result.make (True)
							else
									-- We cannot optimize it away and we need to evaluate XXX.
								l_is_normal := True
							end
						else
								-- case of: XXX or False_expression
								--       or XXX or else False_expression
								-- We always need to return left-hand side.
							Result := left
						end
					else
						l_is_normal := True
					end
				end
			else
				l_is_normal := True
			end

			if l_is_normal then
					-- Normal code transformation.
				create l_b_or_else_bl
				l_b_or_else_bl.init (access.enlarged_on (context.real_type (left.type)))
				l_b_or_else_bl.set_left (left)
				l_b_or_else_bl.set_right (right)
				Result := l_b_or_else_bl
			end
		end

	generate_operator (a_buffer: GENERATION_BUFFER) is
			-- Generate the operator
		do
			a_buffer.put_four_character (' ', '|', '|', ' ')
		end;

	is_commutative: BOOLEAN is
			-- Is operation commutative ?
		do
			Result := not has_call;
		end;

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
