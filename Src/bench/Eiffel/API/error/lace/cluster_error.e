indexing
	description: "Error for cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLUSTER_ERROR

inherit
	LACE_ERROR

feature -- Property

	cluster: CONF_GROUP
			-- Cluster involved

feature -- Output

	put_cluster_name (a_text_formatter: TEXT_FORMATTER) is
			-- Display the cluster name
		do
			if cluster /= Void then
				if cluster.is_assembly then
					a_text_formatter.add ("Assembly cluster name: ")
				else
					a_text_formatter.add ("Cluster name: ")
				end
				a_text_formatter.add (cluster.name)
				a_text_formatter.add_new_line
			end
		end

	put_cluster_path (a_text_formatter: TEXT_FORMATTER) is
			-- Display the cluster path
		do
			if cluster.is_assembly then
				a_text_formatter.add ("Assembly details: ")
			else
				a_text_formatter.add ("Cluster path: ")
			end
			a_text_formatter.add_string (cluster.location.evaluated_path)
			a_text_formatter.add_new_line
		end

feature {AST_LACE, COMPILER_EXPORTER}

	set_cluster (c: CONF_GROUP) is
			-- Assign `c' to `cluster'.
		require
			c_not_void: c /= Void
		do
			cluster := c
		ensure
			cluster_set: cluster = c
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

end -- class CLUSTER_ERROR
