indexing
	description: "Enlarged access to a local."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class LOCAL_BL

inherit

	LOCAL_B
		redefine
			type, free_register,
			analyze, generate, propagate,
			used, parent, set_parent
		end;

create {LOCAL_B}
	make

feature {NONE} -- Creation

	make (l: LOCAL_B)
			-- Make node from local `l'.
		require
			l_attached: l /= Void
		local
			i: like initialization_byte_code
		do
			multi_constraint_static := l.multi_constraint_static
			position := l.position
			type := l.type
			i := l.initialization_byte_code
			if i /= Void then
				initialization_byte_code := i.enlarged
			end
		end

feature

	parent: NESTED_BL;
			-- Parent of access

	type: TYPE_A
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

	analyze is
			-- Mark local as used
		local
			i: like initialization_byte_code
		do
			i := initialization_byte_code
			if i /= Void then
					-- Initialization byte node includes this node.
				initialization_byte_code := Void
				i.analyze
				initialization_byte_code := i
			else
				context.mark_local_used (position)
				if c_type.is_pointer then
					context.set_local_index (register_name, Current)
				end
			end
		end

	generate
			-- Generate local initialization if required.
		local
			b: like initialization_byte_code
		do
			if initialization_byte_code /= Void then
					-- Avoid recursion
				b := initialization_byte_code
				initialization_byte_code := Void
				b.generate
				initialization_byte_code := b
			end
		end

	free_register is
			-- Do nothing
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
