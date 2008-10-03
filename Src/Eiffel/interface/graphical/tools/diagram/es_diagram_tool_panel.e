indexing
	description:
		"Area in EB_CONTEXT_TOOL notebook designated to view%N%
		%the context diagram of center class or center cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DIAGRAM_TOOL_PANEL

inherit
	EB_STONABLE_TOOL
		export
			{EB_CONTEXT_DIAGRAM_COMMAND, ES_GRAPH, EIFFEL_WORLD, EIFFEL_FACTORY, CLASS_TEXT_MODIFIER, EIFFEL_CLASS_FIGURE}
				develop_window
		redefine
			attach_to_docking_manager,
			mini_toolbar,
			build_mini_toolbar,
			build_docking_content,
			internal_recycle,
			internal_detach_entities,
			force_last_stone
		end

	SHARED_EIFFEL_PROJECT

	EB_WINDOW_MANAGER_OBSERVER
		redefine
			on_item_removed
		end

	TEXT_OBSERVER
		rename
			set_manager as set_manager_text_observer
		redefine
			on_text_edited
		end

	SHARED_ERROR_HANDLER

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS
		undefine
			pixmaps
		end

	SHARED_WORKBENCH
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES

	EV_SHARED_APPLICATION
		undefine
			default_create
		end

	EB_SHARED_ID_SOLUTION

	EB_HISTORY_OWNER
		rename
			set_stone as launch_stone
		redefine
			internal_recycle,
			internal_detach_entities
		end

create
	make

feature {NONE} -- Initialization

	make_with_tool is
			-- Set default values.
		local
			empty_world: BON_CLASS_DIAGRAM
			border_frame: EV_FRAME
			a_class_graph: ES_CLASS_GRAPH
		do
			create widget
			widget.set_minimum_size (0, 0)

				-- Initialize undoable command history.
			create history
			register_action (history.do_actions, agent on_history_do_command)
			register_action (history.undo_actions, agent on_history_undo_command)
			register_action (history.undo_exhausted_actions, agent on_history_undo_exhausted)
			register_action (history.redo_exhausted_actions, agent on_history_redo_exhausted)
			project_close_agent := agent store
			Eiffel_project.manager.close_agents.extend (project_close_agent)
			develop_window.window_manager.add_observer (Current)

			create a_class_graph.make (Current)
			auto_recycle (a_class_graph)
			create empty_world.make (a_class_graph, Current)
			auto_recycle (empty_world)
			create world_cell.make_with_world_and_tool (empty_world, Current)
			auto_recycle (world_cell)
			register_action (world_cell.horizontal_scrollbar.change_actions, agent on_scroll)
			register_action (world_cell.vertical_scrollbar.change_actions, agent on_scroll)

			create border_frame
			border_frame.extend (world_cell)

			graph := a_class_graph
			create {EIFFEL_INHERITANCE_LAYOUT} layout.make_with_world (empty_world)
			is_rebuild_world_needed := False
			update_excluded_class_figures
			register_action (empty_world.drop_actions, agent on_cluster_drop)
			register_action (empty_world.drop_actions, agent on_class_drop)
			create force_directed_layout.make_with_world (empty_world)
			force_directed_layout.stop
			register_action (force_directed_layout.stop_actions, agent on_force_stop)
			force_directed_layout.set_theta (50)

			create shortcut_table.make (20)

			init_commands
			build_tool_bar
			disable_toolbar
			widget.extend (border_frame)

			retrieve_depth_preferences

			develop_window.editors_manager.add_edition_observer (Current)
			register_action (area.key_press_actions, agent on_key_pressed)

			area.set_configurable_target_menu_mode
			area.set_configurable_target_menu_handler (agent context_menu_handler)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu handler.
		do
			develop_window.menus.context_menu_factory.diagram_tool_menu (a_menu, a_target_list, a_source, a_pebble)
		end

	init_commands is
			-- Create command classes.
		do

			create toggle_selected_classes_ancestors_cmd.make_for_ancestors (Current)
			auto_recycle (toggle_selected_classes_ancestors_cmd)
			toggle_selected_classes_ancestors_cmd.enable_displayed
			toggle_selected_classes_ancestors_cmd.enable_sensitive

			create toggle_selected_classes_descendents_cmd.make_for_descendents (Current)
			auto_recycle (toggle_selected_classes_descendents_cmd)
			toggle_selected_classes_descendents_cmd.enable_displayed
			toggle_selected_classes_descendents_cmd.enable_sensitive

			create toggle_selected_classes_clients_cmd.make_for_clients (Current)
			auto_recycle (toggle_selected_classes_clients_cmd)
			toggle_selected_classes_clients_cmd.enable_displayed
			toggle_selected_classes_clients_cmd.enable_sensitive

			create toggle_selected_classes_suppliers_cmd.make_for_suppliers (Current)
			auto_recycle (toggle_selected_classes_suppliers_cmd)
			toggle_selected_classes_suppliers_cmd.enable_displayed
			toggle_selected_classes_suppliers_cmd.enable_sensitive

			create center_diagram_cmd.make (Current)
			auto_recycle (center_diagram_cmd)
			center_diagram_cmd.enable_displayed
			center_diagram_cmd.enable_sensitive

			create create_class_cmd.make (Current)
			auto_recycle (create_class_cmd)
			create_class_cmd.enable_displayed

			create delete_cmd.make (Current, develop_window)
			auto_recycle (delete_cmd)
			delete_cmd.enable_displayed

			create create_new_links_cmd.make (Current)
			auto_recycle (create_new_links_cmd)
			create_new_links_cmd.enable_displayed
			create_new_links_cmd.select_type (create_new_links_cmd.Inheritance)

			create change_color_cmd.make (Current)
			auto_recycle (change_color_cmd)
			change_color_cmd.enable_displayed

			create trash_cmd.make (Current)
			auto_recycle (trash_cmd)
			trash_cmd.enable_displayed

			create toggle_inherit_cmd.make (Current)
			toggle_inherit_cmd.enable_displayed
			auto_recycle (toggle_inherit_cmd)

			create toggle_supplier_cmd.make (Current)
			auto_recycle (toggle_supplier_cmd)
			toggle_supplier_cmd.enable_displayed

			create toggle_labels_cmd.make (Current)
			auto_recycle (toggle_labels_cmd)
			toggle_labels_cmd.enable_displayed

			create toggle_quality_cmd.make (Current)
			auto_recycle (toggle_quality_cmd)
			toggle_quality_cmd.enable_displayed

			create link_tool_cmd.make (Current)
			auto_recycle (link_tool_cmd)
			link_tool_cmd.enable_displayed

			create fill_cluster_cmd.make (Current)
			auto_recycle (fill_cluster_cmd)
			fill_cluster_cmd.enable_displayed

			create select_depth_cmd.make (Current)
			auto_recycle (select_depth_cmd)
			select_depth_cmd.enable_displayed

			create history_cmd.make (Current)
			auto_recycle (history_cmd)
			history_cmd.enable_displayed

			create undo_cmd.make (Current)
			auto_recycle (undo_cmd)
			undo_cmd.enable_displayed

			create redo_cmd.make (Current)
			auto_recycle (redo_cmd)
			redo_cmd.enable_displayed

			create zoom_in_cmd.make (Current)
			auto_recycle (zoom_in_cmd)
			zoom_in_cmd.enable_displayed

			create zoom_out_cmd.make (Current)
			auto_recycle (zoom_out_cmd)
			zoom_out_cmd.enable_displayed

			create delete_view_cmd.make (Current)
			auto_recycle (delete_view_cmd)
			delete_view_cmd.enable_displayed

			create diagram_to_ps_cmd.make (Current)
			auto_recycle (diagram_to_ps_cmd)
			diagram_to_ps_cmd.enable_displayed

			create toggle_force_cmd.make (Current)
			auto_recycle (toggle_force_cmd)
			toggle_force_cmd.enable_displayed

			create toggle_cluster_cmd.make (Current)
			auto_recycle (toggle_cluster_cmd)
			toggle_cluster_cmd.enable_displayed

			create remove_anchor_cmd.make (Current)
			auto_recycle (remove_anchor_cmd)
			remove_anchor_cmd.enable_displayed

			create toggle_cluster_legend_cmd.make (Current)
			auto_recycle (toggle_cluster_legend_cmd)
			toggle_cluster_legend_cmd.enable_displayed

			create toggle_uml_cmd.make (Current)
			auto_recycle (toggle_uml_cmd)
			toggle_uml_cmd.enable_sensitive
			toggle_uml_cmd.enable_displayed

			create fit_to_screen_cmd.make (Current)
			auto_recycle (fit_to_screen_cmd)
			fit_to_screen_cmd.enable_displayed
			fit_to_screen_cmd.enable_sensitive

			create reset_view_cmd.make (Current)
			auto_recycle (reset_view_cmd)
			reset_view_cmd.enable_sensitive
			reset_view_cmd.enable_displayed

			create force_settings_cmd.make (Current)
			auto_recycle (force_settings_cmd)
			force_settings_cmd.enable_sensitive
			force_settings_cmd.enable_displayed
		end

	initialize_accelerators (a_command_list: LINKED_LIST [EB_TOOLBARABLE_COMMAND]) is
			-- Initialize accelerators from commands held in `a_command_list'.
		require
			a_command_list_not_void: a_command_list /= Void
		local
			l_item: EB_TOOLBARABLE_COMMAND
		do
			from
				a_command_list.start
			until
				a_command_list.after
			loop
				l_item := a_command_list.item
					-- `l_item' may be Void to signify a separator for building the toolbar.
				if l_item /= Void and then l_item.accelerator /= Void then
					extend_shortcut_table (l_item.accelerator)
				end
				a_command_list.forth
			end
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			v_box: EV_VERTICAL_BOX
			view_bar: EV_HORIZONTAL_BOX
			drawing_bar: EV_HORIZONTAL_BOX
			view_menu: EV_HORIZONTAL_BOX
			customize_area: EV_CELL
			draw_commands, view_commands: LINKED_LIST [EB_TOOLBARABLE_COMMAND]
			zoom_cell: EV_CELL
			h_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			view_label: EV_LABEL
		do
			create v_box
			create view_bar
			create drawing_bar

				-- Create commands for view and draw toolbars.
			create draw_commands.make
			create view_commands.make

-- TODO: Remove and make create class in standard toolbar pick and dropable
			draw_commands.extend (create_class_cmd)
			draw_commands.extend (create_new_links_cmd)
			draw_commands.extend (Void)
			draw_commands.extend (delete_cmd)
			draw_commands.extend (remove_anchor_cmd)
			draw_commands.extend (trash_cmd)
			draw_commands.extend (Void)
			draw_commands.extend (change_color_cmd)
			draw_commands.extend (link_tool_cmd)
			draw_commands.extend (fill_cluster_cmd)

			draw_commands.extend (toggle_quality_cmd)
			draw_commands.extend (select_depth_cmd)
			draw_commands.extend (Void)

			draw_commands.extend (toggle_force_cmd)
			draw_commands.extend (force_settings_cmd)
			draw_commands.extend (Void)

			draw_commands.extend (zoom_out_cmd)
			draw_commands.extend (fit_to_screen_cmd)
			draw_commands.extend (zoom_in_cmd)

			from
				create drawing_toolbar.make
				draw_commands.start
			until
				draw_commands.after
			loop
				if draw_commands.item /= Void then
					drawing_toolbar.extend (draw_commands.item.new_sd_toolbar_item (False))
				else
					drawing_toolbar.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
				end
				draw_commands.forth
			end

			--| As we now have two levels we no longer need customizable toolbars.
--			custom_toolbar := preferences.diagram_tool_data.retrieve_diagram_toolbar (draw_commands)

			view_commands.extend (toggle_selected_classes_ancestors_cmd)
			view_commands.extend (toggle_selected_classes_descendents_cmd)
			view_commands.extend (toggle_selected_classes_clients_cmd)
			view_commands.extend (toggle_selected_classes_suppliers_cmd)
			view_commands.extend (Void)

				-- Extending `Void' to list will generate a toolbar separator in its place.
			view_commands.extend (diagram_to_ps_cmd)
			view_commands.extend (center_diagram_cmd)
			view_commands.extend (toggle_uml_cmd)
			view_commands.extend (toggle_cluster_cmd)
			view_commands.extend (toggle_cluster_legend_cmd)
			view_commands.extend (Void)

			view_commands.extend (toggle_supplier_cmd)
			view_commands.extend (toggle_inherit_cmd)
			view_commands.extend (toggle_labels_cmd)
			view_commands.extend (Void)

			view_commands.extend (undo_cmd)
			view_commands.extend (history_cmd)
			view_commands.extend (redo_cmd)

			from
				create view_toolbar.make
				view_commands.start
			until
				view_commands.after
			loop
				if view_commands.item /= Void then
					view_toolbar.extend (view_commands.item.new_sd_toolbar_item (False))
				else
					view_toolbar.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
				end
				view_commands.forth
			end

			view_toolbar.compute_minimum_size
			view_bar.extend (view_toolbar)
			view_bar.disable_item_expand (view_bar.last)

			initialize_accelerators (draw_commands)
			initialize_accelerators (view_commands)

			if reset_view_cmd.accelerator /= Void then
				extend_shortcut_table (reset_view_cmd.accelerator)
			end
			if delete_view_cmd.accelerator /= Void then
				extend_shortcut_table (delete_view_cmd.accelerator)
			end

			drawing_toolbar.compute_minimum_size
			drawing_bar.extend (drawing_toolbar)
			drawing_bar.disable_item_expand (drawing_bar.last)

			create zoom_cell

			create h_box

			create label.make_with_text (interface_names.l_zoom)
			h_box.extend (label)
			h_box.disable_item_expand (label)

			create zoom_selector.make_default
			zoom_selector.select_actions.extend (agent on_zoom_level_select)

			h_box.extend (zoom_selector)
			h_box.disable_item_expand (zoom_selector)

			zoom_cell.extend (h_box)

			create customize_area
			drawing_bar.extend (customize_area)

			drawing_bar.extend (zoom_cell)
			drawing_bar.disable_item_expand (zoom_cell)

				-- Add toolbars to vertical box.
			v_box.extend (view_bar)
			v_box.disable_item_expand (view_bar)

			v_box.extend (create {EV_HORIZONTAL_SEPARATOR})
			v_box.disable_item_expand (v_box.last)

			v_box.extend (drawing_bar)
			v_box.disable_item_expand (drawing_bar)
			widget.extend (v_box)
			widget.disable_item_expand (v_box)

			create view_menu

			create view_label.make_with_text (interface_names.l_view)
			view_menu.extend (view_label)
			view_menu.disable_item_expand (view_label)

			create view_selector.make_with_text (world.default_view_name)
			view_selector.return_actions.extend (agent on_view_changed)
			view_selector.set_minimum_width (100)
			view_menu.extend (view_selector)
			view_menu.disable_item_expand (view_selector)

			create view_menu_button
			view_menu_button.set_pixmap (pixmaps.mini_pixmaps.toolbar_dropdown_icon)
			--view_menu_button.set_minimum_size (15, 20)
			view_menu.extend (view_menu_button)
			view_menu.disable_item_expand (view_menu_button)
			view_menu_button.select_actions.extend (agent show_view_menu)

				-- We want view menu to be right aligned.
			view_bar.extend (create {EV_CELL})
			view_bar.extend (view_menu)
			view_bar.disable_item_expand (view_menu)

		end

	show_view_menu is
			-- Display "View" menu.
		local
			view_menu: EV_MENU
			l_list: LIST [STRING]
			menu_item: EV_MENU_ITEM
		do
			create view_menu
			view_menu.extend (reset_view_cmd.new_menu_item)
--TODO: Maybe a pop up dialog.
--			create menu_item.make_with_text_and_action ("Name view", agent name_view)
--			view_menu.extend (menu_item)
			view_menu.extend (delete_view_cmd.new_menu_item)
			if world.current_view.has_substring ("DEFAULT") then
				delete_view_cmd.disable_sensitive
			end
			view_menu.extend (create {EV_MENU_SEPARATOR})
			from
				l_list := world.available_views
				l_list.start
			until
				l_list.after
			loop
				create menu_item.make_with_text_and_action (l_list.item, agent select_view (l_list.item))
				view_menu.extend (menu_item)
				l_list.forth
			end
			view_menu.show_at (view_menu_button, 0, view_menu_button.height)
		end

	select_view (a_name: STRING) is
			-- Select `a_name' as the current view and switch to that view.
		do
			view_selector.set_text (a_name)
			on_view_changed
		end

	name_view is
			-- Name the view.
		do
			view_selector.select_all
			view_selector.set_focus
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build dockable content.
		do
			Precursor {EB_STONABLE_TOOL}(a_docking_manager)
			content.drop_actions.extend (agent center_diagram_cmd.execute_with_class_stone)
			content.drop_actions.extend (agent center_diagram_cmd.execute_with_cluster_stone)
		end

feature -- EB_TOOL features

	build_interface is
			-- Build interface
		do
			check
				has_case: (create {EIFFEL_LAYOUT}).eiffel_layout.has_diagram
			end
			make_with_tool

			create history_manager.make (Current)
			create address_manager.make (Current, True)
			auto_recycle (address_manager)
			address_manager.set_context_menu_factory (develop_window.menus.context_menu_factory)
		end

	build_mini_toolbar is
			-- Redefine
		do
			create history_toolbar.make
			history_toolbar.extend (history_manager.back_command.new_mini_sd_toolbar_item)
			history_toolbar.extend (history_manager.forth_command.new_mini_sd_toolbar_item)
			history_toolbar.compute_minimum_size

			create mini_toolbar
			mini_toolbar.extend (address_manager.header_info)
			mini_toolbar.extend (history_toolbar)
			address_manager.label_changed_actions.extend (agent (develop_window.docking_manager).update_mini_tool_bar_size (content))
		end

feature -- Initialization

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)
			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Status report

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
			Result := world_cell.world
		ensure
			Result_not_void: Result /= Void
		end

	projector: EIFFEL_PROJECTOR is
			-- Current projector
		require
			not_recycled: not is_recycled
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

	force_directed_layout: EIFFEL_FORCE_LAYOUT
			-- Layout used to force direct the graph.

feature -- Status settings.

	update_excluded_class_figures is
			-- Preferences may have changed.
			-- Refresh `excluded_class_figures' and `ignore_excluded_figures'.
		local
			l_array: ARRAY [STRING]
			i: INTEGER
		do
			ignore_excluded_figures := preferences.diagram_tool_data.ignore_excluded_class_figures
			if not ignore_excluded_figures then
				l_array := preferences.diagram_tool_data.excluded_class_figures
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
			toggle_force_cmd.disable_sensitive
			toggle_cluster_cmd.disable_sensitive
			remove_anchor_cmd.disable_sensitive
			toggle_cluster_legend_cmd.disable_sensitive
			toggle_uml_cmd.disable_sensitive
			fit_to_screen_cmd.disable_sensitive
			toggle_quality_cmd.disable_sensitive
			reset_view_cmd.disable_sensitive
			view_selector.disable_sensitive
			view_menu_button.disable_sensitive
			force_settings_cmd.disable_sensitive
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
			min_box: EV_RECTANGLE
			fig: EG_LINKABLE_FIGURE
		do
			if timer = Void then
				create timer.make_with_interval (50)
			else
				timer.actions.wipe_out
			end
			timer.actions.extend (agent on_time_out)
			is_force_directed_used := True
			if class_graph = Void then
				fig ?= world.figure_from_model (cluster_graph.center_cluster)
				if fig /= Void then
					min_box := fig.minimum_size
					force_directed_layout.set_center (min_box.left + min_box.width // 2, min_box.top + min_box.height // 2)
				end
			else
				fig ?= world.figure_from_model (class_graph.center_class)
				if fig /= Void then
					force_directed_layout.set_center (fig.port_x, fig.port_y)
					fig.set_is_fixed (True)
				end
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
			toggle_force_cmd.disable_select
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
			-- Make `area' empty.
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
			disable_toolbar
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
				develop_window.status_bar.reset
				develop_window.status_bar.display_message (interface_names.l_constructing_diagram_for (a_class.name))

				graph.wipe_out

				world.drop_actions.wipe_out
				create a_class_graph.make (Current)
				if class_graph /= Void then
					default_ancestor_depth := class_graph.ancestor_depth
					default_descendant_depth := class_graph.descendant_depth
					default_client_depth := class_graph.client_depth
					default_supplier_depth := class_graph.supplier_depth
					a_class_graph.set_include_all_classes_of_cluster (class_graph.include_all_classes_of_cluster)
					a_class_graph.set_include_only_classes_of_cluster (class_graph.include_only_classes_of_cluster)
				end
				a_class_graph.set_ancestor_depth (default_ancestor_depth)
				a_class_graph.set_descendant_depth (default_descendant_depth)
				a_class_graph.set_client_depth (default_client_depth)
				a_class_graph.set_supplier_depth (default_supplier_depth)
				if world.is_uml then
					create {UML_CLASS_DIAGRAM} a_class_view.make (a_class_graph, Current)
					layout.set_spacing (default_uml_horizontal_spacing, default_uml_vertical_spacing)
				else
					create {BON_CLASS_DIAGRAM} a_class_view.make (a_class_graph, Current)
					layout.set_spacing (default_bon_horizontal_spacing, default_bon_vertical_spacing)
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
					world.set_current_view (view_selector.text)
					if not world.available_views.has (world.current_view) then
						world.available_views.extend (world.current_view)
					end
					layout.layout
				end
				cf ?= world.figure_from_model (class_graph.center_class)
				if cf /= Void then
					cf.set_is_fixed (True)
				end

				projector.enable_painting
				world_cell.enable_resize
				projector.full_project
				develop_window.status_bar.reset
				crop_diagram
				if world.is_uml then
					reset_tool_bar_for_uml_class_view
				else
					reset_tool_bar_for_class_view
				end
				if was_legend_shown then
					world.show_legend
				end
				reset_view_selector
				reset_tool_bar_toggles
				world.figure_change_end_actions.extend (agent on_figure_change_end)
				world.figure_change_start_actions.extend (agent on_figure_change_start)
				world.cluster_legend.move_actions.extend (agent on_cluster_legend_move)
				world.cluster_legend.pin_actions.extend (agent on_cluster_legend_pin)
				on_cluster_legend_pin

				if world.is_right_angles then
					world.apply_right_angles
				end
			end
		rescue
			cancelled := True
			error_handler.error_list.wipe_out
			projector.enable_painting
			world_cell.enable_resize
			clear_area
			is_rebuild_world_needed := True
			if is_force_directed_used then
				toggle_force_cmd.current_button.disable_select
			end
			retry
		end

	create_cluster_view (a_group: CONF_GROUP; load_when_possible: BOOLEAN) is
			-- Initialize diagram centered on `a_cluster', load from file if possible when `load_when_possible'.
		require
			a_group_exists: a_group /= Void
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
				develop_window.status_bar.reset
				develop_window.status_bar.display_message (interface_names.l_constructing_diagram_for (a_group.name))

				graph.wipe_out

				world.drop_actions.wipe_out
				create l_cluster_graph.make (Current)
				if cluster_graph /= Void then
					default_subcluster_depth := cluster_graph.subcluster_depth
					default_supercluster_depth := cluster_graph.supercluster_depth
				end
				l_cluster_graph.set_subcluster_depth (default_subcluster_depth)
				l_cluster_graph.set_supercluster_depth (default_supercluster_depth)
				if world.is_uml then
					create {UML_CLUSTER_DIAGRAM} l_cluster_view.make (l_cluster_graph, Current)
					layout.set_spacing (default_uml_horizontal_spacing, default_uml_vertical_spacing)
				else
					create {BON_CLUSTER_DIAGRAM} l_cluster_view.make (l_cluster_graph, Current)
					layout.set_spacing (default_uml_horizontal_spacing, default_bon_vertical_spacing)
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

				update_excluded_class_figures
				world_cell.disable_resize
				world.hide
				create new_cluster.make (a_group)
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
					world.set_current_view (view_selector.text)
					if not world.available_views.has (world.current_view) then
						world.available_views.extend (world.current_view)
					end
					layout.layout
				end

				world.show
				world_cell.enable_resize

				develop_window.status_bar.reset
				projector.full_project
				crop_diagram
				if world.is_uml then
					reset_tool_bar_for_uml_cluster_view
				else
					reset_tool_bar_for_cluster_view
				end
				if world.is_right_angles then
					world.apply_right_angles
				end
				reset_view_selector
				reset_tool_bar_toggles
				world.figure_change_end_actions.extend (agent on_figure_change_end)
				world.figure_change_start_actions.extend (agent on_figure_change_start)
				world.cluster_legend.move_actions.extend (agent on_cluster_legend_move)
				world.cluster_legend.pin_actions.extend (agent on_cluster_legend_pin)
				on_cluster_legend_pin

				if was_legend_shown then
					world.show_legend
				end
			end
		rescue
			cancelled := True
			error_handler.error_list.wipe_out
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
			if widget.is_displayed then
				graph.synchronize
				reset_history
				projector.full_project
			else
				is_synchronization_needed := True
			end
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

			if is_force_directed_used then
				disable_force_directed
			end
			if world.is_uml then
				if world.available_views.has ("DEFAULT:BON") then
					view_selector.set_text ("DEFAULT:BON")
					on_view_changed
				else
					create f.make (diagram_file_name (graph))
					if f.exists then
						f.open_read
					else
						f.open_write
					end
					world.store (f)
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
					layout.set_spacing (default_bon_horizontal_spacing, default_bon_vertical_spacing)
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
					on_cluster_legend_pin
				end
			else
				if world.available_views.has ("DEFAULT:UML") then
					view_selector.set_text ("DEFAULT:UML")
					on_view_changed
				else
					create f.make (diagram_file_name (graph))
					if f.exists then
						f.open_read
					else
						f.open_write
					end
					world.store (f)
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
					layout.set_spacing (default_uml_horizontal_spacing, default_uml_vertical_spacing)
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
					on_cluster_legend_pin
				end
			end
		end

	is_uml: BOOLEAN is
			-- Is diagram shown in UML.
		do
			Result := world.is_uml
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Frees `Current's memory, and leave `Current' in an unstable state
			-- so that we know whether we're still referenced or not.
		local
			l_editors: ARRAYED_LIST [EB_SMART_EDITOR]
		do
--			is_recycled := False
--			area.set_configurable_target_menu_handler (Void)
--			is_recycled := True

			Eiffel_project.manager.close_agents.start
			Eiffel_project.manager.close_agents.prune_all (project_close_agent)
			develop_window.window_manager.remove_observer (Current)

				--| 'if' necessary because the editor may be recycled before the diagram.
			l_editors := develop_window.editors_manager.editors
			if l_editors /= Void then
				from
					l_editors.start
				until
					l_editors.after
				loop
					l_editors.item.remove_observer (Current)
					l_editors.forth
				end
			end
			drawing_toolbar.destroy
			view_toolbar.destroy
			world_cell.destroy
			Precursor {EB_STONABLE_TOOL}
			Precursor {EB_HISTORY_OWNER}
		end

	internal_detach_entities
			-- Detaches objects from their container
		do
			drawing_toolbar := Void
			view_toolbar := Void
			world_cell := Void
			history_cmd := Void
			create_class_cmd := Void
			delete_cmd := Void
			create_new_links_cmd := Void
			center_diagram_cmd := Void
			change_color_cmd := Void
			trash_cmd := Void
			toggle_inherit_cmd := Void
			toggle_supplier_cmd := Void
			toggle_labels_cmd := Void
			toggle_cluster_cmd := Void
			select_depth_cmd := Void
			link_tool_cmd := Void
			fill_cluster_cmd := Void
			zoom_in_cmd := Void
			zoom_out_cmd := Void
			toggle_quality_cmd := Void
			diagram_to_ps_cmd := Void
			toggle_force_cmd := Void
			remove_anchor_cmd := Void
			toggle_cluster_legend_cmd := Void
			delete_view_cmd := Void
			reset_view_cmd := Void
			toggle_uml_cmd := Void
			fit_to_screen_cmd := Void
			force_settings_cmd := Void
			toggle_selected_classes_ancestors_cmd := Void
			toggle_selected_classes_descendents_cmd := Void
			toggle_selected_classes_clients_cmd := Void
			toggle_selected_classes_suppliers_cmd := Void
			address_manager := Void
			Precursor {EB_STONABLE_TOOL}
			Precursor {EB_HISTORY_OWNER}
		ensure then
			drawing_toolbar_detached: drawing_toolbar = Void
			view_toolbar_detached: view_toolbar = Void
			world_cell_detached: world_cell = Void
			history_cmd_detached: history_cmd = Void
			create_class_cmd_detached: create_class_cmd = Void
			delete_cmd_detached: delete_cmd = Void
			create_new_links_cmd_detached: create_new_links_cmd = Void
			center_diagram_cmd_detached: center_diagram_cmd = Void
			change_color_cmd_detached: change_color_cmd = Void
			trash_cmd_detached: trash_cmd = Void
			toggle_inherit_cmd_detached: toggle_inherit_cmd = Void
			toggle_supplier_cmd_detached: toggle_supplier_cmd = Void
			toggle_labels_cmd_detached: toggle_labels_cmd = Void
			toggle_cluster_cmd_detached: toggle_cluster_cmd = Void
			select_depth_cmd_detached: select_depth_cmd = Void
			link_tool_cmd_detached: link_tool_cmd = Void
			fill_cluster_cmd_detached: fill_cluster_cmd = Void
			zoom_in_cmd_detached: zoom_in_cmd = Void
			zoom_out_cmd_detached: zoom_out_cmd = Void
			toggle_quality_cmd_detached: toggle_quality_cmd = Void
			diagram_to_ps_cmd_detached: diagram_to_ps_cmd = Void
			toggle_force_cmd_detached: toggle_force_cmd = Void
			remove_anchor_cmd_detached: remove_anchor_cmd = Void
			toggle_cluster_legend_cmd_detached: toggle_cluster_legend_cmd = Void
			delete_view_cmd_detached: delete_view_cmd = Void
			reset_view_cmd_detached: reset_view_cmd = Void
			toggle_uml_cmd_detached: toggle_uml_cmd = Void
			fit_to_screen_cmd_detached: fit_to_screen_cmd = Void
			force_settings_cmd_detached: force_settings_cmd = Void
			toggle_selected_classes_ancestors_cmd_detached: toggle_selected_classes_ancestors_cmd = Void
			toggle_selected_classes_descendents_cmd_detached: toggle_selected_classes_descendents_cmd = Void
			toggle_selected_classes_clients_cmd_detached: toggle_selected_classes_clients_cmd = Void
			toggle_selected_classes_suppliers_cmd_detached: toggle_selected_classes_suppliers_cmd = Void
		end

feature {ES_DIAGRAM_TOOL_PANEL, EB_CONTEXT_DIAGRAM_COMMAND, EIFFEL_CLASS_FIGURE} -- Toolbar actions

	launch_stone (a_stone: STONE) is
			-- Launch stone.
		local
			l_tool: EB_STONABLE_TOOL
			fst: FEATURE_STONE
		do
			fst ?= a_stone
			l_tool := decide_tool_to_display (a_stone)
			if develop_window.unified_stone then
				develop_window.set_stone (a_stone)
			else
				l_tool.set_stone (a_stone)
			end
			if fst /= Void and then address_manager /= Void then
				address_manager.hide_address_bar
			end
		end

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

feature {EB_DEVELOPMENT_WINDOW_TOOLS, EB_STONE_CHECKER} -- Context tool

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

	set_stone (new_stone: STONE) is
			-- Simply change last stone.
			-- If current widget is displayed, the stone is forced.
			-- Choose default tool to load a feature stone.
		local
			fs: FEATURE_STONE
			cs: CLASSC_STONE
		do
			fs ?= new_stone
			if fs /= Void then
				if address_manager /= Void then
					address_manager.hide_address_bar
				end
				check
					feature_not_void: fs.e_feature /= Void
					associated_class_not_void: fs.e_feature.associated_class /= Void
				end
				create cs.make (fs.e_feature.associated_class)
			end
			if cs /= Void then
					-- If it is a feature stone, we take the class of the feature.
					-- We do not extend a feature stone into diagram tool.
				set_last_stone (cs)
			else
				set_last_stone (new_stone)
			end

			develop_window.tools.set_last_stone (last_stone)

			if widget.is_displayed then
				force_last_stone
			elseif is_auto_hide then
				request_force_last_stone_now
			end
		end

	force_last_stone is
			-- Force last stone.
		do
			if not is_last_stone_processed then
				if last_stone /= Void then
					history_manager.extend (last_stone)
					stone := last_stone
					class_stone ?= last_stone
					cluster_stone ?= last_stone
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
							is_synchronization_needed := False
						end
					else
						if cluster_stone /= Void then
							-- create a cluster view
							if
								is_rebuild_world_needed or else
								cluster_graph = Void or else
								cluster_graph.center_cluster = Void or else
								cluster_graph.center_cluster.group /= cluster_stone.group
							then
								is_rebuild_world_needed := False
								store
								create_cluster_view (cluster_stone.group, True)
								is_synchronization_needed := False
							end
						end
					end
						-- Synchronization was not done when invisible.
					if is_synchronization_needed then
						graph.synchronize
						reset_history
						is_synchronization_needed := False
					end
				else
					clear_area
				end
				Precursor {EB_STONABLE_TOOL}
			end
		end

	decide_tool_to_display (a_st: STONE): EB_STONABLE_TOOL is
			-- Decide which tool to display.
		local
			fs: FEATURE_STONE
		do
			fs ?= a_st
			if fs /= Void then
				develop_window.tools.show_default_tool_of_feature
				Result := develop_window.tools.default_feature_tool
			else
				show
				set_focus
				Result := Current
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- force last stone when displayed

	force_last_stone_now is
		do
			cancel_force_last_stone_now
			force_last_stone
		end

	agent_force_last_stone_now: PROCEDURE [ANY, TUPLE]
			-- agent on `force_last_stone_now'.

	request_force_last_stone_now is
			-- Request `force_last_stone_now'
		do
			if agent_force_last_stone_now = Void then
				agent_force_last_stone_now := agent force_last_stone_now
				content.show_actions.extend_kamikaze (agent_force_last_stone_now)
			else
				-- already requested
			end
		end

	cancel_force_last_stone_now is
			-- Request `force_last_stone_now'
		do
			if content /= Void and then agent_force_last_stone_now /= Void then
				content.show_actions.prune_all (agent_force_last_stone_now)
				agent_force_last_stone_now := Void
			end
		end

feature {EB_CENTER_DIAGRAM_COMMAND, EIFFEL_CLASS_FIGURE} -- Center diagram command

	class_stone: CLASSI_STONE
			-- Stone representing center class.

	cluster_stone: CLUSTER_STONE
			-- Stone representing center cluster.

feature {NONE} -- Class head command

	area_as_widget: EV_WIDGET is
			-- `area' cast to EV_WIDGET.
		require
			not_recycled: not is_recycled
		do
			Result ?= area
		ensure
			Result_not_void: Result /= Void
		end

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Commands with global accelerators

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
		do
			view_selector.set_text (world.current_view)
		end

feature -- Commands

	view_selector: EV_TEXT_FIELD
			-- Combo box that lets the user change views.

	view_menu_button: EV_BUTTON
			-- Button for the view menu.

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
			-- Toggle right angles.

	fill_cluster_cmd: EB_FILL_CLUSTER_COMMAND
			-- Command to fill cluster with all classes.

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

	reset_view_cmd: EB_RESET_VIEW_COMMAND
			-- Reset current view.

	toggle_uml_cmd: EB_TOGGLE_UML_COMMAND
			-- Toggle between UML/BON.

	fit_to_screen_cmd: EB_FIT_TO_SCREEN_COMMAND
			-- Resize diagram such that it fits to screen.

	force_settings_cmd: EB_SHOW_PHYSICS_SETTINGS_COMMAND
			-- Show settings dialog for force directed.

	toggle_selected_classes_ancestors_cmd: EB_ADD_CLASS_FIGURE_RELATIONS_COMMAND
	toggle_selected_classes_descendents_cmd: EB_ADD_CLASS_FIGURE_RELATIONS_COMMAND
	toggle_selected_classes_clients_cmd: EB_ADD_CLASS_FIGURE_RELATIONS_COMMAND
	toggle_selected_classes_suppliers_cmd: EB_ADD_CLASS_FIGURE_RELATIONS_COMMAND
			-- Toggle showing ancestor, descendent, client and supplier classes for selected diagram classes.

feature {EG_FIGURE, EIFFEL_WORLD} -- Force directed.

	on_time_out is
			-- `timer' has a timeout.
		local
			time: C_DATE
			l_ticks: INTEGER
		do
			if world.is_statistics then
				create time
				l_ticks := time.millisecond_now + time.second_now * 1000 + time.hour_now * 60000

				projector.full_project

				time.update
				world.set_last_physics_time (time.millisecond_now + time.second_now * 1000 + time.hour_now * 60000 - l_ticks)

				time.update
				l_ticks := time.millisecond_now + time.second_now * 1000 + time.hour_now * 60000

				force_directed_layout.layout

				time.update
				world.set_last_draw_time (time.millisecond_now + time.second_now * 1000 + time.hour_now * 60000 - l_ticks)
			else
				projector.full_project
				force_directed_layout.layout
			end
		end

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

	on_history_do_command is
			-- An undoable command has been done.
			-- Enable `undo_cmd'.
		do
			if not history.undo_exhausted then
				undo_cmd.enable_sensitive
			end
		end

	on_history_undo_command is
			-- An undoable command has been undone.
			-- Enable `redo_cmd'.
		do
			if not history.redo_exhausted then
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
			l_str: STRING_GENERAL
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
			l_str := interface_names.t_diagram_zoom_cmd
			l_str.append (" ")
			l_str.append (level_text.out)
			l_str.append ("%%")
			history.register_named_undoable (
				l_str,
				[<<agent world.scale (scale_factor), agent crop_diagram, agent zoom_selector.show_as_text (new_scale), agent restart_force_directed>>],
				[<<agent world.scale (1/scale_factor), agent crop_diagram, agent zoom_selector.show_as_text (old_scale), agent restart_force_directed>>])
		end

	on_view_changed is
			-- The user wants to switch to another view.
		local
			cancelled: BOOLEAN
		do
			if not cancelled then--and not view_selector.is_empty then
				reset_history

				develop_window.status_bar.display_message ("Loading diagram for " + view_selector.text)
				develop_window.status_bar.reset_progress_bar_with_range (0 |..| 0)

				if is_force_directed_used then
					disable_force_directed
				end

				update_excluded_class_figures
				world_cell.disable_resize
				projector.disable_painting

				world.retrieve_view (view_selector.text)

				projector.enable_painting
				world_cell.enable_resize
				projector.full_project
				develop_window.status_bar.reset
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
				on_cluster_legend_pin

				if world.is_right_angles then
					world.apply_right_angles
				end
			end
		rescue
			cancelled := True
			error_handler.error_list.wipe_out
			develop_window.status_bar.reset
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
			if a_item = develop_window then
				store
			end
		end

feature {EB_DELETE_VIEW_COMMAND} -- View selector

	remove_view (a_name: STRING) is
			-- Delete view of `a_name'.
		require
			a_name_not_void: a_name /= Void
			not_default: not a_name.has_substring ("DEFAULT")
		local
			cancelled: BOOLEAN
		do
			if not cancelled then

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
				crop_diagram

				if world.is_right_angles then
					world.apply_right_angles
				end
				view_selector.set_text (world.current_view)
			end
		rescue
			cancelled := True
			error_handler.error_list.wipe_out
			projector.enable_painting
			world_cell.enable_resize
			clear_area
			is_rebuild_world_needed := True
			if is_force_directed_used then
				toggle_force_cmd.current_button.disable_select
			end
			retry
		end

feature {EB_RESET_VIEW_COMMAND} -- Implementation

	reset_current_view is
			-- Reset current view to default.
		do
			if class_graph /= Void then
				create_class_view (class_graph.center_class.class_i, False)
			else
				create_cluster_view (cluster_graph.center_cluster.group, False)
			end
		end

feature {EB_FIT_TO_SCREEN_COMMAND} -- Implementation

	world_cell: EIFFEL_FIGURE_WORLD_CELL
			-- Cell showing the graph.

feature {EB_SHOW_LEGEND_COMMAND} -- Implementation

	on_cluster_legend_pin is
			-- User pined `world'.`cluster_legend'.
		do
			cluster_legend_x := world.cluster_legend.point_x - projector.area_x
			cluster_legend_y := world.cluster_legend.point_y - projector.area_y
		end

feature -- Implementation

	default_bon_horizontal_spacing: INTEGER is 25
	default_bon_vertical_spacing: INTEGER is 25
	default_uml_horizontal_spacing: INTEGER is 150
	default_uml_vertical_spacing: INTEGER is 150
		-- Default spacings used to layout generated figures.

feature {NONE} -- Implementation

	default_subcluster_depth: INTEGER
	default_supercluster_depth: INTEGER
	default_client_depth: INTEGER
	default_supplier_depth: INTEGER
	default_ancestor_depth: INTEGER
	default_descendant_depth: INTEGER

	retrieve_depth_preferences is
			-- Retrieve values for default depth from preferences.
		do
			default_subcluster_depth := preferences.diagram_tool_data.subcluster_depth
			default_supercluster_depth := preferences.diagram_tool_data.supercluster_depth
			default_client_depth := preferences.diagram_tool_data.client_depth
			default_supplier_depth := preferences.diagram_tool_data.supplier_depth
			default_ancestor_depth := preferences.diagram_tool_data.ancestor_depth
			default_descendant_depth := preferences.diagram_tool_data.descendant_depth

			if class_graph /= Void then
				class_graph.set_descendant_depth (default_descendant_depth)
				class_graph.set_ancestor_depth (default_ancestor_depth)
				class_graph.set_supplier_depth (default_supplier_depth)
				class_graph.set_client_depth (default_client_depth)
				if class_graph.center_class /= Void then
					create_class_view (class_graph.center_class.class_i, False)
				end
			elseif cluster_graph /= Void then
				cluster_graph.set_subcluster_depth (default_subcluster_depth)
				cluster_graph.set_supercluster_depth (default_supercluster_depth)
				create_cluster_view (cluster_graph.center_cluster.group, False)
			end
		end

	is_synchronization_needed: BOOLEAN
			-- Is synchronization needed when `Current' gets selected in the tabs?

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

	has_diagram_edited_class: BOOLEAN
			-- Was a class edited through the Diagram.
			-- (Add remove feature, add remove inheritance link)

	view_toolbar: SD_TOOL_BAR
	drawing_toolbar: SD_TOOL_BAR
			-- Part of toolbar that can be customized.

	area: EV_DRAWING_AREA is
			-- Graphical surface displaying diagram.
		require
			not_recycled: not is_recycled
		do
			Result := world_cell.drawing_area
		ensure
			Result_not_void: Result /= Void
		end

	toolbar_menu: EV_MENU
			-- Popped up when user clicks left to the right of the toolbar.

	on_class_drop (a_stone: CLASSI_STONE) is
			-- `stone' was dropped on an empty world.
		do
			if a_stone.is_valid then
				is_rebuild_world_needed := True
				launch_stone (a_stone)
			end
		end

	on_cluster_drop (a_stone: CLUSTER_STONE) is
			-- `stone' was dropped on an empty world
		do
			if a_stone.is_valid then
				is_rebuild_world_needed := True
				launch_stone (a_stone)
			end
		end

	reset_tool_bar_for_uml_class_view is
			-- Set toolbar for uml class view
		do
			reset_toolbar

			change_color_cmd.disable_sensitive
			fill_cluster_cmd.disable_sensitive
			toggle_quality_cmd.disable_sensitive
			toggle_cluster_legend_cmd.disable_sensitive
			toggle_cluster_cmd.disable_sensitive
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
			reset_toolbar

			remove_anchor_cmd.enable_sensitive
			toggle_cluster_legend_cmd.enable_sensitive
			change_color_cmd.enable_sensitive
			toggle_quality_cmd.enable_sensitive

			fill_cluster_cmd.disable_sensitive
			toggle_cluster_cmd.disable_sensitive
		end

	reset_tool_bar_for_cluster_view is
			-- Set toolbar for cluster_view.
		do
			reset_tool_bar_for_class_view
			fill_cluster_cmd.enable_sensitive
			toggle_cluster_cmd.enable_sensitive
		end

	reset_toolbar is
			-- Set toolbar for all views.
		do
			zoom_selector.enable_sensitive
			create_class_cmd.enable_sensitive
			delete_cmd.enable_sensitive
			create_new_links_cmd.enable_sensitive
			trash_cmd.enable_sensitive
			link_tool_cmd.enable_sensitive
			toggle_inherit_cmd.enable_sensitive
			toggle_supplier_cmd.enable_sensitive
			toggle_labels_cmd.enable_sensitive
			select_depth_cmd.enable_sensitive
			if not history.undo_exhausted then
				undo_cmd.enable_sensitive
			else
				undo_cmd.disable_sensitive
			end
			history_cmd.enable_sensitive
			if not history.redo_exhausted then
				redo_cmd.enable_sensitive
			else
				redo_cmd.disable_sensitive
			end
			zoom_in_cmd.enable_sensitive
			zoom_out_cmd.enable_sensitive
			delete_view_cmd.enable_sensitive
			diagram_to_ps_cmd.enable_sensitive
			toggle_uml_cmd.enable_sensitive
			fit_to_screen_cmd.enable_sensitive
			reset_view_cmd.enable_sensitive
			view_selector.enable_sensitive
			view_menu_button.enable_sensitive
			toggle_force_cmd.enable_sensitive
			force_settings_cmd.enable_sensitive
		end

	project_close_agent: PROCEDURE [ANY, TUPLE]
			-- The agent that is called when the project is closed.

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

feature {EIFFEL_WORLD} -- XML Output

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
			l_class: CLASS_I
		do
			clg ?= esg
			if clg = Void then
				cg ?= esg
				check
					is_class_graph: cg /= Void
				end
				create Result.make_from_string (Eiffel_system.context_diagram_path)
				l_class := cg.center_class.class_i
				Result.extend (id_of_class (l_class.config_class))
			else
				create Result.make_from_string (Eiffel_system.context_diagram_path)
				Result.extend (clg.center_cluster.group_id)
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
			if world.is_client_supplier_links_shown then
				toggle_supplier_cmd.enable_select
			else
				toggle_supplier_cmd.disable_select
			end
			if world.is_inheritance_links_shown then
				toggle_inherit_cmd.enable_select
			else
				toggle_inherit_cmd.disable_select
			end
			if world.is_cluster_shown then
				toggle_cluster_cmd.enable_select
			else
				toggle_cluster_cmd.disable_select
			end
			if world.is_labels_shown then
				toggle_labels_cmd.enable_select
			else
				toggle_labels_cmd.disable_select
			end
			if world.is_high_quality then
				toggle_quality_cmd.enable_select
			else
				toggle_quality_cmd.disable_select
			end
			if world.is_legend_shown then
				toggle_cluster_legend_cmd.enable_select
			else
				toggle_cluster_legend_cmd.disable_select
			end
			if world.is_right_angles then
				link_tool_cmd.enable_select
			else
				link_tool_cmd.disable_select
			end
			if world.is_uml then
				toggle_uml_cmd.enable_select
			else
				toggle_uml_cmd.disable_select
			end

			zoom_selector.show_as_text ((world.scale_factor * 100).rounded)
		end

feature {NONE} -- Implementation keyboard shortcuts

	on_key_pressed (a_key: EV_KEY) is
			-- A key was pressed while focus is on `area'.
		local
			accelerators: LIST [EV_ACCELERATOR]
			l_item: EV_ACCELERATOR
			alt_pressed, ctrl_pressed, shift_pressed: BOOLEAN
		do
			accelerators := shortcut_table.item (a_key.code)
			if accelerators /= Void then
				alt_pressed := ev_application.alt_pressed
				ctrl_pressed := ev_application.ctrl_pressed
				shift_pressed := ev_application.shift_pressed
				from
					accelerators.start
				until
					accelerators.after
				loop
					l_item := accelerators.item
					if
						l_item.alt_required = alt_pressed and then
					 	l_item.control_required = ctrl_pressed and then
					 	l_item.shift_required = shift_pressed
					 then
						l_item.actions.call (Void)
					end
					accelerators.forth
				end
			end
		end

	shortcut_table: HASH_TABLE [LIST[EV_ACCELERATOR], INTEGER]
			-- List of accelerators and key codes.

	extend_shortcut_table (an_accelerator: EV_ACCELERATOR) is
			-- Add `an_accelerator' to `shortcut_table'.
		require
			an_accelerator_exists: an_accelerator /= Void
		local
			l_list: LIST [EV_ACCELERATOR]
			l_code: INTEGER
		do
			l_code := an_accelerator.key.code
			l_list := shortcut_table.item (l_code)
			if l_list /= Void then
				l_list.extend (an_accelerator)
			else
				create {ARRAYED_LIST [EV_ACCELERATOR]} l_list.make (1)
				l_list.extend (an_accelerator)
				shortcut_table.put (l_list, l_code)
			end
		end

feature {NONE} -- Implementation for mini tool bar

	mini_toolbar: EV_HORIZONTAL_BOX
			-- Mini tool bar.

	history_toolbar: SD_TOOL_BAR;
			-- Toolbar containing the history commands.

	window: EV_WINDOW is
			-- Window dialogs can refer to.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			conv_dev ?= develop_window
			if conv_dev /= Void then
				Result := conv_dev.window
			else
				create Result
			end
		end

	refresh is
			-- Refresh
		do
		end

	stone: STONE
			-- Current stone

	address_manager: EB_ADDRESS_MANAGER
			-- Manager for the header info.
invariant
	world_cell_not_void: not is_recycled implies world_cell /= Void
	shortcut_table_not_void: shortcut_table /= Void

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

end -- class EB_CONTEXT_EDITOR


