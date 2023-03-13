note
	description: "Objects that is a graph model for a given group"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLUSTER

inherit
	EM_CLUSTER
		redefine
			node_type,
			cluster
		end

	ES_ITEM
		undefine
			default_create,
			is_equal
		end

	SHARED_WORKBENCH
		undefine
			default_create,
			is_equal
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		undefine
			default_create,
			is_equal
		end

create
	make,
	make_with_id

feature {NONE} -- Implementation

	make (a_group: like group)
			-- Create an ES_CLUSTER from `cluster_i'.
		require
			a_group_not_void: a_group /= Void
		do
			if cluster_id = Void then
				cluster_id := generate_uuid
			end
			group := a_group
			make_with_name (a_group.name)
			group_id := id_of_group (a_group)
			is_needed_on_diagram := True
		end

	make_with_id (a_group: like group; a_id: STRING)
			-- Create an ES_CLUSTER from `cluster_i'.
		require
			a_group_not_void: a_group /= Void
			a_id_not_void: a_id /= Void
		do
			cluster_id := a_id
			make (a_group)
		end

feature -- Access

	group: CONF_GROUP
			-- cluster_i `Current' is model for.

	cluster: ES_CLUSTER
			-- Parent cluster.

	group_id: STRING
			-- Group identifier

	cluster_id: STRING
			-- ES_CLUSTER identifier

	needed_links: LIST [ES_ITEM]
			-- `links' that are EIFFEL_ITEMS and are needed_on_diagram.
		local
			l_links: like internal_links
		do
			l_links := internal_links
			create {ARRAYED_LIST [ES_ITEM]} Result.make (l_links.count)
			from
				l_links.start
			until
				l_links.after
			loop
				if attached {ES_ITEM} l_links.item as l_item and then l_item.is_needed_on_diagram then
					Result.extend (l_item)
				end
				l_links.forth
			end
		end

	needed_linkables: LIST [ES_ITEM]
			-- `linkables' that are EIFFEL_ITEMS and are needed_on_diagram.
		local
			l_linkables: like linkables
		do
			l_linkables := linkables
			create {ARRAYED_LIST [ES_ITEM]} Result.make (l_linkables.count)
			from
				l_linkables.start
			until
				l_linkables.after
			loop
				if attached {ES_ITEM} l_linkables.item as l_item and then l_item.is_needed_on_diagram then
					Result.extend (l_item)
				end
				l_linkables.forth
			end
		end

feature {EIFFEL_CLUSTER_FIGURE} -- Element Change

	set_group_id (a_str: STRING)
			-- Set `group_id' with `a_str'
		require
			a_str_not_void: a_str /= Void
		do
			group_id := a_str
		ensure
			group_id_not_void: group_id /= Void
		end

	set_cluster_id (a_id: STRING)
			-- Set `cluster_id' with `a_id'
		require
			a_id_not_void: a_id /= Void
		do
			cluster_id := a_id
		ensure
			cluster_id_not_void: cluster_id /= Void
		end

feature -- Element change

	synchronize
			-- Some properties may have changed due to recompilation.
			-- | Check sub clusters, if not correct, disconnect the relationship.
		do
			if not group.is_valid then
				graph.remove_all (Current)
			else
				if attached {like Current} cluster as l_cluster then
					if attached {CONF_CLUSTER} group as l_clu then
						if l_clu.parent /= l_cluster.group then
							remove_cluster
							l_cluster.prune_all (Current)
						else
							set_name_32 (group.name)
							group_id := id_of_group (group)
						end
					else
						if attached {CONF_LIBRARY} group as l_lib then
							if not l_cluster.group.is_library then
								remove_cluster
								l_cluster.prune_all (Current)
							elseif
								attached {CONF_LIBRARY} l_cluster.group as l_cluster_lib and then
								(
									not l_cluster_lib.library_target.libraries.has_key (group.name) or else
									l_cluster_lib.library_target.libraries.found_item /= group
								)
							then
								remove_cluster
								l_cluster.prune_all (Current)
							else
								set_name_32 (group.name)
								group_id := id_of_group (group)
							end
						end
					end
				end
			end
		end

	node_of (a_class: CLASS_I): like node_type
			-- Node of `a_class'
		local
			l_linkables: like linkables
			i: INTEGER
		do
			l_linkables := linkables
			from
				i := l_linkables.count
			until
				i = 0 or Result /= Void
			loop
				if attached {like node_type} l_linkables [i] as l_node and then l_node.class_i = a_class then
					Result := l_node
				end
				i := i - 1
			end
		end

	sub_cluster_of (a_cluster: CONF_GROUP): like Current
			--
		local
			l_linkables: like linkables
			i: INTEGER
		do
			l_linkables := linkables
			from
				i := l_linkables.count
			until
				i = 0 or Result /= Void
			loop
				if attached {like Current} l_linkables [i] as l_cluster and then l_cluster.group = a_cluster then
					Result := l_cluster
				end
				i := i - 1
			end
		end

feature -- Node type

	node_type: ES_CLASS;

invariant
	group_not_void: group /= Void
	identifier_not_void: group_id /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
