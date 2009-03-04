note
	description: "Visitor that looks for cluster with a certain location."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FIND_LOCATION_VISITOR

inherit
	CONF_FIND_VISITOR [attached CONF_CLUSTER]
		rename
			found_groups as found_clusters
		end

create
	make

feature -- Access

	directory: STRING
			-- Directory to look for.

feature -- Update

	set_directory (a_directory: STRING)
			-- Set `directory' to `a_directory'.
		require
			a_directory_ok: a_directory /= Void and then not a_directory.is_empty
		do
			directory := a_directory
		ensure
			directory_set: directory = a_directory
		end

feature {NONE} -- Query

	is_matching (a_cluster: attached CONF_CLUSTER): BOOLEAN
			-- <Precursor>
		do
			Result := a_cluster.location.evaluated_directory.is_equal (directory)
		end

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
