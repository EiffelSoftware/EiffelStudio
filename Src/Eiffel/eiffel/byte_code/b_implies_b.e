indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Byte code for semi-strict "implies"

class
	B_IMPLIES_B

inherit
	BOOL_BINARY_B
		redefine
			built_in_enlarged, print_register
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_implies_b (Current)
		end

feature

	built_in_enlarged: EXPR_B is
			-- Enlarge node. Try to get rid of useless code if possible.
		local
			l_b_implies_bl: B_IMPLIES_BL
			l_bool_val: VALUE_I
			l_is_normal: BOOLEAN
		do
			left := left.enlarged
			if context.final_mode then
				l_bool_val := left.evaluate
				if l_bool_val.is_boolean then
					if not l_bool_val.boolean_value then
							-- Expression is always True as left-hand side is False.
						create {BOOL_CONST_B} Result.make (True)
					else
						right := right.enlarged
						l_bool_val := right.evaluate
						if l_bool_val.is_boolean then
								-- Expression value is the one from the right-hand side.
							create {BOOL_CONST_B} Result.make (l_bool_val.boolean_value)
						else
							Result := right
						end
					end
				else
					l_is_normal := True
				end
			else
				l_is_normal := True
			end

			if l_is_normal then
					-- Normal code transformation.
				create l_b_implies_bl
				l_b_implies_bl.init (access.enlarged_on (context.real_type (left.type)))
				l_b_implies_bl.set_left (left)
				l_b_implies_bl.set_right (right.enlarged)
				Result := l_b_implies_bl
			end
		end

	print_register is
			-- Print the expression
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("(!(");
			left.print_register;
			buf.put_string (") || (");
			right.print_register;
			buf.put_string ("))");
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
