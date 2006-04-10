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

	EB_CLUSTER_MANAGER_OBSERVER
		undefine
			default_create
		redefine
			on_class_moved,
			on_cluster_changed
		end

	EB_CONSTANTS
		undefine
			default_create
		end

	CONF_REFACTORING
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

			manager.add_observer (Current)
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
			l_classes: LIST [CLASS_I]
		do
			l_classes := cluster.cluster_i.classes.linear_representation
			create {ARRAYED_LIST [EG_LINKABLE]} last_included_classes.make (l_classes.count)
			from
				l_classes.start
			until
				l_classes.after
			loop
				add_class (l_classes.item, cluster)
				if last_added_class /= Void then
					last_included_classes.extend (last_added_class)
				end
				l_classes.forth
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

feature {NONE} -- Cluster manger observer

	on_class_moved (a_class: CONF_CLASS; old_cluster: CONF_GROUP) is
			-- `a_class' has been moved away from `old_cluster'.
		local
			old_clus, new_clus: ES_CLUSTER
			l_class: ES_CLASS
		do
			conf_todo
--			l_class := class_from_interface (a_class)
--			if l_class /= Void and then l_class.is_needed_on_diagram then
--				old_clus := cluster_from_interface (old_cluster)
--				new_clus := cluster_from_interface (a_class.cluster)
--
--				if old_clus /= Void and then old_clus.is_needed_on_diagram and then old_clus.has (l_class) then
--					if new_clus = Void or else not new_clus.is_needed_on_diagram then
--						remove_links (l_class.links)
--						remove_node (l_class)
--						context_editor.history.wipe_out
--						remove_unneeded_items
--					else
--						old_clus.prune_all (l_class)
--						new_clus.extend (l_class)
--						context_editor.history.register_named_undoable (
--							interface_names.t_diagram_move_class_cmd (l_class.name),
--							[<<agent old_clus.prune_all (l_class),
--							   agent new_clus.extend (l_class),
--							   agent manager.move_class (l_class.class_i.config_class, old_clus.cluster_i, new_clus.cluster_i)>>],
--							[<<agent new_clus.prune_all (l_class),
--							   agent old_clus.extend (l_class),
--							   agent manager.move_class (l_class.class_i.config_class, new_clus.cluster_i, old_clus.cluster_i)>>])
--					end
--				elseif new_clus /= Void and then new_clus.is_needed_on_diagram and then not new_clus.has (l_class) then
--				   	if old_clus = Void or else not old_clus.is_needed_on_diagram then
--				   		check
--				   			l_class_is_not_on_diagram: False
--				   		end
--				   	else
--				   		old_clus.prune_all (l_class)
--						new_clus.extend (l_class)
--						context_editor.history.register_named_undoable (
--							interface_names.t_diagram_move_class_cmd (l_class.name),
--							[<<agent old_clus.prune_all (l_class),
--							   agent new_clus.extend (l_class),
--							   agent manager.move_class (l_class.class_i.config_class, old_clus.cluster_i, new_clus.cluster_i)>>],
--							[<<agent new_clus.prune_all (l_class),
--							   agent old_clus.extend (l_class),
--							   agent manager.move_class (l_class.class_i.config_class, new_clus.cluster_i, old_clus.cluster_i)>>])
--				   	end
--				end
--			end
		end

	on_cluster_changed (a_cluster: CLUSTER_I) is
			-- `a_cluster' was renamed.
		local
			l_cluster: ES_CLUSTER
		do
			l_cluster := cluster_from_interface (a_cluster)
			if l_cluster /= Void then
				l_cluster.set_name (a_cluster.cluster_name)
			end
		end

feature {NONE} -- Implementation

	explore_relations is
			--
		local
			nb_of_items: INTEGER
		do
			if context_editor /= Void then
				nb_of_items := number_of_superclusters (center_cluster.cluster_i, supercluster_depth) +
							   number_of_subclusters (center_cluster.cluster_i, subcluster_depth)

				context_editor.development_window.status_bar.reset_progress_bar_with_range (0 |..| nb_of_items)
			end

			if context_editor /= Void then
				context_editor.development_window.status_bar.display_message ("Exploring superclusters of " + center_cluster.name)
			end
			explore_superclusters (center_cluster, supercluster_depth)

			if context_editor /= Void then
				context_editor.development_window.status_bar.display_message ("Exploring subclusters of " + center_cluster.name)
			end
			explore_subclusters (center_cluster, subcluster_depth)
		end

	number_of_superclusters (a_cluster: CLUSTER_I; depth: INTEGER): INTEGER is
			-- Add superclusters of `a_cluster' until `depth' is reached.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			new_cluster: CLUSTER_I
		do
			if depth > 0 then
				new_cluster := a_cluster.parent_cluster
				if new_cluster /= Void then
					Result := Result + number_of_superclusters (new_cluster, depth - 1) + 1
				end
			end
		end

	explore_superclusters (a_cluster: ES_CLUSTER; depth: INTEGER) is
			-- Add superclusters of `a_cluster' until `depth' is reached.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			new_cluster: CLUSTER_I
			es_cluster: ES_CLUSTER
		do
			if depth > 0 then
				new_cluster := a_cluster.cluster_i.parent_cluster
				if new_cluster /= Void then
					create es_cluster.make (new_cluster)
					add_cluster (es_cluster)
					if context_editor /= Void then
						context_editor.development_window.status_bar.display_progress_value (
							context_editor.development_window.status_bar.current_progress_value + 1
						)
					end
					include_all_classes (es_cluster)
					es_cluster.extend (a_cluster)
					explore_superclusters (es_cluster, depth - 1)
				end
			end
		end

	number_of_subclusters (a_cluster: CLUSTER_I; depth: INTEGER): INTEGER is
			-- Add subclusters of `a_cluster' until `depth' is reached.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			new_cluster: CLUSTER_I
		do
			if depth > 0 then
				sub_clusters := a_cluster.sub_clusters
				from
					sub_clusters.start
				until
					sub_clusters.after
				loop
					new_cluster := sub_clusters.item
					Result := Result + number_of_subclusters (new_cluster, depth - 1) + 1
					sub_clusters.forth
				end
			end
		end

	explore_subclusters (a_cluster: ES_CLUSTER; depth: INTEGER) is
			-- Add subclusters of `a_cluster' until `depth' is reached.
		require
			a_cluster_not_void: a_cluster /= Void
		local
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			new_cluster: CLUSTER_I
			es_cluster: ES_CLUSTER
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			if depth > 0 then
				sub_clusters := a_cluster.cluster_i.sub_clusters
				from
					sub_clusters.start
					if context_editor /= Void then
						l_status_bar := context_editor.development_window.status_bar
					end
				until
					sub_clusters.after
				loop
					new_cluster := sub_clusters.item
					create es_cluster.make (new_cluster)
					add_cluster (es_cluster)
					if l_status_bar /= Void then
						l_status_bar.display_progress_value (
							l_status_bar.current_progress_value + 1
						)
					end
					include_all_classes (es_cluster)
					a_cluster.extend (es_cluster)
					explore_subclusters (es_cluster, depth - 1)
					sub_clusters.forth
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
				es_class := class_from_interface (a_class)
				if es_class = Void then
					create es_class.make (a_class)
					add_node (es_class)
					cluster.extend (es_class)
					last_added_class := es_class
				elseif not es_class.is_needed_on_diagram then
					es_class.enable_needed_on_diagram
					if es_class.is_compiled then
						add_ancestor_relations (es_class)
						add_descendant_relations (es_class)
						add_client_relations (es_class)
						add_supplier_relations (es_class)
					end
					if not cluster.has (es_class) then
						cluster.extend (es_class)
					end
					last_added_class := es_class
				end
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
