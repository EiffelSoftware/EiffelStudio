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

create
	make_with_tool

feature {NONE} -- Initialization

	make_with_tool (a_tool: like tool) is
			-- Set default values.
		local
			empty_world: EV_FIGURE_WORLD
			border_frame: EV_FRAME
			vertical_box: EV_VERTICAL_BOX
		do
			tool := a_tool
			create widget

				-- Initialize undoable command history.
			create history 
			history.do_actions.extend (~on_history_do_command)
			history.undo_actions.extend (~on_history_undo_command)
			history.undo_exhausted_actions.extend (~on_history_undo_exhausted)
			history.redo_exhausted_actions.extend (~on_history_redo_exhausted)
			project_close_agent := ~store
			Eiffel_project.manager.close_agents.extend (project_close_agent)
			development_window.window_manager.add_observer (Current)

			development_window.editor_tool.text_area.add_edition_observer (Current)

			init_commands
			build_tool_bar

			create area
			area.set_minimum_size (1, 1)
			area.clear
			area.flush
			create area_buffer
			create horizontal_box
			create vertical_scrollbar.make_with_value_range (create {INTEGER_INTERVAL}.make (0, 1))
			vertical_scrollbar.set_step (15)
			vertical_scrollbar.change_actions.extend (~on_vertical_scroll)
			create horizontal_scrollbar.make_with_value_range (create {INTEGER_INTERVAL}.make (0, 1))
			horizontal_scrollbar.set_step (15)
			horizontal_scrollbar.change_actions.extend (~on_horizontal_scroll)
			horizontal_box.extend (area)
			horizontal_box.extend (vertical_scrollbar)
			horizontal_box.disable_item_expand (vertical_scrollbar)
			area.resize_actions.extend (~on_resizing)
			create empty_world
			empty_world.drop_actions.extend (agent tool.launch_stone)
			create projector.make_with_buffer (empty_world, area)
			update_size (Void)
			create border_frame
			create vertical_box
			vertical_box.extend (horizontal_box)
			vertical_box.extend (horizontal_scrollbar)
			vertical_box.disable_item_expand (horizontal_scrollbar)
			border_frame.extend (vertical_box)
			widget.extend (border_frame)
			create autoscroll
			autoscroll.actions.extend (agent on_time_out)
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
		end

	build_tool_bar is
			-- Create diagram option bar.
		local
			bar_bar: EV_HORIZONTAL_BOX
			view_menu_button: EV_TOOL_BAR_BUTTON
			view_menu_toolbar: EV_TOOL_BAR
			customize_area: EV_CELL
			tb_commands: LINKED_LIST [EB_TOOLBARABLE_COMMAND]
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
			tb_commands.extend (delete_view_cmd)
			tb_commands.extend (diagram_to_ps_cmd)
			tb_commands.extend (crop_cmd)
			custom_toolbar := retrieve_diagram_toolbar (tb_commands)

			custom_toolbar.update_toolbar
			bar_bar.extend (custom_toolbar.widget)
			bar_bar.disable_item_expand (custom_toolbar.widget)

			widget.extend (bar_bar)
			widget.disable_item_expand (bar_bar)

			create customize_area
			bar_bar.extend (customize_area)

			create view_menu_button.make_with_text ("View")
			view_menu_button.set_pixmap (pixmaps.Icon_nothing)
			create view_menu_toolbar
			view_menu_toolbar.extend (view_menu_button)

			view_menu_button.select_actions.extend (agent show_view_menu)
			bar_bar.extend (view_menu_toolbar)
			bar_bar.disable_item_expand (view_menu_toolbar)

			create view_selector.make_default
			view_selector.select_actions.extend (~on_view_changed)
			bar_bar.extend (view_selector)
			bar_bar.disable_item_expand (view_selector)

			customize_area.pointer_button_release_actions.extend (~on_customize)
		end
		
	show_view_menu is
			-- Display "View" menu.
		local
			view_menu: EV_MENU
		do
			create view_menu
			view_menu.extend (select_depth_cmd.new_menu_item)
			view_menu.extend (create {EV_MENU_SEPARATOR})
			view_menu.extend (link_tool_cmd.new_menu_item)
			view_menu.extend (crop_cmd.new_menu_item)
			view_menu.extend (create {EV_MENU_SEPARATOR})
			view_menu.extend (delete_view_cmd.new_menu_item)			
			view_menu.extend (diagram_to_ps_cmd.new_menu_item)
			view_menu.show
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW is
			-- Application main window.
		do
			Result ?= tool.manager
		end

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current'.

	horizontal_box: EV_HORIZONTAL_BOX
			-- Container for `area' and `vertical_scrollbar'.

	horizontal_scrollbar: EV_HORIZONTAL_SCROLL_BAR
			-- horizontal scroll bar for the diagram

	vertical_scrollbar: EV_VERTICAL_SCROLL_BAR
			-- vertical scroll bar for the diagram

	history: EB_HISTORY_DIALOG
			-- History of undoable commands.

	custom_toolbar: EB_TOOLBAR
			-- Part of toolbar that can be customized.

	view_selector: EB_VIEW_SELECTOR
			-- Combo box that lets the user change views.

	area: EV_DRAWING_AREA
			-- Graphical surface displaying diagram.

	area_buffer: EV_PIXMAP
			-- Copy of `area' from which drawing routines get called.

	area_as_widget: EV_WIDGET is
			-- `area' cast to EV_WIDGET.
		do
			Result ?= area
		end

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer relative to `area'.
		require
			area_is_widget: area_as_widget /= Void
			projector_exists: projector /= Void
		do
			create Result.set (
				area_as_widget.pointer_position.x + projector.area_x,
				area_as_widget.pointer_position.y + projector.area_y)
		ensure
			position_not_void: Result /= Void
		end

	projector: ES_PROJECTOR
			-- Responsible for drawing views.

	class_view: BON_CLASS_DIAGRAM
			-- Class view currently displayed.

	cluster_view: BON_CLUSTER_DIAGRAM
			-- Cluster view currently displayed.

	diagram_file_name (cd: CONTEXT_DIAGRAM): FILE_NAME is
			-- Location of XML file.
		require
			diagram_exists: cd /= Void
		local
			cld: CLUSTER_DIAGRAM
		do
			cld ?= cd
			if cld = Void then
				create Result.make_from_string (Eiffel_system.context_diagram_path)
				Result.extend (cd.center_class.class_i.name)
			else
				create Result.make_from_string (Eiffel_system.context_diagram_path)
				Result.extend (cld.center_cluster.cluster_i.cluster_name)
			end
			Result.add_extension ("ead")
		end

	toolbar_menu: EV_MENU
			-- Popped up when user clicks left to the right of the toolbar.

	class_stone: CLASSI_STONE
			-- Stone representing center class.

	cluster_stone: CLUSTER_STONE
			-- Stone representing center cluster.			

feature -- Status setting

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			fs: FEATURE_STONE
		do
			fs ?= a_stone
			if 
				fs = Void 
					or else
				(
					class_stone = Void
						or else
					class_stone.class_i /= fs.class_i
				)
			then
				if is_building then
					last_build_cancelled := True
					Progress_dialog.hide
					if class_view /= Void then
						class_view.cancel
					end
					if cluster_view /= Void then
						cluster_view.cancel
					end
				end
					-- Save current diagram.
				if not last_build_cancelled then
					store
				end

				horizontal_box.wipe_out
				if projector /= Void then
					projector.widget.pointer_motion_actions.wipe_out
					projector.widget.pointer_button_press_actions.wipe_out
					projector.widget.pointer_double_press_actions.wipe_out
					projector.widget.pointer_button_release_actions.wipe_out
					projector.widget.pointer_leave_actions.wipe_out
				end
				projector := Void

				if area /= Void then
					area.destroy
				end
				area := Void
				if class_view /= Void then
					class_view.recycle
				end
				class_view := Void
				if cluster_view /= Void then
					cluster_view.recycle
				end
				cluster_view := Void
	
				class_stone ?= a_stone
				cluster_stone ?= a_stone			
				if tool.is_diagram_selected then
					on_select
				end
			end
		end

	on_select is
			-- Current became selected in notebook.
		do
			if 
				area = Void 
			then
				horizontal_box.wipe_out
				update_excluded_class_figures
				development_window.window.set_pointer_style (Default_pixmaps.Wait_cursor)
				if class_stone /= Void then
					create_class_view (class_stone.class_i)
				elseif cluster_stone /= Void then
					create_cluster_view (cluster_stone.cluster_i)
				else
					disable_toolbar
				end
				development_window.window.set_pointer_style (Default_pixmaps.Standard_cursor)
			elseif class_view /= Void and then class_view.cancelled then
				set_stone (class_stone)
			elseif cluster_view /= Void and then cluster_view.cancelled then
				set_stone (cluster_stone)
			end
		end

	create_class_view (a_class: CLASS_I) is
			-- Initialize diagram centered on `a_class'.
		require
			a_class_exists: a_class /= Void
		local
			f: RAW_FILE
			cancelled: BOOLEAN
			l_class_view: BON_CLASS_DIAGRAM
		do
			is_building := True
			history.wipe_out
			disable_toolbar

			if not cancelled then
				progress_dialog.set_title ("Building progress")
				progress_dialog.set_message ("Diagram for " + a_class.name_in_upper)
				progress_dialog.enable_cancel
				progress_dialog.start (6)
				progress_dialog.set_value (0)
				progress_dialog.show

				class_view := Void

				create l_class_view.make (Current)
				cluster_view := Void
	
				create area
				area.disable_sensitive
				area.resize_actions.extend (~on_resizing)
				horizontal_box.extend (area)
				horizontal_box.extend (vertical_scrollbar)
				horizontal_box.disable_item_expand (vertical_scrollbar)
				create {ES_PROJECTOR} projector.make_with_buffer (l_class_view,area)-- area_buffer, area)
				l_class_view.set_drawable_cell_and_position (projector.drawable_cell, projector.drawable_position)
				l_class_view.set_projector (projector)
			
				progress_dialog.set_value (1)
				class_view := l_class_view
				l_class_view.set_class (a_class)
	
				create f.make (diagram_file_name (l_class_view))
				if not l_class_view.cancelled then
					l_class_view.load_from_file (f)
				else
					l_class_view := Void
				end
				if l_class_view /= Void then
					class_view := l_class_view
				end
				last_build_cancelled := False
			else
				clear_area
			end
			is_building := False
			area.enable_sensitive

			rescue
				class_view := Void
				cluster_view := Void
				cancelled := True
				Error_handler.error_list.wipe_out
				progress_dialog.hide
				retry
			end
	
	create_cluster_view (a_cluster: CLUSTER_I) is
			-- Initialize diagram centered on `a_cluster'.
		require
			a_cluster_exists: a_cluster /= Void
		local
			f: RAW_FILE
			cancelled: BOOLEAN
			l_cluster_view: BON_CLUSTER_DIAGRAM
		do
			is_building := True
			disable_toolbar
			history.wipe_out
			if not cancelled then
				progress_dialog.set_title ("Building progress")
				progress_dialog.set_message ("Diagram for " + a_cluster.cluster_name)
				progress_dialog.enable_cancel
				progress_dialog.start (5)
				progress_dialog.set_value (0)
				progress_dialog.show

				cluster_view := Void
				create l_cluster_view.make (Current)
				class_view := Void
	
				create area
				area.disable_sensitive
				area.resize_actions.extend (~on_resizing)
				horizontal_box.extend (area)
				horizontal_box.extend (vertical_scrollbar)
				horizontal_box.disable_item_expand (vertical_scrollbar)
				create projector.make_with_buffer (l_cluster_view, area)
				l_cluster_view.set_drawable_cell_and_position (projector.drawable_cell, projector.drawable_position)
				l_cluster_view.set_projector (projector)
					
				progress_dialog.set_value (1)
				cluster_view := l_cluster_view
				l_cluster_view.set_cluster (a_cluster)
	
				create f.make (diagram_file_name (l_cluster_view))
				if not l_cluster_view.cancelled then
					l_cluster_view.load_from_file (f)
				else
					l_cluster_view := Void
				end
				if l_cluster_view /= Void then
					cluster_view := l_cluster_view
				end
				reset_scrollbars
				last_build_cancelled := False
			else
				clear_area
			end
			is_building := False
			area.enable_sensitive

		rescue
			class_view := Void
			cluster_view := Void
			cancelled := True
			Error_handler.error_list.wipe_out
			progress_dialog.hide
			retry
		end

	synchronize is
			-- Contexts need to be updated because of recompilation
			-- or similar action that needs resynchonization.
		do
			reset_history
			if class_view /= Void then
				class_view.synchronize (True, Void)
			elseif cluster_view /= Void then
				cluster_view.synchronize (True, Void)
			end
		end

	set_focus is
			-- Give the focus to the drawing_area.
		require
			focusable: widget.is_displayed and widget.is_sensitive
		do
			area.set_focus
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
			if cluster_view /= Void then
				cluster_view.manager.remove_observer (cluster_view)
			end
			cluster_view := Void
			class_view := Void
			projector := Void
			area := Void
			widget := Void
		end

feature {EB_CONTEXT_EDITOR, EB_CONTEXT_DIAGRAM_COMMAND, CONTEXT_DIAGRAM} -- Toolbar actions

	on_new_client_click is
			-- The user wants a new client-supplier link.
		require
			a_view_exists: class_view /= Void or else cluster_view /= Void
		do
			if class_view /= Void then
				class_view.set_link_client
			elseif cluster_view /= Void then
				cluster_view.set_link_client
			end
		end

	on_new_agg_client_click is
			-- The user wants a new client-supplier link.
		require
			a_view_exists: class_view /= Void or else cluster_view /= Void
		do
			if class_view /= Void then
				class_view.set_link_aggregate_client
			elseif cluster_view /= Void then
				cluster_view.set_link_aggregate_client
			end	
		end

	on_new_inherit_click is
			-- The user wants a new inheritance link.
		require
			a_view_exists: class_view /= Void or else cluster_view /= Void
		do
			if class_view /= Void then
				class_view.set_link_inheritance
			elseif cluster_view /= Void then
				cluster_view.set_link_inheritance
			end
		end

	reset (cd: CONTEXT_DIAGRAM) is
			-- It was not possible to retrieve current view.
			-- Set it in a default way.
		require
			diagram_exists: cd /= Void
		do
			cd.reset
			cd.reset_views
			view_selector.select_actions.block
			view_selector.set_strings (cd.available_views)
			view_selector.select_actions.resume
			view_selector.set_text ("DEFAULT")
			update_size (cd)
		end

	reset_tool_bar_for_class_view is
			-- Set toolbar for class_view.
		do
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
		end

	reset_tool_bar_for_cluster_view is
			-- Set toolbar for cluster_view.
		do
			reset_tool_bar_for_class_view
			fill_cluster_cmd.enable_sensitive
		end

	disable_toolbar is
			-- There is no need for any button to be sensitive.
		do
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
		end

	crop_diagram is
			-- Crop diagram.
		do
			if class_view /= Void then
				class_view.crop
			elseif cluster_view /= Void then
				cluster_view.crop
			end
			projector.full_project
			projector.update
		end
	
feature {DIAGRAM_COMPONENT} -- Control right-click

	create_development_window (a_stone: STONE) is
			-- Create a new_development_window with `a_stone'.
		require
			a_stone_exists: a_stone /= Void
		do
			window_manager.create_window
			window_manager.last_created_window.set_stone (a_stone)
		end

	create_link_tool (a_stone: LINK_STONE) is
			-- Create a new link tool with `a_stone'.
		require
			a_stone_exists: a_stone /= Void
		do
			link_tool_cmd.execute_with_link_stone (a_stone)
		end

feature {CONTEXT_DIAGRAM, EB_CONTEXT_DIAGRAM_COMMAND, DIAGRAM_COMPONENT} -- Status setting

	update_bounds (cd: CONTEXT_DIAGRAM) is
			-- Drawable area needs to be resized because of figure moves or new figures.
		require
			diagram_exists: cd /= Void
		local
			r: EV_RECTANGLE
			new_x, new_y: INTEGER
		do
			r := cd.bounds
			new_x := - r.x
			new_y := - r.y
			if new_x > 0 or new_y > 0 then
				cd.point.set_position (
					new_x.max (0) + cd.point.x,
					new_y.max (0) + cd.point.y)
			end
			if 
				r.width + r.x > visible_width
					or
				r.height + r.y > visible_height
			then
				update_size (cd)
			end
		end		

	update_size (cd: CONTEXT_DIAGRAM) is
			-- Scrollable area and drawable area need to be resized because of diagram resizing.
		local
			t: EB_DIMENSIONS
			leap_x, leap_y, old_value: INTEGER
		do
			if cd /= Void then
				t := cd.minimum_size
			else
				create t.set (1, 1)
			end
			visible_width := t.width.max (area.width)
			visible_height := t.height.max (area.height)
			leap_x := area.width
			leap_y := area.height

			old_value := horizontal_scrollbar.value
			horizontal_scrollbar.value_range.resize_exactly (
				0,		
				(visible_width - 1 - leap_x).max (1)
			)
			horizontal_scrollbar.set_leap (leap_x)
			if horizontal_scrollbar.value_range.has (old_value) then
				horizontal_scrollbar.set_value (old_value)
			else
				horizontal_scrollbar.set_value (horizontal_scrollbar.value_range.lower)
			end

			old_value := vertical_scrollbar.value
			vertical_scrollbar.value_range.resize_exactly (
				0,
				(visible_height	- 1 - leap_y).max (1)
			)
			vertical_scrollbar.set_leap (leap_y)
			if vertical_scrollbar.value_range.has (old_value) then
				vertical_scrollbar.set_value (old_value)
			else
				vertical_scrollbar.set_value (vertical_scrollbar.value_range.lower)
			end
		end

	update_toggles (cd: CONTEXT_DIAGRAM)  is	
			-- Diagram was retrieved from a file with non-default
			-- settings. Update toolbar.
		require
			diagram_exists: cd /= Void
		local
			cld: CLUSTER_DIAGRAM
		do
			cld ?= cd
			toggle_inherit_cmd.current_button.select_actions.wipe_out
			toggle_supplier_cmd.current_button.select_actions.wipe_out
			toggle_labels_cmd.current_button.select_actions.wipe_out
			if cld = Void then
				if cd.inheritance_links_displayed then
					cd.inheritance_layer.show
					cd.inheritance_layer.enable_sensitive
					if not toggle_inherit_cmd.current_button.is_selected then
						toggle_inherit_cmd.current_button.toggle
					end
				else
					cd.inheritance_layer.hide
					cd.inheritance_layer.disable_sensitive
					if toggle_inherit_cmd.current_button.is_selected then
						toggle_inherit_cmd.current_button.toggle
					end
				end
				if cd.client_links_displayed then
					cd.client_supplier_layer.show
					cd.client_supplier_layer.enable_sensitive
					if not toggle_supplier_cmd.current_button.is_selected then
						toggle_supplier_cmd.current_button.toggle
					end
				else
					cd.client_supplier_layer.hide
					cd.client_supplier_layer.disable_sensitive
					if toggle_supplier_cmd.current_button.is_selected then
						toggle_supplier_cmd.current_button.toggle
					end
				end
				if cd.labels_shown then
					cd.show_labels
					if not toggle_labels_cmd.current_button.is_selected then
						toggle_labels_cmd.current_button.toggle
					end
				else
					cd.hide_labels
					if toggle_labels_cmd.current_button.is_selected then
						toggle_labels_cmd.current_button.toggle
					end
				end
			else
				if cld.inheritance_links_displayed then
					cld.inheritance_layer.show
					cld.inheritance_layer.enable_sensitive
					if not toggle_inherit_cmd.current_button.is_selected then
						toggle_inherit_cmd.current_button.toggle
					end
				else
					cld.inheritance_layer.hide
					cld.inheritance_layer.disable_sensitive
					if toggle_inherit_cmd.current_button.is_selected then
						toggle_inherit_cmd.current_button.toggle
					end
				end
				if cld.client_links_displayed then
					cld.client_supplier_layer.show
					cld.client_supplier_layer.enable_sensitive
					if not toggle_supplier_cmd.current_button.is_selected then
						toggle_supplier_cmd.current_button.toggle
					end
				else
					cld.client_supplier_layer.hide
					cld.client_supplier_layer.disable_sensitive
					if toggle_supplier_cmd.current_button.is_selected then
						toggle_supplier_cmd.current_button.toggle
					end
				end
				if cld.labels_shown then
					cld.show_labels
					if not toggle_labels_cmd.current_button.is_selected then
						toggle_labels_cmd.current_button.toggle
					end
				else
					cld.hide_labels
					if toggle_labels_cmd.current_button.is_selected then
						toggle_labels_cmd.current_button.toggle
					end
				end
			end
			toggle_inherit_cmd.current_button.select_actions.extend (toggle_inherit_cmd~execute)
			toggle_supplier_cmd.current_button.select_actions.extend (toggle_supplier_cmd~execute)
			toggle_labels_cmd.current_button.select_actions.extend (toggle_labels_cmd~execute)
		end

	reset_toggles (cd: CONTEXT_DIAGRAM) is	
			-- Put toggles to default settings.
		do
			if cd /= Void then
				if not toggle_inherit_cmd.current_button.is_selected then
					toggle_inherit_cmd.current_button.toggle
				end
				if toggle_supplier_cmd.current_button.is_selected then
					toggle_supplier_cmd.current_button.toggle
				end
				cd.client_supplier_layer.hide
				cd.client_supplier_layer.disable_sensitive
			end
		end

	put_progress_string (info: STRING; new_value: INTEGER) is
			-- Fill `progress_dialog' with `info' and `new_value' while building a diagram.
		require
			info_not_void: info /= Void
		do
			progress_dialog.set_message (info)
			progress_dialog.set_value (new_value)
		end

	refresh_progress is
			-- Process events while exploring classes.
		do
			progress_dialog.graphical_update
		end

	reset_scrollbars is
			-- Scroll both scrollbars to their mimimum value.
		do
			horizontal_scrollbar.set_value (horizontal_scrollbar.value_range.lower)
			vertical_scrollbar.set_value (vertical_scrollbar.value_range.lower)
		end

feature {CLASS_TEXT_MODIFIER, INHERITANCE_FIGURE, CONTEXT_DIAGRAM, EB_CONTEXT_DIAGRAM_COMMAND} -- Status setting

	reset_history is
			-- Forget about previous undoable commands.
		do
			history.wipe_out
			undo_cmd.disable_sensitive
			redo_cmd.disable_sensitive
		end

feature {EB_DEVELOPMENT_WINDOW} -- Commands with global accelerators

	undo_cmd: EB_UNDO_DIAGRAM_COMMAND
			-- Command to undo last action
			
	redo_cmd: EB_REDO_DIAGRAM_COMMAND
			-- Command to redo last undone action

feature {NONE} -- Implementation

	project_close_agent: PROCEDURE [ANY, TUPLE []]
			-- The agent that is called when the project is closed.

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
			
	select_depth_cmd: EB_SELECT_DEPTH_COMMAND
			-- Command to select the depth of the diagram.

	link_tool_cmd: EB_LINK_TOOL_COMMAND

	fill_cluster_cmd: EB_FILL_CLUSTER_COMMAND

	history_cmd: EB_DIAGRAM_HISTORY_COMMAND
	
	crop_cmd: EB_CROP_DIAGRAM_COMMAND

	zoom_in_cmd: EB_ZOOM_IN_COMMAND

	zoom_out_cmd: EB_ZOOM_OUT_COMMAND

	delete_view_cmd: EB_DELETE_VIEW_COMMAND

	diagram_to_ps_cmd: EB_DIAGRAM_TO_PS_COMMAND
	
	Pixmaps: EB_SHARED_PIXMAPS is
		once
			create Result
		end

	last_build_cancelled: BOOLEAN
			-- Was last diagram creation cancelled?

	is_building: BOOLEAN
			-- Is a diagram currently being built?

	excluded_class_figures: ARRAY [STRING]
			-- Classes never present on the diagram (unless `ignore_excluded_figures' is False).

	ignore_excluded_figures: BOOLEAN
			-- Will `excluded_class_figures' be taken into account?

	Default_excluded_class_figures: ARRAY [STRING] is
			-- Default settings for `excluded_class_figures'.
		once
			Result := <<
				"INTEGER", "BOOLEAN", "STRING",
				"CHARACTER", "REAL", "DOUBLE"
				>>
		end

	update_excluded_class_figures is
			-- Preferences may have changed.
			-- Refresh `excluded_class_figures' and `ignore_excluded_figures'.
		do
			ignore_excluded_figures := boolean_resource_value ("ignore_excluded_class_figures", False)
			if not ignore_excluded_figures then
				excluded_class_figures := array_resource_value ("excluded_class_figures", Default_excluded_class_figures)
			else
				create excluded_class_figures.make (1,0)
			end
			excluded_class_figures.compare_objects
		end			

feature {CONTEXT_DIAGRAM, EB_CONTEXT_DIAGRAM_COMMAND} -- Implementation

	is_excluded_in_preferences (name: STRING): BOOLEAN is
			-- Is class figure named `name' excluded in preferences?
		do
			Result := excluded_class_figures.has (name)
		end

	clear_area is
			-- Make `area' empty because a diagram has been cancelled.
		local
			empty_world: EV_FIGURE_WORLD
		do
			last_build_cancelled := True
			create area_buffer
			create area
			horizontal_box.wipe_out
			horizontal_box.extend (area)
			horizontal_box.extend (vertical_scrollbar)
			horizontal_box.disable_item_expand (vertical_scrollbar)
			create empty_world
			empty_world.drop_actions.extend (agent tool.launch_stone)
			create {ES_PROJECTOR} projector.make_with_buffer (empty_world, area)
			update_size (Void)
			projector.full_project
		end

	progress_dialog: EB_PROGRESS_DIALOG is
		once
			create Result
		end

	Default_pixmaps: EV_STOCK_PIXMAPS is
		do
			create Result
		end

	tool: EB_CONTEXT_TOOL
			-- Container of `Current'.

feature {NONE} -- Events

	on_vertical_scroll (new_value: INTEGER) is
			-- `vertical_scrollbar' has been moved by the user.
		do
			if projector /= Void and then new_value /= projector.area_y then
				projector.change_area_position (projector.area_x, new_value)
			end
		end

	on_horizontal_scroll (new_value: INTEGER) is
			-- `horizontal_scrollbar' has been moved by the user.
		do
			if projector /= Void and then new_value /= projector.area_x then
				projector.change_area_position (new_value, projector.area_y)
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
	
	customize_toolbar is
			-- Customize diagram toolbar.
		do
			custom_toolbar.customize
			save_diagram_toolbar (custom_toolbar)
		end
		
	on_resizing (a_x, a_y, a_width, a_height: INTEGER) is
			-- `area' has been resized.
			-- Update scrollbars.
		local
			max, old_value: INTEGER
		do
			if area /= Void then
				visible_width := visible_width.max (area.width) 
				visible_height := visible_height.max (area.height)
				old_value := horizontal_scrollbar.value
				max := (visible_width - 1 - area.width.max (1)).max (1)
				horizontal_scrollbar.value_range.resize_exactly (0, max)
				horizontal_scrollbar.set_leap (area.width.max (1))
				old_value := old_value.min (max).max (0)
				horizontal_scrollbar.set_value (old_value)
				on_horizontal_scroll (old_value)
				
				old_value := vertical_scrollbar.value
				max := (visible_height - 1 - area.height.max (1)).max (1)
				vertical_scrollbar.value_range.resize_exactly (0, max)
				vertical_scrollbar.set_leap (area.height.max (1))
				old_value := old_value.min (max).max (0)
				vertical_scrollbar.set_value (old_value)
				on_vertical_scroll (old_value)
--				if projector /= Void then
--					projector.update_rectangle (create {EV_RECTANGLE}.make (0, 0, area.width, area.height), 0, 0)
--				end
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

	on_view_changed is
			-- The user wants to switch to another view.
		do
			reset_history
			if class_view /= Void then
				class_view.set_current_view (view_selector.selected_item.text)
				projector.full_project
			elseif cluster_view /= Void then
				cluster_view.set_current_view (view_selector.selected_item.text)
				projector.full_project
			end
		end

	on_text_edited (directly_edited: BOOLEAN) is 
			-- Some text was inserted in the editor.
			-- If `directly_edited' is true, the user did.
		do
			if directly_edited then
				reset_history
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

feature {DIAGRAM_COMPONENT} -- Events

	autoscroll: EV_TIMEOUT
			-- Timer limiting scrolling speed.

	on_time_out is
			-- Enable scroll.
		do
			autoscroll.set_interval (0)
			if scroll then
				scroll_if_necessary
				autoscroll.set_interval (300)
			end
			scroll := False
		end
	
	scroll: BOOLEAN
			-- Is scrolling enabled?
	
	on_figure_moved is
			-- Disable scrolling till end of timer.
		do
			scroll := True
			if autoscroll.interval = 0 then
				autoscroll.set_interval (300)
			end
		end

	scroll_if_necessary is
			-- A figure has moved.
			-- `scrollable_area' should move as well, and may have to be resized.
			-- Do nothing if `only_if_cursor_outside' and if the mouse pointer is over
			-- the diagram.
		local
 			cursor_x, cursor_y, offset, old_value: INTEGER
		do
			cursor_x := (pointer_position.x).max (0)
			cursor_y := (pointer_position.y)
			if cursor_x <= horizontal_scrollbar.value + 40 then
				if cursor_x >= 40 then
					horizontal_scrollbar.set_value (
						(cursor_x - 40).max (0).min (horizontal_scrollbar.value_range.upper))
				else
					offset := (40 - cursor_x).max (40)
					visible_width := visible_width - cursor_x + offset
					horizontal_scrollbar.value_range.resize_exactly (
						0,
						(visible_width - 1 - area.width.max (1)).max (1)
					)
					if class_view /= Void then
						class_view.point.set_x (class_view.x_to_grid (class_view.point.x + offset))
					elseif cluster_view /= Void then
						offset := cluster_view.x_to_grid (cluster_view.point.x + offset)
						cluster_view.point.set_x (offset)
						cluster_view.notify_clusters_of_origin_moved (offset - cluster_view.point.x, 0)
					end
				end
			end
			if cursor_y <= vertical_scrollbar.value + 40 then
				if cursor_y >= 40 then
					vertical_scrollbar.set_value (
						(cursor_y - 40).max (0).min (vertical_scrollbar.value_range.upper))
				else
					offset := (40 - cursor_y).max (40)
					visible_height := visible_height + offset
					vertical_scrollbar.value_range.resize_exactly (
						0,
						(visible_height - 1 - area.height.max (1)).max (1)
					)
					if class_view /= Void then
						class_view.point.set_y (class_view.y_to_grid (class_view.point.y + offset)) 
					elseif cluster_view /= Void then
						old_value := cluster_view.point.y
						offset := cluster_view.y_to_grid (old_value + offset)
						cluster_view.point.set_y (offset) 
						cluster_view.notify_clusters_of_origin_moved (0, offset - old_value)
					end
				end
			end
			if cursor_x >= horizontal_scrollbar.value + area.width - 40 then
				if cursor_x + 40 <= visible_width
				then
					horizontal_scrollbar.set_value (
						(horizontal_scrollbar.value + 40).max (0).min (horizontal_scrollbar.value_range.upper))
				else
					offset := (40 + cursor_x - visible_width).max (40)
					visible_width := visible_width + offset
					horizontal_scrollbar.value_range.resize_exactly (
						0,
						(visible_width - 1 - area.width.max (1)).max (1)
					)
				end
			end
			if cursor_y >= vertical_scrollbar.value + area.height - 40 then
				if cursor_y + 40 <= visible_height
				then
					vertical_scrollbar.set_value (
						(vertical_scrollbar.value + 40).max (0).min (vertical_scrollbar.value_range.upper))
				else
					offset := (40 + cursor_y -	visible_height).max (40)
					visible_height := visible_height + offset
					vertical_scrollbar.value_range.resize_exactly (
							0,
							(visible_height - 1 - area.height.max (1)).max (1)
					)
				end
			end
			projector.update_rectangle (create {EV_RECTANGLE}.make (0, 0, area.width, area.height), 0, 0)
		end
		
feature {INHERITANCE_FIGURE} -- Events

	on_inheritance_link_created is
			-- An inheritance link has been created.
			-- Display inheritance links if necessary.
		do
			toggle_inherit_cmd.current_button.select_actions.wipe_out
			if class_view /= Void then
				if not class_view.inheritance_layer.is_show_requested then
					toggle_inherit_cmd.current_button.toggle
					toggle_inherit_cmd.execute
				end
			end
			if cluster_view /= Void then
				if not cluster_view.inheritance_layer.is_show_requested then
					toggle_inherit_cmd.current_button.toggle
					toggle_inherit_cmd.execute
				end
			end
			toggle_inherit_cmd.current_button.select_actions.extend (toggle_inherit_cmd~execute)
		end

feature {CLASS_TEXT_MODIFIER} -- Events

	on_client_link_created is
			-- A client link has been created.
			-- Display client links if necessary.
		do
			toggle_supplier_cmd.current_button.select_actions.wipe_out
			if class_view /= Void then
				if not class_view.client_supplier_layer.is_show_requested then
					toggle_supplier_cmd.current_button.toggle
					toggle_supplier_cmd.execute
				end
			end
			if cluster_view /= Void then
				if not cluster_view.client_supplier_layer.is_show_requested then
					toggle_supplier_cmd.current_button.toggle
					toggle_supplier_cmd.execute
				end
			end
			toggle_supplier_cmd.current_button.select_actions.extend (toggle_supplier_cmd~execute)
		end

feature {EB_CONTEXT_TOOL} -- XML Output

	store is
			-- Freeze state of `Current'.
		local
			ptf: RAW_FILE
			retried: BOOLEAN
		do
			if not last_build_cancelled then
				if not retried then
					if class_view /= Void then
						create ptf.make (diagram_file_name (class_view))
						if ptf.exists then
							ptf.open_read
						else
							ptf.open_write
						end
						class_view.store (ptf)
						ptf.close
					elseif cluster_view /= Void then
						create ptf.make (diagram_file_name (cluster_view))
						if ptf.exists then
							ptf.open_read
						else
							ptf.open_write
						end
						cluster_view.store (ptf)
						ptf.close
					end
				end
			end
		rescue
			retried := True
			retry
		end
		
	visible_width: INTEGER
			-- width of the part of the diagram that is visible
	
	visible_height: INTEGER
			-- height of the part of the diagram that is visible
		
end -- class EB_CONTEXT_EDITOR

