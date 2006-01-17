indexing

	description: 
		"Error when cluster name listed twice in the second part %
		%of a cluster renaming clause."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VD49

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	new_name: ID_SD;
			-- Cluster name involved

	path: ID_SD;
			-- Path of precompiled library

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Debug purpose
		do
			st.add_string ("Precompiled path: ");
			st.add_string (path);
			st.add_new_line;
			st.add_string ("Cluster name: ");
			st.add_string (new_name);
			st.add_new_line
		end;

feature {D_PRECOMPILED_SD} -- Setting

	set_new_name (s: ID_SD) is
			-- Assign `s' to `new_name'.
		do
			new_name := s;
		end;

	set_path (s: ID_SD) is
			-- Assign `s' to `path'.
		do
			path := s;
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

end -- class VD49
