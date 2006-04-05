indexing

	description:
		"Error when class name listed twice in the first part %
		%of a renaming clause of a cluster adaptation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VD47

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	old_name: ID_SD;
			-- Class name involved

	cluster: CLUSTER_I;
			-- Cluster containing classes renamed

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Debug purpose
		do
			a_text_formatter.add ("Cluster path: ");
			a_text_formatter.add (cluster.path);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Class name: ");
			a_text_formatter.add (old_name.as_upper);
			a_text_formatter.add_new_line
		end;

feature {CLUST_PROP_SD, CLUST_ADAPT_SD} -- Setting

	set_old_name (s: ID_SD) is
			-- Assign `s' to `old_name'.
		do
			old_name := s;
		end;

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
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

end -- class VD47
