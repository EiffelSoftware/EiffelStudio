indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- The enlarged "old" operator

class UN_OLD_BL 

inherit

	UN_OLD_B
		redefine
			register, set_register,
			generate, unanalyze, analyze,
			print_register, free_register
		end;
	
feature 

	register: REGISTRABLE;
			-- Register which stores the old value.
			-- This register is never freed, of course.
	
	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r;
		end;

	special_analyze is
			-- Analyze expression and get a register
		local
			target_type: TYPE_I
		do
			target_type := Context.real_type (type);
			context.init_propagation;
			expr.propagate (No_register);
			get_register;
			expr.analyze;
			expr.free_register;
		end;

	initialize is
			-- Initialize the value of the old variable.
		local
			target_type: TYPE_I
			buf: GENERATION_BUFFER
		do
			buf := buffer
			expr.generate;
			target_type := Context.real_type (type);
			register.print_register;
			buf.put_string (" = ");
			if target_type.is_true_expanded then
				buf.put_string ("RTCL(")
				expr.print_register
				buf.put_character (')')
			else
				expr.print_register;
			end
			buf.put_character (';');
			buf.put_new_line;
		end;

	unanalyze is
			-- Undo the analysis
		local
			void_reg: REGISTER;
		do
			expr.unanalyze;
			set_register (void_reg);
		end;

	analyze is
			-- Do nothing
		do
		end;

	generate is
			-- Do nothing
		do
		end;
	
	print_register is
			-- Print the value of the old variable
		do
			register.print_register;
		end;

	free_register is
			-- Do nothing
		do
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
