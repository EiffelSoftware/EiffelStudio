note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Enlarged byte code for semi-strict "implies"

class B_IMPLIES_BL

inherit
	B_IMPLIES_B
		redefine
			propagate, free_register, print_register, generate, analyze,
			register, set_register
		end;

feature

	register: REGISTRABLE;
			-- Where result of expression should be stored

	set_register (r: REGISTRABLE)
			-- Set `register' to `r'
		do
			register := r;
		end;

	free_register
			-- Free register used by expression
		do
			if has_call then
				register.free_register
			else
				Precursor {B_IMPLIES_B};
			end;
		end;

	print_register
			-- Print value of the expression
		do
			if has_call then
				register.print_register;
			else
				Precursor {B_IMPLIES_B};
			end;
		end;

	propagate (r: REGISTRABLE)
			-- Propagate register `r' throughout the expression
		do
			if has_call then
					-- Do not propagate local or result in workbench mode as it would change its value
					-- in the debugger before evaluating the expression (bug#14220).
				if
					not context.propagated
					and then register = Void
					and then r /= No_register
					and then not used (r)
					and then (context.final_mode or else not r.is_local and then not r.is_result)
				then
					register := r
					context.set_propagated
				end
			else
				Precursor {B_IMPLIES_B} (r)
			end
		end

	analyze
			-- Analyze expression
		do
			if has_call then
				get_register;
				context.init_propagation;
				left.propagate (No_register);
				context.init_propagation;
				right.propagate (No_register);
				left.analyze;
				left.free_register;
				right.analyze;
				right.free_register;
			else
				Precursor {B_IMPLIES_B};
			end;
		end;

	generate
			-- Generate expression
		local
			buf: GENERATION_BUFFER
		do
			if has_call then
					-- Initialize value to true
				buf := buffer
				buf.put_new_line;
				register.print_register;
				buf.put_string (" = '\01';");
					-- Test first value. If it is false, then the whole
					-- expression is true and the right handside is not evaled.
				left.generate;
				buf.put_new_line;
				buf.put_string (gc_if_l_paran);
				left.print_register;
				buf.put_string (") {");
					-- Left handside was true. Value of the expression is the
					-- value of the right handside.
				buf.indent;
				right.generate;
				buf.put_new_line;
				register.print_register;
				buf.put_string (" = ");
				right.print_register;
				buf.put_character (';');
				buf.exdent;
				buf.put_new_line;
				buf.put_character ('}');
			else
				Precursor {B_IMPLIES_B};
			end;
		end;

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
