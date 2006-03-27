indexing
	description: "Internal representation of a cluster"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_I

inherit
	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			is_equal
		end

	SHARED_RESCUE_STATUS
		export
			{NONE} all
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end

	CONF_CLUSTER
		rename
			name as cluster_name,
			parent as parent_cluster,
			children as sub_clusters
		redefine
			classes,
			parent_cluster,
			sub_clusters
		end

create {CONF_COMP_FACTORY}
	make

feature -- Attributes

	path: STRING is
			-- Path to the cluster (without environment variables)
		do
			Result := location.evaluated_path
		end

	classes: HASH_TABLE [EIFFEL_CLASS_I, STRING]
			-- Classes available in the cluster: key is the declared
			-- name and entry is the class

	parent_cluster: CLUSTER_I
			-- Parent cluster of Current cluster
			-- (Void implies it is a top level cluster)

	sub_clusters: ARRAYED_LIST [CLUSTER_I]
			-- List of sub clusters for Current cluster

feature -- Access

	name_in_upper: STRING is
			-- Cluster name in upper case
		do
			Result := cluster_name.as_upper
		end

feature -- Formatting

	format (a_text_formatter: TEXT_FORMATTER) is
			-- Output name of Current in `a_text_formatter'.
			-- (from ASSEMBLY_INFO)
		require -- from ASSEMBLY_INFO
			st_not_void: a_text_formatter /= Void
		do
			a_text_formatter.add_string (path)
		end

feature -- Type anchors

	class_anchor: CLASS_I is
			-- Type of classes one can insert in Current
		do
		end

invariant
	path_not_void: path /= Void
	classes_not_void: classes /= Void
	sub_clusters_not_void: sub_clusters /= Void

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
