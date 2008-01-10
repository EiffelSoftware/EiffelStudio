indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Byte code for "and then"

class B_AND_THEN_B

inherit

	BOOL_BINARY_B
		redefine
			built_in_enlarged, generate_operator,
			is_commutative
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_and_then_b (Current)
		end

feature -- Status report

	is_and: BOOLEAN is
			-- Is Current just `and', i.e. order does not matter?
		do
		end

feature -- Enlarging

	built_in_enlarged: EXPR_B is
			-- Enlarge node. Try to get rid of useless code if possible.
		local
			l_b_and_thn_bl: B_AND_THN_BL
			l_bool_val: VALUE_I
			l_is_normal: BOOLEAN
		do
			left := left.enlarged
			right := right.enlarged
			if context.final_mode then
				l_bool_val := left.evaluate
				if l_bool_val.is_boolean then
					if l_bool_val.boolean_value then
						Result := right
					else
							-- Expression will always be False.
							-- case of: False_expression and XXX
							--       or False_expression and then XXX
						create {BOOL_CONST_B} Result.make (False)
					end
				else
					l_bool_val := right.evaluate
					if l_bool_val.is_boolean then
						if l_bool_val.boolean_value or not is_and then
								-- case of: XXX and True_expression
								--       or XXX and then True_expression
								--       or XXX and then False_expression
								-- We always need to return left-hand side, even
								-- for third case because `and then' implies a certain
								-- order of evaluation.
							Result := left
						else
							check
								valid_simplification: not l_bool_val.boolean_value and is_and
							end
								-- Expression will always be False.
								-- case of: XXX and False_expression
								-- Note: you cannot do such an optimization with a `and then'
								-- statement as the order matter (see above comments).
							create {BOOL_CONST_B} Result.make (False)
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
				create l_b_and_thn_bl
				l_b_and_thn_bl.init (access.enlarged_on (left.type))
				l_b_and_thn_bl.set_left (left)
				l_b_and_thn_bl.set_right (right)
				Result := l_b_and_thn_bl
			end
		end

	generate_operator (a_buffer: GENERATION_BUFFER) is
			-- Generate the operator
		do
			a_buffer.put_four_character (' ', '&', '&', ' ')
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
