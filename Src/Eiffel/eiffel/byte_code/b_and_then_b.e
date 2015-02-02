note
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

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_bin_and_then_b (Current)
		end

feature -- Status report

	is_and: BOOLEAN
			-- Is Current just `and', i.e. order does not matter?
		do
		end

feature -- Enlarging

	built_in_enlarged: EXPR_B
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
						if l_bool_val.boolean_value then
								-- case of: XXX and True_expression
								--       or XXX and then True_expression
								-- We always need to return left-hand side.
							Result := left
						else
								-- Expression will always be False.
								-- case of: XXX and False_expression
								--       or XXX and then False_expression.
								-- However in second case, you cannot make an optimization
								-- if there is a call. For the time being if the left hand
								-- side is predefined (local/args/current/result or attribute)
								-- we optimize.
							if is_and or left.is_predefined or attached {ATTRIBUTE_B} left then
								create {BOOL_CONST_B} Result.make (False)
							else
								l_is_normal := True
							end
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
				l_b_and_thn_bl.init (access.enlarged_on (context.real_type (left.type)))
				l_b_and_thn_bl.set_left (left)
				l_b_and_thn_bl.set_right (right)
				Result := l_b_and_thn_bl
			end
		end

	generate_operator (a_buffer: GENERATION_BUFFER)
			-- Generate the operator
		do
			a_buffer.put_four_character (' ', '&', '&', ' ')
		end;

	is_commutative: BOOLEAN
			-- Is operation commutative ?
		do
			Result := not has_call;
		end;

note
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
