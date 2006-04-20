indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class UN_NOT_B

inherit
	UNARY_B
		redefine
			generate_operator, is_built_in, print_register,
			enlarged, is_type_fixed
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_un_not_b (Current)
		end

feature

	print_register is
			-- print expression value
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("(EIF_BOOLEAN) !")
			expr.print_register
		end

	generate_operator is
			-- Generate the unary operator
		do
			buffer.put_character ('!');
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (expr.type).is_boolean;
		end;

	is_type_fixed: BOOLEAN is
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?
		do
			Result := is_built_in
		end

feature -- Enlarging

	enlarged: EXPR_B is
			-- Enlarge expression.
		local
			l_val: VALUE_I
		do
			if not is_built_in or not context.final_mode then
				Result := Precursor {UNARY_B}
			else
				expr := expr.enlarged
				l_val := expr.evaluate
				if l_val.is_boolean then
					create {BOOL_CONST_B} Result.make (not l_val.boolean_value)
				else
					if access /= Void then
						access := access.enlarged_on (expr.type)
					end
					Result := Current
				end
			end
		end

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
