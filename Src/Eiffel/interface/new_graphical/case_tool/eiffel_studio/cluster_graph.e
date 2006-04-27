indexing
	description: "Objects that is a graph of clusters and classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLUSTER_GRAPH

inherit
	ES_GRAPH
		redefine
			default_create,
			synchronize
		end

	EB_CONSTANTS
		undefine
			default_create
		end

create
	make,
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Create an ES_CLUSTER_GRAPH.
		do
			Precursor {ES_GRAPH}

			subcluster_depth := 1
			supercluster_depth := 1
		end


	make (a_tool: like context_editor) is
			-- Create a ES_CLUSTER_GRAPH in `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			default_create
			context_editor := a_tool
		ensure
			set: context_editor = a_tool
		end

feature -- Access

	supercluster_depth: INTEGER
			-- Depth of sub-clusters.

	subcluster_depth: INTEGER
			-- Depth of super-clusters.

	center_cluster: ES_CLUSTER
			-- Center cluster of `Current'.

	cluster_of_id (a_id: STRING): ES_CLUSTER is
			-- Cluster of cluster_id `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_clusters: ARRAYED_LIST [EG_CLUSTER]
			l_cluster: ES_CLUSTER
		do
			l_clusters := clusters
			from
				l_clusters.start
			until
				l_clusters.after or Result /= Void
			loop
				l_cluster ?= l_clusters.item
				check
					l_cluster_not_void: l_cluster /= Void
				end
				if l_cluster.cluster_id.is_equal (a_id) then
					Result := l_cluster
				end
				l_clusters.forth
			end
		end

feature -- Element change

	set_supercluster_depth (a_supercluster_depth: like supercluster_depth) is
			-- Set `supercluster_depth' to `a_supercluster_depth'.
		require
			a_supercluster_depth_non_negative: a_supercluster_depth >= 0
		do
			supercluster_depth := a_supercluster_depth
		ensure
			supercluster_depth_assigned: supercluster_depth = a_supercluster_depth
		end

	set_subcluster_depth (a_subcluster_depth: like subcluster_depth) is
			-- Set `subcluster_depth' to `a_subcluster_depth'.
		require
			a_subcluster_depth_non_negative: a_subcluster_depth >= 0
		do
			subcluster_depth := a_subcluster_depth
		ensure
			subcluster_depth_assigned: subcluster_depth = a_subcluster_depth
		end

	set_center_cluster (a_center_cluster: like center_cluster) is
			-- Set `center_cluster' to `a_center_cluster'.
		require
			a_center_cluster_not_void: a_center_cluster /= Void
		do
			center_cluster := a_center_cluster
		ensure
			set: center_cluster = a_center_cluster
		end

	explore_center_cluster is
			-- Explore relations according to `center_cluster'.
		require
			center_cluster_not_void: center_cluster /= Void
		do
			wipe_out
			add_cluster (center_cluster)
			include_all_classes (center_cluster)
			explore_relations
		end

	include_all_classes (cluster: ES_CLUSTER) is
			-- Include all classes in `cluster'.
		require
			cluster_not_void: cluster /= Void
		local
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_class: CLASS_I
		do
			if cluster.group.is_cluster then
				l_classes := cluster.group.classes
				if l_classes /= Void then
					create {ARRAYED_LIST [EG_LINKABLE]} last_included_classes.make (l_classes.count)
					from
						l_classes.start
					until
						l_classes.after
					loop
						l_class ?= l_classes.item_for_iteration
						check
							l_class_not_viod: l_class /= Void
						end
						add_class (l_class, cluster)
						if last_added_class /= Void then
							last_included_classes.extend (last_added_class)
						end
						l_classes.forth
					end
				else
					create {ARRAYED_LIST [EG_LINKABLE]} last_included_classes.make (0)
				end
			else
				create {ARRAYED_LIST [EG_LINKABLE]} last_included_classes.make (0)
			end
		ensure
			last_included_classes_not_void: last_included_classes /= Void
		end

	last_included_classes: LIST [EG_LINKABLE]
			-- Last classes added by `include_all_classes'.

feature {EB_CONTEXT_EDITOR} -- Synchronization

	synchronize is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchronization.
		do
			Precursor {ES_GRAPH}
			if not has_cluster (center_cluster) then
				check
					not center_cluster.is_needed_on_diagram
				end
				add_cluster (center_cluster)
			end
		end

feature {NONE} -- Implementation

	explore_relations is
			--
		local
			nb_of_items: INTEGER
		do
			if context_editor /= Void then
				nb_of_items := number_of_superclusters (center_cluster.group, supercluster_depth) +
							   number_of_subclusters (center_cluster.group, subcluster_depth)

				context_editor.development_window.status_bar.reset_progress_bar_with_range (0 |..| nb_of_items)
			end

			if context_editor /= Void then
				context_editor.development_window.status_bar.display_message ("Exploring superclusters of " + center_cluster.name)
			end
			explore_superclusters (center_cluster, supercluster_depth)

			if context_editor /= Void then
				context_editor.development_window.status_bar.display_message ("Exploring subclusters of " + center_cluster.name)
			end
			explore_subclusters (center_cluster, subcluster_depth, True, True)
		end

	number_of_superclusters (a_group: CONF_GROUP; depth: INTEGER): INTEGER is
			-- Add superclusters of `a_cluster' until `depth' is reached.
		require
			a_group_not_void: a_group /= Void
		local
			l_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_libs: ARRAYED_LIST [CONF_LIBRARY]
		do
			if depth > 0 then
				l_group := a_group
				if l_group.is_cluster then
					l_cluster ?= l_group
					if l_cluster.parent /= Void then
						Result := Result + number_of_superclusters (l_cluster.parent, depth - 1) + 1
					end
				elseif l_group.is_library then
					l_lib ?= l_group
					if l_lib.target.used_in_libraries /= Void then
						l_libs := l_lib.target.used_in_libraries.twin
					end
					if l_libs /= Void then
						from
							l_libs.start
						until
							l_libs.after
						loop
							Result := Result + number_of_superclusters (l_libs.item, depth - 1) + 1
							l_libs.forth
						end
					end
				end
			end
		end

	explore_superclusters (a_group: ES_CLUSTER; depth: INTEGER) is
			-- Add superclusters of `a_group' until `depth' is reached.
		require
			a_group_not_void: a_group /= Void
		local
			l_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_libs: ARRAYED_LIST [CONF_LIBRARY]
			es_cluster: ES_CLUSTER
			l_need_new: BOOLEAN
			l_cluster_clone: ES_CLUSTER
		do
			if depth > 0 then
				l_group := a_group.group
				if l_group.is_cluster then
					l_cluster ?= l_group
					if l_cluster.parent /= Void then
						create es_cluster.make (l_cluster.parent)
						add_cluster (es_cluster)
						if context_editor /= Void then
							context_editor.development_window.status_bar.display_progress_value (
								context_editor.development_window.status_bar.current_progress_value + 1
							)
						end
						include_all_classes (es_cluster)
						es_cluster.extend (a_group)
						explore_superclusters (es_cluster, depth - 1)
					end
				elseif l_group.is_library then
					l_lib ?= l_group
					if l_lib.target.used_in_libraries /= Void then
						l_libs := l_lib.target.used_in_libraries.twin
					end
					if l_libs /= Void then
						from
							l_libs.start
						until
							l_libs.after
						loop
							create es_cluster.make (l_libs.item)
							add_cluster (es_cluster)
							if context_editor /= Void then
								context_editor.development_window.status_bar.display_progress_value (
									context_editor.development_window.status_bar.current_progress_value + 1
								)
							end
							include_all_classes (es_cluster)
							if not l_need_new then
								es_cluster.extend (a_group)
								l_need_new := True
							else
								create l_cluster_clone.make (a_group.group)
								es_cluster.extend (l_cluster_clone)
								explore_subclusters (l_cluster_clone, subcluster_depth, False, False)
							end
							explore_superclusters (es_cluster, depth - 1)
							l_libs.forth
						end
					end
				end
			end
		end

	number_of_subclusters (a_group: CONF_GROUP; depth: INTEGER): INTEGER is
			-- Add subgroups of `a_group' until `depth' is reached.
		require
			a_group_not_void: a_group /= Void
		local
			sub_clusters: ARRAYED_LIST [CONF_CLUSTER]
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_groups: HASH_TABLE [CONF_GROUP, STRING]
		do
			if depth > 0 then
				if a_group.is_cluster then
					l_cluster ?= a_group
					sub_clusters := l_cluster.children
					if sub_clusters /= Void then
						from
							sub_clusters.start
						until
							sub_clusters.after
						loop
							Result := Result + number_of_subclusters (sub_clusters.item, depth - 1) + 1
							sub_clusters.forth
						end
					end
				elseif a_group.is_library then
					l_lib ?= a_group
					l_groups := l_lib.library_target.groups
					from
						l_groups.start
					until
						l_groups.after
					loop
						if not l_groups.item_for_iteration.is_assembly then
							Result := Result + number_of_subclusters (l_groups.item_for_iteration, depth - 1) + 1
						end
						l_groups.forth
					end
				elseif a_group.is_assembly then
					check error: false end
				end
			end
		end

	explore_subclusters (a_group: ES_CLUSTER; depth: INTEGER; include_class: BOOLEAN; status_bar: BOOLEAN) is
			-- Add subclusters of `a_group' until `depth' is reached.
		require
			a_group_not_void: a_group /= Void
		local
			sub_clusters: ARRAYED_LIST [CONF_CLUSTER]
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_groups: HASH_TABLE [CONF_GROUP, STRING]
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			l_group: CONF_GROUP
			es_cluster: ES_CLUSTER
		do
			if depth > 0 then
				if context_editor /= Void then
					l_status_bar := context_editor.development_window.status_bar
				end
				l_group := a_group.group
				if l_group.is_cluster then
					l_cluster ?= l_group
					sub_clusters := l_cluster.children
					if sub_clusters /= Void then
						from
							sub_clusters.start
						until
							sub_clusters.after
						loop
							create es_cluster.make (sub_clusters.item)
							add_cluster (es_cluster)
							if l_status_bar /= Void and status_bar then
								l_status_bar.display_progress_value (
									l_status_bar.current_progress_value + 1
								)
							end
							if include_class then
								include_all_classes (es_cluster)
							end
							a_group.extend (es_cluster)
							explore_subclusters (es_cluster, depth - 1, include_class, status_bar)
							sub_clusters.forth
						end
					end
				elseif l_group.is_library then
					l_lib ?= l_group
					l_groups := l_lib.library_target.groups
					from
						l_groups.start
					until
						l_groups.after
					loop
						if not l_groups.item_for_iteration.is_assembly then
							create es_cluster.make (l_groups.item_for_iteration)
							add_cluster (es_cluster)
							if l_status_bar /= Void and status_bar then
								l_status_bar.display_progress_value (
									l_status_bar.current_progress_value + 1
								)
							end
							if include_class then
								include_all_classes (es_cluster)
							end
							a_group.extend (es_cluster)
							explore_subclusters (es_cluster, depth - 1, include_class, status_bar)
						end
						l_groups.forth
					end
				elseif l_group.is_assembly then
					check error: false end
				end
			end
		end

	add_class (a_class: CLASS_I; cluster: ES_CLUSTER) is
			-- Include `a_class' in the diagram.
			-- Add any relations `a_class' may have with
			-- all items in `class_figures'.
		require
			a_class_not_void: a_class /= Void
		local
			es_class: ES_CLASS
		do
			last_added_class := Void
			if context_editor = Void or else not context_editor.is_excluded_in_preferences (a_class.name_in_upper) then
				es_class := cluster.node_of (a_class)
				if es_class = Void then
					create es_class.make (a_class)
					add_node (es_class)
					cluster.extend (es_class)
					last_added_class := es_class
				elseif not es_class.is_needed_on_diagram then
					es_class.enable_needed_on_diagram
					if not cluster.has (es_class) then
						cluster.extend (es_class)
					end
					last_added_class := es_class
				end
				add_node_relations (es_class)
			end
		end

	last_added_class: ES_CLASS

invariant
	subcluster_depth_positive: subcluster_depth >= 0
	supercluster_depth_positive: supercluster_depth >= 0

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

end -- class ES_CLUSTER_GRAPH
