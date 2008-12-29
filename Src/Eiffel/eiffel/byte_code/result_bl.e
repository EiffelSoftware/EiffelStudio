note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Enlarged access to Result

class
	RESULT_BL

inherit
	RESULT_B
		redefine
			used, generate, parent, set_parent,
			free_register, print_register, propagate,
			type
		end;

create
	make

feature

	parent: NESTED_BL;
			-- Parent of access

	type: TYPE_A
			-- Result type

	make (t: like type)
			-- Initialization
		require
			good_argument: t /= Void
		do
			type := t;
		end;

	set_parent (p: NESTED_BL)
			-- Set `parent' to `p'
		do
			parent := p;
		end;

feature -- C code generation

	propagate (r: REGISTRABLE)
			-- Do nothing
		do
		end;

	used (r: REGISTRABLE): BOOLEAN
			-- Is `r' the "Result" entity ?
		do
			Result := r.is_result;
		end;

	generate
			-- Do nothing
		do
		end

	free_register
			-- Do nothing
		do
		end;

	print_register
			-- Print "Result"
		local
			type_i: TYPE_A;
		do
			if context.result_used then
					-- Once function have their result recorded into the GC,
					-- so it's useless to use an l[] variable.
				buffer.put_string (register_name);
			else
				type_i := real_type (context.byte_code.result_type);
				type_i.c_type.generate_cast (buffer);
				buffer.put_character ('0');
			end;
		end;

note
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
