note
	description: "Objects that is view for a CLUSTER_GRAPH."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	default_create
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

	xml_node_name: STRING
			-- Name of the node returned by `xml_element'.
		do
			Result := eiffel_cluster_diagram_str
		end

	xml_element (node: like xml_element): XML_ELEMENT
			-- Xml node representing `Current's state.
		do
			node.add_attribute (name_str, xml_namespace, current_view)
			node.put_last (Xml_routines.xml_node (node, subcluster_depth_str, model.subcluster_depth.out))
			node.put_last (Xml_routines.xml_node (node, supercluster_depth_str, model.supercluster_depth.out))
			node.put_last (xml_routines.xml_node (node, center_cluster_id_str, model.center_cluster.cluster_id))
			Result := Precursor {EIFFEL_WORLD} (node)
		end

	set_with_xml_element (node: like xml_element)
			-- Retrive state from `node'.
		local
			l_cluster_id: STRING
		do
			node.forth
			model.set_subcluster_depth (xml_routines.xml_integer (node, subcluster_depth_str))
			model.set_supercluster_depth (xml_routines.xml_integer (node, supercluster_depth_str))
			l_cluster_id := xml_routines.xml_string (node, center_cluster_id_str)
			Precursor {EIFFEL_WORLD} (node)
			if attached model.cluster_of_id (l_cluster_id) as center_cluster then
				model.set_center_cluster (center_cluster)
			end
		end

feature -- Element change

	recycle
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_WORLD}
			drop_actions.prune_all (agent on_class_drop)
			drop_actions.prune_all (agent on_group_drop)
			drop_actions.prune_all (agent on_new_class_drop)
			manager.remove_observer (Current)
		end

feature -- Status

	classes_in_same_scope (a_source, a_target: ES_CLASS): BOOLEAN
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

	change_view (view_name: READABLE_STRING_GENERAL; f: RAW_FILE)
			-- Change view to `view_name' load from file `f' without saving `Current'.
		require
			f_closed: f.is_closed
		do
			current_view := view_name
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
				f.close
			end
		ensure
			f_closed: f.is_closed
		end

feature {NONE} -- Implementation

	on_group_drop (a_stone: CLUSTER_STONE)
			-- Add to diagram.
		do
			if a_stone.is_valid then
				if a_stone.group.is_cluster then
					if attached {CONF_CLUSTER} a_stone.group as l_cluster then
						on_cluster_drop (l_cluster)
					end
				elseif a_stone.group.is_library then
					if attached {CONF_LIBRARY} a_stone.group as l_lib then
						on_library_drop (l_lib)
					end
				end
			end
		end

	on_cluster_drop (a_cluster: CONF_CLUSTER)
		local
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			parent: ES_CLUSTER
			l_classes: STRING_TABLE [CONF_CLASS]
			l_cluster, es_cluster : ES_CLUSTER
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			nr_of_items: INTEGER
			cluster_fig, parent_fig: EIFFEL_CLUSTER_FIGURE
			cluster_added: BOOLEAN
			remove_classes: like classes_to_remove_in_cluster
			remove_links: LIST [ES_ITEM]
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE]
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
					parent_fig := {EIFFEL_CLUSTER_FIGURE} / figure_from_model (parent)
					l_cluster := parent.sub_cluster_of (a_cluster)
					if parent.is_needed_on_diagram and then l_cluster = Void then
						create es_cluster.make (a_cluster)
						model.add_cluster (es_cluster)
						parent.extend (es_cluster)
						model.add_children_relations (es_cluster, parent)
						add_classes_of_cluster (es_cluster, True, True)
						cluster_fig := {EIFFEL_CLUSTER_FIGURE} / figure_from_model (es_cluster)
						cluster_fig.set_port_position (parent_fig.port_x, parent_fig.port_y)

						check
							fig_inserted: cluster_fig /= Void
						end
						cluster_added := True
						context_editor.layout.layout_cluster (cluster_fig, 1)
					elseif parent.is_needed_on_diagram and then not l_cluster.is_needed_on_diagram then
						add_classes_of_cluster (l_cluster, False, True)
						model.add_children_relations (l_cluster, parent)
						cluster_fig := {EIFFEL_CLUSTER_FIGURE} / figure_from_model (l_cluster)
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

	on_library_drop (a_lib: CONF_LIBRARY)
		local
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			parent: ES_CLUSTER
			es_cluster : ES_CLUSTER
			cluster_fig, parent_fig: EIFFEL_CLUSTER_FIGURE
			cluster_added: BOOLEAN
			remove_classes: like classes_to_remove_in_cluster
			remove_links: LIST [ES_ITEM]
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE]
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
						parent_fig := {EIFFEL_CLUSTER_FIGURE} / figure_from_model (parent)
						es_cluster := parent.sub_cluster_of (a_lib)
						if es_cluster = Void then
							create es_cluster.make (a_lib)
							model.add_cluster (es_cluster)
							parent.extend (es_cluster)
							model.add_children_relations (es_cluster, parent)
							cluster_fig := {EIFFEL_CLUSTER_FIGURE} / figure_from_model (es_cluster)
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
							cluster_fig := {EIFFEL_CLUSTER_FIGURE} / figure_from_model (es_cluster)
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

	on_class_drop (a_stone: CLASSI_STONE)
			-- `a_stone' was dropped on `Current'
		do
			if a_stone.is_valid then
				is_dropped_on_diagram := True
				if attached {CLASSI_FIGURE_STONE} a_stone as l_class_fig_stone then
					move_class (l_class_fig_stone.source, context_editor.pointer_position.x, context_editor.pointer_position.y)
				else
					add_to_diagram (a_stone.class_i)
				end
				is_dropped_on_diagram := False
			end
		end

	on_class_added (a_class: CLASS_I)
			-- `a_class' was added to the system.
		do
			if not is_dropped_on_diagram then
				add_to_diagram (a_class)
			end
		end

	on_cluster_added (a_cluster: CLUSTER_I)
			-- `a_cluster' was added to the system.
		local
			parent, es_cluster: ES_CLUSTER
			parent_fig, cluster_fig: EG_CLUSTER_FIGURE
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE]
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
					parent_fig := {EG_CLUSTER_FIGURE} / figure_from_model (parent)
					create es_cluster.make (a_cluster)
					model.add_cluster (es_cluster)
					parent.extend (es_cluster)
					update_cluster_legend
					cluster_fig := {EG_CLUSTER_FIGURE} / figure_from_model (es_cluster)
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

	on_new_class_drop (a_stone: CREATE_CLASS_STONE)
			-- `a_stone' was dropped on `Current'
			-- Display create class dialog and add to diagram.
		local
			dial: EB_CREATE_CLASS_DIALOG
			drop_x, drop_y: INTEGER
			clf: EIFFEL_CLUSTER_FIGURE
		do
			drop_x := context_editor.pointer_position.x
			drop_y := context_editor.pointer_position.y
			is_dropped_on_diagram := True
			clf := top_cluster_at (Current, drop_x, drop_y)
			create dial.make_default (context_editor.develop_window, True)
			if clf /= Void then
				if attached {CONF_CLUSTER} clf.model.group as l_cluster then
					dial.preset_cluster (l_cluster)
				end
			end
			dial.call_default
			include_new_dropped_class (dial, drop_x, drop_y)
			is_dropped_on_diagram := False
		end

feature {NONE} -- Cluster manager observer

	on_class_moved (a_class: CONF_CLASS; old_cluster: CONF_GROUP; old_path: READABLE_STRING_32)
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
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE]
			l_manager: EB_CLUSTERS
		do
			if not is_dropped_on_diagram then
				l_class_i := {CLASS_I} / a_class
				check
					l_class_i_not_void: l_class_i /= Void
				end
				new_cluster_i := {CONF_CLUSTER} / l_class_i.group
				old_cluster_i := {CONF_CLUSTER} / old_cluster

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
					update_cluster_legend
					fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (es_class)
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
						fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (es_class)
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
						fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (es_class)
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

	on_cluster_changed (a_cluster: CLUSTER_I)
			-- `a_cluster' was renamed.
		do
			across
				model.cluster_from_interface (a_cluster) as c
			loop
				c.item.set_name_32 (a_cluster.cluster_name)
			end
		end

feature {EB_CREATE_CLASS_DIAGRAM_COMMAND} -- Element Change

	add_to_diagram (a_class: CLASS_I)
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
			l_array_redo: ARRAYED_LIST [PROCEDURE]
			l_array_undo: ARRAYED_LIST [PROCEDURE]
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
						fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (new_class)
						position_new_class_in_cluster (fig, True)

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
						fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (new_class)

						position_new_class_in_cluster (fig, False)

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
						fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (new_class)

						position_new_class_in_cluster (fig, False)

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
					l_array_redo.extend (agent new_cluster.enable_needed_on_diagram)
					l_array_undo.extend (agent new_cluster.disable_needed_on_diagram)

					create new_class.make (a_class)
					new_cluster.extend (new_class)
					model.add_node_relations (new_class)
					update_cluster_legend
					fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (new_class)
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

	position_new_class_in_cluster (fig: EIFFEL_CLASS_FIGURE; position_on_screen_if_possible: BOOLEAN)
			-- Position `a_class_fig' so that it is positioned in a position suitable for current view.
		local
			l_cluster_bounding_box, l_projector_bounding_box, l_insertion_bounding_box, l_class_bounding_box: EV_RECTANGLE
			l_class_x_offset, l_class_y_offset: INTEGER
			l_fig_shown: BOOLEAN
			i: INTEGER
			l_add_across: BOOLEAN
		do
				-- Temporarily hide figure so that is doesn't get taken in to account in the bounding box calculation.

			l_fig_shown := fig.is_show_requested
			if l_fig_shown then
				fig.hide
			end
			l_cluster_bounding_box := fig.cluster.bounding_box
			if l_fig_shown then
				fig.show
			end

			l_class_bounding_box := fig.bounding_box

			create l_projector_bounding_box.make (context_editor.projector.area_x, context_editor.projector.area_y, context_editor.projector.area.width, context_editor.projector.area.height)
			l_insertion_bounding_box := l_cluster_bounding_box.intersection (l_projector_bounding_box)

			if not position_on_screen_if_possible or else l_insertion_bounding_box.width = 0 or else l_insertion_bounding_box.height = 0 then
				l_insertion_bounding_box := l_cluster_bounding_box
			end

			l_class_x_offset := l_insertion_bounding_box.x + (l_class_bounding_box.width // 2) + new_class_padding
			l_class_y_offset := l_insertion_bounding_box.y + (l_class_bounding_box.height // 2) + new_class_padding

			-- Update class bounding box with offset

			l_class_bounding_box.set_x (l_class_x_offset)
			l_class_bounding_box.set_y (l_class_y_offset)

			from
				i := classes.count
				l_add_across := True
			until
				i = 0
			loop
				if classes [i] /= Void and then classes [i] /= fig then
					l_insertion_bounding_box := classes [i].bounding_box

					if l_insertion_bounding_box.intersects (l_class_bounding_box) then
						-- We are placing on top of an existing class, update insertion box and try again until we find an empty slot
						if l_add_across then
							l_class_bounding_box.set_x (l_insertion_bounding_box.x + l_insertion_bounding_box.width)
							l_class_bounding_box.set_y (l_insertion_bounding_box.y)
						else
							l_class_bounding_box.set_x (l_class_x_offset)
							l_class_bounding_box.set_y (l_insertion_bounding_box.y + l_insertion_bounding_box.height)
						end
						l_add_across := not l_add_across

						if i > 1 then
								-- Reset counter so that we iterate all the classes again.
							i := classes.count + 1
						else
							-- We have iterated all of the classes so we exit at this final set position to avoid infinite looping.
						end
					end
				end
				i := i - 1
			end

			l_class_bounding_box.set_x (l_class_bounding_box.x + (l_class_bounding_box.width // 2) + new_class_padding)
			l_class_bounding_box.set_y (l_class_bounding_box.y + (l_class_bounding_box.height // 2) + new_class_padding)
			if world.grid_enabled then
				l_class_bounding_box.set_x (world.x_to_grid (l_class_bounding_box.x))
				l_class_bounding_box.set_y (world.y_to_grid (l_class_bounding_box.y))
			end
			fig.set_point_position (l_class_bounding_box.x, l_class_bounding_box.y)
		end

feature {NONE} -- Implementation

	new_class_padding: INTEGER = 20
		-- Padding between newly inserted classes.

	eiffel_cluster_diagram_str: STRING = "EIFFEL_CLUSTER_DIAGRAM"
	name_str: STRING = "NAME"
	subcluster_depth_str: STRING = "SUBCLUSTER_DEPTH"
	supercluster_depth_str: STRING = "SUPERCLUSTER_DEPTH"
	center_cluster_id_str: STRING = "CENTER_CLUSTER_ID"

	window_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			-- Status bar of window
		do
			Result := context_editor.develop_window.status_bar
		ensure
			Result_not_void: Result /= Void
		end

	move_class (a_fig: EIFFEL_CLASS_FIGURE; drop_x, drop_y: INTEGER)
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
			l_array_redo: ARRAYED_LIST [PROCEDURE]
			l_array_undo: ARRAYED_LIST [PROCEDURE]
			l_old_path: STRING_32
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
					new_cluster_i := {CONF_CLUSTER} / l_cluster.group
					old_cluster_i := {CONF_CLUSTER} / l_class_i.group
					l_manager := manager
					create l_array_redo.make (10)
					create l_array_undo.make (10)
					from
						l_classes.start
					until
						l_classes.after
					loop
						es_class := l_classes.item
						fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (es_class)
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
							fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (es_class)
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
							fig := {EIFFEL_CLASS_FIGURE} / figure_from_model (es_class)
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
							l_array_undo.item.call (Void)
							l_array_undo.forth
						end
					end
				end
			end
		end

	classes_to_remove_in_cluster (a_cluster: ES_CLUSTER): LIST [TUPLE [figure: EIFFEL_CLASS_FIGURE; port_x: INTEGER; port_y: INTEGER]]
			-- All class figures in `a_cluster' that are needed on diagram plus ther positions.
		local
			l_linkables: LIST [EG_LINKABLE]
		do
			from
				create {ARRAYED_LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]} Result.make (5)
				l_linkables := a_cluster.linkables
			until
				l_linkables.after
			loop
				if attached {ES_CLASS} l_linkables.item_for_iteration as es_class and then es_class.is_needed_on_diagram then
					if attached {EIFFEL_CLASS_FIGURE} figure_from_model (es_class) as class_fig then
						Result.extend ([class_fig, class_fig.port_x, class_fig.port_y])
					end
				end
				l_linkables.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	links_to_remove_in_classes (a_classes: like classes_to_remove_in_cluster): LIST [ES_ITEM]
			-- All links to remove in `a_cluster'
		require
			a_classes_not_void: a_classes /= Void
		do
			create {ARRAYED_LIST [ES_ITEM]} Result.make (a_classes.count * 2)
			across
				a_classes as c
			loop
				Result.append (c.item.figure.model.needed_links)
			end
		ensure
			result_not_void: Result /= Void
		end

	is_dropped_on_diagram: BOOLEAN
			-- Is a class added to a cluster dropped on diagram by user?

	include_new_dropped_class (a_create_class_dialog: EB_CREATE_CLASS_DIALOG; a_x, a_y: INTEGER)
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

	top_cluster_at (a_group: EV_MODEL_GROUP; ax, ay: INTEGER): EIFFEL_CLUSTER_FIGURE
			-- Top cluster at `ax', `ay'. Void if none.
		do
			across
				a_group as g
			loop
				if
					attached {EIFFEL_CLUSTER_FIGURE} g.item as l_item and then
					l_item.model.is_needed_on_diagram and then
					(l_item.left <= ax and then ax <= l_item.right) and then
					(l_item.top <= ay and then ay <= l_item.bottom)
				then
					Result := top_cluster_at (l_item, ax, ay)
					if Result = Void then
						Result := l_item
					end
				end
			end
		end

	parents_of_group (a_cluster: CONF_GROUP): ARRAYED_LIST [ES_CLUSTER]
			-- Parents of `a_cluster', clusters and libs included
		require
			a_cluster_not_void: a_cluster /= Void
		do
			if attached {CONF_CLUSTER} a_cluster as l_cluster then
				if l_cluster.parent /= Void then
					Result := model.cluster_from_interface (l_cluster.parent)
				else
					Result := library_usage_parents (l_cluster.target)
				end
			elseif attached {CONF_LIBRARY} a_cluster as l_lib then
				Result := library_usage_parents (l_lib.target)
			elseif attached {CONF_ASSEMBLY} a_cluster as l_as then
				Result := library_usage_parents (l_as.target)
			elseif attached {CONF_PHYSICAL_ASSEMBLY} a_cluster as l_phys_as then
				create Result.make (5)
				across
					l_phys_as.assemblies as p
				loop
					Result.append (model.cluster_from_interface (p.item))
				end
			else
				check error: False end
			end
		ensure
			Result_not_void: Result /= Void
		end

	library_usage_parents (a_target: CONF_TARGET): ARRAYED_LIST [ES_CLUSTER]
			-- Return groups because of library usage of `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			create Result.make (5)
			if attached a_target.system.used_in_libraries as l_libs then
				across
					l_libs as l
				loop
					Result.append (model.cluster_from_interface (l.item))
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	add_classes_of_cluster (a_cluster: ES_CLUSTER; a_new_cluster: BOOLEAN; with_status_bar: BOOLEAN)
			-- Add classes of `a_cluster'
		require
			a_cluster_not_void: a_cluster /= Void
			a_cluster_is_cluster: a_cluster.group.is_cluster
		local
			l_classes: STRING_TABLE [CONF_CLASS]
			new_class: ES_CLASS
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
						if attached {CLASS_I} l_classes.item_for_iteration as l_item then
							if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_item.name) then
								create new_class.make (l_item)
								a_cluster.extend (new_class)
								model.add_node_relations (new_class)
							end
						else
							check l_item_not_void: False end
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
						if attached {CLASS_I} l_classes.item_for_iteration as l_item then
							new_class := a_cluster.node_of (l_item)
							if new_class = Void then
								if attached {CLASS_I} l_classes.item_for_iteration as l_sub_item then
									if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_sub_item.name) then
										create new_class.make (l_sub_item)
										model.add_node (new_class)
										model.add_node_relations (new_class)
										a_cluster.extend (new_class)
									end
								else
									check has_sub_item: False end
								end
							else
								if attached new_class.class_i as l_sub_item then
									if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_sub_item.name) then
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
								else
									check has_sub_item: False end
								end
							end
						else
							check l_item_not_void: False end
						end
						if with_status_bar then
						 	a_status_bar.progress_bar.set_value (a_status_bar.progress_bar.value + 1)
						end
						l_classes.forth
					end
				end
			end
		end

	veto_function (a_any: ANY): BOOLEAN
			-- Veto function.
			-- CREATE_CLASS_STONE, CLASSI_STONE, CLUSTER_STONE none assemble accepted.
		local
			l_pointer_position: EV_COORDINATE
		do
			if attached {CLASSI_STONE} a_any as l_class_stone then
				Result := True
					-- Only a figure is picked, we check it.
				if attached {CLASSI_FIGURE_STONE} l_class_stone as l_class_fig_stone then
					l_pointer_position := context_editor.pointer_position
					if
						attached top_cluster_at (Current, l_pointer_position.x, l_pointer_position.y) as l_cluster implies
							-- If the figure is readonly or contains the same group, we deny dropping.
							(l_cluster.model.group.is_readonly or else
							l_cluster.model.group.is_library or else
							l_cluster.model.group = l_class_fig_stone.class_i.group)
					then
						Result := False
					end
				end
			elseif attached {CREATE_CLASS_STONE} a_any then
				Result := True
			elseif attached {CLUSTER_FIGURE_STONE} a_any then
				-- Result := False
			elseif attached {CLUSTER_STONE} a_any as l_cluster_stone then
				Result := not l_cluster_stone.group.is_assembly and not l_cluster_stone.group.is_physical_assembly
			end
		end

	check_and_add_on_top (a_group: CONF_GROUP; with_status_bar: BOOLEAN)
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
			l_array_redo, l_array_undo: ARRAYED_LIST [PROCEDURE]
			remove_classes: like classes_to_remove_in_cluster
			remove_links: LIST [ES_ITEM]
			l_string: STRING_GENERAL
		do
			l_clusters := model.top_level_clusters
			create l_array_redo.make (5)
			create l_array_undo.make (5)
			from
				l_clusters.start
			until
				l_clusters.after or l_found
			loop
				l_found := a_group = l_clusters.item.group
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
				cluster_fig := {EIFFEL_CLUSTER_FIGURE} / figure_from_model (es_cluster)
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
				cluster_fig := {EIFFEL_CLUSTER_FIGURE} / figure_from_model (l_found_cluster)
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

	any_clusters_needed (a_clusters: ARRAYED_LIST [ES_CLUSTER]): BOOLEAN
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
