indexing
	description:
		"Area in EB_CONTEXT_TOOL notebook designated to view%N%
		%the context diagram of center class or center cluster."
	date: "$Date$"
	revision: "$Revision$"

class 
	EB_CONTEXT_EDITOR

inherit
	SHARED_EIFFEL_PROJECT

	EB_CONTEXT_TOOL_DATA

	EB_WINDOW_MANAGER_OBSERVER
		redefine
			on_item_removed
		end

	TEXT_OBSERVER
		redefine
			on_text_edited
		end

	SHARED_ERROR_HANDLER

	EB_RECYCLABLE

	EB_SHARED_WINDOW_MANAGER
	
	PROJECT_CONTEXT
		export {EB_CONTEXT_DIAGRAM_COMMAND}
			Project_directory_name
		end
		
	EB_CONSTANTS
		undefine
			pixmaps
		end
		
	SHARED_WORKBENCH
		undefine
			default_create
		end
		
create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_tool: like tool) is
			-- Set default values.
		local
			empty_world: BON_CLASS_DIAGRAM
			border_frame: EV_FRAME
			a_class_graph: ES_CLASS_GRAPH
		do
			tool := a_tool
			create widget

				-- Initialize undoable command history.
			create history 
			history.do_actions.extend (agent on_history_do_command)
			history.undo_actions.extend (agent on_history_undo_command)
			history.undo_exhausted_actions.extend (agent on_history_undo_exhausted)
			history.redo_exhausted_actions.extend (agent on_history_redo_exhausted)
			project_close_agent := agent store
			Eiffel_project.manager.close_agents.extend (project_close_agent)
			development_window.window_manager.add_observer (Current)

			create a_class_graph.make (Current)
			create empty_world.make (a_class_graph, Current)
			create world_cell.make_with_world_and_tool (empty_world, Current)
			world_cell.horizontal_scrollbar.change_actions.extend (agent on_scroll)
			world_cell.vertical_scrollbar.change_actions.extend (agent on_scroll)
			create border_frame
			border_frame.extend (world_cell)
			
			graph := a_class_graph
			create {EIFFEL_INHERITANCE_LAYOUT} layout.make_with_world (empty_world)
			is_rebuild_world_needed := False
			update_excluded_class_figures
			empty_world.drop_actions.extend (agent on_cluster_drop)
			empty_world.drop_actions.extend (agent on_class_drop)
			create force_directed_layout.make_with_world (empty_world)
			force_directed_layout.stop
			force_directed_layout.stop_actions.extend (agent on_force_stop)
			
			init_commands
			build_tool_bar
			disable_toolbar
			widget.extend (border_frame)

			development_window.editor_tool.text_area.add_edition_observer (Current)
		end

	init_commands is
			-- Create command classes.
		do
			create center_diagram_cmd.make (Current)
			center_diagram_cmd.enable_displayed
			center_diagram_cmd.enable_sensitive

			create create_class_cmd.make (Current)
			create_class_cmd.enable_displayed
			create delete_cmd.make (Current, development_window)
			delete_cmd.enable_displayed
			create create_new_links_cmd.make (Current)
			create_new_links_cmd.enable_displayed
			create change_color_cmd.make (Current)
			change_color_cmd.enable_displayed
			create trash_cmd.make (Current)
			trash_cmd.enable_displayed
			create change_header_cmd.make (Current)
			change_header_cmd.enable_displayed
			create toggle_inherit_cmd.make (Current)
			toggle_inherit_cmd.enable_displayed
			create toggle_supplier_cmd.make (Current)
			toggle_supplier_cmd.enable_displayed
			create toggle_labels_cmd.make (Current)
			toggle_labels_cmd.enable_displayed
			create toggle_quality_cmd.make (Current)
			toggle_quality_cmd.enable_displayed
			create link_tool_cmd.make (Current)
			link_tool_cmd.enable_displayed
			create fill_cluster_cmd.make (Current)
			fill_cluster_cmd.enable_displayed
			create select_depth_cmd.make (Current)
			select_depth_cmd.enable_displayed
			create history_cmd.make (Current)
			history_cmd.enable_displayed
			create undo_cmd.make (Current)
			undo_cmd.enable_displayed
			create redo_cmd.make (Current)
			redo_cmd.enable_displayed
			create zoom_in_cmd.make (Current)
			zoom_in_cmd.enable_displayed
			create zoom_out_cmd.make (Current)
			zoom_out_cmd.enable_displayed
			create delete_view_cmd.make (Current)
			delete_view_cmd.enable_displayed
			create diagram_to_ps_cmd.make (Current)
			diagram_to_ps_cmd.enable_displayed
			create crop_cmd.make (Current)
			crop_cmd.enable_displayed
			create toggle_force_cmd.make (Current)
			toggle_force_cmd.enable_displayed
			create toggle_cluster_cmd.make (Current)
			toggle_cluster_cmd.enable_displayed
			create remove_anchor_cmd.make (Current)
			remove_anchor_cmd.enable_displayed
			create toggle_cluster_legend_cmd.make (Current)
			toggle_cluster_legend_cmd.enable_displayed
			create toggle_uml_cmd.make (Current)
			toggle_uml_cmd.enable_sensitive
			create fit_to_screen_cmd.make (Current)
			fit_to_screen_cmd.enable_sensitive
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			bar_bar: EV_HORIZONTAL_BOX
			view_menu_button: EV_TOOL_BAR_BUTTON
			view_menu_toolbar: EV_TOOL_BAR
			customize_area: EV_CELL
			tb_commands: LINKED_LIST [EB_TOOLBARABLE_COMMAND]
			zoom_cell: EV_CELL
			h_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			create bar_bar

			create tb_commands.make
			tb_commands.extend (center_diagram_cmd)
			tb_commands.extend (create_class_cmd)
			tb_commands.extend (create_new_links_cmd)
			tb_commands.extend (delete_cmd)
			tb_commands.extend (undo_cmd)
			tb_commands.extend (history_cmd)
			tb_commands.extend (redo_cmd)
			tb_commands.extend (trash_cmd)
			tb_commands.extend (change_color_cmd)
			tb_commands.extend (change_header_cmd)
			tb_commands.extend (link_tool_cmd)
			tb_commands.extend (select_depth_cmd)
			tb_commands.extend (fill_cluster_cmd)
			tb_commands.extend (zoom_in_cmd)
			tb_commands.extend (zoom_out_cmd)
			tb_commands.extend (toggle_supplier_cmd)
			tb_commands.extend (toggle_inherit_cmd)
			tb_commands.extend (toggle_labels_cmd)
			tb_commands.extend (toggle_quality_cmd)
			tb_commands.extend (delete_view_cmd)
			tb_commands.extend (diagram_to_ps_cmd)
			tb_commands.extend (crop_cmd)
			tb_commands.extend (toggle_force_cmd)
			tb_commands.extend (toggle_cluster_cmd)
			tb_commands.extend (remove_anchor_cmd)
			tb_commands.extend (toggle_cluster_legend_cmd)
			tb_commands.extend (toggle_uml_cmd)
			tb_commands.extend (fit_to_screen_cmd)
			custom_toolbar := retrieve_diagram_toolbar (tb_commands)

			custom_toolbar.update_toolbar
			bar_bar.extend (custom_toolbar.widget)
			bar_bar.disable_item_expand (custom_toolbar.widget)
			
			create zoom_cell
			
				create h_box
				
				create label.make_with_text ("zoom: ")
				h_box.extend (label)
				h_box.disable_item_expand (label)
			
					create zoom_selector.make_default
					zoom_selector.select_actions.extend (agent on_zoom_level_select)
					
				h_box.extend (zoom_selector)
				h_box.disable_item_expand (zoom_selector)
				
			zoom_cell.extend (h_box)
			bar_bar.extend (zoom_cell)
			bar_bar.disable_item_expand (zoom_cell)
			

			widget.extend (bar_bar)
			widget.disable_item_expand (bar_bar)

			create customize_area
			bar_bar.extend (customize_area)

			create view_menu_button.make_with_text ("View")
			create view_menu_toolbar
			view_menu_toolbar.extend (view_menu_button)

			view_menu_button.select_actions.extend (agent show_view_menu)
			bar_bar.extend (view_menu_toolbar)
			bar_bar.disable_item_expand (view_menu_toolbar)

			create view_selector.make_default
			view_selector.select_actions.extend (agent on_view_changed)
			bar_bar.extend (view_selector)
			bar_bar.disable_item_expand (view_selector)

			customize_area.pointer_button_release_actions.extend (agent on_customize)
		end
		

	show_view_menu is
			-- Display "View" menu.
		local
			view_menu: EV_MENU
		do
			create view_menu
			view_menu.extend (select_depth_cmd.new_menu_item)
			view_menu.extend (create {EV_MENU_SEPARATOR})
			view_menu.extend (crop_cmd.new_menu_item)
			view_menu.extend (create {EV_MENU_SEPARATOR})
			view_menu.extend (delete_view_cmd.new_menu_item)			
			view_menu.extend (diagram_to_ps_cmd.new_menu_item)
			view_menu.show
		end

feature -- Status report

	is_resize_enabled: BOOLEAN is
			-- 
		do
			Result := world_cell.is_resize_enabled
		end

	is_rebuild_world_needed: BOOLEAN
			-- Is a rebuild of the world needed when a stone is dropped?
			
	is_excluded_in_preferences (name: STRING): BOOLEAN is
			-- Is class figure named `name' excluded in preferences?
		do
			Result := excluded_class_figures.has (name)
		end
		
	ignore_excluded_figures: BOOLEAN
			-- Will `excluded_class_figures' be taken into account?
			
	is_force_directed_used: BOOLEAN
			-- Is force directed physics used to arrange classes?
		
feature -- Access

	default_pixmaps: EV_STOCK_PIXMAPS is
		do
			create Result
		end

	progress_dialog: EB_PROGRESS_DIALOG is
		once
			create Result
		end
			
	development_window: EB_DEVELOPMENT_WINDOW is
			-- Application main window.
		do
			Result ?= tool.manager
		end
	
	graph: ES_GRAPH
			-- Current graph.
	
	class_graph: ES_CLASS_GRAPH is
			-- Current class graph if not Void.
		do
			Result ?= graph
		end
		
	cluster_graph: ES_CLUSTER_GRAPH is
			-- Current cluster graph if not Void.
		do
			Result ?= graph
		end

	world: EIFFEL_WORLD is
			-- Current world.
		do
			Result ?= world_cell.world
		ensure
			Result_not_void: Result /= Void
		end
	
	projector: EIFFEL_PROJECTOR is
			-- Current projector
		do
			Result := world_cell.projector
		ensure
			Result_not_void: Result /= Void
		end
		
	layout: EIFFEL_INHERITANCE_LAYOUT
			-- Current layout.

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current' containing `world_cell'.

	history: EB_HISTORY_DIALOG
			-- History of undoable commands.


	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer relative to `area'.
		do
			create Result.set (
				area_as_widget.pointer_position.x + projector.area_x,
				area_as_widget.pointer_position.y + projector.area_y)
		ensure
			position_not_void: Result /= Void
		end

	class_view: EIFFEL_CLASS_DIAGRAM is
			-- Class view currently displayed.
		do
			Result ?= world
		end

	cluster_view: EIFFEL_CLUSTER_DIAGRAM is
			-- Cluster view currently displayed.
		do
			Result ?= world
		end

feature -- Status settings.

	update_excluded_class_figures is
			-- Preferences may have changed.
			-- Refresh `excluded_class_figures' and `ignore_excluded_figures'.
		local
			l_array: ARRAY [STRING]
			i: INTEGER
		do
			ignore_excluded_figures := boolean_resource_value ("ignore_excluded_class_figures", False)
			if not ignore_excluded_figures then
				l_array := array_resource_value ("excluded_class_figures", Default_excluded_class_figures)
				create excluded_class_figures.make (l_array.count)
				from
					i := l_array.lower
				until
					i > l_array.upper
				loop
					excluded_class_figures.put (l_array.item (i), l_array.item (i))
					i := i + 1
				end
			else
				create excluded_class_figures.make (0)
			end
		end

	disable_resize is
			-- Disable resizing world cell.
		do
			world_cell.disable_resize
		end
		
	enable_resize is
			-- Enable resizing worl cell.
		do
			world_cell.enable_resize
		end
			
	set_is_rebuild_world_needed (b: BOOLEAN) is
			-- Set `is_rebuild_world_needed' to `b'.
		do
			is_rebuild_world_needed := b
		ensure
			set: is_rebuild_world_needed = b
		end
		
	disable_toolbar is
			-- Disable sensitive for all buttons except center diagram.
		do
			zoom_selector.disable_sensitive
			create_class_cmd.disable_sensitive
			delete_cmd.disable_sensitive
			create_new_links_cmd.disable_sensitive
			change_color_cmd.disable_sensitive
			trash_cmd.disable_sensitive
			change_header_cmd.disable_sensitive
			link_tool_cmd.disable_sensitive
			toggle_inherit_cmd.disable_sensitive
			toggle_supplier_cmd.disable_sensitive
			toggle_labels_cmd.disable_sensitive
			select_depth_cmd.disable_sensitive
			fill_cluster_cmd.disable_sensitive
			undo_cmd.disable_sensitive
			history_cmd.disable_sensitive
			redo_cmd.disable_sensitive
			zoom_in_cmd.disable_sensitive
			zoom_out_cmd.disable_sensitive
			delete_view_cmd.disable_sensitive
			diagram_to_ps_cmd.disable_sensitive
			crop_cmd.disable_sensitive
			toggle_force_cmd.disable_sensitive
			toggle_cluster_cmd.disable_sensitive
			remove_anchor_cmd.disable_sensitive
			toggle_cluster_legend_cmd.disable_sensitive
			toggle_uml_cmd.disable_sensitive
			fit_to_screen_cmd.disable_sensitive
		end
		
	enable_toolbar is
			-- Enable toolbar.
		do
			if class_graph /= Void then
				if world.is_uml then
					reset_tool_bar_for_uml_class_view
				else
					reset_tool_bar_for_class_view
				end
			else
				if world.is_uml then
					reset_tool_bar_for_uml_cluster_view
				else
					reset_tool_bar_for_cluster_view
				end
			end
		end
		
	enable_force_directed is
			-- Enable use of force directed physics.
		local
			wbbox, min_box: EV_RECTANGLE
			w, h: INTEGER
			fig: EG_LINKABLE_FIGURE
		do
			if timer = Void then
				create timer.make_with_interval (50)
			else
				timer.actions.wipe_out
			end
			timer.actions.extend (agent on_time_out)
			wbbox := world.bounding_box
			w := wbbox.width.max (area.width)
			h := wbbox.height.max (area.height)
			wbbox.grow_left (w * 5)
			wbbox.grow_right (w * 5)
			wbbox.grow_top (h * 5)
			wbbox.grow_bottom (h * 5)
			force_directed_layout.set_fence (wbbox)
			is_force_directed_used := True
			if class_graph = Void then
				fig ?= world.figure_from_model (cluster_graph.center_cluster)
				min_box := fig.minimum_size
				force_directed_layout.set_center (min_box.left + min_box.width // 2, min_box.top + min_box.height // 2)
			else
				fig ?= world.figure_from_model (class_graph.center_class)
				force_directed_layout.set_center (fig.port_x, fig.port_y)
				fig.set_is_fixed (True)
			end
			if world.is_right_angles then
				world.remove_right_angles
			end
			world.show_anchors
			force_directed_layout.reset
		ensure
			is_force_directed_used: is_force_directed_used
		end
		
	disable_force_directed is
			-- Disable use of force directed physics.
		do
			is_force_directed_used := False
			world.hide_anchors
			force_directed_layout.stop
			
			if 
				toggle_force_cmd.current_button /= Void and then
				toggle_force_cmd.current_button.is_selected
			then
				toggle_force_cmd.current_button.select_actions.block
				toggle_force_cmd.current_button.toggle
				toggle_force_cmd.current_button.set_tooltip (toggle_force_cmd.tooltip)
				toggle_force_cmd.current_button.select_actions.resume	
			end
		ensure
			not_is_force_directed_used: not is_force_directed_used
		end
		
	restart_force_directed is
			-- Restart using force directed physics after stop.
		do
			if is_force_directed_used then
				force_directed_layout.reset
				if timer = Void then
					create timer.make_with_interval (50)
				end
				if timer.actions.is_empty then
					timer.actions.extend (agent on_time_out)
				end
				timer.set_interval (50)
				if world.is_right_angles then
					world.remove_right_angles
				end
			end
		ensure
			not_stopped: is_force_directed_used implies not force_directed_layout.is_stopped
		end

feature -- Element change

	clear_area is
			-- Make `area' empty because a diagram has been cancelled.
		local
			a_class_graph: ES_CLASS_GRAPH
			a_class_view: BON_CLASS_DIAGRAM
		do
			world.drop_actions.wipe_out
			create a_class_graph.make (Current)
			create a_class_view.make (a_class_graph, Current)
			world_cell.set_world (a_class_view)
			layout.set_world (a_class_view)
			graph := a_class_graph
			world.drop_actions.extend (agent on_class_drop)
			world.drop_actions.extend (agent on_cluster_drop)
			projector.full_project
			crop_diagram
		end

	create_link_tool (a_stone: LINK_STONE) is
			-- Create a new link tool with `a_stone'.
		require
			a_stone_exists: a_stone /= Void
		do
			link_tool_cmd.execute_with_link_stone (a_stone)
		end
		
	reset_history is
			-- Forget about previous undoable commands.
		do
			history.wipe_out
			undo_cmd.disable_sensitive
			redo_cmd.disable_sensitive
		end

	create_class_view (a_class: CLASS_I; load_when_possible: BOOLEAN) is
			-- Initialize diagram centered on `a_class', load from file if possible when `load_when_possible'.
		require
			a_class_exists: a_class /= Void
		local
			f: RAW_FILE
			cancelled: BOOLEAN
			a_class_graph: ES_CLASS_GRAPH
			a_class_view: EIFFEL_CLASS_DIAGRAM
			cf: EIFFEL_CLASS_FIGURE
			es_class: ES_CLASS
			was_legend_shown: BOOLEAN
		do
			history.wipe_out
			disable_toolbar

			if not cancelled then
				graph.wipe_out
				
				world.drop_actions.wipe_out
				create a_class_graph.make (Current)
				if class_graph /= Void then
					a_class_graph.set_ancestor_depth (class_graph.ancestor_depth)
					a_class_graph.set_descendant_depth (class_graph.descendant_depth)
					a_class_graph.set_client_depth (class_graph.client_depth)
					a_class_graph.set_supplier_depth (class_graph.supplier_depth)
					a_class_graph.set_include_all_classes_of_cluster (class_graph.include_all_classes_of_cluster)
					a_class_graph.set_include_only_classes_of_cluster (class_graph.include_only_classes_of_cluster)
				end
				if world.is_uml then
					create {UML_CLASS_DIAGRAM} a_class_view.make (a_class_graph, Current)
					layout.set_spacing (150, 150)
				else
					create {BON_CLASS_DIAGRAM} a_class_view.make (a_class_graph, Current)
					layout.set_spacing (40, 40)
				end
				a_class_view.scale (world.scale_factor)
				if not world.is_high_quality then
					a_class_view.disable_high_quality
				end
				if not world.is_labels_shown then
					a_class_view.hide_labels
				end
				if not world.is_client_supplier_links_shown then
					a_class_view.hide_client_supplier_links
				end
				if not world.is_inheritance_links_shown then
					a_class_view.hide_inheritance_links
				end
				if not world.is_cluster_shown then
					a_class_view.hide_clusters
				end
				if world.is_right_angles then
					a_class_view.enable_right_angles
				end
				if world.is_legend_shown then
					was_legend_shown := True
				end
				
				world.recycle
				world_cell.set_world (a_class_view)
				layout.set_world (a_class_view)
				force_directed_layout.set_world (a_class_view)
				graph := a_class_graph
				
				if is_force_directed_used then
					disable_force_directed
				end
				
				progress_dialog.set_title ("Building progress")
				progress_dialog.set_message ("Diagram for " + a_class.name_in_upper)
				progress_dialog.enable_cancel
				progress_dialog.show
				progress_dialog.show_relative_to_window (Window_manager.last_focused_window.window)
				
				update_excluded_class_figures
				world_cell.disable_resize
				projector.disable_painting
				create es_class.make (a_class)
				
				class_graph.set_center_class (es_class)

				create f.make (diagram_file_name (class_graph))
				
				if load_when_possible and then is_valide_diagram_file (f) then
					a_class_view.retrieve (f)
					if class_graph.is_empty then
						class_graph.explore_center_class
						layout.layout
					end
				else
					class_graph.explore_center_class
					if is_valide_diagram_file (f) then
						world.load_available_views (f)
					end
					layout.layout
				end
				cf ?= world.figure_from_model (class_graph.center_class)
				cf.set_is_fixed (True)
				
				projector.enable_painting
				world_cell.enable_resize
				projector.full_project
				progress_dialog.hide
				crop_diagram
				if world.is_uml then
					reset_tool_bar_for_uml_class_view
				else
					reset_tool_bar_for_class_view
				end
				reset_view_selector
				reset_tool_bar_toggles
				world.figure_change_end_actions.extend (agent on_figure_change_end)
				world.figure_change_start_actions.extend (agent on_figure_change_start)
				world.cluster_legend.move_actions.extend (agent on_cluster_legend_move)
				world.cluster_legend.pin_actions.extend (agent on_cluster_legend_pin)
				
				if world.is_right_angles then
					world.apply_right_angles
				end
				if was_legend_shown then
					world.show_legend
				end
			end
		rescue
			cancelled := True
			error_handler.error_list.wipe_out
			progress_dialog.hide
			projector.enable_painting
			world_cell.enable_resize
			clear_area
			is_rebuild_world_needed := True
			if is_force_directed_used then
				toggle_force_cmd.current_button.disable_select
			end
			retry
		end
	
	create_cluster_view (a_cluster: CLUSTER_I; load_when_possible: BOOLEAN) is
			-- Initialize diagram centered on `a_cluster', load from file if possible when `load_when_possible'.
		require
			a_cluster_exists: a_cluster /= Void
		local
			cancelled: BOOLEAN
			l_cluster_view: EIFFEL_CLUSTER_DIAGRAM
			l_cluster_graph: ES_CLUSTER_GRAPH
			new_cluster: ES_CLUSTER
			f: RAW_FILE
			was_legend_shown: BOOLEAN
		do
			history.wipe_out
			disable_toolbar

			if not cancelled then
				graph.wipe_out
				
				world.drop_actions.wipe_out
				create l_cluster_graph.make (Current)
				if cluster_graph /= Void then
					l_cluster_graph.set_subcluster_depth (cluster_graph.subcluster_depth)
					l_cluster_graph.set_supercluster_depth (cluster_graph.supercluster_depth)
				end
				if world.is_uml then
					create {UML_CLUSTER_DIAGRAM} l_cluster_view.make (l_cluster_graph, Current)
					layout.set_spacing (150, 150)
				else
					create {BON_CLUSTER_DIAGRAM} l_cluster_view.make (l_cluster_graph, Current)
					layout.set_spacing (40, 40)
				end
				l_cluster_view.scale (world.scale_factor)
				
				if not world.is_high_quality then
					l_cluster_view.disable_high_quality
				end
				if not world.is_labels_shown then
					l_cluster_view.hide_labels
				end
				if not world.is_client_supplier_links_shown then
					l_cluster_view.hide_client_supplier_links
				end
				if not world.is_inheritance_links_shown then
					l_cluster_view.hide_inheritance_links
				end
				if not world.is_cluster_shown then
					l_cluster_view.hide_clusters
				end
				if world.is_right_angles then
					l_cluster_view.enable_right_angles
				end
				if world.is_legend_shown then
					was_legend_shown := True
				end
				
				world.recycle
				world_cell.set_world (l_cluster_view)
				layout.set_world (l_cluster_view)
				force_directed_layout.set_world (l_cluster_view)
				graph := l_cluster_graph

				
				if is_force_directed_used then
					disable_force_directed
				end
				
				progress_dialog.set_title ("Building progress")
				progress_dialog.set_message ("Diagram for " + a_cluster.name_in_upper)
				progress_dialog.enable_cancel
				progress_dialog.show
				progress_dialog.show_relative_to_window (Window_manager.last_focused_window.window)
				
				update_excluded_class_figures
				world_cell.disable_resize
				world.hide
				create new_cluster.make (a_cluster)
				cluster_graph.set_center_cluster (new_cluster)

				create f.make (diagram_file_name (cluster_graph))
				
				if load_when_possible and then is_valide_diagram_file (f) then
					l_cluster_view.retrieve (f)
					if cluster_graph.is_empty then
						cluster_graph.explore_center_cluster
						layout.layout
					end
				else
					cluster_graph.explore_center_cluster
					if is_valide_diagram_file (f) then
						world.load_available_views (f)
					end
					layout.layout
				end
				
				world.show
				world_cell.enable_resize

				progress_dialog.hide
				projector.full_project
				crop_diagram
				if world.is_uml then
					reset_tool_bar_for_uml_cluster_view
				else
					reset_tool_bar_for_cluster_view
				end
				reset_view_selector
				reset_tool_bar_toggles
				world.figure_change_end_actions.extend (agent on_figure_change_end)
				world.figure_change_start_actions.extend (agent on_figure_change_start)
				world.cluster_legend.move_actions.extend (agent on_cluster_legend_move)
				world.cluster_legend.pin_actions.extend (agent on_cluster_legend_pin)
				
				if world.is_right_angles then
					world.apply_right_angles
				end
				if was_legend_shown then
					world.show_legend
				end
			end
		rescue
			cancelled := True
			error_handler.error_list.wipe_out
			progress_dialog.hide
			world.show
			world_cell.enable_resize
			clear_area
			is_rebuild_world_needed := True
			if is_force_directed_used then
				toggle_force_cmd.current_button.disable_select
			end
			retry
		end

	synchronize is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			graph.synchronize
			reset_history
			projector.full_project
		end
		
	crop_diagram is
			-- Crop diagram.
		do
			world_cell.crop
		end
		
feature {EB_TOGGLE_UML_COMMAND} -- UML/BON toggle.
		
	toggle_uml is
			-- Toggle between UML/BON mode
		local
			uml_class: UML_CLASS_DIAGRAM
			uml_cluster: UML_CLUSTER_DIAGRAM
			bon_class: BON_CLASS_DIAGRAM
			bon_cluster: BON_CLUSTER_DIAGRAM
			f: RAW_FILE
		do
			create f.make (diagram_file_name (graph))
			if f.exists then
				f.open_read
			else
				f.open_write
			end
			world.store (f)
			
			if is_force_directed_used then
				disable_force_directed
			end
			if world.is_uml then
				if world.available_views.has ("DEFAULT") then
					-- "Load" default
					from
						view_selector.start
					until
						view_selector.item.text.is_equal ("DEFAULT")
					loop
						view_selector.forth
					end
					view_selector.select_actions.block
					view_selector.item.enable_select
					view_selector.select_actions.resume
					on_view_changed
				else
					world.recycle
					if class_graph /= Void then
						create bon_class.make (class_graph, Current)
						if world.scale_factor /= 1.0 then
							bon_class.scale (world.scale_factor)	
						end
						world_cell.set_world (bon_class)
						reset_tool_bar_for_class_view
					else
						create bon_cluster.make (cluster_graph, Current)
						if world.scale_factor /= 1.0 then
							bon_cluster.scale (world.scale_factor)	
						end
						world_cell.set_world (bon_cluster)
						reset_tool_bar_for_cluster_view
					end
					layout.set_spacing (40, 40)
					layout.set_world (world)
					force_directed_layout.set_world (world)
					layout.layout
					world.load_available_views (f)
					reset_tool_bar_toggles
					reset_view_selector
					crop_diagram
					world.figure_change_end_actions.extend (agent on_figure_change_end)
					world.figure_change_start_actions.extend (agent on_figure_change_start)
					world.cluster_legend.move_actions.extend (agent on_cluster_legend_move)
					world.cluster_legend.pin_actions.extend (agent on_cluster_legend_pin)
				end
			else
				if world.available_views.has ("DEFAULT:UML") then
					-- "Load" default
					from
						view_selector.start
					until
						view_selector.item.text.is_equal ("DEFAULT:UML")
					loop
						view_selector.forth
					end
					view_selector.select_actions.block
					view_selector.item.enable_select
					view_selector.select_actions.resume
					on_view_changed
				else
					world.recycle
					if class_graph /= Void then
						create uml_class.make (class_graph, Current)
						if world.scale_factor /= 1.0 then
							uml_class.scale (world.scale_factor)	
						end
						world_cell.set_world (uml_class)
						reset_tool_bar_for_uml_class_view
					else
						create uml_cluster.make (cluster_graph, Current)
						if world.scale_factor /= 1.0 then
							uml_cluster.scale (world.scale_factor)	
						end
						world_cell.set_world (uml_cluster)
						reset_tool_bar_for_uml_cluster_view
					end
					layout.set_spacing (150, 150)
					layout.set_world (world)
					force_directed_layout.set_world (world)
					layout.layout
					world.load_available_views (f)
					reset_tool_bar_toggles
					reset_view_selector
					crop_diagram
					world.figure_change_end_actions.extend (agent on_figure_change_end)
					world.figure_change_start_actions.extend (agent on_figure_change_start)
					world.cluster_legend.move_actions.extend (agent on_cluster_legend_move)
					world.cluster_legend.pin_actions.extend (agent on_cluster_legend_pin)
				end
			end
		end
		
	is_uml: BOOLEAN is
			-- Is diagram shown in UML.
		do
			Result := world.is_uml
		end

feature -- Memory management

	recycle is
			-- Frees `Current's memory, and leave `Current' in an unstable state
			-- so that we know whether we're still referenced or not.
		do
			Eiffel_project.manager.close_agents.start
			Eiffel_project.manager.close_agents.prune_all (project_close_agent)
			development_window.window_manager.remove_observer (Current)
			
				--| 'if' necessary because the editor may be recycled before the diagram.
			if development_window.editor_tool.text_area /= Void then
				development_window.editor_tool.text_area.remove_observer (Current)
			end
			if cluster_graph /= Void then
				cluster_graph.manager.remove_observer (cluster_graph)
			end
			world.recycle
			world_cell := Void
		end

feature {EB_CONTEXT_EDITOR, EB_CONTEXT_DIAGRAM_COMMAND, EIFFEL_CLASS_FIGURE} -- Toolbar actions

	is_link_client, is_link_inheritance, is_link_aggregate: BOOLEAN

	on_new_client_click is
			-- The user wants a new client-supplier link.
		do
			is_link_client := True
			is_link_inheritance := False
			is_link_aggregate := False
		end

	on_new_agg_client_click is
			-- The user wants a new client-supplier link.
		do
			is_link_client := False
			is_link_inheritance := False
			is_link_aggregate := True
		end

	on_new_inherit_click is
			-- The user wants a new inheritance link.
		do
			is_link_client := False
			is_link_inheritance := True
			is_link_aggregate := False
		end
		
feature {EB_CONTEXT_TOOL} -- Context tool

	on_select is
			-- Current became selected in notebook.
		do
			if class_stone /= Void then
				set_stone (class_stone)
			elseif cluster_stone /= Void then
				set_stone (cluster_stone)
			end
		end


	set_focus is
			-- Give the focus to the drawing_area.
		require
			focusable: widget.is_displayed and widget.is_sensitive
		do
			if area /= Void then
				area.set_focus
			else
				widget.set_focus
			end
		end
			
	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		do
			if a_stone /= Void then
				class_stone ?= a_stone
				cluster_stone ?= a_stone
				if tool.is_diagram_selected then
					if class_stone /= Void then
						-- create a new class view
						if 
							is_rebuild_world_needed or else 
							class_graph = Void or else 
							class_graph.center_class = Void or else 
							class_graph.center_class.class_i /= class_stone.class_i 
						then
							is_rebuild_world_needed := False
							store
							create_class_view (class_stone.class_i, True)
						end
					else
						if cluster_stone /= Void then
							-- create a cluster view
							if 
								is_rebuild_world_needed or else
								cluster_graph = Void or else
								cluster_graph.center_cluster = Void or else
								not cluster_graph.center_cluster.cluster_i.cluster_name.is_equal (cluster_stone.cluster_i.cluster_name)
							then
								is_rebuild_world_needed := False
								store
								create_cluster_view (cluster_stone.cluster_i, True)
							end
						end
					end
				end
			end
		end
		
feature {EB_CENTER_DIAGRAM_COMMAND, EIFFEL_CLASS_FIGURE} -- Center diagram command

	class_stone: CLASSI_STONE
			-- Stone representing center class.

	cluster_stone: CLUSTER_STONE
			-- Stone representing center cluster.

	tool: EB_CONTEXT_TOOL
			-- Container of `Current'.
		
feature {EB_CLASS_HEADER_COMMAND} -- Class head command
		
	area_as_widget: EV_WIDGET is
			-- `area' cast to EV_WIDGET.
		do
			Result ?= area
		ensure
			Result_not_void: Result /= Void
		end

feature {EB_DEVELOPMENT_WINDOW} -- Commands with global accelerators

	undo_cmd: EB_UNDO_DIAGRAM_COMMAND
			-- Command to undo last action
			
	redo_cmd: EB_REDO_DIAGRAM_COMMAND
			-- Command to redo last undone action
			
feature {EB_ZOOM_OUT_COMMAND, EB_ZOOM_IN_COMMAND, EIFFEL_FIGURE_WORLD_CELL, EB_FIT_TO_SCREEN_COMMAND} -- Zoom command.

	zoom_selector: EB_ZOOM_SELECTOR
			-- Combo box that lets the user select a zoom level
			
feature {NONE} -- Views

	reset_view_selector is
			-- Set entries in `view_selector' to `available_views' in `world'.
		local
			l_item: EV_LIST_ITEM
		do
			view_selector.select_actions.block
			view_selector.set_strings (world.available_views)
			from
				view_selector.start
			until
				view_selector.after
			loop
				l_item := view_selector.item
				if l_item.text.is_equal (world.current_view) then
					l_item.enable_select
				end
				view_selector.forth
			end
			view_selector.select_actions.resume
		end

feature {NONE} -- Commands

	view_selector: EB_VIEW_SELECTOR
			-- Combo box that lets the user change views.

	history_cmd: EB_DIAGRAM_HISTORY_COMMAND
			-- History command.

	create_class_cmd: EB_CREATE_CLASS_DIAGRAM_COMMAND
			-- Command to create new classes.
			
	delete_cmd: EB_DELETE_DIAGRAM_ITEM_COMMAND
			-- Command to remove an element from the system.

	create_new_links_cmd: EB_CREATE_LINK_COMMAND
			-- Command to select the type of new links.

	center_diagram_cmd: EB_CENTER_DIAGRAM_COMMAND
			-- Command to target the diagram to a class or a cluster.

	change_color_cmd: EB_CHANGE_COLOR_COMMAND
			-- Command to change the color of a class or all the classes.
			
	trash_cmd: EB_DELETE_FIGURE_COMMAND
			-- Command to hide an element.

	change_header_cmd: EB_CLASS_HEADER_COMMAND
			-- Command to rename classes.

	toggle_inherit_cmd: EB_TOGGLE_INHERIT_COMMAND
			-- Command to show/hide inheritance links.
			
	toggle_supplier_cmd: EB_TOGGLE_SUPPLIER_COMMAND
			-- Command to show/hide supplier links.
			
	toggle_labels_cmd: EB_TOGGLE_LABELS_COMMAND
			-- Command to show/hide labels.
			
	toggle_cluster_cmd: EB_TOGGLE_CLUSTER_COMMAND
			-- Command to show/hide clusters.
			
	select_depth_cmd: EB_SELECT_DEPTH_COMMAND
			-- Command to select the depth of the diagram.

	link_tool_cmd: EB_LINK_TOOL_COMMAND
			-- Command to create new links.

	fill_cluster_cmd: EB_FILL_CLUSTER_COMMAND
			-- Command to fill cluster with all classes.
	
	crop_cmd: EB_CROP_DIAGRAM_COMMAND
			-- Crop command.

	zoom_in_cmd: EB_ZOOM_IN_COMMAND
			-- Zoom in command.

	zoom_out_cmd: EB_ZOOM_OUT_COMMAND
			-- Zoom out command.
	
	toggle_quality_cmd: EB_TOGGLE_QUALITY_COMMAND
			-- Toggle quality command.
			
	diagram_to_ps_cmd: EB_DIAGRAM_TO_PS_COMMAND
			-- Save diagram as ps or png.
			
	toggle_force_cmd: EB_TOGGLE_FORCE_COMMAND
			-- Toggle force directed layout.
			
	remove_anchor_cmd: EB_REMOVE_ANCHOR_COMMAND
			-- Remove anchor from a fixed class.
			
	toggle_cluster_legend_cmd: EB_SHOW_LEGEND_COMMAND
			-- Colorize clusters.
			
	delete_view_cmd: EB_DELETE_VIEW_COMMAND
			-- Delete current view.
			
	toggle_uml_cmd: EB_TOGGLE_UML_COMMAND
			-- Toggle between UML/BON.
			
	fit_to_screen_cmd: EB_FIT_TO_SCREEN_COMMAND
			-- Resize diagram such that it fits to screen.

feature {EG_FIGURE, EIFFEL_WORLD} -- Force directed.

	on_time_out is
			-- `timer' has a timeout.
		local
			time: C_DATE
			l_ticks: INTEGER
		do
			if world.is_statistics then
				create time
				l_ticks := time.millisecond_now
				
				projector.full_project
				
				time.update
				world.set_last_physics_time (time.millisecond_now - l_ticks)
				
				time.update
				l_ticks := time.millisecond_now
				
				force_directed_layout.layout
				
				time.update
				world.set_last_draw_time (time.millisecond_now - l_ticks)				
			else
				projector.full_project
				force_directed_layout.layout
			end
		end
		
	force_directed_layout: EIFFEL_FORCE_LAYOUT
			-- Layout used to force direct the graph.

feature {NONE} -- Events

	timer: EV_TIMEOUT
			-- Timer used to force direct the graph.
			
	on_force_stop is
			-- `force_directed_layout' has stopped.
		do
			if timer /= Void then
				timer.actions.wipe_out
				timer := Void
				if world.is_right_angles and not is_right_angles_blocked then
					world.apply_right_angles
				end
			end
		end

	on_customize (
		a_x: INTEGER;
		a_y: INTEGER;
		a_button: INTEGER;
		a_x_tilt: DOUBLE;
		a_y_tilt: DOUBLE;
		a_pressure: DOUBLE;
		a_screen_x: INTEGER;
		a_screen_y: INTEGER) is
			-- The user clicked on customizable toolbar.
		local
			mi: EV_MENU_ITEM
		do
			if a_button = 3 then
				create toolbar_menu
				create mi.make_with_text ("Customize...")
				toolbar_menu.extend (mi)
				mi.select_actions.extend (agent customize_toolbar)
				toolbar_menu.show
			end
		end
		
	on_history_do_command is
			-- An undoable command has been done.
			-- Enable `undo_cmd'.
		do
			if not history.undo_list.is_empty then
				undo_cmd.enable_sensitive
			end
		end

	on_history_undo_command is
			-- An undoable command has been undone.
			-- Enable `redo_cmd'.
		do
			if not history.undo_list.is_empty then
				redo_cmd.enable_sensitive
			end
		end

	on_history_undo_exhausted is
			-- There is no more actions to undo.
			-- Disable `undo_cmd'.
		do
			undo_cmd.disable_sensitive
		ensure
			undo_cmd_not_sensitive: not undo_cmd.is_sensitive
		end
	
	on_history_redo_exhausted is
			-- There is no more actions to redo.
			-- Disable `redo_cmd'.
		do
			redo_cmd.disable_sensitive
		ensure
			redo_cmd_not_sensitive: not redo_cmd.is_sensitive
		end
		
	on_zoom_level_select is
			-- User selected a new zoom level.
		local
			level_text: STRING
			level, scale_factor: DOUBLE
			old_scale: INTEGER
			new_scale: INTEGER
		do
			level_text := zoom_selector.selected_item.text.twin
			level_text.keep_head (level_text.count - 1)
			check
				level_text_is_integer: level_text.is_integer
			end
			level := level_text.to_integer / 100
			scale_factor := level / world.scale_factor
			old_scale := (world.scale_factor * 100).rounded
			world.scale (scale_factor)
			crop_diagram
			new_scale := (world.scale_factor * 100).rounded
			restart_force_directed
			history.register_named_undoable (
				interface_names.t_diagram_zoom_cmd + " " + level_text.out + "%%",
				[<<agent world.scale (scale_factor), agent crop_diagram, agent zoom_selector.show_as_text (new_scale), agent restart_force_directed>>],
				[<<agent world.scale (1/scale_factor), agent crop_diagram, agent zoom_selector.show_as_text (old_scale), agent restart_force_directed>>])
		end

	on_view_changed is
			-- The user wants to switch to another view.
		local
			cancelled: BOOLEAN
		do
			if not cancelled and not view_selector.is_empty then
				reset_history		

				progress_dialog.set_title ("Loading view")
				progress_dialog.set_message ("Diagram for " + view_selector.selected_item.text)
				progress_dialog.set_degree ("Calculating size:")
				progress_dialog.enable_cancel
				progress_dialog.show
				progress_dialog.show_relative_to_window (Window_manager.last_focused_window.window)
				
				progress_dialog.start (0)
				
				if is_force_directed_used then
					disable_force_directed
				end
				
				update_excluded_class_figures
				world_cell.disable_resize
				projector.disable_painting
			
				world.set_current_view (view_selector.selected_item.text)

				projector.enable_painting
				world_cell.enable_resize
				projector.full_project
				progress_dialog.hide
				crop_diagram
				
				if world.is_uml then
					if class_graph /= Void then
						reset_tool_bar_for_uml_class_view
					else
						reset_tool_bar_for_uml_cluster_view
					end
				else
					if class_graph /= Void then
						reset_tool_bar_for_class_view
					else
						reset_tool_bar_for_cluster_view
					end
				end
				reset_view_selector
				reset_tool_bar_toggles
				world.figure_change_end_actions.extend (agent on_figure_change_end)
				world.figure_change_start_actions.extend (agent on_figure_change_start)
				world.cluster_legend.move_actions.extend (agent on_cluster_legend_move)
				world.cluster_legend.pin_actions.extend (agent on_cluster_legend_pin)

				if world.is_right_angles then
					world.apply_right_angles
				end
			end
		rescue
			cancelled := True
			error_handler.error_list.wipe_out
			progress_dialog.hide
			projector.enable_painting
			world_cell.enable_resize
			clear_area
			is_rebuild_world_needed := True
			if is_force_directed_used then
				toggle_force_cmd.current_button.disable_select
			end
			retry
		end

	on_text_edited (directly_edited: BOOLEAN) is 
			-- Some text was inserted in the editor.
			-- If `directly_edited' is true, the user did.
		do
			if directly_edited then
				if has_diagram_edited_class then
					reset_history
					has_diagram_edited_class := False
				end
			else
				has_diagram_edited_class := True
			end
		end

	on_item_removed (a_item: EB_WINDOW) is
			-- `a_item' has been removed.
			-- If it is parent development window, store diagram.
		 do
			if a_item = development_window then
				store
			end
		end
		
feature {EB_DELETE_VIEW_COMMAND} -- View selector

	remove_view (a_name: STRING) is
			-- Delete view of `a_name'.
		require
			a_name_not_void: a_name /= Void
			not_default: not a_name.is_equal ("DEFAULT")
		local
			cancelled: BOOLEAN
		do
			if not cancelled then
				
				progress_dialog.set_title ("Loading view")
				progress_dialog.set_message ("Diagram for " + view_selector.selected_item.text)
				progress_dialog.enable_cancel
				progress_dialog.show
				progress_dialog.show_relative_to_window (Window_manager.last_focused_window.window)
				
				if is_force_directed_used then
					disable_force_directed
				end
				
				update_excluded_class_figures
				world_cell.disable_resize
				projector.disable_painting
				
				world.remove_view (world.current_view)
				
				reset_tool_bar_toggles
				
				projector.enable_painting
				world_cell.enable_resize
				projector.full_project
				progress_dialog.hide
				crop_diagram

				if world.is_right_angles then
					world.apply_right_angles
				end
				
				view_selector.select_actions.block
				view_selector.set_strings (world.available_views)
				view_selector.set_text ("DEFAULT")
				view_selector.select_actions.resume
			end
		rescue
			cancelled := True
			error_handler.error_list.wipe_out
			progress_dialog.hide
			projector.enable_painting
			world_cell.enable_resize
			clear_area
			is_rebuild_world_needed := True
			if is_force_directed_used then
				toggle_force_cmd.current_button.disable_select
			end
			retry
		end
		
feature {EB_FIT_TO_SCREEN_COMMAND} -- Implementation

	world_cell: EIFFEL_FIGURE_WORLD_CELL
			-- Cell showing the graph.
		
feature {NONE} -- Implementation.

	is_right_angles_blocked: BOOLEAN
			-- Is not right angles applayed at force stop?

	on_figure_change_start is
			-- User started to change position/shape of a figure.
		do
			is_right_angles_blocked := True
		end

	on_figure_change_end is
			-- User finished to change position/shape of a figure.
		do
			is_right_angles_blocked := False
			if world.is_right_angles then
				world.apply_right_angles
			end
		end
		
	on_scroll (value: INTEGER) is
			-- User scrolled scrollbars.
		local
			l_legend: EIFFEL_CLUSTER_LEGEND
		do
			if world.is_legend_shown and then world.cluster_legend.is_pined then
				l_legend := world.cluster_legend
				l_legend.set_point_position (projector.area_x + cluster_legend_x, projector.area_y + cluster_legend_y)
			end
		end

	cluster_legend_x: INTEGER
	cluster_legend_y: INTEGER
			-- Position of pined cluster legend.
		
	on_cluster_legend_move (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- User moved `world'.`cluster_legend'.
		do
			cluster_legend_x := world.cluster_legend.point_x - projector.area_x
			cluster_legend_y := world.cluster_legend.point_y - projector.area_y
		end
		
	on_cluster_legend_pin is
			-- User pined `world'.`cluster_legend'.
		do
			cluster_legend_x := world.cluster_legend.point_x - projector.area_x
			cluster_legend_y := world.cluster_legend.point_y - projector.area_y
		end
		

	has_diagram_edited_class: BOOLEAN
			-- Was a class edited through the Diagram.
			-- (Add remove feature, add remove inheritance link)

	customize_toolbar is
			-- Customize diagram toolbar.
		do
			custom_toolbar.customize
			save_diagram_toolbar (custom_toolbar)
			reset_tool_bar_toggles
		end
			
	custom_toolbar: EB_TOOLBAR
			-- Part of toolbar that can be customized.
			
	area: EV_DRAWING_AREA is
			-- Graphical surface displaying diagram.
		do
			Result := world_cell.drawing_area
		ensure
			Result_not_void: Result /= Void
		end
		
	toolbar_menu: EV_MENU
			-- Popped up when user clicks left to the right of the toolbar.
			
	on_class_drop (stone: CLASSI_STONE) is
			-- `stone' was dropped on an empty world.
		do
			is_rebuild_world_needed := True
			tool.launch_stone (stone)
		end
		
	on_cluster_drop (stone: CLUSTER_STONE) is
			-- `stone' was dropped on an empty world
		do
			is_rebuild_world_needed := True
			tool.launch_stone (stone)
		end	
		
	reset_tool_bar_for_uml_class_view is
			-- Set toolbar for uml class view
		do
			zoom_selector.enable_sensitive
			create_class_cmd.enable_sensitive
			delete_cmd.enable_sensitive
			create_new_links_cmd.select_type (create_new_links_cmd.Inheritance)
			create_new_links_cmd.enable_sensitive
			trash_cmd.enable_sensitive
			change_header_cmd.enable_sensitive
			link_tool_cmd.enable_sensitive
			toggle_inherit_cmd.enable_sensitive
			toggle_supplier_cmd.enable_sensitive
			toggle_labels_cmd.enable_sensitive
			select_depth_cmd.enable_sensitive
			undo_cmd.disable_sensitive
			history_cmd.enable_sensitive
			redo_cmd.disable_sensitive
			zoom_in_cmd.enable_sensitive
			zoom_out_cmd.enable_sensitive
			delete_view_cmd.enable_sensitive
			diagram_to_ps_cmd.enable_sensitive
			crop_cmd.enable_sensitive
			toggle_uml_cmd.enable_sensitive
			
			change_color_cmd.disable_sensitive
			fill_cluster_cmd.disable_sensitive
			toggle_quality_cmd.disable_sensitive
			toggle_force_cmd.disable_sensitive
			remove_anchor_cmd.disable_sensitive
			toggle_cluster_legend_cmd.disable_sensitive
			toggle_cluster_cmd.disable_sensitive
			fit_to_screen_cmd.enable_sensitive
		end
		
	reset_tool_bar_for_uml_cluster_view is
			-- Set toolbar for uml cluster view.
		do
			reset_tool_bar_for_uml_class_view
			fill_cluster_cmd.enable_sensitive
			toggle_cluster_cmd.enable_sensitive
		end
		
	reset_tool_bar_for_class_view is
			-- Set toolbar for class_view.
		do
			zoom_selector.enable_sensitive
			create_class_cmd.enable_sensitive
			delete_cmd.enable_sensitive
			create_new_links_cmd.select_type (create_new_links_cmd.Inheritance)
			create_new_links_cmd.enable_sensitive
			change_color_cmd.enable_sensitive
			trash_cmd.enable_sensitive
			change_header_cmd.enable_sensitive
			link_tool_cmd.enable_sensitive
			toggle_inherit_cmd.enable_sensitive
			toggle_supplier_cmd.enable_sensitive
			toggle_labels_cmd.enable_sensitive
			select_depth_cmd.enable_sensitive
			fill_cluster_cmd.disable_sensitive
			undo_cmd.disable_sensitive
			history_cmd.enable_sensitive
			redo_cmd.disable_sensitive
			zoom_in_cmd.enable_sensitive
			zoom_out_cmd.enable_sensitive
			delete_view_cmd.enable_sensitive
			diagram_to_ps_cmd.enable_sensitive
			crop_cmd.enable_sensitive
			toggle_quality_cmd.enable_sensitive
			toggle_force_cmd.enable_sensitive
			remove_anchor_cmd.enable_sensitive
			toggle_cluster_legend_cmd.enable_sensitive
			toggle_uml_cmd.enable_sensitive
			fit_to_screen_cmd.enable_sensitive
		end

	reset_tool_bar_for_cluster_view is
			-- Set toolbar for cluster_view.
		do
			reset_tool_bar_for_class_view
			fill_cluster_cmd.enable_sensitive
			toggle_cluster_cmd.enable_sensitive
		end
		
	project_close_agent: PROCEDURE [ANY, TUPLE]
			-- The agent that is called when the project is closed.

	pixmaps: EB_SHARED_PIXMAPS is
		once
			create Result
		end

	excluded_class_figures: HASH_TABLE [STRING, STRING]
			-- Classes never present on the diagram (unless `ignore_excluded_figures' is False).

	default_excluded_class_figures: ARRAY [STRING] is
			-- Default settings for `excluded_class_figures'.
		once
			Result := <<
				"INTEGER", "BOOLEAN", "STRING",
				"CHARACTER", "REAL", "DOUBLE"
				>>
		end

feature {EB_CONTEXT_TOOL, EIFFEL_WORLD} -- XML Output

	store is
			-- Freeze state of `Current'.
		local
			ptf: RAW_FILE
			retried: BOOLEAN
		do
			if eiffel_project.initialized then
				if 
					(class_graph /= Void and then class_graph.center_class /= Void) or else
					(cluster_graph /= Void and then cluster_graph.center_cluster /= Void)
				then
					if not retried then
						create ptf.make (diagram_file_name (graph))
						if ptf.exists then
							ptf.open_read
						else
							ptf.open_write
						end
						world.store (ptf)
						ptf.close
					end
				end
			end
		rescue
			retried := True
			retry
		end

	diagram_file_name (esg: ES_GRAPH): FILE_NAME is
			-- Location of XML file.
		require
			diagram_exists: esg /= Void
		local
			clg: ES_CLUSTER_GRAPH
			cg: ES_CLASS_GRAPH
		do
			clg ?= esg
			if clg = Void then
				cg ?= esg
				check
					is_class_graph: cg /= Void
				end
				create Result.make_from_string (Eiffel_system.context_diagram_path)
				Result.extend (cg.center_class.class_i.name)
			else
				create Result.make_from_string (Eiffel_system.context_diagram_path)
				Result.extend (clg.center_cluster.cluster_i.cluster_name)
			end
			Result.add_extension ("xml")
		end
		
	is_valide_diagram_file (f: RAW_FILE): BOOLEAN is
			-- Is `f' referencing a valid diagram file?
		require
			f_not_void: f /= Void
		local
			is_retried: BOOLEAN
		do
			if not is_retried then
				if f.exists then
					f.open_read
					if f.readable then
						Result := True
					end
				end
			else
				Result := False
			end
		rescue
			is_retried := True
			retry
		end
		
	reset_tool_bar_toggles is
			-- Set toolbar toggle buttons states according to worlds settings.
		do
			if toggle_supplier_cmd.current_button /= Void then
				toggle_supplier_cmd.current_button.select_actions.block
				if world.is_client_supplier_links_shown then
					if not toggle_supplier_cmd.current_button.is_selected then
						toggle_supplier_cmd.current_button.toggle
					end
				else
					if toggle_supplier_cmd.current_button.is_selected then
						toggle_supplier_cmd.current_button.toggle
					end
				end
				toggle_supplier_cmd.current_button.set_tooltip (toggle_supplier_cmd.tooltip)
				toggle_supplier_cmd.current_button.select_actions.resume
			end

			if toggle_inherit_cmd.current_button /= Void then
				toggle_inherit_cmd.current_button.select_actions.block
				if world.is_inheritance_links_shown then
					if not toggle_inherit_cmd.current_button.is_selected then
						toggle_inherit_cmd.current_button.toggle
					end
				else
					if toggle_inherit_cmd.current_button.is_selected then
						toggle_inherit_cmd.current_button.toggle
					end
				end
				toggle_inherit_cmd.current_button.set_tooltip (toggle_inherit_cmd.tooltip)
				toggle_inherit_cmd.current_button.select_actions.resume
			end
			
			if toggle_cluster_cmd.current_button /= Void then
				toggle_cluster_cmd.current_button.select_actions.block
				if world.is_cluster_shown then
					if not toggle_cluster_cmd.current_button.is_selected then
						toggle_cluster_cmd.current_button.toggle
					end
				else
					if toggle_cluster_cmd.current_button.is_selected then
						toggle_cluster_cmd.current_button.toggle
					end
				end
				toggle_cluster_cmd.current_button.set_tooltip (toggle_cluster_cmd.tooltip)
				toggle_cluster_cmd.current_button.select_actions.resume
			end
			
			if toggle_labels_cmd.current_button /= Void then
				toggle_labels_cmd.current_button.select_actions.block
				if world.is_labels_shown then
					if not toggle_labels_cmd.current_button.is_selected then
						toggle_labels_cmd.current_button.toggle
					end
				else
					if toggle_labels_cmd.current_button.is_selected then
						toggle_labels_cmd.current_button.toggle
					end
				end
				toggle_labels_cmd.current_button.set_tooltip (toggle_labels_cmd.tooltip)
				toggle_labels_cmd.current_button.select_actions.resume
			end
			
			if toggle_quality_cmd.current_button /= Void then
				toggle_quality_cmd.current_button.select_actions.block
				if world.is_high_quality then
					if not toggle_quality_cmd.current_button.is_selected then
						toggle_quality_cmd.current_button.toggle
					end
				else
					if toggle_quality_cmd.current_button.is_selected then
						toggle_quality_cmd.current_button.toggle
					end
				end
				toggle_quality_cmd.current_button.set_tooltip (toggle_quality_cmd.tooltip)
				toggle_quality_cmd.current_button.select_actions.resume
			end
			
			if toggle_cluster_legend_cmd.current_button /= Void then
				toggle_cluster_legend_cmd.current_button.select_actions.block
				if world.is_legend_shown then
					if not toggle_cluster_legend_cmd.current_button.is_selected then
						toggle_cluster_legend_cmd.current_button.toggle
					end
				else
					if toggle_cluster_legend_cmd.current_button.is_selected then
						toggle_cluster_legend_cmd.current_button.toggle
					end
				end
				toggle_cluster_legend_cmd.current_button.set_tooltip (toggle_cluster_legend_cmd.tooltip)
				toggle_cluster_legend_cmd.current_button.select_actions.resume
			end
			
			if link_tool_cmd.current_button /= Void then
				link_tool_cmd.current_button.select_actions.block			
				if world.is_right_angles then
					if not link_tool_cmd.current_button.is_selected then
						link_tool_cmd.current_button.toggle
					end
				else
					if link_tool_cmd.current_button.is_selected then
						link_tool_cmd.current_button.toggle
					end
				end
				link_tool_cmd.current_button.set_tooltip (link_tool_cmd.tooltip)
				link_tool_cmd.current_button.select_actions.resume
			end
			
			if toggle_uml_cmd.current_button /= Void then
				toggle_uml_cmd.current_button.select_actions.block
				if world.is_uml then
					if not toggle_uml_cmd.current_button.is_selected then
						toggle_uml_cmd.current_button.toggle
					end
				else
					if toggle_uml_cmd.current_button.is_selected then
						toggle_uml_cmd.current_button.toggle
					end
				end
				toggle_uml_cmd.current_button.set_tooltip (toggle_uml_cmd.tooltip)
				toggle_uml_cmd.current_button.select_actions.resume
			end
			
			zoom_selector.show_as_text ((world.scale_factor * 100).rounded)
		end

invariant
	world_cell_not_void: world_cell /= Void
	area_not_void: area /= Void
	area_as_widget_not_void: area_as_widget /= Void
	projector_not_void: projector /= Void
	
	
end -- class EB_CONTEXT_EDITOR

