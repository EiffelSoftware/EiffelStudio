note
	description: "Represent a fold under a cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FOLDER

inherit
	ANY
		redefine
			is_equal
		end

create
	make,
	make_with_name

feature {NONE} -- Initialize

	make (a_cluster: CONF_CLUSTER; a_path: STRING)
			-- Initialize
		require
			a_cluster_not_void: a_cluster /= Void
			a_path_valid: a_path /= Void and then not a_path.is_empty
		do
			cluster := a_cluster
			path := a_path
			build_name
		ensure
			a_cluster_not_void: cluster = a_cluster
			a_path_valid: path = a_path and then not path.is_empty
			a_name_not_void: name /= Void
		end

	make_with_name (a_cluster: CONF_CLUSTER; a_path: STRING; a_name: STRING)
			-- Initialize with name
		require
			a_cluster_not_void: a_cluster /= Void
			a_path_valid: a_path /= Void and then not a_path.is_empty
			a_name_not_void: a_name /= Void
		do
			cluster := a_cluster
			path := a_path
			name := a_name
		ensure
			a_cluster_not_void: cluster = a_cluster
			a_path_valid: path = a_path and then not path.is_empty
			a_name_not_void: name = a_name
		end

feature -- Access

	cluster: CONF_CLUSTER
			-- Cluster in which current is

	path: STRING
			-- Relative path to `cluster' of current fold

	name: STRING
			-- Name of the folder

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := (cluster = other.cluster and then
						path.is_equal (other.path)) and then
						name.is_equal (other.name)
		end

feature -- Element change

	set_cluster (a_cluster: like cluster)
			-- Set `cluster' with `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
		do
			cluster := a_cluster
		ensure
			cluster_not_void: a_cluster = a_cluster
		end

	set_path (a_path: like path)
			-- Set `path' with `a_path'.
		require
			a_path_valid: a_path /= Void and then not a_path.is_empty
		do
			path := a_path
		ensure
			path_not_void: path = a_path
		end

feature {NONE} -- Implementation

	build_name
			-- Build name.
		local
			l_string : STRING
			l_start, l_end: INTEGER
		do
			l_string := cluster.location.build_path (path, "")
			if l_string.item (l_string.count).is_equal (operating_environment.directory_separator) then
				l_end := l_string.count - 1
			else
				l_end := l_string.count
			end
			l_start := l_string.last_index_of (operating_environment.directory_separator, l_end)
			l_start := l_start + 1
			name := l_string.substring (l_start, l_end)
		end

invariant
	invariant_clause: True -- Your invariant here

note
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
