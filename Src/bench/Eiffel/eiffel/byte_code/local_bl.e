indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Enlarged access to a local

class LOCAL_BL 

inherit

	LOCAL_B
		redefine
			type, free_register,
			analyze, generate, propagate,
			used, parent, set_parent
		end;
	
feature 

	parent: NESTED_BL;
			-- Parent of access

	type: TYPE_I;
			-- Local variable type
	
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
			local_b: LOCAL_B;
		do
			if r.is_local then
				local_b ?= r;	-- Cannot fail
				if local_b.position = position then
					Result := true;
				end;
			end;
		end;

	fill_from (l: LOCAL_B) is
			-- Fill in node from local `l'
		do
			position := l.position;
			type := l.type;
		end;

	analyze is
			-- Mark local as used
		do
			context.mark_local_used (position);
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
		end

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
