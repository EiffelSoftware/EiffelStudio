indexing
	description	: "Window containing several tools"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_TOOL_MANAGER

inherit
	EB_WINDOW
		rename
			destroy_recyclable_items as recycle
		redefine
			make,
			build_menus,
			build_menu_bar,
			destroy_imp,
			recycle
		end

	EB_EXPLORER_BAR_MANAGER
		undefine
			default_create
		end

	EB_SHARED_DEBUG_TOOLS
		undefine
			default_create
		end

	EB_HISTORY_OWNER
		undefine
			default_create
		redefine
			recycle
		end

feature {NONE} -- Initialization

	make is
			-- Create a new development window.
		do
			Precursor {EB_WINDOW}
			initialized := False -- Reset the flag since initializion is not yet complete.

				-- Track the changes of size of the window.
			window.resize_actions.extend (~on_window_size)

			initialized := True
		end

	init_tools_list is
			-- Create and set up the list of tools that can be put on the left
			-- and on the bottom-right.
		do
			create left_tools.make (7)
			create bottom_tools.make (4)
		end

feature {EB_TOOL_MANAGER} -- Initialization

	build_interface is
			-- Build system widget.
		local
			cell: EV_CELL
			new_split_position: INTEGER
			max_split_position: INTEGER
			min_split_position: INTEGER
			stb: EV_STATUS_BAR
		do
			-- Build widgets -------------------------------------------

				-- Set up the favorites, the history, ...
			create favorites_manager.make (Current)
			set_favorites_manager (favorites_manager)
				-- The favorites manager is already collected by the favorites tool.
--			add_recyclable (favorites_manager)
			create cluster_manager.make (Current)
			set_cluster_manager (cluster_manager)
--			add_recyclable (cluster_manager)

				-- Set up the name of the window.
			set_title (Interface_names.t_Empty_development_window)
			set_minimized_title (Interface_names.t_Empty_development_window)

				-- Create the main container and the left + right panels.
			create container
			window.extend (container)
			create right_panel.make (Current, False, True)
			create left_panel.make (Current, window_preferences.left_panel_use_explorer_style, False)
			create panel
			panel.extend (left_panel.widget)
			panel.extend (right_panel.widget)
			panel.disable_item_expand (left_panel.widget)
			panel.enable_flat_separator
			left_panel.widget.resize_actions.extend (~on_size)

				-- Create the status bar.
			create status_bar.make
			add_recyclable (status_bar)

				-- Build all tools that can take place in this window.
			init_tools_list
			build_tools

			-- Build the layout -------------------------------------------

				-- Add the content of the window (left bar + right cell).
			container.extend (panel)

			new_split_position := window_preferences.left_panel_width
			min_split_position := panel.minimum_split_position
			max_split_position := panel.maximum_split_position
			splitter_position := new_split_position
--			panel.set_split_position (splitter_position.max (min_split_position).min (max_split_position))

				-- Add a cell for spacing (we cannot use padding: there are toolbars coming).
			create cell
			cell.set_minimum_height (2)
			container.extend (cell)
			container.disable_item_expand (cell)

				-- And the status bar.
			stb := status_bar.widget
			container.extend (stb)
			container.disable_item_expand (stb)
		end

feature {NONE} -- Initialization

	build_tools is
			-- Build all tools that can take place in this window and put them
			-- in `left_tools' or `bottom_tools'.
		deferred
		ensure
			tools_initialized: tools_initialized
		end

	init_toolbars is
			-- Create the toolbars, do not fill them.
		do
			create toolbars_area
			toolbars_area.set_padding (1)

			build_general_toolbar
			toolbars_area.extend (general_toolbar)
			toolbars_area.disable_item_expand (general_toolbar)

			build_address_toolbar
			toolbars_area.extend (address_toolbar)
			toolbars_area.disable_item_expand (address_toolbar)

			build_project_toolbar
			toolbars_area.extend (project_toolbar)
			toolbars_area.disable_item_expand (project_toolbar)
		end

	build_toolbars_area is
			-- Set up the toolbars area (general toolbar, address toolbar, ...).
		do
			create toolbars_area
			toolbars_area.set_padding (1)

			build_general_toolbar
			toolbars_area.extend (general_toolbar)
			toolbars_area.disable_item_expand (general_toolbar)

			build_address_toolbar
			toolbars_area.extend (address_toolbar)
			toolbars_area.disable_item_expand (address_toolbar)

			build_project_toolbar
			toolbars_area.extend (project_toolbar)
			toolbars_area.disable_item_expand (project_toolbar)
			
			view_menu.put_front (build_toolbar_menu)
		end
	
	build_general_toolbar is
			-- Set up the general toolbar (New, Save, Search, Shell, Undo, Redo, ...).
		deferred
		end
	
	build_address_toolbar is
			-- Set up the address toolbar (Back, Forward, Current, Class name, feature name, ...).
		deferred
		end

	build_project_toolbar is
			-- Build toolbar corresponding to the project options bar.
		deferred
		end

feature {NONE} -- Menus initializations

	build_menus is
			-- Build all menus.
		do
				-- Build the favorites menu.
			build_favorites_menu
			build_view_menu

				-- Build the other menus and the menu bar.
			Precursor
		end

	build_favorites_menu is
			-- Create and build `favorites_menu'.
		local
			conv_cst: CLASSI_STONE
		do
			favorites_menu := favorites_manager.menu
			conv_cst ?= stone
				-- We update the state of the `Add to Favorites' command.
			if conv_cst /= Void then
				favorites_menu.first.enable_sensitive
			else
				favorites_menu.first.disable_sensitive
			end
				-- The favorites menu is already collected by the favorites manager.
--			add_recyclable (favorites_menu)
		ensure
			favorites_menu_created: favorites_menu /= Void
		end

	build_view_menu is
			-- Create and build `view_menu'.
		require
			tools_initialized: tools_initialized
		local
			menu_sep: EV_MENU_SEPARATOR
		do
			create view_menu.make_with_text (Interface_names.m_View)

				-- Toolbars
			--view_menu.extend (build_toolbar_menu)

				-- Explorer Bar
			view_menu.extend (build_explorer_bar_menu)
	
				-- Separator
			create menu_sep
			view_menu.extend (menu_sep)
		ensure
			view_menu_created: view_menu /= Void
		end

	build_toolbar_menu: EV_MENU is
			-- Create and build a sub menu `toolbar_menu'.
		local
			menu_sep: EV_MENU_SEPARATOR
			menu: EV_MENU
			menu_item: EV_MENU_ITEM
			command_menu_item: EB_COMMAND_CHECK_MENU_ITEM
		do
			create menu.make_with_text (Interface_names.m_Toolbars)

				-- Available toolbars
			from
				show_toolbar_commands.start
			until
				show_toolbar_commands.after
			loop
				command_menu_item := show_toolbar_commands.item.new_menu_item
				command_menu_item.select_actions.extend (~save_toolbar_state)
				add_recyclable (command_menu_item)
				menu.extend (command_menu_item)

				show_toolbar_commands.forth
			end

				-- Separator ---------------------------
			create menu_sep
			menu.extend (menu_sep)

				-- Customize.
			create menu_item.make_with_text (Interface_names.m_Customize_general)
			menu_item.select_actions.extend (general_customizable_toolbar~customize)
			menu_item.select_actions.extend (~save_general_toolbar)
			menu.extend (menu_item)

			create menu_item.make_with_text (Interface_names.m_Customize_project)
			menu_item.select_actions.extend (project_customizable_toolbar~customize)
			menu_item.select_actions.extend (~save_project_toolbar)
			menu.extend (menu_item)

			Result := menu
		end

	build_explorer_bar_menu: EV_MENU is
			-- Build toolbar corresponding to available left panels.
		local
			menu_sep: EV_MENU_SEPARATOR
		do
			create Result.make_with_text (Interface_names.m_Explorer_bar)

				-- Left tools
			fill_explorer_bar_menu_with_list (Result, left_tools)

				-- Separator
			create menu_sep
			Result.extend (menu_sep)

				-- Bottom Tools
			fill_explorer_bar_menu_with_list (Result, bottom_tools)
		end

	build_menu_bar is
				-- Build the menu bar and put it into the window.
		local
			menu_bar: EV_MENU_BAR
		do
			create menu_bar
			menu_bar.extend (file_menu)
			menu_bar.extend (edit_menu)
			menu_bar.extend (view_menu)
			menu_bar.extend (tools_menu)
			menu_bar.extend (favorites_menu)
			menu_bar.extend (window_menu)
			menu_bar.extend (help_menu)

			window.set_menu_bar (menu_bar)
		end

feature -- Access

	left_tools: ARRAYED_LIST [EB_EXPLORER_BAR_ITEM]
			-- Tools under management that can be put in the left bar.
	
	bottom_tools: ARRAYED_LIST [EB_EXPLORER_BAR_ITEM]
			-- Tools under management that can be put on the right, below
			-- the editor.
			
	status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR
			-- Status bar.

feature -- Status setting

	left_tools_are_visible: BOOLEAN is
			-- Are tools visible ?
		do
			Result := not right_panel.is_maximized
		end

	hide_tools is
			-- Hide all tools.
			--| Used for optimization purposes, to avoid computing a lot
			--| when changing completely the display of the window.
		do
			panel.hide
		end

	show_tools is
			-- Show all tools.
		do
			panel.show
		end

feature -- Memory management

	destroy_imp is
			-- Recycle `Current', and leave it in an unstable state, 
			-- so that we know whether we are really not referenced any more.
		do
			toolbars_area.wipe_out
--			view_menu.wipe_out
			panel.wipe_out
			container.wipe_out
				--	All these components are automatically recycled through add_recyclable.
--			favorites_manager.recycle
--			cluster_manager.recycle
--			favorites_menu.recycle
			general_customizable_toolbar.recycle
				-- Recycle the history manager.
				-- This is called polymorphically by EV_WINDOW.
--			recycle
--			history_manager.recycle
			view_menu.destroy
			Precursor {EB_WINDOW}
			toolbars_area.destroy
			panel.destroy
			container.destroy
		end

feature {EB_DEBUGGER_MANAGER} -- Explorer bars

	left_panel: EB_EXPLORER_BAR
			-- Left panel: contains one of the item of `left_tools': the favorites, 
			-- the clusters tree, the features tree, ... or Void if it
			-- contains nothing and is not displayed.

	right_panel: EB_EXPLORER_BAR
			-- Right panel: typically contains the editor and the context area.
			-- The right panel is always displayed and is therefore never Void
			-- (see invariant).

	panel: EB_HORIZONTAL_SPLIT_AREA
			-- Main panel. It can be either a EV_HORIZONTAL_SPLIT_AREA or an EV_CELL.
			-- It depends whether the left explorer bar is displayed or not.
			--
			-- Panel contains `left_panel' and `right_panel' if it's a split area,
			-- `right_panel' only if it's a cell.

feature {NONE} -- Vision2 architechture

	container: EV_VERTICAL_BOX
			-- Main container. It contains everything that appears in the window:
			-- The toolbars area and the panel.

	toolbars_area: EV_VERTICAL_BOX
			-- Area where toolbars will be displayed.

	general_toolbar: EV_VERTICAL_BOX
			-- General toolbar (Edit operation, compile operation, selectors, ...).

	general_customizable_toolbar: EB_TOOLBAR
			-- Customizable part of `general_toolbar'.

	project_customizable_toolbar: EB_TOOLBAR
			-- Customizable part of `project_toolbar'.

	address_toolbar: EV_VERTICAL_BOX
			-- Address toolbar (Back, forth, Class name, feature name, format type).
			-- The vertical box contains the separator and then the toolbar.

	project_toolbar: EV_VERTICAL_BOX
			-- Project toolbar
			-- The vertical box contains the separator and then the toolbar.

feature {NONE} -- Menus.

	favorites_menu: EB_FAVORITES_MENU
			-- Menu representing the favorites.

	view_menu: EV_MENU
			-- Menu representing the different selectable views.

feature -- Favorites & History handling.

	favorites_manager: EB_FAVORITES_MANAGER
			-- Graphical manager for favorites, contains the favorites
			-- tree (`favorites_window') and the favorites menu.

	cluster_manager: EB_CLUSTER_MANAGER
			-- Graphical manager for clusters and classes, contains the cluster tree.

	set_favorites_manager (a_favorites_manager: EB_FAVORITES_MANAGER) is
			-- Set `favorites_manager' to `a_favorites_manager'.
		do
			favorites_manager := a_favorites_manager
		end

	set_cluster_manager (a_cluster_manager: EB_CLUSTER_MANAGER) is
			-- Set `cluster_manager' to `a_cluster_manager'.
		do
			cluster_manager := a_cluster_manager
		end

feature -- Explorer bar handling.

	splitter_position: INTEGER
			-- Position of the main splitter.

	display_bar (a_bar: EB_EXPLORER_BAR) is
			-- Switch the current view to `a_bar'.
		do
			if
				(a_bar.widget.parent = Void) and
				(not other_bar (a_bar).is_maximized) and 
				a_bar.is_show_requested
			then
				if a_bar = left_panel then
					panel.set_first (left_panel.widget)
				else
					panel.set_second (right_panel.widget)
				end
				if panel.full then
					panel.set_split_position (splitter_position.max (panel.minimum_split_position).min (panel.maximum_split_position))
				end
			end
		end

	force_display_bar (a_bar: EB_EXPLORER_BAR) is
			-- Switch the current view to `a_bar', even if the other bar is maximized.
		do
			if
				(a_bar.widget.parent = Void) and
				(other_bar (a_bar).is_maximized)
			then
					-- Unmaximize the other bar.
				other_bar (a_bar).unmaximize
			end
			if
				(a_bar.widget.parent /= Void) and
				(a_bar.is_maximized)
			then
				a_bar.unmaximize
			end
			if
				(a_bar.widget.parent = Void) and
				a_bar.is_show_requested
			then
				if a_bar = left_panel then
					panel.set_first (left_panel.widget)
				else
					panel.set_second (right_panel.widget)
				end
				if panel.full then
					panel.set_split_position (splitter_position.max (panel.minimum_split_position).min (panel.maximum_split_position))
				end
			end
		end

	close_bar (a_bar: EB_EXPLORER_BAR) is
			-- An explorer bar asks to be closed.
		do
			if (a_bar.widget.parent /= Void) then
				if other_bar (a_bar).widget.parent /= Void then
					splitter_position := panel.split_position
				end
				panel.prune_all (a_bar.widget)
			end
		end

	close_all_bars_except (a_bar: EB_EXPLORER_BAR) is
			-- An explorer bar item asks to be maximized.
		do
			close_bar (other_bar (a_bar))
		end

	restore_bars is
			-- A maximized item has been restored.
		do
			if left_panel.widget.parent = Void then
				display_bar (left_panel)
			end
			if right_panel.widget.parent = Void then
				display_bar (right_panel)
			end
		end

	other_bar (a_bar: EB_EXPLORER_BAR): EB_EXPLORER_BAR is
			-- If `a_bar' is `left_panel', return `right_panel' and vice versa.
		do
			if left_panel = a_bar then
				Result := right_panel
			else
				Result := left_panel
			end
		end

feature {NONE} -- Implementation

	fill_explorer_bar_menu_with_list (a_menu: EV_MENU; a_list: ARRAYED_LIST [EB_EXPLORER_BAR_ITEM]) is
			-- Fill `a_menu' with the list of explorer bar iten `a_list'.
		local
			menu_item: EB_COMMAND_CHECK_MENU_ITEM
			bar_item: EB_EXPLORER_BAR_ITEM
		do
			from
				a_list.start
			until
				a_list.after
			loop
				bar_item := a_list.item
					-- We only generate an entry for closeable explorer bars
					-- (the editor is not closeable and has no entry).
				if bar_item.is_closeable then
					menu_item ?= a_list.item.associated_command.new_menu_item
					if menu_item /= Void then
						add_recyclable (menu_item)
						a_menu.extend (menu_item)
					end
				end
				a_list.forth
			end
		end

	on_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Save the size of the window and the main layout.
		do
			if initialized then
				window_preferences.save_left_panel_width (panel.split_position)
	
					-- Save width & height.
				window_preferences.save_size (window.width, window.height, window.is_maximized)
			end
		end

	on_window_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Save the size of the window and the main layout.
		do
			if panel.full then
				panel.set_split_position (Window_preferences.left_panel_width.max (
					panel.minimum_split_position).min (panel.maximum_split_position))
			end
			on_size (a_x, a_y, a_width, a_height)
		end

feature {NONE} -- Implementation / Commands

	show_tool_commands: ARRAYED_LIST [EB_SHOW_TOOL_COMMAND]
			-- Commands to show/hide a tool.

	show_toolbar_commands: ARRAYED_LIST [EB_SHOW_TOOLBAR_COMMAND]
			-- Commands to show/hide a toolbar.

	show_general_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			-- Command to show/hide the general toolbar.

	show_project_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			-- Command to show/hide the project toolbar.

	show_address_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			-- Command to show/hide the address toolbar.

	save_general_toolbar is
			-- Save the apparence of the general toolbar in the registry (or in .es5rc)
		do
			if general_customizable_toolbar.changed then
				window_preferences.save_general_toolbar (general_customizable_toolbar, show_general_toolbar_command.is_visible)
			end
		end

	save_project_toolbar is
			-- Save the apparence of the project toolbar in the registry (or in .es5rc)
		do
			if project_customizable_toolbar.changed then
				debugger_manager.save_interface (project_customizable_toolbar)
			end
		end

	save_toolbar_state is
			-- Write in the preferences whether to display the toolbars or not.
		do
			window_preferences.set_boolean ("development_window__show_general_toolbar", show_general_toolbar_command.is_visible)
			window_preferences.set_boolean ("development_window__show_address_toolbar", show_address_toolbar_command.is_visible)
			window_preferences.set_boolean ("development_window__show_project_toolbar", show_project_toolbar_command.is_visible)
			window_preferences.resources.save
		end

feature {NONE} -- Initialization flags

	tools_initialized: BOOLEAN
			-- Are the tools initialized?

	recycle is
			-- Destroy `Current'.
		do
			Precursor {EB_HISTORY_OWNER}
			Precursor {EB_WINDOW}
		end

feature {NONE} -- Constants

	Frame_constants: EV_FRAME_CONSTANTS is
			-- Default constants for Frame look.
		once
			create Result
		end
	
	Default_colors: EV_STOCK_COLORS is
			-- Default Vision2 colors.
		once	
			create Result
		end

	window_preferences: EB_DEVELOPMENT_WINDOW_DATA is
			-- Preferences for the development window.
		once
			create Result
		end

end -- class EB_TOOL_MANAGER
