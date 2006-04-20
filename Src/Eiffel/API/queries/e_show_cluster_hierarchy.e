indexing

	description:
		"Command to display hierarchical structure of the system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLUSTER_HIERARCHY

inherit
	E_OUTPUT_CMD

	SHARED_EIFFEL_PROJECT

create
	make, do_nothing

feature -- Execution

	work is
			-- Show classes in universe
		do
			display_clusters (Eiffel_system.sub_clusters, 0)
		end;

feature {NONE} -- Implementation

	display_clusters (a_list: ARRAYED_LIST [CLUSTER_I]; indent: INTEGER) is
			-- Display the `a_list' of cluster to `text_formatter'.
		local
			a_cluster: CLUSTER_I
		do
			from
				a_list.start
			until
				a_list.after
			loop
				add_tabs (text_formatter, indent);
				a_cluster := a_list.item;
				text_formatter.add_group (a_cluster, a_cluster.cluster_name);
				text_formatter.add_new_line;
				display_clusters (a_cluster.sub_clusters, indent + 1)
				a_list.forth
			end
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

end -- class E_SHOW_CLUSTER_HIERARCHY
