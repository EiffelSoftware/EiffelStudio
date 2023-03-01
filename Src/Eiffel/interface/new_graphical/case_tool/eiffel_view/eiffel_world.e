note
	description: "Objects that is a view for on EIFFEL_GRAPH."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_WORLD

inherit
	EG_FIGURE_WORLD
		rename
			nodes as classes,
			flat_nodes as flat_classes
		redefine
			default_create,
			figure_added,
			scale,
			on_pointer_button_press,
			model,
			xml_element,
			set_with_xml_element,
			xml_node_name,
			store,
			retrieve,
			on_linkable_move,
			update,
			make_with_model_and_factory,
			node_type
		end

	EB_CONSTANTS
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

create {EIFFEL_WORLD}
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Create an EIFFEL_WORLD.
		do
			Precursor {EG_FIGURE_WORLD}
			is_labels_shown := True
			is_client_supplier_links_shown := True
			is_inheritance_links_shown := True
			is_high_quality := True
			is_cluster_shown := True
			current_view := default_view_name

			create available_views.make
			available_views.compare_objects
			available_views.extend (current_view)

			create cluster_legend.make_with_world (Current)
			extend (cluster_legend)
			cluster_legend.disable_sensitive
			cluster_legend.hide
		end

	make_with_model_and_factory (a_model: like model; a_factory: like factory)
			-- Create a view for `a_model' using `a_factory'.
		do
			Precursor {EG_FIGURE_WORLD} (a_model, a_factory)
		end

feature -- Status report

	is_labels_shown: BOOLEAN
			-- Are labels of client supplier links shown?

	is_client_supplier_links_shown: BOOLEAN
			-- Are client supplier links shown?

	is_inheritance_links_shown: BOOLEAN
			-- Are inheritance links shown?

	is_high_quality: BOOLEAN
			-- Is `Current' shown in high quality?

	is_cluster_shown: BOOLEAN
			-- Are cluster figures shown?

	is_legend_shown: BOOLEAN
			-- Is cluster legend shown?

	is_right_angles: BOOLEAN
			-- Are right angles used for links?

	is_statistics: BOOLEAN = False
			-- Is a statistic shown informing of draw and physics time?

	is_uml: BOOLEAN
			-- Is diagram shown as UML?

feature -- Access

	context_editor: ES_DIAGRAM_TOOL_PANEL
			-- Context showing `Current'.

	model: ES_GRAPH
			-- Model for `Current'.

	current_view: IMMUTABLE_STRING_32
			-- Name of Current view.

	available_views: LINKED_LIST [READABLE_STRING_GENERAL]
			-- All the views described in `Current' ead file.

	has_available_view (a_view_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Has view `a_view_name` in `available_views` ?
		do
			across
				available_views as ic
			until
				Result
			loop
				Result := a_view_name.same_string (a_view_name)
			end
		end

	default_view_name: STRING
			-- Name for the default view.
		do
			Result := once "DEFAULT"
		ensure
			result_not_void: Result /= Void
		end

	uml_views (file_name: READABLE_STRING_GENERAL): LIST [READABLE_STRING_GENERAL]
			-- All views in `file_name' which are uml views.
		require
			file_name_not_void: file_name /= Void
		local
			diagram_input: XML_DOCUMENT
			a_cursor: XML_COMPOSITE_CURSOR
			view_name: READABLE_STRING_GENERAL
		do
			create {ARRAYED_LIST [STRING]} Result.make (0)
			diagram_input := Xml_routines.deserialize_document (file_name)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.has_same_name (xml_node_name)
				end
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					if attached {like xml_element} a_cursor.item as l_node then
						if l_node.has_same_name ("VIEW") then
							view_name := l_node.attribute_by_name ("NAME").value
							if l_node.attribute_by_name ("IS_UML").value.is_equal ("True") then
								Result.extend (view_name)
							end
						end
					end
					a_cursor.forth
				end
			end
		end

	bon_views (file_name: PATH): LIST [READABLE_STRING_GENERAL]
			-- All views in `file_name' which are bon views.
		require
			file_name_not_void: file_name /= Void
		local
			diagram_input: XML_DOCUMENT
			a_cursor: XML_COMPOSITE_CURSOR
			view_name: READABLE_STRING_GENERAL
		do
			create {ARRAYED_LIST [READABLE_STRING_GENERAL]} Result.make (0)
			diagram_input := Xml_routines.deserialize_document_with_path (file_name)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.has_same_name (xml_node_name)
				end
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					if attached {like xml_element} a_cursor.item as l_node then
						if l_node.has_same_name (once "VIEW") then
							view_name := l_node.attribute_by_name (once "NAME").value
							if l_node.attribute_by_name (once "IS_UML").value.same_string (once "False") then
								Result.extend (view_name)
							end
						end
					end
					a_cursor.forth
				end
			end
		end

feature -- Element change.

	update
			-- Update.
		local
			l_background_color: like background_color
		do
			l_background_color := preferences.diagram_tool_data.diagram_background_color
			if background_color /= l_background_color then
				background_color := l_background_color
				full_redraw
			end
			if is_anti_aliasing_enabled /= preferences.diagram_tool_data.enable_anti_aliasing then
				is_anti_aliasing_enabled := not is_anti_aliasing_enabled
				full_redraw
			end
			if is_statistics then
				update_statistic
			end
			Precursor {EG_FIGURE_WORLD}
		end

	scale (a_scale: DOUBLE)
			-- Scale to x and y direction for `a_scale'.
		local
			val: DOUBLE
		do
			if cluster_legend /= Void then
				prune_all (cluster_legend)
			end

			if not is_center_valid then
				set_center
			end
			scale_factor := scale_factor * a_scale
			val := -a_scale + 1
			projection_matrix.put (a_scale, 1, 1)
			internal_projection_matrix.put (0.0, 1, 2)
			internal_projection_matrix.put (center.x_precise * val, 1, 3)
			internal_projection_matrix.put (0.0, 2, 1)
			internal_projection_matrix.put (a_scale, 2, 2)
			internal_projection_matrix.put (center.y_precise * val, 2, 3)
			internal_projection_matrix.put (0.0, 3, 1)
			internal_projection_matrix.put (0.0, 3, 2)
			internal_projection_matrix.put (1.0, 3, 3)

			recursive_transform (internal_projection_matrix)
			if is_in_group and then group.is_center_valid then
				group.center_invalidate
			end
			if cluster_legend /= Void then
				extend (cluster_legend)
			end
			if is_right_angles then
				apply_right_angles
			end
		end

	enable_high_quality
			-- Enable high quality.
		do
			is_high_quality := True
			set_high_quality (True)
		ensure
			is_high_quality: is_high_quality
		end

	disable_high_quality
			-- Disable high qualtiy.
		do
			is_high_quality := False
			set_high_quality (False)
		ensure
			is_low_quality: not is_high_quality
		end

	show_labels
			-- Show labels.
		do
			is_labels_shown := True
			set_label_shown (True)
		ensure
			is_labels_shown: is_labels_shown
		end

	hide_labels
			-- Hide labels.
		do
			is_labels_shown := False
			set_label_shown (False)
		ensure
			labels_hidden: not is_labels_shown
		end

	show_client_supplier_links
			-- Show client supplier links.
		do
			is_client_supplier_links_shown := True
			set_client_supplier_links_shown (True)
			if context_editor /= Void then
				context_editor.restart_force_directed
			end
		ensure
			client_supplier_links_shown: is_client_supplier_links_shown
		end

	hide_client_supplier_links
			-- Hide client supplier links.
		do
			is_client_supplier_links_shown := False
			set_client_supplier_links_shown (False)
			if context_editor /= Void then
				context_editor.restart_force_directed
			end
		ensure
			client_supplier_links_hidden: not is_client_supplier_links_shown
		end

	show_inheritance_links
			-- Show client supplier links.
		do
			is_inheritance_links_shown := True
			set_inheritance_links_shown (True)
			if context_editor /= Void then
				context_editor.restart_force_directed
			end
		ensure
			inheritance_links_shown: is_inheritance_links_shown
		end

	hide_inheritance_links
			-- Hide client supplier links.
		do
			is_inheritance_links_shown := False
			set_inheritance_links_shown (False)
			if context_editor /= Void then
				context_editor.restart_force_directed
			end
		ensure
			inheritance_links_hidden: not is_inheritance_links_shown
		end

	show_clusters
			-- Show cluster figures.
		do
			is_cluster_shown := True
			set_is_cluster_shown (True)
		ensure
			is_cluster_shown: is_cluster_shown
		end

	hide_clusters
			-- Hide cluster figures.
		do
			is_cluster_shown := False
			set_is_cluster_shown (False)
		ensure
			not_is_cluster_shown: not is_cluster_shown
		end

	show_legend
			-- Show legend of clusters and colors.
		do
			cluster_legend.update
			cluster_legend.hide
			if attached calculated_bounding_box as bbox then
				cluster_legend.set_point_position (bbox.left, bbox.top)
			end
			cluster_legend.show
			cluster_legend.enable_sensitive
			if not has (cluster_legend) then
				extend (cluster_legend)
			end
			bring_to_front (cluster_legend)
			is_legend_shown := True
		ensure
			legend_is_shown: is_legend_shown
		end

	hide_legend
			-- Hide legend of clusters and colors.
		do
			cluster_legend.hide
			cluster_legend.disable_sensitive
			is_legend_shown := False
		ensure
			legend_is_hidden: not is_legend_shown
		end

	enable_right_angles
			-- Set `is_right_angles' to True.
		do
			is_right_angles := True
		ensure
			set: is_right_angles
		end

	disable_right_angles
			-- Set `is_right_angles' to False.
		do
			is_right_angles := False
		ensure
			set: not is_right_angles
		end

	apply_right_angles
			-- Apply right angles to all LINK_FIGUREs in the world.
		local
			l_edges: ARRAYED_LIST [EG_LINK_FIGURE]
			i, nb: INTEGER
		do
			if context_editor = Void or else context_editor.force_directed_layout.is_stopped then
				update
				from
					l_edges := links
					i := 1
					nb := l_edges.count
				until
					i > nb
				loop
					if attached {EIFFEL_LINK_FIGURE} l_edges.i_th (i) as l_item then
						l_item.apply_right_angles
					end
					i := i + 1
				end
			end
		end

	remove_right_angles
			-- Remove all edges in links.
		local
			l_edges: ARRAYED_LIST [EG_LINK_FIGURE]
			i, nb: INTEGER
		do
			from
				l_edges := links
				i := 1
				nb := l_edges.count
			until
				i > nb
			loop
				if attached {EIFFEL_LINK_FIGURE} l_edges.i_th (i) as l_item then
					l_item.reset
				end
				i := i + 1
			end
		end

feature {ES_DIAGRAM_TOOL_PANEL} -- Status settings

	show_anchors
			-- Show all anchors of fixed linkable figures.
		do
			set_is_anchor_shown (True)
		end

	hide_anchors
			-- Hide all anchors of fixed linkable figures.
		do
			set_is_anchor_shown (False)
		end

feature {EB_CHANGE_COLOR_COMMAND, EB_DELETE_FIGURE_COMMAND, EG_FIGURE} -- Cluster color legend.

	update_cluster_legend
			--
		do
			if is_legend_shown then
				cluster_legend.update
				bring_to_front (cluster_legend)
			end
		end

feature {ES_DIAGRAM_TOOL_PANEL} -- Legend

	cluster_legend: EIFFEL_CLUSTER_LEGEND
			-- Legend of clusters and colors.

feature -- Store/Retrive

	remove_view (name: READABLE_STRING_GENERAL)
			-- Remove any reference to view named `name' in the .xml file.
			-- Switch to view default_view_name.
		require
			name_not_void: name /= Void
		local
			f: RAW_FILE
		do
			f := (context_editor.diagram_file (model))
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			remove_view_from_file (f, name)
			available_views.prune_all (name)
			f.close

			current_view := default_view_name
			f := context_editor.diagram_file (model)
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
			end
			context_editor.projector.full_project
		ensure
			default_view_restored: current_view.same_string (default_view_name)
		end

	set_current_view (name: READABLE_STRING_GENERAL)
			-- Set `current_view' to `name'.
		require
			name_not_void: name /= Void
		do
			current_view := name
			if not has_available_view (name) then
				available_views.extend (name)
			end
		ensure
			set: current_view = name
			name_is_available: has_available_view (name)
		end

	retrieve_view (name: READABLE_STRING_GENERAL)
			-- Assign `name' to `current_view' and retrieve corresponding settings.
		require
			name_not_void: name /= Void
		local
			f: RAW_FILE
		do
			 	-- Save current view.
			f := context_editor.diagram_file (model)
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			store (f)
			f.close
				-- Restore view `name' if possible.
			current_view := name
			f := context_editor.diagram_file (model)
			if f.exists then
				f.open_read
				if f.readable and then has_view_with_name (f, name) then
					retrieve (f)
				end
			end
			if not has_available_view (name) then
				available_views.extend (name)
			end
		ensure
			name_assigned: current_view.same_string (name)
		end

	store (ptf: RAW_FILE)
			-- Freeze state of `Current'.
		local
			diagram_output: XML_DOCUMENT
			view_output: like xml_element
			root: like xml_element
			l_view_str, l_name_str: STRING
			i: INTEGER
		do
			if ptf.is_open_read then
					-- Remove any previous save of `current_view'.
				diagram_output := Xml_routines.deserialize_document_with_path (ptf.path)
			else
					-- Create a new view.
				create diagram_output.make_with_root_named (xml_node_name,
					create {XML_NAMESPACE}.make_default)
			end
			if diagram_output /= Void then
					-- TODO: avoid creating a duplicate list of elements as soon as XML_COMPOSITE is fixed and supports element removal.
				across
					diagram_output.root_element.elements as elements
				from
					l_view_str := "VIEW"
					l_name_str := "NAME"
					i := 1
				loop
					if
						attached elements.item as l_node and then
						l_node.has_same_name (l_view_str) and then
						current_view.same_string (l_node.attribute_by_name (l_name_str).value)
					then
							-- Remove found element.
						diagram_output.root_element.remove (i)
					else
							-- Advance to the next element.
						i := i + 1
					end
				end
				create root.make_root (create {XML_DOCUMENT}.make, "VIEW", xml_namespace)
				root.add_attribute ("IS_UML", xml_namespace, is_uml.out)
				view_output := xml_element (root)
				diagram_output.root_element.force_first (view_output)
				Xml_routines.save_xml_document_with_path (ptf.path, diagram_output)
			end
		end

	load_available_views (f: RAW_FILE)
			-- Load avaiable views from `f' store it in `available_views.
		require
			f_exists: f /= Void
		local
			diagram_input: XML_DOCUMENT
			a_cursor: XML_COMPOSITE_CURSOR
			view_name: READABLE_STRING_GENERAL
		do
			available_views.wipe_out
			diagram_input := Xml_routines.deserialize_document_with_path (f.path)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.has_same_name (xml_node_name)
				end
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					if attached {like xml_element} a_cursor.item as l_node then
						if l_node.has_same_name (once "VIEW") then
							view_name := l_node.attribute_by_name (once "NAME").value
							available_views.extend (view_name)
						end
					end
					a_cursor.forth
				end
			end
			if not has_available_view (default_view_name) then
				available_views.extend (default_view_name)
			end
		end

	retrieve (f: RAW_FILE)
			-- Reload former state of `Current'.
		local
			diagram_input: XML_DOCUMENT
			view_input: like xml_element
			a_cursor: XML_COMPOSITE_CURSOR
			nb_of_tags: INTEGER
			view_name: READABLE_STRING_GENERAL
			l_name_str, l_view_str: STRING
		do
			diagram_input := Xml_routines.deserialize_document_with_path (f.path)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.has_same_name (xml_node_name)
				end
				available_views.wipe_out
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
					l_name_str := "NAME"
					l_view_str := "VIEW"
				until
					a_cursor.after
				loop
					if attached {like xml_element} a_cursor.item as l_node then
						if l_node.has_same_name (l_view_str) then
							view_name := l_node.attribute_by_name (l_name_str).value
							available_views.extend (view_name)
							if view_input = Void or else l_node.attribute_by_name (l_name_str).value.same_string (current_view) then
								view_input := l_node
							end
						end
					end
					a_cursor.forth
				end
				if view_input /= Void then
					current_view := view_input.attribute_by_name ("NAME").value
					if view_input.attribute_by_name ("IS_UML").value.is_equal ("True") then
						if not is_uml then
							set_factory (create {UML_FACTORY})
							is_uml := True
						end
					else
						if is_uml then
							set_factory (create {BON_FACTORY})
							is_uml := False
						end
					end
					if context_editor /= Void then
						--context_editor.progress_dialog.start (0)
						--context_editor.development_window.status_bar.progress_bar.reset_with_range (0 |..| 0)
						nb_of_tags := xml_routines.number_of_tags (view_input)
						--context_editor.progress_dialog.start (nb_of_tags)
						context_editor.develop_window.status_bar.reset_progress_bar_with_range (0 |..| nb_of_tags)
						--context_editor.progress_dialog.set_degree ("Loading:")
						xml_routines.valid_tag_read_actions.extend (agent on_valid_tag_read)
					end
					wipe_out
					model.wipe_out
					view_input.start
					view_input.forth
					set_with_xml_element (view_input)
					xml_routines.valid_tag_read_actions.wipe_out
				end
			end
		end

	xml_node_name: STRING
			-- Name of the node returned by `xml_element'.
		do
			Result := once "EIFFEL_WORLD"
		end

	xml_element (a_node: like xml_element): XML_ELEMENT
			-- Xml node representing `Current's state.
		do
			a_node.put_last (Xml_routines.xml_node (a_node, once "INHERITANCE_LINKS_DISPLAYED", is_inheritance_links_shown.out))
			a_node.put_last (Xml_routines.xml_node (a_node, once "CLIENT_LINKS_DISPLAYED", is_client_supplier_links_shown.out))
			a_node.put_last (Xml_routines.xml_node (a_node, once "LABELS_SHOWN", is_labels_shown.out))
			a_node.put_last (Xml_routines.xml_node (a_node, once "CLUSTER_SHOWN", is_cluster_shown.out))
			a_node.put_last (Xml_routines.xml_node (a_node, once "HIGH_QUALITY", is_high_quality.out))
			a_node.put_last (Xml_routines.xml_node (a_node, once "LEGEND_SHOWN", is_legend_shown.out))
			a_node.put_last (Xml_routines.xml_node (a_node, once "LEGEND_X_POS", cluster_legend.point_x.out))
			a_node.put_last (Xml_routines.xml_node (a_node, once "LEGEND_Y_POS", cluster_legend.point_y.out))
			a_node.put_last (xml_routines.xml_node (a_node, once "IS_RIGHT_ANGLES", is_right_angles.out))

			Result := Precursor {EG_FIGURE_WORLD} (a_node)
		end

	set_with_xml_element (a_node: like xml_element)
			-- Retrive state from `a_node'.
		local
			ax, ay: INTEGER
		do
			if xml_routines.xml_boolean (a_node, once "INHERITANCE_LINKS_DISPLAYED") then
				show_inheritance_links
			else
				hide_inheritance_links
			end
			if xml_routines.xml_boolean (a_node, once "CLIENT_LINKS_DISPLAYED") then
				show_client_supplier_links
			else
				hide_client_supplier_links
			end
			if xml_routines.xml_boolean (a_node, once "LABELS_SHOWN") then
				show_labels
			else
				hide_labels
			end
			if xml_routines.xml_boolean (a_node, once "CLUSTER_SHOWN") then
				show_clusters
			else
				hide_clusters
			end
			if xml_routines.xml_boolean (a_node, once "HIGH_QUALITY") then
				enable_high_quality
			else
				disable_high_quality
			end
			if xml_routines.xml_boolean (a_node, once "LEGEND_SHOWN") then
				show_legend
				ax := xml_routines.xml_integer (a_node, once "LEGEND_X_POS")
				ay := xml_routines.xml_integer (a_node, once "LEGEND_Y_POS")
				cluster_legend.set_point_position (ax, ay)
			else
				hide_legend
				ax := xml_routines.xml_integer (a_node, once "LEGEND_X_POS")
				ay := xml_routines.xml_integer (a_node, once "LEGEND_Y_POS")
				cluster_legend.set_point_position (ax, ay)
			end
			if xml_routines.xml_boolean (a_node, once "IS_RIGHT_ANGLES") then
				enable_right_angles
			else
				disable_right_angles
			end

			Precursor {EG_FIGURE_WORLD} (a_node)
		end

feature {ES_DIAGRAM_TOOL_PANEL} -- Statistic

	set_last_draw_time (ms: INTEGER)
			-- Set time needed for draw.
		do
			if draw_count >= 1000 then
				draw_count := 0
				draw_sum := 0
			end
			draw_sum := draw_sum + ms
			draw_count := draw_count + 1
			nbOfDraws := nbOfDraws + 1
		end

	set_last_physics_time (ms: INTEGER)
			-- Set time needed for physics.
		do
			if physics_count >= 1000 then
				physics_count := 0
				physics_sum := 0
			end
			physics_sum := physics_sum + ms
			physics_count := physics_count + 1
		end

feature {NONE} -- Statistic

	physics_count, draw_count: INTEGER

	physics_sum, draw_sum: INTEGER
	nbOfDraws: INTEGER

	statistic_box: EV_MODEL_MOVE_HANDLE
	txt: EV_MODEL_TEXT

	update_statistic
			-- Update statistic
		local
			l_classes: like classes
			l_clusters: like clusters
			l_links: like links
			nr_of_classes: INTEGER
			nr_of_clusters: INTEGER
			nr_of_client_supplier_links: INTEGER
			nr_of_inheritance_links: INTEGER
			rec: EV_MODEL_RECTANGLE
			l_physics, l_draw: STRING
		do
			if statistic_box = Void then
				create statistic_box
				create txt.make_with_text (interface_names.l_diagram_statistic (nr_of_classes.out,
																				nr_of_client_supplier_links.out,
																				nr_of_inheritance_links.out,
																				nr_of_clusters.out,
																				"",
																				"0",
																				""))
				txt.set_point_position (10, 10)
				create rec.make_with_positions (0, 0, txt.width + 60, txt.height + 20)
				rec.set_background_color (default_colors.white)
				statistic_box.extend (rec)
				statistic_box.extend (txt)
				statistic_box.set_pointer_style (default_pixmaps.sizeall_cursor)
			end
			if not has (statistic_box) then
				extend (statistic_box)
			end
			from
				nr_of_classes := 0
				l_classes := classes
				l_classes.start
			until
				l_classes.after
			loop
				if attached {EIFFEL_CLASS_FIGURE} l_classes.item as l_node and then l_node.is_show_requested then
					nr_of_classes := nr_of_classes + 1
				end
				l_classes.forth
			end
			from
				nr_of_clusters := 0
				l_clusters := clusters
				l_clusters.start
			until
				l_clusters.after
			loop
				if attached {EIFFEL_CLUSTER_FIGURE} l_clusters.item as l_cluster and then l_cluster.is_show_requested then
					nr_of_clusters := nr_of_clusters + 1
				end
				l_clusters.forth
			end
			from
				nr_of_client_supplier_links := 0
				nr_of_inheritance_links := 0
				l_links := links
				l_links.start
			until
				l_links.after
			loop
				if attached {EIFFEL_INHERITANCE_FIGURE} l_links.item as l_i_link and then l_i_link.is_show_requested then
					nr_of_inheritance_links := nr_of_inheritance_links + 1
				end
				if attached {EIFFEL_CLIENT_SUPPLIER_FIGURE} l_links.item as l_cs_link and then l_cs_link.is_show_requested then
					nr_of_client_supplier_links := nr_of_client_supplier_links + 1
				end
				l_links.forth
			end
			if physics_count = 0 then
				l_physics := "0"
			else
				l_physics := (physics_sum // physics_count).out
			end
			if draw_count = 0 then
				l_draw := "?"
			else
				l_draw := (draw_sum // draw_count).out
			end
			txt.set_text (interface_names.l_diagram_statistic (
										nr_of_classes.out,
										nr_of_client_supplier_links.out,
										nr_of_inheritance_links.out,
										nr_of_clusters.out,
										l_physics,
										l_draw,
										nbOfDraws.out))
			bring_to_front (statistic_box)
		end

feature {NONE} -- Implementation

	remove_view_from_file (ptf: RAW_FILE; a_name: READABLE_STRING_GENERAL)
			-- Remove view named `a_name' in `ptf'.
		require
			file_not_void: ptf /= Void
			ptf_is_readable: ptf.is_open_read
			a_name_exists: a_name /= Void
		local
			diagram_output: XML_DOCUMENT
			a_cursor: XML_COMPOSITE_CURSOR
		do
			diagram_output := Xml_routines.deserialize_document_with_path (ptf.path)
			if diagram_output /= Void then
				check
					valid_xml: diagram_output.root_element.has_same_name (xml_node_name)
				end
				a_cursor := diagram_output.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					if
						attached {like xml_element} a_cursor.item as l_node and then
						l_node.has_same_name (once "VIEW") and then
						a_name.same_string (l_node.attribute_by_name (once "NAME").value)
					then
						diagram_output.root_element.remove_at_cursor (a_cursor)
					end
					if not a_cursor.after then
						a_cursor.forth
					end
				end
				Xml_routines.save_xml_document_with_path (ptf.path, diagram_output)
			end
		end

	has_view_with_name (f: RAW_FILE; a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `f' contain a view with name `a_name'?
		local
			diagram_input: XML_DOCUMENT
			a_cursor: XML_COMPOSITE_CURSOR
			view_name: READABLE_STRING_GENERAL
		do
			diagram_input := Xml_routines.deserialize_document_with_path (f.path)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.has_same_name (xml_node_name)
				end
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after or else Result
				loop
					if attached {like xml_element} a_cursor.item as l_node then
						if l_node.has_same_name (once "VIEW") then
							view_name := l_node.attribute_by_name (once "NAME").value
							Result := view_name.same_string (a_name)
						end
					end
					a_cursor.forth
				end
				a_cursor.go_after
			end
		end

	figure_added (a_figure: EG_FIGURE)
			-- `a_figure' was added to the view.
		do
			Precursor {EG_FIGURE_WORLD} (a_figure)
			if not is_high_quality then
				if attached {BON_FIGURE} a_figure as bon_fig then
					bon_fig.disable_high_quality
				end
			end
			if attached {EIFFEL_CLIENT_SUPPLIER_FIGURE} a_figure as cs_fig then
				if not is_labels_shown then
					cs_fig.hide_label
				end
				if not is_client_supplier_links_shown then
					cs_fig.hide
					cs_fig.disable_sensitive
				end
				if is_right_angles then
					cs_fig.apply_right_angles
				end
			elseif attached {EIFFEL_INHERITANCE_FIGURE} a_figure as i_fig then
				if not is_inheritance_links_shown then
					i_fig.hide
					i_fig.disable_sensitive
				end
				if is_right_angles then
					i_fig.apply_right_angles
				end
			elseif attached {EIFFEL_CLUSTER_FIGURE} a_figure as c_fig then
				if not is_cluster_shown then
					c_fig.disable_shown
				end
			elseif
				is_legend_shown and then
				attached {EIFFEL_CLASS_FIGURE} a_figure as bc_fig
			then
				cluster_legend.update
				bring_to_front (cluster_legend)
			end
		end

	set_high_quality (b: BOOLEAN)
			-- Set all BON_FIGUREs in `world' to high quality if `b', low quality otherwise.
		do
			across
				clusters as ic
			loop
				if attached {BON_FIGURE} ic.item as bon_fig then
					if b then
						bon_fig.enable_high_quality
					else
						bon_fig.disable_high_quality
					end
				end
			end
			across
				links as ic
			loop
				if attached {BON_FIGURE} ic.item as bon_fig then
					if b then
						bon_fig.enable_high_quality
					else
						bon_fig.disable_high_quality
					end
				end
			end
			across
				classes as ic
			loop
				if attached {BON_FIGURE} ic.item as bon_fig then
					if b then
						bon_fig.enable_high_quality
					else
						bon_fig.disable_high_quality
					end
				end
			end
		end

	set_label_shown (b: BOOLEAN)
			-- Show labels if `b', hide otherwise.
		do
			across
				links as ic
			loop
				if attached {EIFFEL_CLIENT_SUPPLIER_FIGURE} ic.item as cs_link then
					if b then
						if not cs_link.is_label_shown then
							cs_link.show_label
						end
					else
						if cs_link.is_label_shown then
							cs_link.hide_label
						end
					end
				end
			end
		end

	set_client_supplier_links_shown (b: BOOLEAN)
			-- Show client supplier links in `links' if `b', hide otherwise.
		do
			across
				links as ic
			loop
				if
					attached {EIFFEL_CLIENT_SUPPLIER_FIGURE} ic.item as cs_link and then
					cs_link.model.is_needed_on_diagram
				then
					if b then
						cs_link.show
						cs_link.enable_sensitive
					else
						cs_link.hide
						cs_link.disable_sensitive
					end
				end
			end
		end

	set_inheritance_links_shown (b: BOOLEAN)
			-- Show inheritance links in `links' if `b', hide otherwise.
		do
			across
				links as ic
			loop
				if
					attached {EIFFEL_INHERITANCE_FIGURE} ic.item as i_link and then
					i_link.model.is_needed_on_diagram
				then
					if b then
						i_link.show
						i_link.enable_sensitive
					else
						i_link.hide
						i_link.disable_sensitive
					end
				end
			end
		end

	set_is_cluster_shown (b: BOOLEAN)
			-- Show clusters in `clusters' if `b', hide otherwise.
		do
			across
				clusters as ic
			loop
				if attached {EIFFEL_CLUSTER_FIGURE} ic.item as l_item then
					if b then
						l_item.enable_shown
					else
						l_item.disable_shown
					end
				end
			end
		end

	set_is_anchor_shown (b: BOOLEAN)
			-- Show all anchors of linkable figures if `b'.
		do
			across
				classes as ic
			loop
				if attached {BON_CLASS_FIGURE} ic.item as bcf then
					if b then
						bcf.show_anchor
					else
						bcf.hide_anchor
					end
				end
			end
		end

feature {EB_DELETE_FIGURE_COMMAND} -- UndoRedo delete

	reinclude_class (a_class: EIFFEL_CLASS_FIGURE; a_links: LIST [ES_ITEM]; ax, ay: INTEGER)
			-- Reinclude `a_class' and all links in `a_links' that has been removed by `disable_needed_on_diagram'
			-- and set the corresponding figures port position to (`ax',`ay').
		require
			a_class_not_void: a_class /= Void
			a_class_not_needed_on_diagram: not a_class.model.is_needed_on_diagram
		do
			a_class.model.enable_needed_on_diagram
			from
				a_links.start
			until
				a_links.after
			loop
				a_links.item.enable_needed_on_diagram
				a_links.forth
			end
			a_class.set_port_position (ax, ay)
		ensure
			a_class_needed_on_diagram: a_class.model.is_needed_on_diagram
		end

	remove_class_virtual (a_class: EIFFEL_CLASS_FIGURE; a_links: LIST [ES_ITEM])
			-- Remove `a_class' and all links in `a_links' from diagram
			-- by disable `is_needed_on_diagram'
		do
			a_class.model.disable_needed_on_diagram
			from
				a_links.start
			until
				a_links.after
			loop
				a_links.item.disable_needed_on_diagram
				a_links.forth
			end
		end

	remove_cluster_virtual (cluster_figure: EIFFEL_CLUSTER_FIGURE; a_links: LIST [ES_ITEM]; a_classes: LIST [TUPLE [figure: EIFFEL_CLASS_FIGURE; port_x: INTEGER; port_y: INTEGER]])
			-- Remove `cluster_figure' all links in `a_links' and all classes in `a_classes' at position in TUPLE by
			-- disable `is_needed_on_diagram'.
		local
			empty_list: ARRAYED_LIST [ES_ITEM]
			l_class_figure: EIFFEL_CLASS_FIGURE
		do
			cluster_figure.model.disable_needed_on_diagram
			from
				create empty_list.make (0)
				a_classes.start
			until
				a_classes.after
			loop
				l_class_figure := a_classes.item.figure
				remove_class_virtual (l_class_figure, empty_list)
				a_classes.forth
			end
			from
				a_links.start
			until
				a_links.after
			loop
				a_links.item.disable_needed_on_diagram
				a_links.forth
			end
		end

	reinclude_cluster (cluster_figure: EIFFEL_CLUSTER_FIGURE; a_links: LIST [ES_ITEM];
				a_classes: LIST [TUPLE [figure: EIFFEL_CLASS_FIGURE; port_x: INTEGER; port_y: INTEGER]]
			)
			-- Reinclude `cluster_figure', all links in `a_links' and all classes in `a_classes' at position in TUPLE
			-- by enable `is_needed_on_diagram'.
		local
			empty_list: ARRAYED_LIST [ES_ITEM]
			l_class_figure: EIFFEL_CLASS_FIGURE
			ax, ay: INTEGER
		do
			cluster_figure.model.enable_needed_on_diagram
			from
				create empty_list.make (0)
				a_classes.start
			until
				a_classes.after
			loop
				l_class_figure := a_classes.item.figure
				ax := a_classes.item.port_x
				ay := a_classes.item.port_y
				reinclude_class (l_class_figure, empty_list, ax, ay)
				a_classes.forth
			end
			from
				a_links.start
			until
				a_links.after
			loop
				a_links.item.enable_needed_on_diagram
				a_links.forth
			end
		end

feature {NONE} -- Implementation

	enable_all_links (a_linkable: EG_LINKABLE)
			-- Enable is_neede_on_diagram for all links in `a_linkable'.
		do
			across
				a_linkable.links as ic
			loop
				if
					attached {ES_ITEM} ic.item as eiffel_item and then
					not eiffel_item.is_needed_on_diagram and then
					(not attached {ES_ITEM} ic.item.source as e_source or else e_source.is_needed_on_diagram) and then
					(not attached {ES_ITEM} ic.item.target as e_target or else e_target.is_needed_on_diagram)
				then
					eiffel_item.enable_needed_on_diagram
				end
			end
		end

	on_pointer_button_press (figure: EG_LINKABLE_FIGURE; ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- Pointer button was pressed on `figure'.
		do
			Precursor {EG_FIGURE_WORLD} (figure, ax, ay, button, x_tilt, y_tilt, pressure, screen_x, screen_y)
			if cluster_legend /= Void and then cluster_legend.is_show_requested then
				bring_to_front (cluster_legend)
			end
		end

	on_linkable_move (figure: EG_LINKABLE_FIGURE; ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- `figure' was moved for `ax' `ay'.
			-- | Move all `selected_figures' as well.
		local
			l_selected_figures: like selected_figures
			l_item: EG_FIGURE
			i, nb, l_index: INTEGER
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			l_edge_list: LIST [EG_EDGE]
		do
			if
				not attached {EG_CLUSTER_FIGURE} figure and then
				not selected_figures.is_empty
			then
				check
					when_figures_selected_move_only_a_selected_figure: selected_figures.has (figure)
				end
				from
					l_selected_figures := selected_figures
					i := 1
					nb := l_selected_figures.count
				until
					i > nb
				loop
					l_item := l_selected_figures.i_th (i)
					if l_item /= figure then
						if attached {EG_LINKABLE_FIGURE} l_item as l_linkable then
							l_linkable.set_is_fixed (True)
							l_links := l_linkable.internal_links
							if not is_right_angles and then l_links /= Void and then l_links.count > 0 then
									-- Here we check if both `source' and `target' of a link figure are selected, if so then we must force a transition of the links' edges.
								from
									l_index := 1
								until
									l_index > l_links.count
								loop
									if
										l_links [l_index].source.is_selected and then
										l_links [l_index].target.is_selected and then
										l_links [l_index].source /= l_links [l_index].target and then
										attached {EG_POLYLINE_LINK_FIGURE} l_links [l_index] as l_polyline_link
									then
										l_edge_list := l_polyline_link.edge_move_handlers
										if l_edge_list /= Void and then l_edge_list.count > 0 then
											from
												l_edge_list.start
											until
												l_edge_list.after
											loop
												l_edge_list.item.set_point_position (l_edge_list.item.point_x + ax, l_edge_list.item.point_y + ay)
												l_edge_list.item.move_actions.call ([ax, ay, x_tilt, y_tilt, pressure, screen_x, screen_y])
												l_edge_list.forth
											end
										end
									end
									l_index := l_index + 1
								end
							end
						end
						l_item.set_point_position (l_item.point_x + ax, l_item.point_y + ay)
					end
					if attached {EIFFEL_CLASS_FIGURE} l_item as e_c_fig then
						if is_right_angles and not context_editor.is_force_directed_used then
							e_c_fig.apply_right_angles
						end
					end
					i := i + 1
				end
			else
				if is_right_angles and not context_editor.is_force_directed_used then
					if attached {EIFFEL_CLASS_FIGURE} figure as e_c_fig then
						e_c_fig.apply_right_angles
					end
				end
			end
		end

	on_valid_tag_read
			-- A valid tag was read through xml routines.
		local
			lpd: EB_PERCENT_PROGRESS_BAR
		do
			lpd := context_editor.develop_window.status_bar.progress_bar
			if lpd /= Void then
				if lpd.value < lpd.range.upper then
					lpd.set_value (lpd.value + 1)
				end
			end
		end

feature {NONE} -- Implementation

	is_same_string (s1, s2: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is s1 and s2 the same string content?
		do
			if s1 = Void then
				Result := s2 = Void
			elseif s1 = s2 then
				Result := True
			else
				Result := s1.same_string (s2)
			end
		end

	node_type: ES_CLASS
			-- Type for nodes.
		do
		end

invariant
	scale_factor_larger_zero: scale_factor > 0.0
	current_view_not_void: current_view /= Void
	available_views_not_void: available_views /= Void
	available_views_compare_objects: available_views.object_comparison

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
