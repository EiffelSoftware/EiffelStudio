indexing
	description: "Abstract representation of a cluster in AST for Lace"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLUSTER_SD

inherit
	AST_LACE

create
	initialize

feature {NONE} -- Initialization

	initialize (cn: like cluster_name; pn: like parent_name;
		dn: like directory_name; cp: like cluster_properties;
		is_all, is_lib: BOOLEAN) is
			-- Create a new CLUSTER AST node.
		require
			cn_not_void: cn /= Void
			dn_not_void: dn /= Void
		do
			cluster_name := cn
			cluster_name.to_lower
			parent_name := pn
			if parent_name /= Void then
				parent_name.to_lower
			end
			directory_name := dn
			cluster_properties := cp
			is_recursive := is_all
			is_library := is_lib
		ensure
			cluster_name_set: cluster_name = cn
			parent_name_set: parent_name = pn
			directory_name_set: directory_name = dn
			cluster_properties_set: cluster_properties = cp
			recursive_cluster_set: is_recursive = is_all
			library_cluster_set: is_library = is_lib
		end

feature -- Properties

	cluster_name: ID_SD;
			-- Cluster name

	directory_name: ID_SD;
			-- Path to the cluster

	cluster_properties: CLUST_PROP_SD;
			-- Cluster properties

	parent_name: ID_SD;
			-- Name of the parent cluster

	is_recursive: BOOLEAN
			-- Must subclusters be processed (keyword `all')?

	is_library: BOOLEAN
			-- Is cluster part of a library and therefore not subject to changes?

feature -- Status

	has_parent: BOOLEAN is
			-- Does Current have a parent cluster
		do
			Result := parent_name /= Void
		ensure
			has_parent: Result implies parent_name /= Void
			not_has_parent: not Result implies parent_name = Void
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

end -- class CLUSTER_SD


