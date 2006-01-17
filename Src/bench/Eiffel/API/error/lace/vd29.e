indexing

	description: 
		"Error when the root class is in two different clusters%
		%and none of them is specified in the ace file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VD29

inherit

	CLUSTER_ERROR

feature -- Property

	second_cluster_name: STRING;

	root_class_name: STRING;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Class name: ");
			st.add_string (root_class_name);
			st.add_new_line;
			st.add_string ("First cluster: ");
			st.add_string (cluster.cluster_name);
			st.add_new_line;
			st.add_string ("Second cluster: ");
			st.add_string (second_cluster_name);
			st.add_new_line
		end;

feature {ROOT_SD} -- Setting

	set_second_cluster_name (s: STRING) is
		do
			second_cluster_name := s;
		end;

	set_root_class_name (s: STRING) is
		do
			root_class_name := s;
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

end -- class VD29
