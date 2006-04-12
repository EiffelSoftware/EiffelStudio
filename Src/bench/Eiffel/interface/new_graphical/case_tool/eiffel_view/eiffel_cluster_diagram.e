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
			on_cluster_added
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
			drop_actions.extend (agent on_cluster_drop)
			drop_actions.extend (agent on_new_class_drop)
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
			node.put_last (xml_routines.xml_node (node, "CENTER_CLUSTER_NAME", model.center_cluster.cluster_i.cluster_name))
			Result := Precursor {EIFFEL_WORLD} (node)
		end

	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			ccn: STRING
			c: CLUSTER_I
			esc: ES_CLUSTER
		do
			node.forth
			model.set_subcluster_depth (xml_routines.xml_integer (node, "SUBCLUSTER_DEPTH"))
			model.set_supercluster_depth (xml_routines.xml_integer (node, "SUPERCLUSTER_DEPTH"))
			ccn := xml_routines.xml_string (node, "CENTER_CLUSTER_NAME")
			Precursor {EIFFEL_WORLD} (node)

			c := universe.cluster_of_name (ccn)
			esc := model.cluster_from_interface (c)
			check
				center_cluster_in_diagram: esc /= Void
			end
			model.set_center_cluster (esc)
		end

feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_WORLD}
			drop_actions.prune_all (agent on_class_drop)
			drop_actions.prune_all (agent on_cluster_drop)
			drop_actions.prune_all (agent on_new_class_drop)
			manager.remove_observer (Current)
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

	on_cluster_drop (a_stone: CLUSTER_STONE) is
			-- Add to diagram if not present.
		local
			new_cluster: ES_CLUSTER
			fig: EIFFEL_CLUSTER_FIGURE
			class_fig: EIFFEL_CLASS_FIGURE
			drop_x, drop_y: INTEGER
			saved_x, saved_y: INTEGER
			l_classes: LIST [CLASS_I]
			new_class: ES_CLASS
			l_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			nr_of_items: INTEGER
			l_item: CLASS_I
			is_retry: BOOLEAN
			remove_links: LIST [ES_ITEM]
			remove_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]
		do
			context_editor.development_window.window.set_pointer_style (Default_pixmaps.Wait_cursor)

			if not is_retry then

				drop_x := context_editor.pointer_position.x
				drop_y := context_editor.pointer_position.y

				new_cluster := model.cluster_from_interface (a_stone.cluster_i)

				if new_cluster = Void or else not new_cluster.is_needed_on_diagram then

					l_classes := a_stone.cluster_i.classes.linear_representation

					context_editor.projector.disable_painting
					context_editor.disable_resize
					context_editor.update_excluded_class_figures

					l_status_bar := context_editor.development_window.status_bar
					nr_of_items := l_classes.count
					l_status_bar.progress_bar.reset_with_range (0 |..| nr_of_items)
					l_status_bar.progress_bar.set_value (0)
					l_status_bar.display_message ("Including Cluster: Adding Classes into Cluster")

					if new_cluster = Void then
						create new_cluster.make (a_stone.cluster_i)
						model.add_cluster (new_cluster)
						from
							l_classes.start
						until
							l_classes.after
						loop
							l_item ?= l_classes.item
							if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_item.name_in_upper) then
								create new_class.make (l_item)
								new_cluster.extend (new_class)
							end
							l_status_bar.progress_bar.set_value (l_status_bar.progress_bar.value + 1)
							l_classes.forth
						end
					elseif not new_cluster.is_needed_on_diagram then
						new_cluster.enable_needed_on_diagram
						enable_all_links (new_cluster)
						from
							l_classes.start
						until
							l_classes.after
						loop
							new_class := model.class_from_interface (l_classes.item)
							if new_class = Void then
								l_item ?= l_classes.item
								if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_item.name_in_upper) then
									create new_class.make (l_item)
									model.add_node (new_class)
									new_cluster.extend (new_class)
								end
							else
								l_item := new_class.class_i
								if context_editor.ignore_excluded_figures or else not context_editor.is_excluded_in_preferences (l_item.name_in_upper) then
									if not new_class.is_needed_on_diagram then
										new_class.enable_needed_on_diagram
										enable_all_links (new_class)
										if new_class.class_i.is_compiled then
											model.add_ancestor_relations (new_class)
											model.add_descendant_relations (new_class)
											model.add_client_relations (new_class)
											model.add_supplier_relations (new_class)
										end
									end
									if not new_cluster.has (new_class) then
										new_cluster.extend (new_class)
									end
								end
							end
							l_status_bar.progress_bar.set_value (l_status_bar.progress_bar.value + 1)
							l_classes.forth
						end
					end
					l_status_bar.reset
					fig ?= figure_from_model (new_cluster)
					check
						fig_inserted: fig /= Void
					end
					context_editor.enable_resize
					context_editor.projector.enable_painting

					update
					context_editor.layout.layout_cluster (fig, 1)

					model.add_children_relations (new_cluster)
					model.add_parent_relations (new_cluster)

					remove_links := new_cluster.needed_links
					remove_classes := classes_to_remove_in_cluster (new_cluster)
					from
						remove_classes.start
					until
						remove_classes.after
					loop
						class_fig ?= remove_classes.item.item (1)
						remove_links.append (class_fig.model.needed_links)
						remove_classes.forth
					end

					update
					fig.set_port_position (drop_x, drop_y)

					context_editor.history.register_named_undoable (
						interface_names.t_diagram_include_cluster_cmd (new_cluster.name),
						agent reinclude_cluster (fig, remove_links, remove_classes),
						agent remove_cluster_virtual (fig, remove_links, remove_classes))

				else
					-- only a move
					fig ?= figure_from_model (new_cluster)
					saved_x := fig.port_x
					saved_y := fig.port_y
					fig.set_port_position (drop_x, drop_y)
					context_editor.history.register_named_undoable (
						interface_names.t_diagram_move_cluster_cmd (new_cluster.name),
						agent fig.set_port_position (drop_x, drop_y),
						agent fig.set_port_position (saved_x, saved_y))
				end
				if is_right_angles then
					apply_right_angles
				end
			end
			context_editor.projector.full_project
			context_editor.development_window.window.set_pointer_style (Default_pixmaps.Standard_cursor)
		rescue
			is_retry := True
			context_editor.projector.enable_painting
			l_status_bar.reset
			context_editor.enable_resize
			context_editor.clear_area
			error_handler.error_list.wipe_out
			retry
		end

	on_class_drop (a_stone: CLASSI_STONE) is
			-- `a_stone' was dropped on `Current'
		do
			add_to_diagram (a_stone.class_i, context_editor.pointer_position.x, context_editor.pointer_position.y)
		end

	on_class_added (a_class: CLASS_I) is
			-- `a_class' was added to the system.
		local
			class_cluster: CLUSTER_I
			es_cluster: ES_CLUSTER
			cluster_fig: EG_CLUSTER_FIGURE
		do
			if not is_dropped_on_diagram then
				conf_todo
--				class_cluster := a_class.cluster
				if class_cluster /= Void then
					es_cluster := model.cluster_from_interface (class_cluster)
					if es_cluster /= Void then
						cluster_fig ?= figure_from_model (es_cluster)
						if cluster_fig /= Void then
							add_to_diagram (a_class, cluster_fig.port_x, cluster_fig.port_y)
						end
					end
				end
			end
		end

	on_cluster_added (a_cluster: CLUSTER_I) is
			-- `a_cluster' was added to the system.
		local
			parent, es_cluster: ES_CLUSTER
			parent_fig, cluster_fig: EG_CLUSTER_FIGURE
		do
			conf_todo
--			parent := model.cluster_from_interface (a_cluster.actual_cluster.parent_cluster)
--			if parent /= Void then
--				parent_fig ?= figure_from_model (parent)
--				check
--					a_cluster_not_in_graph: model.cluster_from_interface (a_cluster.actual_cluster) = Void
--				end
--				create es_cluster.make (a_cluster.actual_cluster)
--				model.add_cluster (es_cluster)
--				parent.extend (es_cluster)
--				cluster_fig ?= figure_from_model (es_cluster)
--				cluster_fig.set_port_position (parent_fig.port_x, parent_fig.port_y)
--			end
		end

	add_to_diagram (a_class: CLASS_I; drop_x, drop_y: INTEGER) is
			-- Add `a_class' to diagram at position (`drop_x', `drop_y') if not already present
			-- move to (`drop_x', `drop_y') otherwise.
		local
			dropped_on_cluster: EIFFEL_CLUSTER_FIGURE
			parent: ES_CLUSTER
			new_class: ES_CLASS
			fig: EIFFEL_CLASS_FIGURE
			new_cluster, old_cluster: ES_CLUSTER
			new_cluster_i, old_cluster_i: CLUSTER_I
			new_cluster_figure: EIFFEL_CLUSTER_FIGURE
			saved_x, saved_y: INTEGER
			class_was_reincluded: BOOLEAN
			class_was_inserted: BOOLEAN
			l_manager: EB_CLUSTERS
			remove_links: LIST [ES_ITEM]
			remove_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]
		do
			new_class := model.class_from_interface (a_class)
			if new_class = Void then
				create new_class.make (a_class)
				model.add_node (new_class)
				class_was_inserted := True
			elseif not new_class.is_needed_on_diagram then
				new_class.enable_needed_on_diagram
				enable_all_links (new_class)
				if new_class.class_i.is_compiled then
					model.add_ancestor_relations (new_class)
					model.add_descendant_relations (new_class)
					model.add_client_relations (new_class)
					model.add_supplier_relations (new_class)
				end
				class_was_reincluded := True
			end
			dropped_on_cluster := top_cluster_at (Current, drop_x, drop_y)
			conf_todo
--			if dropped_on_cluster = Void or else a_class.cluster = dropped_on_cluster.model.cluster_i then
--				-- new_class is new
--				--		parent is new
--				--				-> add parent add new_class
--				--		parent is not new
--				--			parent is needed
--				--				-> add new_class
--				--			parent is not needed
--				--				-> reinclude parent add new_class
--				-- new_class is not new
--				--		parent is new
--				--				-> reinclude new_class add parent add new_class
--				--		parent is not new
--				--			parent is needed
--				--				parent has new_class
--				--					--> move class to new drop position
--				--				parent not has new_class
--				--					--> reinclude new_class add new_class
--				--			parent is not needed
--				--				-> reinclude parent reinclude new_class add new_class
--				parent := model.cluster_from_interface (a_class.cluster)
--				if parent = Void then
--					--add parent and put class inside
--					create new_cluster.make (a_class.cluster)
--					model.insert_cluster (new_cluster)
--					new_cluster.extend (new_class)
--					fig ?= figure_from_model (new_class)
--					fig.set_port_position (drop_x, drop_y)
--					new_cluster_figure ?= figure_from_model (new_cluster)
--
--					remove_links := new_cluster.needed_links
--					remove_classes := classes_to_remove_in_cluster (new_cluster)
--					from
--						remove_classes.start
--					until
--						remove_classes.after
--					loop
--						fig ?= remove_classes.item.item (1)
--						remove_links.append (fig.model.needed_links)
--						remove_classes.forth
--					end
--
--					update_cluster_legend
--
--					context_editor.history.register_named_undoable (
--						interface_names.t_diagram_include_class_cmd (new_class.name),
--						[<<agent reinclude_cluster (new_cluster_figure, remove_links, remove_classes), agent update_cluster_legend>>],
--						[<<agent remove_cluster_virtual (new_cluster_figure, remove_links, remove_classes), agent update_cluster_legend>>])
--				else
--					if not parent.is_needed_on_diagram then
--						parent.enable_needed_on_diagram
--						enable_all_links (parent)
--						new_cluster_figure ?= figure_from_model (parent)
--						if not parent.has (new_class) then
--							parent.extend (new_class)
--						end
--						model.add_children_relations (parent)
--						model.add_parent_relations (parent)
--						fig ?= figure_from_model (new_class)
--						fig.set_port_position (drop_x, drop_y)
--
--						remove_links := parent.needed_links
--						remove_classes := classes_to_remove_in_cluster (parent)
--						from
--							remove_classes.start
--						until
--							remove_classes.after
--						loop
--							fig ?= remove_classes.item.item (1)
--							remove_links.append (fig.model.needed_links)
--							remove_classes.forth
--						end
--
--						update_cluster_legend
--
--						context_editor.history.register_named_undoable (
--							interface_names.t_diagram_include_class_cmd (new_class.name),
--							[<<agent reinclude_cluster (new_cluster_figure, remove_links, remove_classes), agent update_cluster_legend>>],
--							[<<agent remove_cluster_virtual (new_cluster_figure, remove_links, remove_classes), agent update_cluster_legend>>])
--					else
--						if not parent.has (new_class) then
--							parent.extend (new_class)
--							fig ?= figure_from_model (new_class)
--							fig.set_port_position (drop_x, drop_y)
--							fig.request_update
--							remove_links := new_class.needed_links
--							update_cluster_legend
--							context_editor.history.register_named_undoable (
--								interface_names.t_diagram_include_class_cmd (new_class.name),
--								[<<agent reinclude_class (fig, remove_links, drop_x, drop_y), agent update_cluster_legend>>],
--								[<<agent remove_class_virtual (fig, remove_links), agent update_cluster_legend>>])
--						else
--							if class_was_reincluded then
--								fig ?= figure_from_model (new_class)
--								fig.set_port_position (drop_x, drop_y)
--								fig.request_update
--								remove_links := new_class.needed_links
--								update_cluster_legend
--								context_editor.history.register_named_undoable (
--									interface_names.t_diagram_include_class_cmd (new_class.name),
--									[<<agent reinclude_class (fig, remove_links, drop_x, drop_y), agent update_cluster_legend>>],
--									[<<agent remove_class_virtual (fig, remove_links), agent update_cluster_legend>>])
--							else
--								fig ?= figure_from_model (new_class)
--								saved_x := fig.port_x
--								saved_y := fig.port_y
--								fig.set_port_position (drop_x, drop_y)
--								context_editor.history.register_named_undoable (
--									interface_names.t_diagram_move_class_cmd (new_class.name),
--									agent fig.set_port_position (drop_x, drop_y),
--									agent fig.set_port_position (saved_x, saved_y))
--							end
--						end
--					end
--				end
--			else
--				-- move class
--				fig ?= figure_from_model (new_class)
--				saved_x := fig.port_x
--				saved_y := fig.port_y
--				fig.set_port_position (drop_x, drop_y)
--				new_cluster := dropped_on_cluster.model
--				new_cluster_i := new_cluster.cluster_i
--				old_cluster_i := new_class.class_i.cluster
--				old_cluster := new_class.cluster
--
--				new_cluster.extend (new_class)
--
--				l_manager := model.manager
--				l_manager.move_class (new_class.class_i, old_cluster_i, new_cluster_i)
--
--				if new_cluster.cluster_i.classes.has (new_class.class_i.name) then
--					if not class_was_inserted and then not class_was_reincluded then
--
--						context_editor.history.register_named_undoable (
--							interface_names.t_diagram_move_class_cmd (new_class.name),
--							[<<agent fig.set_port_position (drop_x, drop_y), agent new_cluster.extend (new_class),
--							   agent l_manager.move_class (new_class.class_i, old_cluster.cluster_i, new_cluster.cluster_i)>>],
--							[<<agent fig.set_port_position (saved_x, saved_y), agent old_cluster.extend (new_class),
--							   agent l_manager.move_class (new_class.class_i, new_cluster.cluster_i, old_cluster.cluster_i)>>])
--					else
--						-- class was not in the diagram before.
--						remove_links := new_class.needed_links
--						context_editor.history.register_named_undoable (
--							interface_names.t_diagram_move_class_cmd (new_class.name),
--							[<<agent reinclude_class (fig, remove_links, drop_x, drop_y),
--							   agent new_cluster.extend (new_class),
--							   agent l_manager.move_class (new_class.class_i, old_cluster_i, new_cluster_i)>>],
--							[<<agent remove_class_virtual (fig, remove_links),
--							   agent new_cluster.prune_all (new_class),
--							   agent l_manager.move_class (new_class.class_i, new_cluster_i, old_cluster_i)>>])
--					end
--				else
--					-- Move was not succesfull.
--					fig.set_port_position (saved_x, saved_y)
--					if old_cluster /= Void then
--						old_cluster.extend (new_class)
--					else
--						new_cluster.prune_all (new_class)
--					end
--					if class_was_inserted then
--						from
--							new_class.internal_links.start
--						until
--							new_class.internal_links.is_empty
--						loop
--							model.remove_link (new_class.internal_links.first)
--						end
--						model.remove_node (new_class)
--					elseif class_was_reincluded then
--						new_class.disable_needed_on_diagram
--					end
--				end
--			end
--			if is_right_angles then
--				apply_right_angles
--			end
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
		end

	on_new_class_drop (a_stone: CREATE_CLASS_STONE) is
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
			create dial.make_default (context_editor.development_window)
			if clf /= Void then
				dial.preset_cluster (clf.model.cluster_i)
			end
			dial.call_default
			include_new_dropped_class (dial, drop_x, drop_y)
			is_dropped_on_diagram := False
		end

	is_dropped_on_diagram: BOOLEAN
			-- Is a class added to a cluster dropped on diagram by user?

	include_new_dropped_class (a_create_class_dialog: EB_CREATE_CLASS_DIALOG; a_x, a_y: INTEGER) is
			-- Add `a_class' to the diagram if not already present.
		require
			a_create_class_dialog: a_create_class_dialog /= Void
		local
			a_class: CLASS_I
			cf: EIFFEL_CLASS_FIGURE
			cluster_fig: EIFFEL_CLUSTER_FIGURE
			es_class: ES_CLASS
			es_cluster: ES_CLUSTER
			remove_links: LIST [ES_ITEM]
			remove_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]
		do
			if not a_create_class_dialog.cancelled then
				a_class := a_create_class_dialog.class_i
				if a_class /= Void then
					es_class := model.class_from_interface (a_class)
					if es_class = Void then
						create es_class.make (a_class)
						if a_create_class_dialog.is_deferred then
							es_class.set_is_deferred (True)
						end
						model.add_node (es_class)
					elseif not es_class.is_needed_on_diagram then
						es_class.enable_needed_on_diagram
						enable_all_links (es_class)
						if es_class.class_i.is_compiled then
							model.add_ancestor_relations (es_class)
							model.add_descendant_relations (es_class)
							model.add_client_relations (es_class)
							model.add_supplier_relations (es_class)
						end
					end
					cf ?= figure_from_model (es_class)
					check cf_not_void: cf /= Void end
					conf_todo
--					es_cluster := model.cluster_from_interface (a_class.cluster)
					if es_cluster = Void or else not es_cluster.is_needed_on_diagram then

						if es_cluster = Void then
							conf_todo
--							create es_cluster.make (a_class.cluster)
							model.insert_cluster (es_cluster)
						else
							es_cluster.enable_needed_on_diagram
							enable_all_links (es_cluster)
							model.add_children_relations (es_cluster)
							model.add_parent_relations (es_cluster)
						end
						es_cluster.extend (es_class)
						cf.set_port_position (a_x, a_y)

						remove_links := es_cluster.needed_links
						remove_classes := classes_to_remove_in_cluster (es_cluster)
						from
							remove_classes.start
						until
							remove_classes.after
						loop
							cf ?= remove_classes.item.item (1)
							remove_links.append (cf.model.needed_links)
							remove_classes.forth
						end

						cluster_fig ?= figure_from_model (es_cluster)

						update_cluster_legend

						context_editor.history.register_named_undoable (
							interface_names.t_diagram_include_class_cmd (es_class.name),
							[<<agent reinclude_cluster (cluster_fig, remove_links, remove_classes), agent update_cluster_legend>>],
							[<<agent remove_cluster_virtual (cluster_fig, remove_links, remove_classes), agent update_cluster_legend>>])

					else
						es_cluster.extend (es_class)
						update_cluster_legend
						remove_links := es_class.needed_links
						cf.set_port_position (a_x, a_y)
						context_editor.history.register_named_undoable (
							interface_names.t_diagram_include_class_cmd (es_class.name),
							[<<agent reinclude_class (cf, remove_links, a_x, a_y), agent update_cluster_legend>>],
							[<<agent remove_class_virtual (cf, remove_links), agent update_cluster_legend>>])
					end
				end
				if is_right_angles then
					apply_right_angles
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
