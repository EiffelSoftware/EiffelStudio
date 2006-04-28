indexing
	description: "Objects that is view for a CLUSTER_GRAPH"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CLUSTER_DIAGRAM

inherit
	EIFFEL_WORLD
		redefine
			default_create,
			model,
			xml_node_name,
			xml_element,
			set_with_xml_element,
			recycle
		end

	SHARED_ERROR_HANDLER
		undefine
			default_create
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create
		end

	EB_CLUSTER_MANAGER_OBSERVER
		undefine
			default_create
		redefine
			on_class_added,
			on_cluster_added,
			on_class_moved,
			on_cluster_changed
		end

create
	default_create

create {EIFFEL_CLUSTER_DIAGRAM}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_CLUSTER_DIAGRAM.
		do
			Precursor {EIFFEL_WORLD}
			drop_actions.extend (agent on_class_drop)
			drop_actions.extend (agent on_group_drop)
			drop_actions.extend (agent on_new_class_drop)
			drop_actions.set_veto_pebble_function (agent veto_function)
			manager.add_observer (Current)
		end

feature -- Access

	model: ES_CLUSTER_GRAPH
			-- Model for `Current'.

feature -- Store/Retrive

	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		do
			Result := "EIFFEL_CLUSTER_DIAGRAM"
		end

	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			node.add_attribute ("NAME", xml_namespace, current_view)
			node.put_last (Xml_routines.xml_node (node, "SUBCLUSTER_DEPTH", model.subcluster_depth.out))
			node.put_last (Xml_routines.xml_node (node, "SUPERCLUSTER_DEPTH", model.supercluster_depth.out))
			node.put_last (xml_routines.xml_node (node, "CENTER_CLUSTER_ID", model.center_cluster.cluster_id))
			Result := Precursor {EIFFEL_WORLD} (node)
		end

	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			l_cluster_id: STRING
			esc: ES_CLUSTER
		do
			node.forth
			model.set_subcluster_depth (xml_routines.xml_integer (node, "SUBCLUSTER_DEPTH"))
			model.set_supercluster_depth (xml_routines.xml_integer (node, "SUPERCLUSTER_DEPTH"))
			l_cluster_id := xml_routines.xml_string (node, "CENTER_CLUSTER_ID")
			Precursor {EIFFEL_WORLD} (node)

			esc := model.cluster_of_id (l_cluster_id)
			model.set_center_cluster (esc)
		end

feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_WORLD}
			drop_actions.prune_all (agent on_class_drop)
			drop_actions.prune_all (agent on_group_drop)
			drop_actions.prune_all (agent on_new_class_drop)
			manager.remove_observer (Current)
		end

feature -- Status

	classes_in_same_scope (a_source, a_target: ES_CLASS): BOOLEAN is
			-- Are `a_source' and `a_target' in the same scope.
		require
			a_source_not_void: a_source /= Void
			a_target_not_void: a_target /= Void
		local
			l_classes: ARRAYED_LIST [ES_CLASS]
		do
			l_classes := model.possible_linkable_node (a_source)
			if l_classes.has (a_target) then
				Result := True
			end
		end

feature {EB_DIAGRAM_HTML_GENERATOR} -- Load view

	change_view (view_name: STRING; file_name: STRING) is
			-- Change view to `view_name' load from `file_name' without saving `Current'.
		local
			f: RAW_FILE
		do
			current_view := view_name
			create f.make (file_name)
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
			end
		end

feature {NONE} -- Implementation

	on_group_drop (a_stone: CLUSTER_STONE) is
			-- Add to diagram.
		local
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
		do
			if a_stone.group.is_cluster then
				l_cluster ?= a_stone.group
				on_cluster_drop (l_cluster)
			elseif a_stone.group.is_library then
				l_lib ?= a_stone.group
				on_library_drop (l_lib)
			end
		end

	on_cluster_drop (a_cluster: CONF_CLUSTER) is
			--
		local
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			parent: ES_CLUSTER
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_cluster, es_cluster : ES_CLUSTER
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			nr_of_items: INTEGER
			cluster_fig, parent_fig: EIFFEL_CLUSTER_FIGURE
			cluster_added: BOOLEAN
			remove_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]
			remove_links: LIST [ES_ITEM]
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
		do
			l_clusters := parents_of_group (a_cluster)

			context_editor.projector.disable_painting
			context_editor.disable_resize
			context_editor.update_excluded_class_figures
			l_status_bar := window_status_bar
			l_classes := a_cluster.classes
			if l_classes = Void then
				create l_classes.make (0)
			end
			l_status_bar.progress_bar.set_value (0)
			l_status_bar.display_message ("Including Cluster: Adding Classes into Cluster")

			if not l_clusters.is_empty and any_clusters_needed (l_clusters) then
				nr_of_items := l_classes.count * l_clusters.count
				l_status_bar.progress_bar.reset_with_range (0 |..| nr_of_items)
				create l_array_redo.make (5)
				create l_array_undo.make (5)
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					cluster_added := False
					parent := l_clusters.item
					parent_fig ?= figure_from_model (parent)
					l_cluster := parent.sub_cluster_of (a_cluster)
					if parent.is_needed_on_diagram and then l_cluster = Void then
						create es_cluster.make (a_cluster)
						model.add_cluster (es_cluster)
						parent.extend (es_cluster)
						model.add_children_relations (es_cluster, parent)
						add_classes_of_cluster (es_cluster, True, True)
						cluster_fig ?= figure_from_model (es_cluster)
						cluster_fig.set_port_position (parent_fig.port_x, parent_fig.port_y)

						check
							fig_inserted: cluster_fig /= Void
						end
						cluster_added := True
						context_editor.layout.layout_cluster (cluster_fig, 1)
					elseif parent.is_needed_on_diagram and then not l_cluster.is_needed_on_diagram then
						add_classes_of_cluster (l_cluster, False, True)
						model.add_children_relations (l_cluster, parent)
						cluster_fig ?= figure_from_model (l_cluster)
						cluster_fig.set_port_position (parent_fig.port_x, parent_fig.port_y)
						check
							fig_inserted: cluster_fig /= Void
						end
						cluster_added := True
						context_editor.layout.layout_cluster (cluster_fig, 1)
					else
						l_status_bar.progress_bar.set_value (l_status_bar.progress_bar.value + l_classes.count)
					end
					if cluster_added then
						update_cluster_legend
						remove_classes := classes_to_remove_in_cluster (es_cluster)
						remove_links := links_to_remove_in_classes (remove_classes)
						l_array_redo.extend (agent reinclude_cluster (cluster_fig, remove_links, remove_classes))
						l_array_undo.extend (agent remove_cluster_virtual (cluster_fig, remove_links, remove_classes))
						l_array_redo.extend (agent update_cluster_legend)
						l_array_undo.extend (agent update_cluster_legend)
					end
					l_clusters.forth
				end
				if not l_array_redo.is_empty and then not l_array_undo.is_empty then
					context_editor.history.register_named_undoable (interface_names.t_diagram_include_cluster_cmd (a_cluster.name),
																	[l_array_redo], [l_array_undo])
				end
			else
				nr_of_items := l_classes.count
				l_status_bar.progress_bar.reset_with_range (0 |..| nr_of_items)
				check_and_add_on_top (a_cluster, False)
			end

			l_status_bar.reset
			context_editor.enable_resize
			context_editor.projector.enable_painting
			update

			if is_right_angles then
				apply_right_angles
			end
			context_editor.projector.full_project
		end

	on_library_drop (a_lib: CONF_LIBRARY) is
			--
		local
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			parent: ES_CLUSTER
			es_cluster : ES_CLUSTER
			cluster_fig, parent_fig: EIFFEL_CLUSTER_FIGURE
			cluster_added: BOOLEAN
			remove_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]
			remove_links: LIST [ES_ITEM]
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
		do
			l_clusters := parents_of_group (a_lib)

			context_editor.projector.disable_painting
			context_editor.disable_resize
			context_editor.update_excluded_class_figures

			if not l_clusters.is_empty and then any_clusters_needed (l_clusters) then
				create l_array_redo.make (5)
				create l_array_undo.make (5)
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					cluster_added := False
					parent := l_clusters.item
					if parent.is_needed_on_diagram then
						parent_fig ?= figure_from_model (parent)
						es_cluster := parent.sub_cluster_of (a_lib)
						if es_cluster = Void then
							create es_cluster.make (a_lib)
							model.add_cluster (es_cluster)
							parent.extend (es_cluster)
							model.add_children_relations (es_cluster, parent)
							cluster_fig ?= figure_from_model (es_cluster)
							cluster_fig.set_port_position (parent_fig.port_x, parent_fig.port_y)

							check
								fig_inserted: cluster_fig /= Void
							end
							cluster_added := True
							context_editor.layout.layout_cluster (cluster_fig, 1)
						elseif not es_cluster.is_needed_on_diagram then
							es_cluster.enable_needed_on_diagram
							enable_all_links (es_cluster)
							model.add_children_relations (es_cluster, parent)
							cluster_fig ?= figure_from_model (es_cluster)
							cluster_fig.set_port_position (parent_fig.port_x, parent_fig.port_y)
							check
								fig_inserted: cluster_fig /= Void
							end
							cluster_added := True
							context_editor.layout.layout_cluster (cluster_fig, 1)
						end
						if cluster_added then
							update_cluster_legend
							remove_classes := classes_to_remove_in_cluster (es_cluster)
							remove_links := links_to_remove_in_classes (remove_classes)
							l_array_redo.extend (agent reinclude_cluster (cluster_fig, remove_links, remove_classes))
							l_array_undo.extend (agent remove_cluster_virtual (cluster_fig, remove_links, remove_classes))
							l_array_redo.extend (agent update_cluster_legend)
							l_array_undo.extend (agent update_cluster_legend)
						end
					end
					l_clusters.forth
				end
				if not l_array_redo.is_empty and then not l_array_undo.is_empty then
					context_editor.history.register_named_undoable (interface_names.t_diagram_include_library_cmd (a_lib.name),
																	[l_array_redo], [l_array_undo])
				end
			else
				check_and_add_on_top (a_lib, True)
			end

			context_editor.enable_resize
			context_editor.projector.enable_painting
			update

			if is_right_angles then
				apply_right_angles
			end
			context_editor.projector.full_project
		end

	on_class_drop (a_stone: CLASSI_STONE) is
			-- `a_stone' was dropped on `Current'
		local
			l_class_fig_stone: CLASSI_FIGURE_STONE
		do
			l_class_fig_stone ?= a_stone
			is_dropped_on_diagram := True
			if l_class_fig_stone /= Void then
				move_class (l_class_fig_stone.source, context_editor.pointer_position.x, context_editor.pointer_position.y)
			else
				add_to_diagram (a_stone.class_i)
			end
			is_dropped_on_diagram := False
		end

	on_class_added (a_class: CLASS_I) is
			-- `a_class' was added to the system.
		do
			if not is_dropped_on_diagram then
				add_to_diagram (a_class)
			end
		end

	on_cluster_added (a_cluster: CLUSTER_I) is
			-- `a_cluster' was added to the system.
		local
			parent, es_cluster: ES_CLUSTER
			parent_fig, cluster_fig: EG_CLUSTER_FIGURE
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
		do
			l_clusters := parents_of_group (a_cluster)
			if not l_clusters.is_empty then
				create l_array_redo.make (5)
				create l_array_undo.make (5)
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					parent := l_clusters.item
					parent_fig ?= figure_from_model (parent)
					create es_cluster.make (a_cluster)
					model.add_cluster (es_cluster)
					parent.extend (es_cluster)
					update_cluster_legend
					cluster_fig ?= figure_from_model (es_cluster)
					cluster_fig.set_port_position (parent_fig.port_x, parent_fig.port_y)
					l_array_redo.extend (agent es_cluster.enable_needed_on_diagram)
					l_array_undo.extend (agent es_cluster.disable_needed_on_diagram)
					l_array_redo.extend (agent update_cluster_legend)
					l_array_undo.extend (agent update_cluster_legend)
					l_clusters.forth
				end
				if not l_array_redo.is_empty and then not l_array_undo.is_empty then
					context_editor.history.register_named_undoable (interface_names.t_diagram_include_cluster_cmd (a_cluster.cluster_name),
																	[l_array_redo], [l_array_undo])
				end
			else
				check_and_add_on_top (a_cluster, False)
			end
			update
		end

	on_new_class_drop (a_stone: CREATE_CLASS_STONE) is
			-- `a_stone' was dropped on `Current'
			-- Display create class dialog and add to diagram.
		local
			dial: EB_CREATE_CLASS_DIALOG
			drop_x, drop_y: INTEGER
			clf: EIFFEL_CLUSTER_FIGURE
			l_cluster: CONF_CLUSTER
		do
			drop_x := context_editor.pointer_position.x
			drop_y := context_editor.pointer_position.y
			is_dropped_on_diagram := True
			clf := top_cluster_at (Current, drop_x, drop_y)
			create dial.make_default (context_editor.development_window)
			if clf /= Void then
				l_cluster ?= clf.model.group
				if l_cluster /= Void then
					dial.preset_cluster (l_cluster)
				end
			end
			dial.call_default
			include_new_dropped_class (dial, drop_x, drop_y)
			is_dropped_on_diagram := False
		end

feature {NONE} -- Cluster manger observer

	on_class_moved (a_class: CONF_CLASS; old_cluster: CONF_GROUP; old_path: STRING) is
			-- `a_class' has been moved away from `old_cluster'.
			-- `old_path' is old relative path in `old_group'
		local
			es_class: ES_CLASS
			l_class_i: CLASS_I
			new_cluster_i: CONF_CLUSTER
			old_cluster_i: CONF_CLUSTER
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			l_cluster: ES_CLUSTER
			l_classes: ARRAYED_LIST [ES_CLASS]
			l_remove_links: LIST [ES_ITEM]
			fig: EIFFEL_CLASS_FIGURE
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			l_manager: EB_CLUSTERS
		do
			if not is_dropped_on_diagram then
				l_class_i ?= a_class
				check
					l_class_i_not_void: l_class_i /= Void
				end
				new_cluster_i ?= l_class_i.group
				old_cluster_i ?= old_cluster

				l_classes := model.class_from_interface (l_class_i)
				l_clusters := model.cluster_from_interface (l_class_i.group)

				l_manager := manager
				create l_array_redo.make (10)
				create l_array_undo.make (10)
				from
					l_classes.start
				until
					l_classes.after
				loop
					es_class := l_classes.item
					l_remove_links := es_class.needed_links
					update_cluster_legend
					fig ?= figure_from_model (es_class)
					fig.request_update
					l_remove_links := es_class.needed_links
					l_array_redo.extend (agent remove_class_virtual (fig, l_remove_links))
					l_array_redo.extend (agent update_cluster_legend)
					l_array_undo.extend (agent reinclude_class (fig, l_remove_links, fig.x, fig.y))
					l_array_undo.extend (agent update_cluster_legend)
					l_classes.forth
				end

				from
					l_clusters.start
				until
					l_clusters.after
				loop
					l_cluster := l_clusters.item
					es_class := l_cluster.node_of (l_class_i)
					if es_class = Void then
						create es_class.make (l_class_i)
						l_cluster.extend (es_class)
						update_cluster_legend
						fig ?= figure_from_model (es_class)
						fig.request_update
						l_remove_links := es_class.needed_links
						l_array_redo.extend (agent reinclude_class (fig, l_remove_links, fig.x, fig.y))
						l_array_undo.extend (agent remove_class_virtual (fig, l_remove_links))
						l_array_redo.extend (agent update_cluster_legend)
						l_array_undo.extend (agent update_cluster_legend)
					elseif not es_class.is_needed_on_diagram then
						es_class.enable_needed_on_diagram
						enable_all_links (es_class)
						if es_class.class_i.is_compiled then
							model.add_ancestor_relations (es_class)
							model.add_descendant_relations (es_class)
							model.add_client_relations (es_class)
							model.add_supplier_relations (es_class)
						end
						update_cluster_legend
						fig ?= figure_from_model (es_class)
						fig.request_update
						l_remove_links := es_class.needed_links
						l_array_redo.extend (agent reinclude_class (fig, l_remove_links, fig.x, fig.y))
						l_array_undo.extend (agent remove_class_virtual (fig, l_remove_links))
						l_array_redo.extend (agent update_cluster_legend)
						l_array_undo.extend (agent update_cluster_legend)
					end
					l_clusters.forth
				end

				if not context_editor.history.is_redo_undoing then
					l_array_redo.extend (agent l_manager.move_class (l_class_i.config_class, old_cluster_i, new_cluster_i, l_class_i.path))
					l_array_undo.extend (agent l_manager.move_class (l_class_i.config_class, new_cluster_i, old_cluster_i, old_path))
					context_editor.history.register_named_undoable (interface_names.t_diagram_move_class_cmd (l_class_i.name),
																	[l_array_redo], [l_array_undo])
				end
			end
		end

	on_cluster_changed (a_cluster: CLUSTER_I) is
			-- `a_cluster' was renamed.
		local
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
		do
			l_clusters := model.cluster_from_interface (a_cluster)
			from
				l_clusters.start
			until
				l_clusters.after
			loop
				l_clusters.item.set_name (a_cluster.cluster_name)
				l_clusters.forth
			end
		end

feature {NONE} -- Implementation

	window_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR is
			-- Status bar of window
		do
			Result := context_editor.development_window.status_bar
		ensure
			Result_not_void: Result /= Void
		end

	add_to_diagram (a_class: CLASS_I) is
			-- Add `a_class' to diagram
		local
			parent: ES_CLUSTER
			new_class: ES_CLASS
			new_cluster: ES_CLUSTER
			remove_links: LIST [ES_ITEM]
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			class_cluster: CONF_GROUP
			es_cluster: ES_CLUSTER
			fig: EIFFEL_CLASS_FIGURE
			l_array_redo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			l_array_undo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
		do
			class_cluster := a_class.group
			l_clusters := model.cluster_from_interface (class_cluster)
			create l_array_redo.make (5)
			create l_array_undo.make (5)
			if not l_clusters.is_empty then
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					es_cluster := l_clusters.item
					if not es_cluster.is_needed_on_diagram then
						es_cluster.enable_needed_on_diagram
						l_array_redo.extend (agent es_cluster.enable_needed_on_diagram)
						l_array_undo.extend (agent es_cluster.disable_needed_on_diagram)
					end
					new_class := es_cluster.node_of (a_class)
					if new_class = Void then
						create new_class.make (a_class)
						es_cluster.extend (new_class)
						model.add_node_relations (new_class)
						update_cluster_legend
						fig ?= figure_from_model (new_class)
						fig.request_update
						remove_links := new_class.needed_links
						l_array_redo.extend (agent reinclude_class (fig, remove_links, fig.x, fig.y))
						l_array_undo.extend (agent remove_class_virtual (fig, remove_links))
						l_array_redo.extend (agent update_cluster_legend)
						l_array_undo.extend (agent update_cluster_legend)
					elseif not new_class.is_needed_on_diagram then
						new_class.enable_needed_on_diagram
						enable_all_links (new_class)
						model.add_node_relations (new_class)
						update_cluster_legend
						fig ?= figure_from_model (new_class)
						fig.request_update
						remove_links := new_class.needed_links
						l_array_redo.extend (agent reinclude_class (fig, remove_links, fig.x, fig.y))
						l_array_undo.extend (agent remove_class_virtual (fig, remove_links))
						l_array_redo.extend (agent update_cluster_legend)
						l_array_undo.extend (agent update_cluster_legend)
					end
					l_clusters.forth
				end
			else
				l_clusters := parents_of_group (class_cluster)
				if not l_clusters.is_empty then
					from
						l_clusters.start
					until
						l_clusters.after
					loop
						parent := l_clusters.item
						if not parent.is_needed_on_diagram then
							parent.enable_needed_on_diagram
							l_array_redo.extend (agent parent.enable_needed_on_diagram)
							l_array_undo.extend (agent parent.disable_needed_on_diagram)
						end
						create es_cluster.make (class_cluster)
						parent.extend (es_cluster)
						model.add_cluster (es_cluster)
						update_cluster_legend
						l_array_redo.extend (agent es_cluster.enable_needed_on_diagram)
						l_array_undo.extend (agent es_cluster.disable_needed_on_diagram)
						l_array_redo.extend (agent update_cluster_legend)
						l_array_undo.extend (agent update_cluster_legend)

						create new_class.make (a_class)
						es_cluster.extend (new_class)
						model.add_node_relations (new_class)
						update_cluster_legend
						fig ?= figure_from_model (new_class)
						fig.request_update
						remove_links := new_class.needed_links
						l_array_redo.extend (agent reinclude_class (fig, remove_links, fig.x, fig.y))
						l_array_undo.extend (agent remove_class_virtual (fig, remove_links))
						l_array_redo.extend (agent update_cluster_legend)
						l_array_undo.extend (agent update_cluster_legend)
						l_clusters.forth
					end
				else
					create new_cluster.make (class_cluster)
					model.add_cluster (new_cluster)
					l_array_redo.extend (agent parent.enable_needed_on_diagram)
					l_array_undo.extend (agent parent.disable_needed_on_diagram)

					create new_class.make (a_class)
					es_cluster.extend (new_class)
					model.add_node_relations (new_class)
					update_cluster_legend
					fig ?= figure_from_model (new_class)
					fig.request_update
					remove_links := new_class.needed_links
					l_array_redo.extend (agent reinclude_class (fig, remove_links, fig.x, fig.y))
					l_array_undo.extend (agent remove_class_virtual (fig, remove_links))
					l_array_redo.extend (agent update_cluster_legend)
					l_array_undo.extend (agent update_cluster_legend)
					l_clusters.forth
				end
			end
			if not l_array_redo.is_empty and then not l_array_undo.is_empty then
				context_editor.history.register_named_undoable (interface_names.t_Diagram_include_class_cmd (a_class.name),
																[l_array_redo], [l_array_undo])
			end
			if is_right_angles then
				apply_right_angles
			end
		end

	move_class (a_fig: EIFFEL_CLASS_FIGURE; drop_x, drop_y: INTEGER) is
			--
		local
			dropped_on_cluster: EIFFEL_CLUSTER_FIGURE
			fig: EIFFEL_CLASS_FIGURE
			remove_links: LIST [ES_ITEM]
			new_cluster_i, old_cluster_i: CONF_CLUSTER
			l_manager: EB_CLUSTERS
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			l_cluster : ES_CLUSTER
			l_classes: ARRAYED_LIST [ES_CLASS]
			l_class_i: CLASS_I
			es_class: ES_CLASS
			l_array_redo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			l_array_undo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			l_old_path: STRING
		do
			dropped_on_cluster := top_cluster_at (Current, drop_x, drop_y)
			if dropped_on_cluster /= Void then
				l_cluster := dropped_on_cluster.model
				l_class_i := a_fig.model.class_i
				l_old_path := l_class_i.config_class.path
				if l_cluster /= Void and
					l_cluster.group.is_cluster and then
					(l_cluster.group.classes = Void or else
					not l_cluster.group.classes.has (l_class_i.name))
				then
					l_clusters := model.cluster_from_interface (l_cluster.group)
					l_classes := model.class_from_interface (l_class_i)
					new_cluster_i ?= l_cluster.group
					old_cluster_i ?= l_class_i.group
					l_manager := manager
					create l_array_redo.make (10)
					create l_array_undo.make (10)
					from
						l_classes.start
					until
						l_classes.after
					loop
						es_class := l_classes.item
						fig ?= figure_from_model (es_class)
						remove_links := es_class.needed_links
						remove_class_virtual (fig, remove_links)
						update_cluster_legend
						l_array_redo.extend (agent remove_class_virtual (fig, remove_links))
						l_array_redo.extend (agent update_cluster_legend)
						l_array_undo.extend (agent reinclude_class (fig, remove_links, fig.x, fig.y))
						l_array_undo.extend (agent update_cluster_legend)
						l_classes.forth
					end

					from
						l_clusters.start
					until
						l_clusters.after
					loop
						l_cluster := l_clusters.item
						es_class := l_cluster.node_of (l_class_i)
						if es_class = Void then
							create es_class.make (l_class_i)
							l_cluster.extend (es_class)
							update_cluster_legend
							fig ?= figure_from_model (es_class)
							fig.request_update
							remove_links := es_class.needed_links
							l_array_redo.extend (agent reinclude_class (fig, remove_links, fig.x, fig.y))
							l_array_undo.extend (agent remove_class_virtual (fig, remove_links))
							l_array_redo.extend (agent update_cluster_legend)
							l_array_undo.extend (agent update_cluster_legend)
						elseif not es_class.is_needed_on_diagram then
							es_class.enable_needed_on_diagram
							enable_all_links (es_class)
							model.add_node_relations (es_class)
							update_cluster_legend
							fig ?= figure_from_model (es_class)
							fig.request_update
							remove_links := es_class.needed_links
							l_array_redo.extend (agent reinclude_class (fig, remove_links, fig.x, fig.y))
							l_array_undo.extend (agent remove_class_virtual (fig, remove_links))
							l_array_redo.extend (agent update_cluster_legend)
							l_array_undo.extend (agent update_cluster_legend)
						end
						l_clusters.forth
					end

					l_manager.move_class (l_class_i.config_class, old_cluster_i, new_cluster_i, "")
					if new_cluster_i.classes /= Void and then new_cluster_i.classes.has (l_class_i.name) then
						l_array_redo.extend (agent l_manager.move_class (l_class_i.config_class, old_cluster_i, new_cluster_i, ""))
						l_array_undo.extend (agent l_manager.move_class (l_class_i.config_class, new_cluster_i, old_cluster_i, l_old_path))
						context_editor.history.register_named_undoable (interface_names.t_diagram_move_class_cmd (l_class_i.name),
																		[l_array_redo], [l_array_undo])
					else
						from
							l_array_undo.start
						until
							l_array_undo.after
						loop
							l_array_undo.item.call ([])
							l_array_undo.forth
						end
					end
				end
			end
		end

	classes_to_remove_in_cluster (a_cluster: ES_CLUSTER): LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]] is
			-- All class figures in `a_cluster' that are needed on diagram plus ther positions.
		local
			l_linkables: LIST [EG_LINKABLE]
			es_class: ES_CLASS
			class_fig: EIFFEL_CLASS_FIGURE
		do
			from
				create {ARRAYED_LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]} Result.make (5)
				l_linkables := a_cluster.linkables
			until
				l_linkables.after
			loop
				es_class ?= l_linkables.item
				if es_class /= Void and then es_class.is_needed_on_diagram then
					class_fig ?= figure_from_model (es_class)
					if class_fig /= Void then
						Result.extend ([class_fig, class_fig.port_x, class_fig.port_y])
					end
				end
				l_linkables.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	links_to_remove_in_classes (a_classes: like classes_to_remove_in_cluster): LIST [ES_ITEM] is
			-- All links to remove in `a_cluster'
		require
			a_classes_not_void: a_classes /= Void
		local
			fig: EIFFEL_CLASS_FIGURE
		do
			from
				create {ARRAYED_LIST [ES_ITEM]}Result.make (a_classes.count * 2)
				a_classes.start
			until
				a_classes.after
			loop
				fig ?= a_classes.item.item (1)
				Result.append (fig.model.needed_links)
				a_classes.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	is_dropped_on_diagram: BOOLEAN
			-- Is a class added to a cluster dropped on diagram by user?

	include_new_dropped_class (a_create_class_dialog: EB_CREATE_CLASS_DIALOG; a_x, a_y: INTEGER) is
			-- Add `a_class' to the diagram if not already present.
		require
			a_create_class_dialog: a_create_class_dialog /= Void
		local
			a_class: CLASS_I
		do
			if not a_create_class_dialog.cancelled then
				a_class := a_create_class_dialog.class_i
				if a_class /= Void then
					add_to_diagram (a_class)
				end
			end
		end

	top_cluster_at (a_group: EV_MODEL_GROUP; ax, ay: INTEGER): EIFFEL_CLUSTER_FIGURE is
			-- Top cluster at `ax', `ay'. Void if none.
		local
			l_item: EIFFEL_CLUSTER_FIGURE
		do
			from
				a_group.start
			until
				a_group.after
			loop
				l_item ?= a_group.item
				if l_item /= Void and then l_item.model.is_needed_on_diagram
						and then
				   (ax >= l_item.left and then ax <= l_item.right)
						and then
				   (ay >= l_item.top and then ay <= l_item.bottom)
				then
					Result := top_cluster_at (l_item, ax, ay)
					if Result = Void then
						Result := l_item
					end
				end
				a_group.forth
			end
		end

	parents_of_group (a_cluster: CONF_GROUP): ARRAYED_LIST [ES_CLUSTER] is
			-- Parents of `a_cluster', clusters and libs included
		require
			a_cluster_not_void: a_cluster /= Void
		local
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_libs: ARRAYED_LIST [CONF_LIBRARY]
		do
			l_cluster ?= a_cluster
			l_lib ?= a_cluster
			if l_cluster /= Void then
				if l_cluster.parent /= Void then
					Result := model.cluster_from_interface (l_cluster.parent)
				else
					create Result.make (5)
					l_libs := l_cluster.target.used_in_libraries
					if l_libs /= Void then
						from
							l_libs.start
						until
							l_libs.after
						loop
							Result.append (model.cluster_from_interface (l_libs.item))
							l_libs.forth
						end
					end
				end
			elseif l_lib /= Void then
				create Result.make (5)
				l_libs := l_lib.target.used_in_libraries
				if l_libs /= Void then
					from
						l_libs.start
					until
						l_libs.after
					loop
						Result.append (model.cluster_from_interface (l_libs.item))
						l_libs.forth
					end
				end
			else
				check error: False end
			end
		ensure
			Result_not_void: Result /= Void
		end

	add_classes_of_cluster (a_cluster: ES_CLUSTER; a_new_cluster: BOOLEAN; with_status_bar: BOOLEAN) is
			-- Add classes of `a_cluster'
		require
			a_cluster_not_void: a_cluster /= Void
			a_cluster_is_cluster: a_cluster.group.is_cluster
		local
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			new_class: ES_CLASS
			l_item: CLASS_I
			a_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
		do
			a_status_bar := window_status_bar
			l_classes := a_cluster.group.classes
			if a_new_cluster then
				if l_classes /= Void then
					from
						l_classes.start
					until
						l_classes.after
					loop
						l_item ?= l_classes.item_for_iteration
						check
							l_item_not_void: l_item /= Void
						end
						if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_item.name_in_upper) then
							create new_class.make (l_item)
							a_cluster.extend (new_class)
							model.add_node_relations (new_class)
						end
						if with_status_bar then
						 	a_status_bar.progress_bar.set_value (a_status_bar.progress_bar.value + 1)
						end
						l_classes.forth
					end
				end
			elseif not a_cluster.is_needed_on_diagram then
				a_cluster.enable_needed_on_diagram
				enable_all_links (a_cluster)
				if l_classes /= Void then
					from
						l_classes.start
					until
						l_classes.after
					loop
						l_item ?= l_classes.item_for_iteration
						check
							l_item_not_void: l_item /= Void
						end
						new_class := a_cluster.node_of (l_item)
						if new_class = Void then
							l_item ?= l_classes.item_for_iteration
							if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_item.name_in_upper) then
								create new_class.make (l_item)
								model.add_node (new_class)
								model.add_node_relations (new_class)
								a_cluster.extend (new_class)
							end
						else
							l_item := new_class.class_i
							if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_item.name_in_upper) then
								if not new_class.is_needed_on_diagram then
									new_class.enable_needed_on_diagram
									enable_all_links (new_class)
									model.add_node_relations (new_class)
								end
								if not a_cluster.has (new_class) then
									a_cluster.extend (new_class)
									model.add_node_relations (new_class)
								end
							end
						end
						if with_status_bar then
						 	a_status_bar.progress_bar.set_value (a_status_bar.progress_bar.value + 1)
						end
						l_classes.forth
					end
				end
			end
		end

	veto_function (a_any: ANY): BOOLEAN is
			-- Veto function.
			-- CREATE_CLASS_STONE, CLASSI_STONE, CLUSTER_STONE none assemble accepted.
		local
			l_cc_stone: CREATE_CLASS_STONE
			l_class_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_pointer_position: EV_COORDINATE
			l_class_fig_stone: CLASSI_FIGURE_STONE
			l_cluster: EIFFEL_CLUSTER_FIGURE
			l_cluster_fig_stone: CLUSTER_FIGURE_STONE
		do
			l_cc_stone ?= a_any
			l_class_stone ?= a_any
			l_cluster_stone ?= a_any
			l_cluster_fig_stone ?= a_any
			if l_cc_stone /= Void or l_cluster_stone /= Void or l_class_stone /= Void then
				Result := True
				if l_cluster_stone /= Void then
					if l_cluster_stone.group.is_assembly then
						Result := False
					end
				end
					-- Only a figure is picked, we check it.
				if l_class_stone /= Void then
					l_class_fig_stone ?= l_class_stone
					if l_class_fig_stone /= Void then
						l_pointer_position := context_editor.pointer_position
						l_cluster := top_cluster_at (Current, l_pointer_position.x, l_pointer_position.y)
						if l_cluster /= Void then
								-- If the figure is readonly or contains the same group, we deny dropping
							if l_cluster.model.group.is_readonly or else l_cluster.model.group.is_library then
								Result := False
							else
								if l_cluster.model.group = l_class_fig_stone.class_i.group then
									Result := False
								end
							end
						else
							Result := False
						end
					end
				end
				if l_cluster_fig_stone /= Void then
					Result := False
				end
			end
		end

	check_and_add_on_top (a_group: CONF_GROUP; with_status_bar: BOOLEAN) is
			-- Check if `a_cluster' exist on top.
			-- Add it if no.
		require
			a_cluster_not_void: a_group /= Void
		local
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			l_found: BOOLEAN
			es_cluster: ES_CLUSTER
			cluster_fig: EIFFEL_CLUSTER_FIGURE
			l_found_cluster: ES_CLUSTER
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			remove_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]
			remove_links: LIST [ES_ITEM]
			l_string: STRING
		do
			l_clusters := model.top_level_clusters
			create l_array_redo.make (5)
			create l_array_undo.make (5)
			from
				l_clusters.start
			until
				l_clusters.after or l_found
			loop
				l_found := (a_group = l_clusters.item.group)
				if l_found then
					l_found_cluster := l_clusters.item
				end
				l_clusters.forth
			end
			if not l_found then
				create es_cluster.make (a_group)
				model.add_cluster (es_cluster)
				model.add_children_relations (es_cluster, Void)
				if a_group.is_cluster then
					add_classes_of_cluster (es_cluster, True, with_status_bar)
				end
				cluster_fig ?= figure_from_model (es_cluster)
				check
					fig_inserted: cluster_fig /= Void
				end
				cluster_fig.set_port_position (context_editor.pointer_position.x, context_editor.pointer_position.y)
				update_cluster_legend
				remove_classes := classes_to_remove_in_cluster (es_cluster)
				remove_links := links_to_remove_in_classes (remove_classes)
				l_array_redo.extend (agent reinclude_cluster (cluster_fig, remove_links, remove_classes))
				l_array_undo.extend (agent remove_cluster_virtual (cluster_fig, remove_links, remove_classes))
				l_array_redo.extend (agent update_cluster_legend)
				l_array_undo.extend (agent update_cluster_legend)
				context_editor.layout.layout_cluster (cluster_fig, 1)
			elseif not l_found_cluster.is_needed_on_diagram then
				if l_found_cluster.group.is_cluster then
					add_classes_of_cluster (l_found_cluster, False, with_status_bar)
				else
					l_found_cluster.enable_needed_on_diagram
					enable_all_links (l_found_cluster)
				end
				cluster_fig ?= figure_from_model (l_found_cluster)
				update_cluster_legend
				remove_classes := classes_to_remove_in_cluster (l_found_cluster)
				remove_links := links_to_remove_in_classes (remove_classes)
				l_array_redo.extend (agent reinclude_cluster (cluster_fig, remove_links, remove_classes))
				l_array_undo.extend (agent remove_cluster_virtual (cluster_fig, remove_links, remove_classes))
				l_array_redo.extend (agent update_cluster_legend)
				l_array_undo.extend (agent update_cluster_legend)
			end
			if not l_array_redo.is_empty and then not l_array_undo.is_empty then
				if a_group.is_library then
					l_string := interface_names.t_diagram_include_library_cmd (a_group.name)
				else
					l_string := interface_names.t_diagram_include_cluster_cmd (a_group.name)
				end
				context_editor.history.register_named_undoable (l_string,
																[l_array_redo], [l_array_undo])
			end
		end

	any_clusters_needed (a_clusters: ARRAYED_LIST [ES_CLUSTER]): BOOLEAN is
			-- Any class needed in `a_clusters'?
		require
			a_clusters_not_void: a_clusters /= Void
		do
			from
				a_clusters.start
			until
				a_clusters.after or Result
			loop
				Result := a_clusters.item.is_needed_on_diagram
				a_clusters.forth
			end
		end

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

end -- class EIFFEL_CLUSTER_DIAGRAM
