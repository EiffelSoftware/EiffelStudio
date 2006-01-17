indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BIN_EQ_B

inherit
	BIN_EQUAL_B
		redefine
			enlarged, generate_operator
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_eq_b (Current)
		end

feature

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (" == ");
		end;

	generate_boolean_constant is
			-- Generate false constant
		do
			buffer.put_string ("EIF_FALSE");
		end;

	enlarged: EXPR_B is
			-- Enlarge node
		local
			l_left_val, l_right_val: VALUE_I
		do
			left := left.enlarged
			right := right.enlarged
			if context.final_mode then
				l_left_val := left.evaluate
				l_right_val := right.evaluate
				if
					l_left_val.same_type (l_right_val) and then
					l_left_val.is_equivalent (l_right_val)
				then
					create {BOOL_CONST_B} Result.make (True)
				else
						-- They are either not of the same type, or if they are they might
						-- have different values. For the moment, we simply proceed to
						-- traditional code generation (no optimization done, as you could
						-- have an INTEGER_8 constant of value 1, and an INTEGER constant of value 1
						-- and no comparison features at the moment enables us to tell they
						-- are the same value without computation.
					create {BIN_EQ_BL} Result.make (left, right)
				end
			else
				create {BIN_EQ_BL} Result.make (left, right)
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
