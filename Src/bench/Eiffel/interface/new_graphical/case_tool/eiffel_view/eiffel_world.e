indexing
	description: "Objects that is a view for on EIFFEL_GRAPH"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
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
			make_with_model_and_factory
		end
		
	EB_CONSTANTS
		undefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
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
		
	make_with_model_and_factory (a_model: like model; a_factory: like factory) is
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

	is_statistics: BOOLEAN is False
			-- Is a statistic shown informing of draw and physics time?
			
	is_uml: BOOLEAN
			-- Is diagram shown as UML?
			
feature -- Access

	context_editor: EB_CONTEXT_EDITOR
			-- Context showing `Current'.
			
	model: ES_GRAPH
			-- Model for `Current'.
	
	current_view: STRING
			-- Name of Current view.
			
	available_views: LINKED_LIST [STRING]
			-- All the views described in `Current' ead file.
			
	default_view_name: STRING is
			-- Name for the default view.
		do
			Result := "DEFAULT"
		ensure
			Result_not_Void: Result /= Void
		end
		
	uml_views (file_name: STRING): LIST [STRING] is
			-- All views in `file_name' which are uml views.
		require
			file_name_not_void: file_name /= Void
		local
			diagram_input: XM_DOCUMENT
			node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			view_name: STRING
		do
			create {ARRAYED_LIST [STRING]} Result.make (0)
			diagram_input := Xml_routines.deserialize_document (file_name)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.name.is_equal (xml_node_name)
				end
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					node ?= a_cursor.item
					if node /= Void then
						if node.name.is_equal ("VIEW") then
							view_name := node.attribute_by_name ("NAME").value 
							if node.attribute_by_name ("IS_UML").value.is_equal ("True") then
								Result.extend (view_name)	
							end
						end
					end
					a_cursor.forth
				end
			end
		end
			
	bon_views (file_name: STRING): LIST [STRING] is
			-- All views in `file_name' which are bon views.
		require
			file_name_not_void: file_name /= Void
		local
			diagram_input: XM_DOCUMENT
			node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			view_name: STRING
		do
			create {ARRAYED_LIST [STRING]} Result.make (0)
			diagram_input := Xml_routines.deserialize_document (file_name)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.name.is_equal (xml_node_name)
				end
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					node ?= a_cursor.item
					if node /= Void then
						if node.name.is_equal ("VIEW") then
							view_name := node.attribute_by_name ("NAME").value 
							if node.attribute_by_name ("IS_UML").value.is_equal ("False") then
								Result.extend (view_name)	
							end
						end
					end
					a_cursor.forth
				end
			end
		end
		
feature -- Element change.

	update is
			-- Update.
		do
			if is_statistics then
				update_statistic
			end
			Precursor {EG_FIGURE_WORLD}
			if is_cluster_shown then
				update_fade
			end
		end

	scale (a_scale: DOUBLE) is
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

	enable_high_quality is
			-- Enable high quality.
		do
			is_high_quality := True
			set_high_quality (True)
		ensure
			is_high_quality: is_high_quality
		end
		
	disable_high_quality is
			-- Disable high qualtiy.
		do
			is_high_quality := False
			set_high_quality (False)
		ensure
			is_low_quality: not is_high_quality
		end
		
	show_labels is
			-- Show labels.
		do
			is_labels_shown := True
			set_label_shown (True)
		ensure
			is_labels_shown: is_labels_shown
		end
		
	hide_labels is
			-- Hide labels.
		do
			is_labels_shown := False
			set_label_shown (False)
		ensure
			labels_hidden: not is_labels_shown
		end
		
	show_client_supplier_links is
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
		
	hide_client_supplier_links is
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
		
	show_inheritance_links is
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
		
	hide_inheritance_links is
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
		
	show_clusters is
			-- Show cluster figures.
		do
			is_cluster_shown := True
			set_is_cluster_shown (True)
			update_fade
		ensure
			is_cluster_shown: is_cluster_shown
		end
	
	hide_clusters is
			-- Hide cluster figures.
		local
			l_c_fig: EIFFEL_CLASS_FIGURE
			l_linkables: like classes
			i, nb: INTEGER
		do
			is_cluster_shown := False
			set_is_cluster_shown (False)
			from
				l_linkables := classes
				i := 1
				nb := l_linkables.count
			until
				i > nb
			loop
				l_c_fig ?= l_linkables.i_th (i)
				if l_c_fig /= Void then
					l_c_fig.fade_in
				end
				i := i + 1
			end
		ensure
			not_is_cluster_shown: not is_cluster_shown
		end
		
	show_legend is
			-- Show legend of clusters and colors.
		local
			bbox: like bounding_box
		do
			cluster_legend.update
			cluster_legend.hide
			bbox := bounding_box
			cluster_legend.set_point_position (bbox.left, bbox.top)
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
		
	hide_legend is
			-- Hide legend of clusters and colors.
		do
			cluster_legend.hide
			cluster_legend.disable_sensitive
			is_legend_shown := False
		ensure
			legend_is_hidden: not is_legend_shown
		end
		
	enable_right_angles is
			-- Set `is_right_angles' to True.
		do
			is_right_angles := True
		ensure
			set: is_right_angles
		end
		
	disable_right_angles is
			-- Set `is_right_angles' to False.
		do
			is_right_angles := False
		ensure
			set: not is_right_angles
		end
		
	apply_right_angles is
			-- Apply right angles to all LINK_FIGUREs in the world.
		local
			l_edges: ARRAYED_LIST [EG_LINK_FIGURE]
			l_item: EIFFEL_LINK_FIGURE
			i, nb: INTEGER
		do
			if context_editor.force_directed_layout.is_stopped then
				update
				from
					l_edges := links
					i := 1
					nb := l_edges.count
				until
					i > nb
				loop
					l_item ?= l_edges.i_th (i)
					if l_item /= Void then
						l_item.apply_right_angles
					end
					i := i + 1
				end
			end
		end
		
	remove_right_angles is
			-- Remove all edges in links.
		local
			l_edges: ARRAYED_LIST [EG_LINK_FIGURE]
			l_item: EIFFEL_LINK_FIGURE
			i, nb: INTEGER
		do
			from
				l_edges := links
				i := 1
				nb := l_edges.count
			until
				i > nb
			loop
				l_item ?= l_edges.i_th (i)
				if l_item /= Void then
					l_item.reset
				end
				i := i + 1
			end
		end

feature {EB_CONTEXT_EDITOR} -- Status settings
		
	show_anchors is
			-- Show all anchors of fixed linkable figures.
		do
			set_is_anchor_shown (True)
		end
		
	hide_anchors is
			-- Hide all anchors of fixed linkable figures.
		do
			set_is_anchor_shown (False)
		end

feature {EB_CHANGE_COLOR_COMMAND, EB_DELETE_FIGURE_COMMAND, EG_FIGURE} -- Cluster color legend.

	update_cluster_legend is
			-- 
		do
			if is_legend_shown then
				cluster_legend.update
				bring_to_front (cluster_legend)
			end
		end
		
feature {EB_CONTEXT_EDITOR} -- Legend

	cluster_legend: EIFFEL_CLUSTER_LEGEND
			-- Legend of clusters and colors.
			
feature -- Store/Retrive

	remove_view (name: STRING) is
			-- Remove any reference to view named `name' in the .xml file.
			-- Switch to view default_view_name.
		require
			name_not_void: name /= Void
		local
			f: RAW_FILE
		do
			create f.make (context_editor.diagram_file_name (Current.model))
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			remove_view_from_file (f, name)
			available_views.prune_all (name)
			f.close

			current_view := default_view_name
			create f.make (context_editor.diagram_file_name (Current.model))
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
			end
			context_editor.projector.full_project
		ensure
			default_view_restored: current_view.is_equal (default_view_name)
		end
		
	set_current_view (name: STRING) is
			-- Set `current_view' to `name'.
		require
			name_not_void: name /= Void
		do
			current_view := name
			if not available_views.has (name) then
				available_views.extend (name)
			end
		ensure
			set: current_view = name
			name_is_available: available_views.has (name)
		end

	retrieve_view (name: STRING) is
			-- Assign `name' to `current_view' and retrieve corresponding settings.
		require
			name_not_void: name /= Void
		local
			f: RAW_FILE
		do
			 	-- Save current view.
			create f.make (context_editor.diagram_file_name (Current.model))
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			store (f)
			f.close
				-- Restore view `name' if possible.
			current_view := name
			create f.make (context_editor.diagram_file_name (Current.model))
			if f.exists then
				f.open_read
				if f.readable and then has_view_with_name (f, name) then
					retrieve (f)
				end
			end
			if not available_views.has (name) then
				available_views.extend (name)
			end
		ensure
			name_assigned: current_view.is_equal (name)
		end

	store (ptf: RAW_FILE) is
			-- Freeze state of `Current'.
		local
			diagram_output: XM_DOCUMENT
			view_output, node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			root: XM_ELEMENT
		do
			if ptf.is_open_read then
					-- Remove any previous save of `current_view'.
				diagram_output := Xml_routines.deserialize_document (ptf.name)
			else
					-- Create a new view.
				create diagram_output.make_with_root_named (xml_node_name,
					create {XM_NAMESPACE}.make_default)
			end
			if diagram_output /= Void then
				a_cursor := diagram_output.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					node ?= a_cursor.item
					if
						node /= Void and then
						node.name.is_equal ("VIEW") and then
						equal (node.attribute_by_name ("NAME").value, current_view)
					then
						diagram_output.root_element.remove_at_cursor (a_cursor)
					end
					if not a_cursor.after then
						a_cursor.forth
					end
				end
				create root.make_root (create {XM_DOCUMENT}.make, "VIEW", xml_namespace)
				root.add_attribute ("IS_UML", xml_namespace, is_uml.out)
				view_output := xml_element (root)
				diagram_output.root_element.force_first (view_output)
				Xml_routines.save_xml_document (ptf.name, diagram_output)
			end
		end
		
	load_available_views (f: RAW_FILE) is
			-- Load avaiable views from `f' store it in `available_views.
		require
			f_exists: f /= Void
		local
			diagram_input: XM_DOCUMENT
			node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			view_name: STRING
		do
			available_views.wipe_out
			diagram_input := Xml_routines.deserialize_document (f.name)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.name.is_equal (xml_node_name)
				end
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					node ?= a_cursor.item
					if node /= Void then
						if node.name.is_equal ("VIEW") then
							view_name := node.attribute_by_name ("NAME").value
							available_views.extend (view_name)
						end
					end
					a_cursor.forth
				end
			end
			if not available_views.has (default_view_name) then
				available_views.extend (default_view_name)
			end
		end

	retrieve (f: RAW_FILE) is
			-- Reload former state of `Current'.
		local
			diagram_input: XM_DOCUMENT
			view_input, node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			nb_of_tags: INTEGER
			view_name: STRING
		do
			diagram_input := Xml_routines.deserialize_document (f.name)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.name.is_equal (xml_node_name)
				end
				available_views.wipe_out
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					node ?= a_cursor.item
					if node /= Void then
						if node.name.is_equal ("VIEW") then
							view_name := node.attribute_by_name ("NAME").value
							available_views.extend (view_name)
							if view_input = Void or else node.attribute_by_name ("NAME").value.is_equal (current_view) then
								view_input := node
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
					if context_editor /= Void and then context_editor.progress_dialog /= Void then
						context_editor.progress_dialog.start (0)
						nb_of_tags := xml_routines.number_of_tags (view_input)
						context_editor.progress_dialog.start (nb_of_tags)
						context_editor.progress_dialog.set_degree ("Loading:")
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
		
	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		do
			Result := "EIFFEL_WORLD"
		end

	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			node.put_last (Xml_routines.xml_node (node, "INHERITANCE_LINKS_DISPLAYED", is_inheritance_links_shown.out))
			node.put_last (Xml_routines.xml_node (node, "CLIENT_LINKS_DISPLAYED", is_client_supplier_links_shown.out))
			node.put_last (Xml_routines.xml_node (node, "LABELS_SHOWN", is_labels_shown.out))
			node.put_last (Xml_routines.xml_node (node, "CLUSTER_SHOWN", is_cluster_shown.out))
			node.put_last (Xml_routines.xml_node (node, "HIGH_QUALITY", is_high_quality.out))
			node.put_last (Xml_routines.xml_node (node, "LEGEND_SHOWN", is_legend_shown.out))
			node.put_last (Xml_routines.xml_node (node, "LEGEND_X_POS", cluster_legend.point_x.out))
			node.put_last (Xml_routines.xml_node (node, "LEGEND_Y_POS", cluster_legend.point_y.out))
			node.put_last (xml_routines.xml_node (node, "IS_RIGHT_ANGLES", is_right_angles.out))
			
			Result := Precursor {EG_FIGURE_WORLD} (node)
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			ax, ay: INTEGER
		do
			if xml_routines.xml_boolean (node, "INHERITANCE_LINKS_DISPLAYED") then
				show_inheritance_links
			else
				hide_inheritance_links
			end
			if xml_routines.xml_boolean (node, "CLIENT_LINKS_DISPLAYED") then
				show_client_supplier_links
			else
				hide_client_supplier_links
			end
			if xml_routines.xml_boolean (node, "LABELS_SHOWN") then
				show_labels
			else
				hide_labels
			end
			if xml_routines.xml_boolean (node, "CLUSTER_SHOWN") then
				show_clusters
			else
				hide_clusters
			end
			if xml_routines.xml_boolean (node, "HIGH_QUALITY") then
				enable_high_quality
			else
				disable_high_quality
			end
			if xml_routines.xml_boolean (node, "LEGEND_SHOWN") then
				show_legend
				ax := xml_routines.xml_integer (node, "LEGEND_X_POS")
				ay := xml_routines.xml_integer (node, "LEGEND_Y_POS")
				cluster_legend.set_point_position (ax, ay)
			else
				hide_legend
				ax := xml_routines.xml_integer (node, "LEGEND_X_POS")
				ay := xml_routines.xml_integer (node, "LEGEND_Y_POS")
				cluster_legend.set_point_position (ax, ay)
			end
			if xml_routines.xml_boolean (node, "IS_RIGHT_ANGLES") then
				enable_right_angles
			else
				disable_right_angles
			end
			
			Precursor {EG_FIGURE_WORLD} (node)
		end
	
feature {EB_CONTEXT_EDITOR} -- Statistic

	set_last_draw_time (ms: INTEGER) is
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
		
	set_last_physics_time (ms: INTEGER) is
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
	
	update_statistic is
			-- Update statistic
		local
			l_classes: like classes
			l_node: EIFFEL_CLASS_FIGURE
			l_clusters: like clusters
			l_cluster: EIFFEL_CLUSTER_FIGURE
			l_links: like links
			l_cs_link: EIFFEL_CLIENT_SUPPLIER_FIGURE
			l_i_link: EIFFEL_INHERITANCE_FIGURE
			nr_of_classes: INTEGER
			nr_of_clusters: INTEGER
			nr_of_client_supplier_links: INTEGER
			nr_of_inheritance_links: INTEGER
			rec: EV_MODEL_RECTANGLE
			l_speed: STRING
		do
			if statistic_box = Void then
				create statistic_box
				create txt.make_with_text (	"Classes:  " + nr_of_classes.out + "%N" +
											"CS_Links: " + nr_of_client_supplier_links.out + "%N" +
											"I_Links:  " + nr_of_inheritance_links.out + "%N" +
											"Clusters: " + nr_of_clusters.out + "%N" +
											"Physics ms: %NDraw ms: 0%NDraws: ")
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
				l_node ?= l_classes.item
				if l_node /= Void and then l_node.is_show_requested then
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
				l_cluster ?= l_clusters.item
				if l_cluster /= Void and then l_cluster.is_show_requested then
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
				l_i_link ?= l_links.item
				if l_i_link /= Void and then l_i_link.is_show_requested then
					nr_of_inheritance_links := nr_of_inheritance_links + 1
				end
				l_cs_link ?= l_links.item
				if l_cs_link /= Void and then l_cs_link.is_show_requested then
					nr_of_client_supplier_links := nr_of_client_supplier_links + 1
				end
				l_links.forth
			end
			if physics_count = 0 then
				l_speed := "Physics ms: 0%N" 
			else
				l_speed := "Physics ms: " + (physics_sum // physics_count).out + "%N"
			end
			if draw_count = 0 then
				l_speed := l_speed + "Draw ms: ?"
			else
				l_speed := l_speed + "Draw ms: " + (draw_sum // draw_count).out
			end
			txt.set_text (	"Classes:  " + nr_of_classes.out + "%N" +
							"CS_Links: " + nr_of_client_supplier_links.out + "%N" +
							"I_Links:  " + nr_of_inheritance_links.out + "%N" +
							"Clusters: " + nr_of_clusters.out + "%N" +
							l_speed + "%NDraws: " +  nbOfDraws.out)
			bring_to_front (statistic_box)
		end


feature {NONE} -- Implementation

	remove_view_from_file (ptf: RAW_FILE; a_name: STRING) is
			-- Remove view named `a_name' in `ptf'.
		require
			file_not_void: ptf /= Void
			ptf_is_readable: ptf.is_open_read
			a_name_exists: a_name /= Void
		local
			diagram_output: XM_DOCUMENT
			node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
		do
			diagram_output := Xml_routines.deserialize_document (ptf.name)
			if diagram_output /= Void then
				check
					valid_xml: diagram_output.root_element.name.is_equal (xml_node_name)
				end
				a_cursor := diagram_output.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after
				loop
					node ?= a_cursor.item
					if
						node /= Void and then
						node.name.is_equal ("VIEW") and then
						equal (node.attribute_by_name ("NAME").value, a_name)
					then
						diagram_output.root_element.remove_at_cursor (a_cursor)
					end
					if not a_cursor.after then
						a_cursor.forth
					end
				end
				Xml_routines.save_xml_document (ptf.name, diagram_output)
			end
		end
		
	has_view_with_name (f: RAW_FILE; a_name: STRING): BOOLEAN is
			-- Does `f' contain a view with name `a_name'?
		local
			diagram_input: XM_DOCUMENT
			node: XM_ELEMENT
			a_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			view_name: STRING
		do
			diagram_input := Xml_routines.deserialize_document (f.name)
			if diagram_input /= Void then
				check
					valid_xml: diagram_input.root_element.name.is_equal (xml_node_name)
				end
				a_cursor := diagram_input.root_element.new_cursor
				from
					a_cursor.start
				until
					a_cursor.after or else Result
				loop
					node ?= a_cursor.item
					if node /= Void then
						if node.name.is_equal ("VIEW") then
							view_name := node.attribute_by_name ("NAME").value
							Result := view_name.is_equal (a_name)
						end
					end
					a_cursor.forth
				end
			end
		end

	figure_added (a_figure: EG_FIGURE) is
			-- `a_figure' was added to the view.
		local
			bon_fig: BON_FIGURE
			cs_fig: EIFFEL_CLIENT_SUPPLIER_FIGURE
			i_fig: EIFFEL_INHERITANCE_FIGURE
			c_fig: EIFFEL_CLUSTER_FIGURE
			bc_fig: EIFFEL_CLASS_FIGURE
		do
			Precursor {EG_FIGURE_WORLD} (a_figure)
			if not is_high_quality then
				bon_fig ?= a_figure
				if bon_fig /= Void then
					bon_fig.disable_high_quality
				end
			end
			cs_fig ?= a_figure
			if cs_fig /= Void then
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
			else
				i_fig ?= a_figure
				if i_fig /= Void then
					if not is_inheritance_links_shown then
						i_fig.hide
						i_fig.disable_sensitive
					end
					if is_right_angles then
						i_fig.apply_right_angles
					end
				else
					c_fig ?= a_figure
					if c_fig /= Void then
						if not is_cluster_shown then
							c_fig.disable_shown
						end
					else
						bc_fig ?= a_figure
						if is_legend_shown and then bc_fig /= Void then
							cluster_legend.update
							bring_to_front (cluster_legend)
						end
					end
				end
			end
		end
		
	set_high_quality (b: BOOLEAN) is
			-- Set all BON_FIGUREs in `world' to high quality if `b', low quality otherwise.
		local
			bon_fig: BON_FIGURE
			figs: LIST [EG_FIGURE]
		do
			figs := clusters
			from
				figs.start
			until
				figs.after
			loop
				bon_fig ?= figs.item
				if bon_fig /= Void then
					if b then
						bon_fig.enable_high_quality
					else
						bon_fig.disable_high_quality
					end
				end
				figs.forth
			end
			figs := links
			from
				figs.start
			until
				figs.after
			loop
				bon_fig ?= figs.item
				if bon_fig /= Void then
					if b then
						bon_fig.enable_high_quality
					else
						bon_fig.disable_high_quality
					end
				end
				figs.forth
			end
			figs := classes
			from
				figs.start
			until
				figs.after
			loop
				bon_fig ?= figs.item
				if bon_fig /= Void then
					if b then
						bon_fig.enable_high_quality
					else
						bon_fig.disable_high_quality
					end
				end
				figs.forth
			end
		end
		
	set_label_shown (b: BOOLEAN) is
			-- Show labels if `b', hide otherwise.
		local
			l_links: like links
			cs_link: EIFFEL_CLIENT_SUPPLIER_FIGURE
		do
			from
				l_links := links
				l_links.start
			until
				l_links.after
			loop
				cs_link ?= l_links.item
				if cs_link /= Void then
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
				l_links.forth
			end
		end
		
	set_client_supplier_links_shown (b: BOOLEAN) is
			-- Show client supplier links in `links' if `b', hide otherwise.
		local
			l_links: like links
			cs_link: EIFFEL_CLIENT_SUPPLIER_FIGURE
		do
			from
				l_links := links
				l_links.start
			until
				l_links.after
			loop
				cs_link ?= l_links.item
				if cs_link /= Void and then cs_link.model.is_needed_on_diagram then
					if b then
						cs_link.show
						cs_link.enable_sensitive
					else
						cs_link.hide
						cs_link.disable_sensitive
					end
				end
				l_links.forth
			end
		end
		
	set_inheritance_links_shown (b: BOOLEAN) is
			-- Show inheritance links in `links' if `b', hide otherwise.
		local
			l_links: like links
			i_link: EIFFEL_INHERITANCE_FIGURE
		do
			from
				l_links := links
				l_links.start
			until
				l_links.after
			loop
				i_link ?= l_links.item
				if i_link /= Void and then i_link.model.is_needed_on_diagram then
					if b then
						i_link.show
						i_link.enable_sensitive
					else
						i_link.hide
						i_link.disable_sensitive
					end
				end
				l_links.forth
			end
		end
		
	set_is_cluster_shown (b: BOOLEAN) is
			-- Show clusters in `clusters' if `b', hide otherwise.
		local
			l_clusters: like clusters
			l_item: EIFFEL_CLUSTER_FIGURE
		do
			from
				l_clusters := clusters
				l_clusters.start
			until
				l_clusters.after
			loop
				l_item ?= l_clusters.item
				if l_item /= Void then
					if b then
						l_item.enable_shown
					else
						l_item.disable_shown
					end
				end
				l_clusters.forth
			end
		end
		
	set_is_anchor_shown (b: BOOLEAN) is
			-- Show all anchors of linkable figures if `b'.
		local
			bcf: BON_CLASS_FIGURE
			l_classes: like classes
		do
			from
				l_classes := classes
				l_classes.start
			until
				l_classes.after
			loop
				bcf ?= l_classes.item
				if bcf /= Void then
					if b then
						bcf.show_anchor
					else
						bcf.hide_anchor
					end
				end
				l_classes.forth
			end
		end

feature {EB_DELETE_FIGURE_COMMAND} -- UndoRedo delete

	reinclude_class (a_class: EIFFEL_CLASS_FIGURE; a_links: LIST [ES_ITEM]; ax, ay: INTEGER) is
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
		
	remove_class_virtual (a_class: EIFFEL_CLASS_FIGURE; a_links: LIST [ES_ITEM]) is
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
		
	remove_cluster_virtual (cluster_figure: EIFFEL_CLUSTER_FIGURE; a_links: LIST [ES_ITEM]; a_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]) is
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
				l_class_figure ?= a_classes.item.item (1)
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
		
	reinclude_cluster (cluster_figure: EIFFEL_CLUSTER_FIGURE; a_links: LIST [ES_ITEM]; a_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]) is
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
				l_class_figure ?= a_classes.item.item (1)
				ax := a_classes.item.integer_item (2)
				ay := a_classes.item.integer_item (3)
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
		
	enable_all_links (a_linkable: EG_LINKABLE) is
			-- Enable is_neede_on_diagram for all links in `a_linkable'.
		local
			l_links: LIST [EG_LINK]
			eiffel_item: ES_ITEM
			e_source, e_target: ES_ITEM
		do
			from
				l_links := a_linkable.links
				l_links.start
			until
				l_links.after
			loop
				eiffel_item ?= l_links.item
				e_source ?= l_links.item.source
				e_target ?= l_links.item.target
				if 
					eiffel_item /= Void and then 
					not eiffel_item.is_needed_on_diagram and then
					(e_source = Void or else e_source.is_needed_on_diagram) and then
					(e_target = Void or else e_target.is_needed_on_diagram)
				then
					eiffel_item.enable_needed_on_diagram
				end
				l_links.forth
			end
		end
		
	on_pointer_button_press (figure: EG_LINKABLE_FIGURE; ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Pointer button was pressed on `figure'.
		do
			Precursor {EG_FIGURE_WORLD} (figure, ax, ay, button, x_tilt, y_tilt, pressure, screen_x, screen_y)
			bring_to_front (cluster_legend)
		end
		
	on_linkable_move (figure: EG_LINKABLE_FIGURE; ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- `figure' was moved for `ax' `ay'.
			-- | Move all `selected_figures' as well.
		local
			l_selected_figures: like selected_figures
			l_item: EG_FIGURE
			i, nb: INTEGER
			cf: EG_CLUSTER_FIGURE
			l_linkable: EG_LINKABLE_FIGURE
			e_c_fig: EIFFEL_CLASS_FIGURE
		do
			cf ?= figure
			if cf = Void and then not selected_figures.is_empty then
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
						l_item.set_point_position (l_item.point_x + ax, l_item.point_y + ay)
						l_linkable ?= l_item
						if l_linkable /= Void then
							l_linkable.set_is_fixed (True)
						end
					end
					e_c_fig ?= l_item
					if e_c_fig /= Void then	
						if is_right_angles and not context_editor.is_force_directed_used then
							e_c_fig.apply_right_angles
						end
					end
					i := i + 1
				end
			else
				if is_right_angles and not context_editor.is_force_directed_used then				
					e_c_fig ?= figure
					if e_c_fig /= Void then
						e_c_fig.apply_right_angles
					end
				end
			end
		end
		
	on_valid_tag_read is
			-- A valid tag was read throug xml routines.
		local
			lpd: EB_PROGRESS_DIALOG
		do
			lpd := context_editor.progress_dialog
			if lpd /= Void then
				if lpd.value < lpd.range.upper then
					lpd.set_value (lpd.value + 1)
				end
			end
		end
		
	update_fade is
			-- Fade out classes with cluster on top fade in otherwise.
		local
			l_c_fig: EIFFEL_CLASS_FIGURE
			l_linkables: like classes
			i, nb: INTEGER
		do
			from
				l_linkables := classes
				i := 1
				nb := l_linkables.count
			until
				i > nb
			loop
				l_c_fig ?= l_linkables.i_th (i)
				if l_c_fig /= Void then
					l_c_fig.update_fade
				end
				i := i + 1
			end
		end

invariant
	scale_factor_larger_zero: scale_factor > 0.0
	current_view_not_void: current_view /= Void
	available_views_not_void: available_views /= Void
	available_views_compare_objects: available_views.object_comparison
		
end -- class EIFFEL_WORLD
