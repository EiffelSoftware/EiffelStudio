indexing
	description: "World of DIAGRAM_COMPONENTs that make up a diagram; centered on a class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTEXT_DIAGRAM

inherit
	LINKABLE_FIGURE_GROUP
		undefine
			default_create
		end

	EV_FIGURE_WORLD
		export {CLASS_TEXT_MODIFIER}
			Default_pixmaps
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create
		end

	SHARED_API_ROUTINES
		undefine
			default_create
		end

	SHARED_XML_ROUTINES
		export {ANY}
			error_window
		undefine
			default_create
		end

	EB_CONTEXT_TOOL_DATA
		undefine
			default_create
		end

	SHARED_ERROR_HANDLER
		undefine
			default_create
		end

	EB_CONSTANTS
		undefine
			default_create
		end

	ES_DIAGRAM_BUFFER_MANAGER
		export
			{NONE} set_drawable_position;
			{EB_CONTEXT_EDITOR, EB_DIAGRAM_HTML_GENERATOR} set_drawable_cell_and_position
		undefine
			default_create
		end

feature {NONE} -- Initialization

	make (a_tool: like context_editor) is
			-- Initialize as context in `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			default_create

			set_background_color (diagram_color)
			create layout
			create class_figures.make
			create cluster_figures.make
			create included_figures.make
			included_figures.compare_objects
			create excluded_figures.make
			excluded_figures.compare_objects
			context_editor := a_tool
			enable_grid
			hide_grid
			descendant_depth := 1 
			ancestor_depth := 1 
			client_depth := 0
			supplier_depth := 0 
			scale_x := 1.0
			scale_y := 1.0
			labels_shown := True
			inheritance_links_displayed := True
			client_links_displayed := False
			placement_needed := False
			feature_name_number := 0
			set_link_client
			cancelled := False

			point.set_scale_x (scale_x)
			point.set_scale_y (scale_y)
			current_view := "DEFAULT"
			create available_views.make
			available_views.compare_objects

				-- Initialization of the layers.
				-- Inheritance layer is on top because it is a thin line
				-- and would be obscured by the client links.
				-- Move handles are the farthest away.
			create class_layer
			extend (class_layer)
			create client_supplier_layer
			extend (client_supplier_layer)
			create inheritance_layer
			extend (inheritance_layer)
			create client_supplier_mover_layer
			extend (client_supplier_mover_layer)
			create inheritance_mover_layer
			extend (inheritance_mover_layer)
			create label_mover_layer
			extend (label_mover_layer)
			drop_actions.extend (~on_class_drop)
			drop_actions.extend (~on_new_class_drop)
			reset_valid_tags
		end

feature {EB_CONTEXT_EDITOR} -- Initialization

	set_class (a_class: CLASS_I) is
			-- Set `a_class' as new center of the context.
		do
			clear_figures
			center_class := new_class_figure (a_class)
			create layout
			add_class_figure (center_class)
			center_class.point.set_position (0, 0)
			explore_relations
		end

feature -- Memory management

	recycle is
			-- Frees `Current's memory, and leave `Current' in an unstable state
			-- so that we know whether we're still referenced or not.
		local	
			csf: CLIENT_SUPPLIER_FIGURE
			cf: CLASS_FIGURE
			retried: BOOLEAN
		do
			if not retried then
				wipe_out
				drop_actions.wipe_out
				from
					class_layer.start
				until
					class_layer.after
				loop
					cf ?= class_layer.item
					cf.recycle
					class_layer.forth
				end
				from
					client_supplier_layer.start
				until
					client_supplier_layer.after
				loop
					csf ?= client_supplier_layer.item
					csf.recycle
					client_supplier_layer.forth
				end
				clear_figures
				class_figures.wipe_out
				cluster_figures.wipe_out
				included_figures.wipe_out
				excluded_figures.wipe_out
			end
		rescue
			retried := True
			Error_handler.error_list.wipe_out
			retry
		end

feature -- Layers

	class_layer: EV_FIGURE_GROUP
			-- Classes displayed in current diagram.

	inheritance_mover_layer: EV_FIGURE_GROUP
			-- All move handles on inheritance relations.

	client_supplier_mover_layer: EV_FIGURE_GROUP
			-- All move handles on client relations.

	label_mover_layer: EV_FIGURE_GROUP
			-- All move handles on client link labels.

	inheritance_layer: EV_FIGURE_GROUP
			-- Inheritance links in current diagram.

	client_supplier_layer: EV_FIGURE_GROUP
			-- Client-supplier links in current diagram.	
			
feature -- Access

	center_class: CLASS_FIGURE
			-- Class this diagram is the context of.

	current_view: STRING
			-- Name of `Current' current view.

	available_views: LINKED_LIST [STRING]
			-- All the views described in `Current' ead file.

	included_figures: LINKED_LIST [LINKABLE_FIGURE]
			-- Figures the user wants to have in the diagram.

	excluded_figures: LINKED_LIST [LINKABLE_FIGURE]
			-- Figures the user does not want to have in the diagram.
			
	context_editor: EB_CONTEXT_EDITOR
			-- Container of `Current'.
			-- Used to access surface on which `Current' is displayed.
			
	projector: EV_WIDGET_PROJECTOR
			-- Projector of `Current'on `drawable'.
			
	has_linkable_figure (a_figure: LINKABLE_FIGURE): BOOLEAN is
			-- Is `a_figure' present on `Current'?
		require
			a_figure_not_void: a_figure /= Void
		do
			Result := class_layer.has (a_figure)
		end

	class_figure_by_class (a_class: CLASS_I): CLASS_FIGURE is
			-- Search diagram component of `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			cf: CLASS_FIGURE
		do
			from
				class_layer.start
			until
				Result /= Void or else class_layer.after
			loop
				cf ?= class_layer.item
				check
					cf_exists: cf /= Void
				end
				if cf.class_i = a_class then
					Result := cf
				end
				class_layer.forth
			end
		end
	
	class_figure_by_class_name (n: STRING): CLASS_FIGURE is
			-- Search group component of class named `n'.
		require
			name_not_void: n /= Void
		local
			cf: CLASS_FIGURE
		do
			from
				class_layer.start
			until
				class_layer.after or Result /= Void
			loop
				cf ?= class_layer.item
				if cf /= Void and then cf.name.is_equal (n) then
					Result := cf
				end
				class_layer.forth
			end
		end

	excluded_class_figure_by_class (a_class: CLASS_I): CLASS_FIGURE is
			-- Search any exluded figure representing `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			cf: CLASS_FIGURE
		do
			from
				excluded_figures.start
			until
				excluded_figures.after or Result /= Void
			loop
				cf ?= excluded_figures.item
				if cf /= Void and then cf.class_i = a_class then
					Result := cf
				end
				excluded_figures.forth
			end
		end		

feature {EB_CONTEXT_EDITOR, EB_DIAGRAM_HTML_GENERATOR} -- Element change

--	set_drawable (a_drawable: EV_DRAWABLE) is
--			-- Set `a_drawable' to `drawable'.
--		do
--			drawable := a_drawable
--		end

	set_projector (a_projector: EV_WIDGET_PROJECTOR) is
			-- Set `a_projector' to `projector'.
		require
			a_projector_not_void: a_projector /= Void
		do
			projector := a_projector
		ensure
			assigned: projector = a_projector
		end
		
feature -- Status report

	scale_x: DOUBLE
			-- X scale factor.

	scale_y: DOUBLE
			-- Y scale factor.

	include_all_classes_of_cluster: BOOLEAN
			-- Do all the classes in same cluster as `center_class' have to be in `Current?

	include_only_classes_of_cluster: BOOLEAN
			-- Do all the classes in `Current' have to be in same cluster as `center_class'?

	ancestor_depth: INTEGER
			-- Depth of ancestor links.

	descendant_depth: INTEGER
			-- Depth of descendant links.

	client_depth: INTEGER
			-- Depth of client links.

	supplier_depth: INTEGER
			-- Depth of supplier links.
			
	is_link_inheritance: BOOLEAN
			-- Does the user want inheritance links?

	is_link_client: BOOLEAN
			-- Does the user want client links?

	is_link_aggregate: BOOLEAN
			-- Does the user want aggregate links?
			
	labels_shown: BOOLEAN
			-- Are client link labels currently displayed?
			
	inheritance_links_displayed: BOOLEAN
			-- Are inheritance links currently displayed?

	client_links_displayed: BOOLEAN
			-- Are client links currently displayed?

	cancelled: BOOLEAN
			-- Was construction of `Current' cancelled by another construction?

feature {CLASS_TEXT_MODIFIER} -- Status report
	
	next_feature_name_number: INTEGER is
			-- Number to append to next created feature.
		do
			Result := feature_name_number
			feature_name_number := feature_name_number + 1
		ensure
			feature_name_number_incremented:
				feature_name_number = old feature_name_number + 1
		end

feature -- Status setting

	set_ancestor_depth (i: INTEGER) is
			-- Set `ancestor_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			ancestor_depth := i
		ensure
			assigned: ancestor_depth = i
		end

	set_descendant_depth (i: INTEGER) is
			-- Set `descendant_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			descendant_depth := i
		ensure
			assigned: descendant_depth = i
		end

	set_client_depth (i: INTEGER) is
			-- Set `client_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			client_depth := i
		ensure
			assigned: client_depth = i
		end

	set_supplier_depth (i: INTEGER) is
			-- Set `supplier_depth' to `i'.
		require
			positive_depth: i >= 0
		do
			supplier_depth := i
		ensure
			assigned: supplier_depth = i
		end

	set_scale_x (new_scale_x: DOUBLE) is
			-- Set `scale_x' to `new_scale_x'.
		do
			scale_x := new_scale_x
		end

	set_scale_y (new_scale_y: DOUBLE) is
			-- Set `scale_y' to `new_scale_y'.
		do
			scale_y := new_scale_y
		end

	set_include_all_classes_of_cluster (b: BOOLEAN) is
			-- Set `include_all_classes_of_cluster' to `b'.
		do
			include_all_classes_of_cluster := b
		ensure
			assigned: include_all_classes_of_cluster = b
		end

	set_include_only_classes_of_cluster (b: BOOLEAN) is
			-- Set `include_only_classes_of_cluster' to b.
		do
			include_only_classes_of_cluster := b
		ensure
			assigned: include_only_classes_of_cluster = b
		end

	set_link_inheritance is
		do
			is_link_inheritance := True	
			is_link_client := False
			is_link_aggregate := False
		end

	set_link_client is
		do
			is_link_client := True
			is_link_inheritance := False	
			is_link_aggregate := False	
		end

	set_link_aggregate_client is
		do
			is_link_aggregate := True
			is_link_inheritance := False	
			is_link_client := False	
		end

	enable_inheritance_links_displayed is
			-- Display inheritance links.
		do
			inheritance_links_displayed := True
		ensure
			enabled: inheritance_links_displayed 
		end

	disable_inheritance_links_displayed is
			-- Do not display inheritance links.
		do
			inheritance_links_displayed := False
		ensure
			disabled: not inheritance_links_displayed 
		end

	enable_client_links_displayed is
			-- Display client links.
		do
			client_links_displayed := True
		ensure
			enabled: client_links_displayed 
		end

	disable_client_links_displayed is
			-- Do not display client links.
		do
			client_links_displayed := False
		ensure
			disabled: not client_links_displayed 
		end

	enable_placement_needed is
			-- Set `placement_needed' to True.
		do
			placement_needed := True
		ensure
			placement_needed_enabled: placement_needed
		end		

	use_right_angles is
			-- Use right angles for all links displayed in `Current'.
		local
			csf: CLIENT_SUPPLIER_FIGURE
			ihf: INHERITANCE_FIGURE
			cur: CURSOR
		do
			from
				inheritance_layer.start
			until
				inheritance_layer.after
			loop
				ihf ?= inheritance_layer.item
				cur := inheritance_layer.cursor
				ihf.set_right_angle
				inheritance_layer.go_to (cur)
				inheritance_layer.forth
			end
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				cur := client_supplier_layer.cursor
				csf.set_right_angle
				client_supplier_layer.go_to (cur)
				client_supplier_layer.forth
			end
		end

	undo_right_angles is
			-- Undo `use_right_angles'.
		local
			csf: CLIENT_SUPPLIER_FIGURE
			ihf: INHERITANCE_FIGURE
			cur: CURSOR
		do
			from
				inheritance_layer.start
			until
				inheritance_layer.after
			loop
				ihf ?= inheritance_layer.item
				cur := inheritance_layer.cursor
				ihf.unset_right_angle
				inheritance_layer.go_to (cur)
				inheritance_layer.forth
			end
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				cur := client_supplier_layer.cursor
				csf.unset_right_angle
				client_supplier_layer.go_to (cur)
				client_supplier_layer.forth
			end
		end

	redo_right_angles is
			-- Redo `use_right_angles'.
		local
			csf: CLIENT_SUPPLIER_FIGURE
			ihf: INHERITANCE_FIGURE
			cur: CURSOR
		do
			from
				inheritance_layer.start
			until
				inheritance_layer.after
			loop
				ihf ?= inheritance_layer.item
				cur := inheritance_layer.cursor
				ihf.reset_right_angle
				inheritance_layer.go_to (cur)
				inheritance_layer.forth
			end
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				cur := client_supplier_layer.cursor
				csf.reset_right_angle
				client_supplier_layer.go_to (cur)
				client_supplier_layer.forth
			end
		end

	show_links is
			-- Display inheritance & client links.
		do
			if client_links_displayed then
				client_supplier_layer.show
			end
			if inheritance_links_displayed then
				inheritance_layer.show
			end
		end

	hide_links is
			-- Do not display inheritance & client links.
		do
			if client_links_displayed then
				client_supplier_layer.hide
			end
			if inheritance_links_displayed then
				inheritance_layer.hide
			end
		end

	show_labels is
			-- Display client link labels.
		local	
			csf: CLIENT_SUPPLIER_FIGURE
		do
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				if csf /= Void then
					csf.show_label
					client_supplier_layer.forth
				end
			end
			labels_shown := True
			if not has (label_mover_layer) then
				extend (label_mover_layer)
			end
		ensure
			labels_currently_displayed: labels_shown
		end

	hide_labels is
			-- Do not display client link labels.
		local
			csf: CLIENT_SUPPLIER_FIGURE
		do
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				if csf /= Void then
					csf.hide_label
					client_supplier_layer.forth
				end
			end
			labels_shown := False
			prune_all (label_mover_layer)
		ensure
			labels_not_currently_displayed: not labels_shown
		end
		
	reset is
			-- Redo default placement.
		do
			reset_colors
			reset_links
			included_figures.wipe_out
			excluded_figures.wipe_out
			point.set_position (0, 0)
			layout.arrange_all (Current)
			refresh
		end

	reset_links is
			-- Restore default links between classes.
		local
			icf: BON_INHERITANCE_FIGURE
			csf: BON_CLIENT_SUPPLIER_FIGURE
		do
			from
				inheritance_layer.start
			until
				inheritance_layer.after
			loop
				icf ?= inheritance_layer.item
				if icf /= Void then
					icf.reset
				end
				inheritance_layer.forth
			end
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				if csf /= Void then
					csf.reset
				end
				client_supplier_layer.forth
			end
		end

	reset_colors is
			-- Restore default colors for all class figures.
		local
			bcf: BON_CLASS_FIGURE
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				bcf ?= class_layer.item
				if bcf /= Void then
					bcf.set_color (bon_class_fill_color)
				end
				class_layer.forth
			end
		end

	reset_scales is
			-- Set default scaling factors back.
		do
			set_scale_x (1.0)
			set_scale_y (1.0)
			point.set_scale_x (1.0)
			point.set_scale_y (1.0)
			set_grid_x (Default_grid_x)
			set_grid_y (Default_grid_y)
		end

feature {EB_CONTEXT_EDITOR, EB_SELECT_DEPTH_COMMAND} -- Status setting

	cancel is
			-- Cancel construction of `Current'.
		do
			cancelled := True
		ensure
			is_cancelled: cancelled
		end

feature -- Factory

	new_class_figure (a_class: CLASS_I): CLASS_FIGURE is
			-- Create a concrete class figure.
		deferred
		end

	new_inheritance_figure (a_descendant, a_ancestor: CLASS_FIGURE): INHERITANCE_FIGURE is
			-- Create a concrete inheritance figure.
		deferred
		end

	new_client_supplier_figure (a_client, a_supplier: CLASS_FIGURE; data: CASE_SUPPLIER): CLIENT_SUPPLIER_FIGURE is
			-- Create a concrete client-supplier figure.
		deferred
		end
		
feature -- View management

	set_current_view (name: STRING) is
			-- Assign `name' to `current_view' and retrieve corresponding settings.
		require
			name_not_void: name /= Void
		local
			f: RAW_FILE
		do
			 	-- Save current view.
			create f.make (context_editor.diagram_file_name (Current))
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			store (f)
			f.close

			remove_included_figures
			reset_scales

				-- Restore view `name' if possible.
			current_view := name
			create f.make (context_editor.diagram_file_name (Current))
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
			else
				reset_colors
				reset_links
				included_figures.wipe_out
				excluded_figures.wipe_out
				point.set_position (0, 0)
				context_editor.reset_toggles (Current)
				set_ancestor_depth (1)
				set_descendant_depth (1)
				set_client_depth (0)
				set_supplier_depth (0)
				set_include_all_classes_of_cluster (False) 
				set_include_only_classes_of_cluster (False) 
				synchronize (True, Void)
			end
		ensure
			name_assigned: current_view.is_equal (name)
		end

	remove_view (name: STRING) is
			-- Remove any reference to view named `name' in the .ead file.
			-- Switch to view "DEFAULT".
		require
			name_not_void: name /= Void
		local
			f: RAW_FILE
		do
			create f.make (context_editor.diagram_file_name (Current))
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			remove_view_from_file (f, name)
			f.close

			current_view := "DEFAULT"
			create f.make (context_editor.diagram_file_name (Current))
			if f.exists then
				f.open_read
				if f.readable then
					retrieve (f)
				end
			else
				reset
			end
			context_editor.projector.full_project
		ensure
			default_view_restored: current_view.is_equal ("DEFAULT")
		end
		
	remove_view_from_file (ptf: RAW_FILE; a_name: STRING) is
			-- Remove view named `a_name' in `ptf'.
		require
			file_not_void: ptf /= Void
			ptf_is_readable: ptf.is_open_read
			a_name_exists: a_name /= Void
		local
			s: STRING
			diagram_output, node: XML_ELEMENT
			parser: XML_TREE_PARSER
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
		do
				-- Remove any previous save of `current_view'.
			create parser.make
			ptf.read_stream (ptf.count)
			s := ptf.last_string
			parser.parse_string (s)
			parser.set_end_of_file
			if parser.is_correct then
				if parser.root_element.name.is_equal ("CONTEXT_DIAGRAM") then
					diagram_output := parser.root_element
					a_cursor := diagram_output.new_cursor
					from
						a_cursor.start
					until
						a_cursor.after
					loop
						node ?= a_cursor.item
						if node /= Void then
							if node.name.is_equal ("VIEW") then
								if node.attributes.item ("NAME").value.is_equal (a_name) then
									diagram_output.remove_at_cursor (a_cursor)
								end
							end
						end
						if not a_cursor.after then
							a_cursor.forth
						end
					end
				end
				ptf.close
				ptf.open_write
				ptf.put_string (diagram_output.out)
			end
		end
		
	reset_views is
			-- Delete `available_views' content but "DEFAULT".
		do
			available_views.wipe_out
			available_views.extend ("DEFAULT")
		end

feature {CLASS_FIGURE} -- Relations

	inherit_link (c, p: LINKABLE_FIGURE): INHERITANCE_FIGURE is
			-- Inheritance figure from `c' to `p'.
			-- Void if none.
		local
			ii: INHERITANCE_FIGURE
		do
			from
				inheritance_layer.start
			until
				Result /= Void or else inheritance_layer.after
			loop
				ii ?= inheritance_layer.item
				if ii.ancestor = p and then ii.descendant = c then
					Result := ii
				end
				inheritance_layer.forth
			end
		end

	client_link (c, s: LINKABLE_FIGURE): CLIENT_SUPPLIER_FIGURE is
			-- Client figure from `s' to `c'.
			-- Void if none.
		local
			ii: CLIENT_SUPPLIER_FIGURE
		do
			from
				client_supplier_layer.start
			until
				Result /= Void or else client_supplier_layer.after
			loop
				ii ?= client_supplier_layer.item
				if ii.client = c and then ii.supplier = s then
					Result := ii
				end
				client_supplier_layer.forth
			end
		end

	descendant_figures (c: LINKABLE_FIGURE): LINKED_LIST [LINKABLE_FIGURE] is
			-- All descendants of `c' in the diagram.
		local
			d: LINKED_LIST [INHERITANCE_FIGURE]
			sd: LINKED_LIST [LINKABLE_FIGURE]
		do
			d := c.descendant_figures
			create Result.make
			from d.start until d.after loop
				sd := descendant_figures (d.item.descendant)
				from sd.start until sd.after loop
					Result.extend (sd.item)
					sd.forth
				end
				d.forth
			end
		end

	add_client_supplier_relation (c, s: CLASS_FIGURE) is
			-- Add new client-supplier between `c' and `s'.
			-- Do not add if link already present.
		require
			-- Both figures are in the diagram.
		local
			cg: CLASS_TEXT_MODIFIER
			x_pos, y_pos, screen_w, screen_h: INTEGER
			screen: EV_SCREEN
		do
			create screen
			screen_w := screen.width
			screen_h := screen.height
			x_pos := s.x_position + context_editor.widget.screen_x
			y_pos := s.y_position + context_editor.widget.screen_y
			cg := c.code_generator
			cg.reset_date
			cg.set_diagram (Current)
			cg.new_query_from_diagram (s.name, x_pos, y_pos, screen_w, screen_h)
		end

	add_aggregate_client_supplier_relation (c, s: CLASS_FIGURE) is
			-- Add new aggregate client-supplier between `c' and `s'.
			-- Do not add if link already present.
		require
			-- Both figures are in the diagram.
		local
			cg: CLASS_TEXT_MODIFIER
			x_pos, y_pos, screen_w, screen_h: INTEGER
			screen: EV_SCREEN
		do
			create screen
			screen_w := screen.width
			screen_h := screen.height
			x_pos := s.x_position + context_editor.widget.screen_x
			y_pos := s.y_position + context_editor.widget.screen_y
			cg := c.code_generator
			cg.reset_date
			cg.set_diagram (Current)
			cg.new_aggregate_query_from_diagram (s.name, x_pos, y_pos, screen_w, screen_h)
		end

	add_inheritance_relation (c, p: CLASS_FIGURE) is
			-- Add new inheritance between `c' and `p'.
			-- Do not add if link already present.
			-- Checks for circular inheritance.
		require
			-- Both figures are in the diagram.
		local
			ih_fig: INHERITANCE_FIGURE
			cf: CLASS_FIGURE
		do
			if inherit_link (c, p) = Void then
				ih_fig := new_inheritance_figure (c, p)
				cf ?= ih_fig.descendant
				if cf /= Void then
					cf.code_generator.reset_date
					cf.code_generator.set_diagram (Current)
				end
				context_editor.history.do_named_undoable (
					Interface_names.t_Diagram_add_inh_link_cmd,
					ih_fig~put_on_diagram (Current),
					ih_fig~remove_from_diagram (Current))
				if not ih_fig.last_generation_successful then
					context_editor.history.remove_last
				end
				ih_fig.update
			end
		end
		
feature {EB_CONTEXT_EDITOR, EB_SELECT_DEPTH_COMMAND} -- Synchronizing

	synchronize (projection_required: BOOLEAN; progress_dialog: EB_PROGRESS_DIALOG) is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchronization.
			-- Call the projector if `projection_required' is True.
			-- Display progress bar if `progress_dialog' exists.
		local
			current_cluster_i: CLUSTER_I
			class_list: EXTEND_TABLE [CLASS_I, STRING]
			cf: CLASS_FIGURE
		do
			if not cancelled then
				context_editor.development_window.window.set_pointer_style (Default_pixmaps.Wait_cursor)
				reset_scales
				prepare_synchronize
	
				if include_only_classes_of_cluster or else include_all_classes_of_cluster then
					current_cluster_i := center_class.class_i.cluster
				end
	
				if include_all_classes_of_cluster then
					class_list := current_cluster_i.classes
					from
						class_list.start
					until
						class_list.after
					loop
						cf := class_figure_by_class (class_list.item_for_iteration)
						if cf /= Void then
							cf.enable_needed_on_diagram
						else
							add_class (class_list.item_for_iteration)
						end
						class_list.forth
					end
				end	
	
				if progress_dialog /= Void then
					progress_dialog.set_value (1)
					progress_dialog.set_message ("Synchronizing ancestors")
				end
			end
			synchronize_ancestors (
				center_class.class_i,
				ancestor_depth,
				progress_dialog,
				current_cluster_i)

			if not cancelled and progress_dialog /= Void then
				progress_dialog.set_value (2)
				progress_dialog.set_message ("Synchronizing descendants")
			end
			synchronize_descendants (
				center_class.class_i,
				descendant_depth,
				progress_dialog,
				current_cluster_i)

			if not cancelled and progress_dialog /= Void then
				progress_dialog.set_value (3)
				progress_dialog.set_message ("Synchronizing clients")
			end
			synchronize_clients (
				center_class.class_i,
				client_depth,
				progress_dialog,
				current_cluster_i)

			if not cancelled and progress_dialog /= Void then
				progress_dialog.set_value (4)
				progress_dialog.set_message ("Synchronizing suppliers")
			end
			synchronize_suppliers (
				center_class.class_i,
				supplier_depth,
				progress_dialog,
				current_cluster_i)

			if not cancelled then
				if progress_dialog /= Void then
					progress_dialog.set_value (5)
					progress_dialog.set_message ("Removing unneeded classes")
				end
				remove_unneeded_classes
	
				if progress_dialog /= Void then
					progress_dialog.set_value (6)
					progress_dialog.set_message ("Synchronizing relations")
				end
				synchronize_relations
				remove_unneeded_relations				
	
				update_pebbles
				if placement_needed then
					layout.arrange_all (Current)
					reset_links
					placement_needed := False
				end
				
				if progress_dialog /= Void then
					progress_dialog.hide
				end
				refresh
				if projection_required then
					context_editor.update_bounds (Current)
					context_editor.projector.full_project
				end
				context_editor.development_window.window.set_pointer_style (Default_pixmaps.Standard_cursor)
			end
		end
		
feature {NONE} -- Synchronizing

	prepare_synchronize is
			-- Invalidate all figures before synchronizing.
		local
			dc: DIAGRAM_COMPONENT
			cf: CLASS_FIGURE
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				cf.disable_needed_on_diagram
				cf.build_queries
				class_layer.forth
			end
			from
				inheritance_layer.start
			until
				inheritance_layer.after
			loop
				dc ?= inheritance_layer.item
				dc.disable_needed_on_diagram
				inheritance_layer.forth
			end
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				dc ?= client_supplier_layer.item
				dc.disable_needed_on_diagram
				client_supplier_layer.forth
			end
			label_mover_layer.wipe_out
		end

	synchronize_ancestors (
		a_class: CLASS_I;
		depth: INTEGER;
		progress_dialog: EB_PROGRESS_DIALOG;
		a_cluster: CLUSTER_I) is
			-- Add ancestors of `a_class' until `depth' is reached.
		require
			a_cluster_exists_if_needed:
				include_only_classes_of_cluster implies a_cluster /= Void
		local
			l: FIXED_LIST [CL_TYPE_A]
			ci: CLASS_I
			cf: CLASS_FIGURE
			cur: CURSOR
		do
			if not cancelled then
				if depth > 0 and then a_class.compiled then
					l := a_class.compiled_class.parents
					from
						l.start
					until
						cancelled or l.after
					loop
						ci := l.item.associated_class.lace_class
						if
							(include_only_classes_of_cluster and a_cluster.classes.has_item (ci))
						or
							not include_only_classes_of_cluster
						then
							cf := class_figure_by_class (ci)
							if cf /= Void then
								cf.enable_needed_on_diagram
							else
								add_class (ci)
							end
						end
						cur := l.cursor
						synchronize_ancestors (ci, depth - 1, progress_dialog, a_cluster)
						l.go_to (cur)
						l.forth
						if progress_dialog /= Void then
							progress_dialog.show
							progress_dialog.graphical_update
						end
					end
				end
			end
		end

	synchronize_descendants (
		a_class: CLASS_I;
		depth: INTEGER;
		progress_dialog: EB_PROGRESS_DIALOG;
		a_cluster: CLUSTER_I) is
			-- Add descendants of `a_class' until `depth' is reached.
		local
			l: LINKED_LIST [CLASS_C]
			ci: CLASS_I
			cf: CLASS_FIGURE
			cur: CURSOR
		do
			if not cancelled then
				if depth > 0 and then a_class.compiled then
					l := a_class.compiled_class.descendants
					from
						l.start
					until
						cancelled or l.after
					loop
						ci := l.item.lace_class
						if
							(include_only_classes_of_cluster and a_cluster.classes.has_item (ci))
						or
							not include_only_classes_of_cluster
						then
							cf := class_figure_by_class (ci)
							if cf /= Void then
								cf.enable_needed_on_diagram
							else
								add_class (ci)
							end
						end
						cur := l.cursor
						synchronize_descendants (ci, depth - 1, progress_dialog, a_cluster)
						l.go_to (cur)
						l.forth
						if progress_dialog /= Void then
							progress_dialog.show
							progress_dialog.graphical_update
						end
					end
				end
			end
		end

	synchronize_clients (
		a_class: CLASS_I;
		depth: INTEGER;
		progress_dialog: EB_PROGRESS_DIALOG;
		a_cluster: CLUSTER_I) is
			-- Add clients of `a_class' until `depth' is reached.
		local
			l: LINKED_LIST [CLASS_C]
			ci: CLASS_I
			cf: CLASS_FIGURE
			cur: CURSOR
		do
			if not cancelled then
				if depth > 0 and then a_class.compiled then
					l := a_class.compiled_class.clients
					from
						l.start
					until
						cancelled or l.after
					loop
						ci := l.item.lace_class
						if
							(include_only_classes_of_cluster and a_cluster.classes.has_item (ci))
						or
							not include_only_classes_of_cluster
						then
							cf := class_figure_by_class (ci)
							if cf /= Void then
								cf.enable_needed_on_diagram
							else
								add_class (ci)
							end
						end
						cur := l.cursor					
						synchronize_clients (ci, depth - 1, progress_dialog, a_cluster)
						l.go_to (cur)
						l.forth
						if progress_dialog /= Void then
							progress_dialog.show
							progress_dialog.graphical_update
						end
					end
				end
			end
		end

	synchronize_suppliers (
		a_class: CLASS_I;
		depth: INTEGER;
		progress_dialog: EB_PROGRESS_DIALOG;
		a_cluster: CLUSTER_I) is
			-- Add suppliers of `a_class' until `depth' is reached.
		local
			l: SUPPLIER_LIST
			ci: CLASS_I
			cf: CLASS_FIGURE
			cur: CURSOR
		do
			if not cancelled then
				if depth > 0 and then a_class.compiled then
					l := a_class.compiled_class.suppliers
					from
						l.start
					until
						cancelled or l.after
					loop
						ci := l.item.supplier.lace_class
						if
							(include_only_classes_of_cluster and a_cluster.classes.has_item (ci))
						or
							not include_only_classes_of_cluster
						then
							cf := class_figure_by_class (ci)
							if cf /= Void then
								cf.enable_needed_on_diagram
							else
								add_class (ci)
							end
						end
						cur := l.cursor
						synchronize_suppliers (ci, depth - 1, progress_dialog, a_cluster)
						l.go_to (cur)
						l.forth
						if progress_dialog /= Void then
							progress_dialog.show
							progress_dialog.graphical_update
						end
					end
				end
			end
		end
		
	synchronize_relations is
			-- Synchronize relations according to new classes or class removals.
		local
			cf: CLASS_FIGURE
			a_cursor: CURSOR
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				if cf.class_i.compiled then
					a_cursor := class_layer.cursor
					synchronize_ancestor_relations (cf)
					synchronize_descendant_relations (cf)
					synchronize_client_relations (cf)
					synchronize_supplier_relations (cf)
					class_layer.go_to (a_cursor)
				end
				class_layer.forth
			end
		end

	synchronize_ancestor_relations (a_class: CLASS_FIGURE) is
			-- Add any ancestor links `a_class' may have with a class in the world.
		require
			a_class_compiled: a_class.class_i.compiled
		local
			l: FIXED_LIST [CL_TYPE_A]
			fig: CLASS_FIGURE
			ihf: INHERITANCE_FIGURE
		do
			l := a_class.class_i.compiled_class.parents
			if l /= Void then
				from l.start until l.after loop
					fig := class_figure_by_class (l.item.associated_class.lace_class)
					if fig /= Void then
						ihf := inherit_link (a_class, fig)
						if ihf /= Void then
							ihf.enable_needed_on_diagram
						else
							add_inheritance_figure (new_inheritance_figure (a_class, fig))
						end
					end
					l.forth
				end
			end
		end

	synchronize_descendant_relations (a_class: CLASS_FIGURE) is
			-- Add any descendant links `a_class' may have with a class in the world.
		require
			a_class_compiled: a_class.class_i.compiled
		local
			l: LINEAR [CLASS_C]
			fig: CLASS_FIGURE
			ihf: INHERITANCE_FIGURE
		do
			l := a_class.class_i.compiled_class.descendants
			if l /= Void then
				from l.start until l.after loop
					fig := class_figure_by_class (l.item.lace_class)
					if fig /= Void then
						ihf := inherit_link (fig, a_class)
						if ihf /= Void then
							ihf.enable_needed_on_diagram
						else
							add_inheritance_figure (new_inheritance_figure (fig, a_class))
						end
					end
					l.forth
				end
			end
		end

	synchronize_supplier_relations (a_class: CLASS_FIGURE) is
			-- Add any supplier links `a_class' may have with a class in the world.
		require
			a_class_compiled: a_class.class_i.compiled
		local
			l: LIST [CASE_SUPPLIER]
			sl: LIST [CLASS_I]
			fig: CLASS_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
			cur: CURSOR
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				fig ?= class_layer.item
				cur := class_layer.cursor
				l := a_class.suppliers_with_class (fig.class_i)
				if l /= Void then
					from
						l.start
					until
						l.after
					loop
						sl := l.item.supplier_classes
						from
							sl.start
						until
							sl.after
						loop
							fig := class_figure_by_class (sl.item)
							if fig /= Void then
								csf := client_link (a_class, fig)
								if csf /= Void then	
									csf := csf.link_by_feature_name (l.item.name)
									if csf /= Void then
										csf.enable_needed_on_diagram
										csf.build_label
										csf.update_name_figure
										if not csf.is_reflexive and then 
											not label_mover_layer.has (csf.name_figure_mover) then
												label_mover_layer.extend (csf.name_figure_mover)
										end
									else
										add_client_supplier_figure (new_client_supplier_figure (a_class, fig, l.item))
									end
								else
									add_client_supplier_figure (new_client_supplier_figure (a_class, fig, l.item))
								end
							end
							sl.forth
						end
						l.forth
					end
				end
				class_layer.go_to (cur)
				class_layer.forth
			end
		end

	synchronize_client_relations (a_class: CLASS_FIGURE) is
			-- Add any supplier links the diagram may have with `a_class'.
			-- Traversal happens in reverse, because we store all potential
			-- suppliers for a certain class in the class figures.
		require
			a_class_compiled: a_class.class_i.compiled
		local
			cf: CLASS_FIGURE
			l: LIST [CASE_SUPPLIER]
			csf: CLIENT_SUPPLIER_FIGURE
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				l := cf.suppliers_with_class (a_class.class_i)
				from
					l.start
				until
					l.after
				loop
					csf := client_link (cf, a_class)
					if csf /= Void then
						csf.enable_needed_on_diagram
						csf.build_label
						csf.update_name_figure
						if not csf.is_reflexive and then 
							not label_mover_layer.has (csf.name_figure_mover) then
								label_mover_layer.extend (csf.name_figure_mover)
						end
					else
						add_client_supplier_figure (new_client_supplier_figure (cf, a_class, l.item))
					end
					l.forth
				end
				class_layer.forth
			end
		end

	remove_unneeded_classes is
			-- Remove class figures where `needed_on_diagram' is False.
		local
			cf: CLASS_FIGURE
			a_cursor: CURSOR
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				a_cursor := class_layer.cursor
				if
					excluded_figures.has (cf)
					or
						(not cf.needed_on_diagram
					and not
						included_figures.has (cf)
					and
						cf /= center_class)
				then
					cf.remove_from_diagram (False)
					class_layer.go_to (a_cursor)
				else
					class_layer.forth
				end
			end
		end
	
	remove_unneeded_relations is
			-- Remove relations where `needed_on_diagram' is False.
		local
			ihf: INHERITANCE_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
			a_cursor: CURSOR
		do
			from
				inheritance_layer.start
			until
				inheritance_layer.after
			loop
				ihf ?= inheritance_layer.item
				a_cursor := inheritance_layer.cursor
				if not ihf.needed_on_diagram then
					inheritance_layer.prune_all (ihf)
					ihf.descendant.ancestor_figures.prune_all (ihf)
					ihf.ancestor.descendant_figures.prune_all (ihf)
					inheritance_layer.go_to (a_cursor)
				else
					inheritance_layer.forth
				end
			end
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				a_cursor := client_supplier_layer.cursor
				csf.remove_unneeded_figures
				if not csf.needed_on_diagram then
					csf.remove_from_diagram	
					client_supplier_layer.go_to (a_cursor)
				else
					client_supplier_layer.forth
				end
			end
		end	
		
feature {EB_CONTEXT_EDITOR} -- Saving

	store (ptf: RAW_FILE) is
			-- Freeze state of `Current'.
		require
			file_not_void: ptf /= Void
			file_exists: ptf /= Void
		local
			s: STRING
			diagram_output, view_output, node: XML_ELEMENT
			parser: XML_TREE_PARSER
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			rescued: BOOLEAN
		do
			if not rescued then
				if ptf.is_open_read then
						-- Remove any previous save of `current_view'.
					create parser.make
					ptf.read_stream (ptf.count)
					s := ptf.last_string
					parser.parse_string (s)
					parser.set_end_of_file
					if parser.is_correct then
						if parser.root_element.name.is_equal ("CONTEXT_DIAGRAM") then
							diagram_output := parser.root_element
							a_cursor := diagram_output.new_cursor
							from
								a_cursor.start
							until
								a_cursor.after
							loop
								node ?= a_cursor.item
								if node /= Void then
									if node.name.is_equal ("VIEW") then
										if node.attributes.item ("NAME").value.is_equal (current_view) then
											diagram_output.remove_at_cursor (a_cursor)
										end
									end
								end
								if not a_cursor.after then
									a_cursor.forth
								end
							end
						end
						ptf.close
						ptf.open_write
					end
				else
					create diagram_output.make_root ("CONTEXT_DIAGRAM")
				end
				view_output := xml_element
				view_output.set_parent (diagram_output)
				diagram_output.put_last (view_output)
				ptf.put_string (diagram_output.out)
			end
		rescue
			rescued := True
			Error_handler.error_list.wipe_out
			create error_window
			error_window.set_text ("Unable to write file:" + center_class.name + ".ead")
			error_window.show
			retry
		end

	load_from_file (f: RAW_FILE) is
			-- Retrieve content of `f', if any.
		require
			file_not_void: f /= Void
		local
			vs: EB_VIEW_SELECTOR
			pdial: EB_PROGRESS_DIALOG
			default_index: INTEGER
		do
			if not cancelled then
				pdial := context_editor.Progress_dialog
				if f.exists then
					f.open_read
					if f.readable then
						vs := context_editor.view_selector
						pdial.set_value (6)
						pdial.set_message ("Retrieving saved views")
						retrieve (f)
	
						if not cancelled then
							vs.select_actions.block
							vs.set_strings (available_views)
							vs.set_text ("DEFAULT")
							default_index := available_views.index_of ("DEFAULT", 1)
							if default_index > 0 then
								vs.i_th (default_index).enable_select						
							end				
							vs.select_actions.resume
							context_editor.update_size (Current)
							context_editor.update_toggles (Current)
						end
					else
						context_editor.reset (Current)
						context_editor.reset_toggles (Current)
						context_editor.update_size (Current)
					end
				else
					context_editor.reset (Current)
					context_editor.reset_toggles (Current)
					context_editor.update_size (Current)
				end
				if not cancelled then
					context_editor.reset_tool_bar_for_class_view
					projector.full_project			
				end
				pdial.hide
			end
		end

	retrieve (f: RAW_FILE) is
			-- Reload former state of `Current'.
		require
			file_not_void: f /= Void
			file_exists: f.exists
		local
			s: STRING
			parser: XML_TREE_PARSER
			diagram_input, view_input, node: XML_ELEMENT
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			rescued: BOOLEAN
		do
			if not cancelled then
				if not rescued then
					create parser.make
					f.read_stream (f.count)
					s := f.last_string
					parser.parse_string (s)
					parser.set_end_of_file
					f.close
					if parser.is_correct then
						diagram_input := parser.root_element
						if diagram_input.name.is_equal ("CONTEXT_DIAGRAM") then
							available_views.wipe_out
							a_cursor := diagram_input.new_cursor
							from
								a_cursor.start
							until
								a_cursor.after
							loop
								node ?= a_cursor.item
								if node /= Void then
									if node.name.is_equal ("VIEW") then
										available_views.extend (node.attributes.item ("NAME").value)
										if node.attributes.item ("NAME").value.is_equal (current_view) then
											view_input := node
										end
									end
								end
								a_cursor.forth
							end
							if view_input /= Void then
								set_with_xml_element (view_input)
								context_editor.update_toggles (Current)
								context_editor.update_bounds (Current)
							else
								reset_colors
								reset_links
								included_figures.wipe_out
								excluded_figures.wipe_out
								point.set_position (0, 0)
								context_editor.reset_toggles (Current)
								set_ancestor_depth (1)
								set_descendant_depth (1)
								set_client_depth (0)
								set_supplier_depth (0)
								set_include_all_classes_of_cluster (False) 
								set_include_only_classes_of_cluster (False) 
								synchronize (True, Void)
							end
						else
							create error_window
							error_window.set_text ("Incorrect File:" + center_class.name + ".ead")
							error_window.show
						end
					else
						create error_window
						error_window.set_text ("Incorrect File:" + center_class.name + ".ead")
						error_window.show
					end
				end
			end
		rescue
			rescued := True
			Error_handler.error_list.wipe_out
			create error_window
			error_window.set_text ("Unable to read file:" + center_class.name + ".ead")
			error_window.show_relative_to_window (context_editor.development_window.window)
			retry
		end

feature {NONE} -- XML

	xml_element: XML_ELEMENT is
			-- XML representation.
		local
			cf: CLASS_FIGURE
			hf: BON_INHERITANCE_FIGURE
			csf: BON_CLIENT_SUPPLIER_FIGURE
			include_xe, exclude_xe, xe: XML_ELEMENT
			include_element, exclude_element: XML_ELEMENT
		do
			create Result.make_root ("VIEW")
			Result.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", current_view))
			Result.put_last (xml_node (Result, "ANCESTOR_DEPTH", ancestor_depth.out))
			Result.put_last (xml_node (Result, "DESCENDANT_DEPTH", descendant_depth.out))
			Result.put_last (xml_node (Result, "CLIENT_DEPTH", client_depth.out))
			Result.put_last (xml_node (Result, "SUPPLIER_DEPTH", supplier_depth.out))
			Result.put_last (xml_node (Result, "ALL_CLASSES_IN_CLUSTER", include_all_classes_of_cluster.out))
			Result.put_last (xml_node (Result, "ONLY_CLASSES_IN_CLUSTER", include_only_classes_of_cluster.out))
			Result.put_last (xml_node (Result, "INHERITANCE_LINKS_DISPLAYED", inheritance_links_displayed.out))
			Result.put_last (xml_node (Result, "CLIENT_LINKS_DISPLAYED", client_links_displayed.out))
			Result.put_last (xml_node (Result, "LABELS_SHOWN", labels_shown.out))
			Result.put_last (xml_node (Result, "X_POS", ((point.x / scale_x)).rounded.out))
			Result.put_last (xml_node (Result, "Y_POS", ((point.y / scale_y)).rounded.out))
			create include_element.make (Result, "INCLUDED_FIGURES")
			from
				included_figures.start
			until
				included_figures.after
			loop
				cf ?= included_figures.item
				if cf /= Void then
					create include_xe.make (include_element, "CLASS")
					include_xe.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", cf.name))
				end
				include_element.put_last (include_xe)
				included_figures.forth
			end
			Result.put_last (include_element)
			create exclude_element.make (Result, "EXCLUDED_FIGURES")
			from
				excluded_figures.start
			until
				excluded_figures.after
			loop
				cf ?= excluded_figures.item
				if cf /= Void then
					create  exclude_xe.make (exclude_element, "CLASS")
					exclude_xe.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", cf.name))
				end
				exclude_element.put_last (exclude_xe)
				excluded_figures.forth
			end
			Result.put_last (exclude_element)

				-- Save figure positions.
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				Result.put_last (cf.xml_element (Result))
				class_layer.forth
			end
			from
				inheritance_layer.start
			until
				inheritance_layer.after
			loop
				hf ?= inheritance_layer.item
				xe := hf.xml_element (Result)
				if xe /= Void then
					Result.put_last (xe)
				end
				inheritance_layer.forth
			end
			from
				client_supplier_layer.start
			until
				client_supplier_layer.after
			loop
				csf ?= client_supplier_layer.item
				xe := csf.xml_element (Result)
				if xe /= Void then
					Result.put_last (xe)
				end
				client_supplier_layer.forth
			end
		end

	set_with_xml_element (an_element: XML_ELEMENT) is
			-- Set attributes from XML element.
		require
			an_element_not_void: an_element /= Void
		local
			a_cursor, include_cursor, exclude_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			node, child_node: XML_ELEMENT
			cf, cf2: CLASS_FIGURE
			hf: INHERITANCE_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
			class_name, a_source_name, a_target_name: STRING
			classes_found: LINKED_LIST [CLASS_I]
			new_ancestor_depth, new_descendant_depth, new_client_depth, new_supplier_depth: INTEGER
			all_cluster, only_in_cluster: BOOLEAN
		do
			reset_links
			reset_colors
			reset_valid_tags
			included_figures.wipe_out
			excluded_figures.wipe_out
			new_ancestor_depth := xml_integer (an_element, "ANCESTOR_DEPTH")
			new_descendant_depth := xml_integer (an_element, "DESCENDANT_DEPTH")
			new_client_depth := xml_integer (an_element, "CLIENT_DEPTH")
			new_supplier_depth := xml_integer (an_element, "SUPPLIER_DEPTH")
			all_cluster := xml_boolean (an_element, "ALL_CLASSES_IN_CLUSTER")
			only_in_cluster := xml_boolean (an_element, "ONLY_CLASSES_IN_CLUSTER")
			if new_ancestor_depth /= ancestor_depth or else
				new_descendant_depth /= descendant_depth or else
				new_client_depth /= client_depth or else
				new_supplier_depth /= supplier_depth or else
				all_cluster /= include_all_classes_of_cluster or else
				only_in_cluster /= include_only_classes_of_cluster then
					set_ancestor_depth (new_ancestor_depth)
					set_descendant_depth (new_descendant_depth)
					set_client_depth (new_client_depth)
					set_supplier_depth (new_supplier_depth)
					set_include_all_classes_of_cluster (all_cluster)
					set_include_only_classes_of_cluster (only_in_cluster)
					synchronize (False, context_editor.progress_dialog)
			end
			labels_shown := xml_boolean (an_element, "LABELS_SHOWN")
			if labels_shown then
				show_labels
			else
				hide_labels
			end
			inheritance_links_displayed := xml_boolean (an_element, "INHERITANCE_LINKS_DISPLAYED")
			client_links_displayed := xml_boolean (an_element, "CLIENT_LINKS_DISPLAYED")
			point.set_x (xml_integer (an_element, "X_POS"))
			point.set_y (xml_integer (an_element, "Y_POS"))
			a_cursor := an_element.new_cursor
			from
				a_cursor.go_i_th (valid_tags + 1)
			until
				a_cursor.after
			loop
				node ?= a_cursor.item
				if node /= Void then
					if node.name.is_equal ("CLASS_FIGURE") then
						if not node.attributes.is_empty then
							class_name := clone (node.attributes.first.value)
							class_name.to_upper
							cf := class_figure_by_class_name (class_name)
							if cf /= Void then
								cf.set_with_xml_element (node)
							end
						else
							create error_window
							error_window.set_text ("File " + center_class.name + ".ead: Class name expected")
							error_window.show
						end
					elseif node.name.is_equal ("INHERITANCE_FIGURE") then
						if not node.attributes.is_empty then
							a_source_name := clone (node.attributes.item ("SRC").value)
							a_source_name.to_upper
							cf := class_figure_by_class_name (a_source_name)
							a_target_name := clone (node.attributes.item ("TRG").value)
							a_target_name.to_upper
							cf2 := class_figure_by_class_name (a_target_name)
							hf ?= inherit_link (cf, cf2)
							if hf /= Void then
								hf.set_with_xml_element (node)
							end
						else
							create error_window
							error_window.set_text ("File " + center_class.name + ".ead: Class name expected")
							error_window.show
						end	
					elseif node.name.is_equal ("CLIENT_SUPPLIER_FIGURE") then
						if not node.attributes.is_empty then
							a_source_name := clone (node.attributes.item ("SRC").value)
							a_source_name.to_upper
							cf := class_figure_by_class_name (a_source_name)
							a_target_name := clone (node.attributes.item ("TRG").value)
							a_target_name.to_upper
							cf2 := class_figure_by_class_name (a_target_name)
							csf ?= client_link (cf, cf2)
							if csf /= Void then
								csf.set_with_xml_element (node)
							end
						else
							create error_window
							error_window.set_text ("File " + center_class.name + ".ead: Class name expected")
							error_window.show
						end			
					elseif node.name.is_equal ("INCLUDED_FIGURES") then
						include_cursor := node.new_cursor
						from
							include_cursor.start
						until	
							include_cursor.after
						loop
							child_node ?= include_cursor.item
							if child_node /= Void then
								if child_node.name.is_equal ("CLASS") then
									if not child_node.attributes.is_empty then
										class_name := clone (child_node.attributes.item ("NAME").value)
										class_name.to_upper
										cf := class_figure_by_class_name (class_name)
										if cf = Void then
											class_name.to_lower
											classes_found := Eiffel_universe.classes_with_name (class_name)
											if not classes_found.is_empty then
													--| FIXME: What to do if classes_found.count > 1?
												include_class (classes_found.first) 
											else
												create error_window
												error_window.set_text ("Class " + class_name + " not in the system")
												error_window.show
											end 
										end
									else
										create error_window
										error_window.set_text ("File " + center_class.name + ".ead: Class name expected")
										error_window.show
									end
								else
									create error_window
									error_window.set_text ("File " + center_class.name + ".ead: Tag " + node.name + " unknown")
									error_window.show
								end
							end
							include_cursor.forth
						end
					elseif node.name.is_equal ("EXCLUDED_FIGURES") then	
						exclude_cursor := node.new_cursor
						from
							exclude_cursor.start
						until	
							exclude_cursor.after
						loop
							child_node ?= exclude_cursor.item
							if child_node /= Void then
								if child_node.name.is_equal ("CLASS") then
									if not child_node.attributes.is_empty then
										class_name := clone (child_node.attributes.item ("NAME").value)
										class_name.to_upper
										cf := class_figure_by_class_name (class_name)
										if cf /= Void then
											cf.remove_from_diagram (True)
										end
									else
										create error_window
										error_window.set_text ("File " + center_class.name + ".ead: Class name expected")
										error_window.show
									end
								else
									create error_window
									error_window.set_text ("File " + center_class.name + ".ead: Tag " + node.name + " unknown")
									error_window.show
								end
							end
							exclude_cursor.forth
						end			
					else
						create error_window
						error_window.set_text ("File " + center_class.name + ".ead: Tag " + node.name + " unknown")
						error_window.show
					end
				end
				a_cursor.forth
			end
		end
		
feature {DIAGRAM_COMPONENT, CLASS_TEXT_MODIFIER} -- Implementation

	include_class (a_class: CLASS_I) is
			-- Include `a_class' in the diagram, on user request.
		local
			fig: CLASS_FIGURE
		do
			fig := class_figure_by_class (a_class)
			if fig = Void then
				fig := excluded_class_figure_by_class (a_class)
				if fig = Void then
					fig := new_class_figure (a_class)
				end
				fig.point.set_origin (point)
				add_class_figure (fig)
				if a_class.compiled then
					add_ancestor_relations (fig)
					add_descendant_relations (fig)
					add_client_relations (fig)
					add_supplier_relations (fig)
				end
				fig.update
			end
			excluded_figures.prune_all (fig)
			if not included_figures.has (fig) then
				included_figures.extend (fig)
			end
		end

	add_class (a_class: CLASS_I) is
			-- Include `a_class' in the diagram.
			-- Add any relations `a_class' may have with
			-- all items in `class_figures'.
		local
			fig: CLASS_FIGURE
		do
			if not context_editor.is_excluded_in_preferences (a_class.name_in_upper) then
				fig := class_figure_by_class (a_class)
				if fig = Void then
					fig := new_class_figure (a_class)
					fig.point.set_origin (point)
					add_class_figure (fig)
					if a_class.compiled then
						add_ancestor_relations (fig)
						add_descendant_relations (fig)
						add_client_relations (fig)
						add_supplier_relations (fig)
					end
				end
			end
		end

	exclude_class (a_class: CLASS_I) is
			-- Exclude `a_class' in the diagram, on user request.
		local
			fig: CLASS_FIGURE
		do
			fig := class_figure_by_class (a_class)
			if fig /= center_class then
				included_figures.prune_all (fig)
				if not excluded_figures.has (fig) then
					excluded_figures.extend (fig)
				end
				remove_class (a_class)
			end
		end

	remove_class (a_class: CLASS_I) is
			-- Remove `a_class' from the diagram.
		local
			fig: CLASS_FIGURE
		do
			fig := class_figure_by_class (a_class)
			if fig /= center_class then
				if fig /= Void then
					class_figures.prune_all (fig)
					class_layer.prune_all (fig)
					if fig.cluster_figure /= Void then
						fig.cluster_figure.remove_class (fig)
					end
				end
			end
		end

	add_class_figure (f: CLASS_FIGURE) is
			-- Extend structure with `f'.
		do
			f.point.set_origin (point)
			if f.point.x = 0 and then f.point.y = 0 then
				f.point.set_position (f.width, f.height)
			end
			class_layer.extend (f)
			f.enable_needed_on_diagram
			if not class_figures.has (f) then
				class_figures.extend (f)
			end
		end

	include_class_figure (f: CLASS_FIGURE) is
			-- Include `f' in the diagram, on user request.
		do
			add_class_figure (f)
			if f.class_i.compiled then
				add_ancestor_relations (f)
				add_descendant_relations (f)
				add_client_relations (f)
				add_supplier_relations (f)
			end
			excluded_figures.prune_all (f)
			if not included_figures.has (f) then
				included_figures.extend (f)
			end
		end

	add_inheritance_figure (f: INHERITANCE_FIGURE) is
			-- Extend structure with `f'.
		do
			f.point.set_origin (point)
			inheritance_layer.extend (f)
			f.enable_needed_on_diagram
		end

	add_client_supplier_figure (f: CLIENT_SUPPLIER_FIGURE) is
			-- Extend structure with `f'.
		local
			csf: CLIENT_SUPPLIER_FIGURE
		do
			csf := client_link (f.client, f.supplier)
			if csf = Void then
				client_supplier_layer.extend (f)
				if f.is_reflexive then
					f.reset
				else
					if has_linkable_figure (f.client) and then not f.client.supplier_figures.has (f) then
						f.client.supplier_figures.extend (f)
					end
					if has_linkable_figure (f.supplier) and then not f.supplier.client_figures.has (f) then
						f.supplier.client_figures.extend (f)
					end
					label_mover_layer.extend (f.name_figure_mover)
				end
				f.enable_is_valid
				f.update_origin
				f.enable_needed_on_diagram
			else
				if not csf.has_supplier_data (f.supplier_data) then
					f.set_parent (csf)
					f.wipe_out
					f.enable_needed_on_diagram
				elseif csf.supplier_data = f.supplier_data then
					csf.enable_is_valid
					csf.enable_needed_on_diagram
				end
			end
		end

	remove_included_figures is
			-- Remove elements in `included_figures' from Current.
		local
			cf: CLASS_FIGURE
		do
			from
				included_figures.start
			until
				included_figures.after
			loop
				cf ?= included_figures.item
				if cf /= Void then
					cf.remove_from_diagram (False)
				end
				included_figures.forth
			end
		end

	x_to_default_grid (a_x: INTEGER): INTEGER is
			-- Nearest point on default grid to absolute `a_x'.
		local
			offset, half_grid, grid: INTEGER
		do
			grid := Default_grid_x
			offset := point.x_abs \\ grid
			half_grid := grid // 2
			Result := ((a_x + half_grid - offset) // grid) * grid + offset
		end

	y_to_default_grid (a_y: INTEGER): INTEGER is
			-- Nearest point on default grid to absolute `a_y'.
		local
			offset, half_grid, grid: INTEGER
		do
			grid := Default_grid_y
			offset := point.y_abs \\ grid
			half_grid := grid // 2
			Result := ((a_y + half_grid - offset) // grid) * grid + offset
		end
		
feature {NONE} -- Implementation

	feature_name_number: INTEGER
			-- Number to append to next created feature.
			
	placement_needed: BOOLEAN
			-- Does next call to `synchronize' have to reset class placement?

	explore_relations is
			-- Explore relations of `center_class'.
		do
			if not cancelled then
				context_editor.put_progress_string ("Exploring ancestors of " + center_class.name, 2)
			end
			explore_ancestors (center_class.class_i, ancestor_depth)
			if not cancelled then
				context_editor.put_progress_string ("Exploring descendants of " + center_class.name, 3)
			end
			explore_descendants (center_class.class_i, descendant_depth)
			if not cancelled then
				context_editor.put_progress_string ("Exploring clients of " + center_class.name, 4)
			end
			explore_clients (center_class.class_i, client_depth)
			if not cancelled then
				context_editor.put_progress_string ("Exploring suppliers of " + center_class.name, 5)
			end
			explore_suppliers (center_class.class_i, supplier_depth)
		end

	explore_ancestors (a_class: CLASS_I; depth: INTEGER) is
			-- Add ancestors of `a_class' until `depth' is reached.
		local
			l: FIXED_LIST [CL_TYPE_A]
			ci: CLASS_I
		do
			if not cancelled then
				if depth > 0 and then a_class.compiled then
					l := a_class.compiled_class.parents
					from
						l.start
					until
						cancelled or l.after
					loop
						ci := l.item.associated_class.lace_class
						add_class (ci)
						explore_ancestors (ci, depth - 1)
						l.forth
						context_editor.refresh_progress
					end
				end
			end
		end

	explore_descendants (a_class: CLASS_I; depth: INTEGER) is
			-- Add descendants of `a_class' until `depth' is reached.
		local
			l: LINEAR [CLASS_C]
			ci: CLASS_I
		do
			if not cancelled then
				if depth > 0 and then a_class.compiled then
					l := a_class.compiled_class.descendants
					from
						l.start
					until
						cancelled or l.after
					loop
						ci := l.item.lace_class
						add_class (ci)
						explore_descendants (ci, depth - 1)
						l.forth
						context_editor.refresh_progress
					end
				end
			end
		end

	explore_clients (a_class: CLASS_I; depth: INTEGER) is
			-- Add clients of `a_class' until `depth' is reached.
		local
			l: LINEAR [CLASS_C]
			ci: CLASS_I
		do
			if not cancelled then
				if depth > 0 and then a_class.compiled then
					l := a_class.compiled_class.clients
					from
						l.start
					until
						cancelled or l.after
					loop
						ci := l.item.lace_class
						add_class (ci)
						explore_clients (ci, depth - 1)
						l.forth
						context_editor.refresh_progress
					end
				end
			end
		end

	explore_suppliers (a_class: CLASS_I; depth: INTEGER) is
			-- Add suppliers of `a_class' until `depth' is reached.
		local
			l: SUPPLIER_LIST
			ci: CLASS_I
		do
			if not cancelled then
				if depth > 0 and then a_class.compiled then
					l := a_class.compiled_class.suppliers
					from
						l.start
					until
						cancelled or l.after
					loop
						ci := l.item.supplier.lace_class
						add_class (ci)
						explore_suppliers (ci, depth - 1)
						l.forth
						context_editor.refresh_progress
					end
				end
			end
		end

	add_ancestor_relations (a_class: CLASS_FIGURE) is
			-- Add any ancestor links `a_class' may have with a class in the world.
		local
			l: FIXED_LIST [CL_TYPE_A]
			cl: CLASS_C
			fig: CLASS_FIGURE
		do
			l := a_class.class_i.compiled_class.parents
			if l /= Void then
				from l.start until l.after loop
					cl := l.item.associated_class
					if cl /= Void then
						fig := class_figure_by_class (cl.lace_class)
						if fig /= Void then
							add_inheritance_figure (new_inheritance_figure (a_class, fig))
						end
					end
					l.forth
				end
			end
		end

	add_descendant_relations (a_class: CLASS_FIGURE) is
			-- Add any descendant links `a_class' may have with a class in the world.
		local
			l: LINEAR [CLASS_C]
			fig: CLASS_FIGURE
		do
			l := a_class.class_i.compiled_class.descendants
			if l /= Void then
				from l.start until l.after loop
					fig := class_figure_by_class (l.item.lace_class)
					if fig /= Void then
						add_inheritance_figure (new_inheritance_figure (fig, a_class))
					end
					l.forth
				end
			end
		end

	add_supplier_relations (a_class: CLASS_FIGURE) is
			-- Add any supplier links `a_class' may have with a class in the world.
		local
			l: LIST [CASE_SUPPLIER]
			sl: LIST [CLASS_I]
			fig: CLASS_FIGURE
			cur: CURSOR
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				fig ?= class_layer.item
				cur := class_layer.cursor
				l := a_class.suppliers_with_class (fig.class_i)
				if l /= Void then
					from
						l.start
					until
						l.after
					loop
						sl := l.item.supplier_classes
						from
							sl.start
						until
							sl.after
						loop
							fig := class_figure_by_class (sl.item)
							if fig /= Void then
								add_client_supplier_figure (new_client_supplier_figure (a_class, fig, l.item))
							end
							sl.forth
						end
						l.forth
					end
				end
				class_layer.go_to (cur)
				class_layer.forth
			end
		end

	add_client_relations (a_class: CLASS_FIGURE) is
			-- Add any supplier links the diagram may have with `a_class'.
			-- Traversal happens in reverse, because we store all potential
			-- suppliers for a certain class in the class figures.
		local
			cf: CLASS_FIGURE
			l: LIST [CASE_SUPPLIER] 
		do
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				l := cf.suppliers_with_class (a_class.class_i)
				from
					l.start
				until
					l.after
				loop
					add_client_supplier_figure (new_client_supplier_figure (cf, a_class, l.item))
					l.forth
				end
				class_layer.forth
			end
		end

	include_new_dropped_class (a_create_class_dialog: EB_CREATE_CLASS_DIALOG; a_x, a_y: INTEGER) is
			-- Add `a_class' to the diagram if not already present.
		require
			a_create_class_dialog: a_create_class_dialog /= Void
		local
			a_class: CLASS_I
			cf: CLASS_FIGURE
		do
			if not a_create_class_dialog.cancelled then
				a_class := a_create_class_dialog.class_i
				if a_class /= Void then
					cf := class_figure_by_class (a_class)
					if cf = Void then
						cf := new_class_figure (a_class)	
					end
					check cf_not_void: cf /= Void end
					context_editor.history.do_named_undoable (
						Interface_names.t_Diagram_include_class_cmd,
						~include_dropped_class (cf, a_x, a_y),
						~remove_dropped_class (cf))
				end
			end
		end

	include_dropped_class (a_class: CLASS_FIGURE; a_x, a_y: INTEGER) is
			-- Add `a_class' to the diagram if not already present.
		require
			a_class_not_void: a_class /= Void
			a_class_not_in_diagram: not class_figures.has (a_class)
		do
			include_class_figure (a_class)
			a_class.point.set_position (
				a_x - a_class.point.origin.x_abs,
				a_y - a_class.point.origin.y_abs)
			refresh
			update_display
		end

	reinclude_dropped_class (a_class: CLASS_FIGURE) is
			-- Redo `include_dropped_class'.
		require
			a_class_not_void: a_class /= Void
		do
			a_class.put_back_on_diagram (Current)
			included_figures.extend (a_class)
			update_display
		end
	
	remove_dropped_class (a_class: CLASS_FIGURE) is
			-- Undo `include_dropped_class'.
		require
			a_class_not_void: a_class /= Void
		do
			a_class.remove_from_diagram (False)
			included_figures.prune_all (a_class)
			update_display
		end

	refresh is
			-- Update the exact positions of the relations.
		local
			dc: DIAGRAM_COMPONENT
		do
			from class_layer.start until class_layer.after loop
				dc ?= class_layer.item
				if dc /= Void then
					dc.update
				end
				class_layer.forth
			end
		end

	update_pebbles is
			-- Classes status may have changed due to recompilation.
		local
			cf: CLASS_FIGURE
		do	
			from
				class_layer.start
			until
				class_layer.after
			loop
				cf ?= class_layer.item
				cf.update_pebble
				class_layer.forth
			end
		end

	clear_figures is
			-- Clear structures.
		do
			class_layer.wipe_out
			inheritance_layer.wipe_out
			client_supplier_layer.wipe_out
			inheritance_mover_layer.wipe_out
			client_supplier_mover_layer.wipe_out
			label_mover_layer.wipe_out
		end

	update_display is
			-- Update display.
		do
			context_editor.projector.project
			context_editor.projector.update
		end
		
		
feature {NONE} -- Events

	on_class_drop (a_stone: CLASSI_STONE) is
			-- `a_stone' was dropped on `Current'
			-- Add to diagram if not already present.
		local
			drop_x, drop_y: INTEGER
			cf: CLASS_FIGURE
		do
			drop_x := (x_to_grid (context_editor.pointer_position.x) / point.scale_x).rounded
			drop_y := (y_to_grid (context_editor.pointer_position.y) / point.scale_y).rounded
			cf := class_figure_by_class (a_stone.class_i)
			if cf = Void then
				cf := new_class_figure (a_stone.class_i)
				include_dropped_class (cf, drop_x, drop_y)
				context_editor.history.register_named_undoable (
					Interface_names.t_Diagram_include_class_cmd,
					~reinclude_dropped_class (cf),
					~remove_dropped_class (cf))	
			end
		end

	on_new_class_drop (a_stone: CREATE_CLASS_STONE) is
			-- `a_stone' was dropped on `Current'
			-- Display create class dialog and add to diagram.
		local
			dial: EB_CREATE_CLASS_DIALOG
			drop_x, drop_y: INTEGER
		do
			drop_x := (x_to_grid (context_editor.pointer_position.x) / point.scale_x).rounded
			drop_y := (y_to_grid (context_editor.pointer_position.y) / point.scale_y).rounded
			create dial.make_default (context_editor.development_window)
			dial.preset_cluster (center_class.class_i.cluster)
			dial.call ("New_class")
			include_new_dropped_class (dial, drop_x, drop_y)
		end

end -- class CONTEXT_DIAGRAM

