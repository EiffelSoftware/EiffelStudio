indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Enlarged access to an argument

class ARGUMENT_BL 

inherit

	ARGUMENT_B
		redefine
			analyze, generate, free_register,
			used, parent, set_parent, propagate
		end;

feature 

	parent: NESTED_BL;
			-- Parent of access
	
	set_parent (p: NESTED_BL) is
			-- Set `parent' to `p'
		do
			parent := p;
		end;

	propagate (r: REGISTRABLE) is
			-- Do nothing
		do
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' the same as us ?
		local
			argument_b: ARGUMENT_B;
		do
			if r.is_argument then
				argument_b ?= r;	-- Cannot fail
				if argument_b.position = position then
					Result := true;
				end;
			end;
		end;

	fill_from (l: ARGUMENT_B) is
			-- Fill in node from local `l'
		do
			position := l.position;
		end;

	analyze is
			-- Compute an index in the local variable array if type is pointer
		do
			if c_type.is_pointer then
				context.set_local_index (register_name, Current);
			end;
		end;

	generate is
			-- Do nothing
		do
		end;

	free_register is
			-- Do nothing
		do
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
