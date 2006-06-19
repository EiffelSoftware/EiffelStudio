indexing
	description	: "Window containing several tools"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

	ES_TOOLBAR_PREFERENCE
		undefine
			default_create
		end

feature {NONE} -- Initialization

	make is
			-- Create a new development window.
		do
			Precursor {EB_WINDOW}
			initialized := False -- Reset the flag since initializion is not yet complete.

			initialized := True
		end

	init_tools_list is
			-- Create and set up the list of tools that can be put on the left
			-- and on the bottom-right.
		do
--			create left_tools.make (7)
--			create bottom_tools.make (4) Ted
			create left_tools.make (6)
			create bottom_tools.make (5)
		end

feature {EB_TOOL_MANAGER} -- Initialization

	build_interface is
			-- Build system widget.
		local
			cell: EV_CELL
			new_split_position: INTEGER
			min_split_position: INTEGER
			stb: EV_STATUS_BAR
		do
			-- Build widgets -------------------------------------------

				-- Set up the favorites, the history, ...
			create favorites_manager.make (Current)
			set_favorites_manager (favorites_manager)
				-- The favorites manager is already collected by the favorites tool.
			add_recyclable (favorites_manager)
			create cluster_manager.make (Current)
			set_cluster_manager (cluster_manager)
			add_recyclable (cluster_manager)

				-- Set up the name of the window.
			set_title (Interface_names.t_Empty_development_window)
			set_minimized_title (Interface_names.t_Empty_development_window)

				-- Create the main container and the left + right panels.
			create container
			window.extend (container)
			create right_panel.make (Current, False, True)
			right_panel.enable_top_widget_resizing
			right_panel.set_maximize_pixmap (pixmaps.mini_pixmaps.toolbar_maximize_icon)
			right_panel.set_minimize_pixmap (pixmaps.mini_pixmaps.toolbar_minimize_icon)
			right_panel.set_restore_pixmap (pixmaps.mini_pixmaps.toolbar_restore_icon)
			right_panel.set_close_pixmap (pixmaps.mini_pixmaps.toolbar_close_icon)
			create left_panel.make (Current, preferences.development_window_data.left_panel_use_explorer_style, False)
			left_panel.set_maximize_pixmap (pixmaps.mini_pixmaps.toolbar_maximize_icon)
			left_panel.set_minimize_pixmap (pixmaps.mini_pixmaps.toolbar_minimize_icon)
			left_panel.set_restore_pixmap (pixmaps.mini_pixmaps.toolbar_restore_icon)
			left_panel.set_close_pixmap (pixmaps.mini_pixmaps.toolbar_close_icon)
			left_panel.enable_top_widget_resizing
			create panel
				-- As the side on which panels are displayed may be swapped,
				-- this must be taken into account.
			if editor_left_side_cell.item then
				panel.extend (right_panel)
				panel.extend (left_panel)
			else
				panel.extend (left_panel)
				panel.extend (right_panel)
			end
			update_expanded_state_of_panel

				-- Create the status bar.
			create status_bar.make
			add_recyclable (status_bar)

				-- Build all tools that can take place in this window.
			init_tools_list
			build_tools

			-- Build the layout -------------------------------------------

				-- Add the content of the window (left bar + right cell).
			container.extend (panel)

			new_split_position := preferences.development_window_data.left_panel_width
			min_split_position := panel.minimum_split_position
			splitter_position := new_split_position
--			panel.set_split_position (splitter_position.max (min_split_position))

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

			build_refactoring_toolbar
			toolbars_area.extend (refactoring_toolbar)
			toolbars_area.disable_item_expand (refactoring_toolbar)

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

	build_refactoring_toolbar is
			-- Build toolbar for the refactorings.
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
			add_recyclable (favorites_menu)
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
			menu_item: EV_MENU_ITEM
			command_menu_item: EB_COMMAND_CHECK_MENU_ITEM
		do
			create Result.make_with_text (Interface_names.m_Toolbars)

				-- Available toolbars
			from
				show_toolbar_commands.start
			until
				show_toolbar_commands.after
			loop
				command_menu_item := show_toolbar_commands.item.new_menu_item
				command_menu_item.select_actions.extend (agent save_toolbar_state)
				add_recyclable (command_menu_item)
				Result.extend (command_menu_item)

				show_toolbar_commands.forth
			end

				-- Separator ---------------------------
			create menu_sep
			Result.extend (menu_sep)

				-- Customize.
			create menu_item.make_with_text (Interface_names.m_Customize_general)
			menu_item.select_actions.extend (agent general_customizable_toolbar.customize)
			menu_item.select_actions.extend (agent save_general_toolbar)
			Result.extend (menu_item)

			create menu_item.make_with_text (Interface_names.m_Customize_project)
			menu_item.select_actions.extend (agent project_customizable_toolbar.customize)
			menu_item.select_actions.extend (agent save_project_toolbar)
			Result.extend (menu_item)

			create menu_item.make_with_text (Interface_names.m_Customize_refactoring)
			menu_item.select_actions.extend (agent refactoring_customizable_toolbar.customize)
			menu_item.select_actions.extend (agent save_refactoring_toolbar)
			Result.extend (menu_item)
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

	hide_tools is
			-- Hide all tools.
			--| Used for optimization purposes, to avoid computing a lot
			--| when changing completely the display of the window.
		do
			status_bar.widget.hide
			panel.hide
		end

	show_tools is
			-- Show all tools.
		do
			panel.show
			status_bar.widget.show
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
			project_customizable_toolbar.recycle
			refactoring_customizable_toolbar.recycle
				-- Recycle the history manager.
				-- This is called polymorphically by EV_WINDOW.
--			recycle
--			history_manager.recycle
			view_menu.destroy
			Precursor {EB_WINDOW}
			refactoring_toolbar.destroy
			toolbars_area.destroy
			panel.destroy
			container.destroy

			address_toolbar := Void
			project_toolbar := Void
			refactoring_toolbar := Void
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

	panel: EV_HORIZONTAL_SPLIT_AREA
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

	refactoring_customizable_toolbar: EB_TOOLBAR
			-- Customizable part of `refactoring_toolbar'.

	address_toolbar: EV_VERTICAL_BOX
			-- Address toolbar (Back, forth, Class name, feature name, format type).
			-- The vertical box contains the separator and then the toolbar.

	project_toolbar: EV_VERTICAL_BOX
			-- Project toolbar
			-- The vertical box contains the separator and then the toolbar.

	refactoring_toolbar: EV_VERTICAL_BOX
			-- Refactoring toolbar
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
				(a_bar.parent = Void) and
				(not other_bar (a_bar).is_maximized) and
				a_bar.is_show_requested
			then
				if a_bar = left_panel then
					if Editor_left_side_cell.item then
						panel.set_second (left_panel)
					else
						panel.set_first (left_panel)
					end
				else
					if Editor_left_side_cell.item then
						panel.set_first (right_panel)
					else
						panel.set_second (right_panel)
					end
				end

				if panel.full then
					update_expanded_state_of_panel
					panel.set_split_position (splitter_position.max (panel.minimum_split_position))
				end
			end
		end

	force_display_bar (a_bar: EB_EXPLORER_BAR) is
			-- Switch the current view to `a_bar', even if the other bar is maximized.
		do
			if
				(a_bar.parent = Void) and
				(other_bar (a_bar).is_maximized)
			then
					-- Unmaximize the other bar.
				other_bar (a_bar).unmaximize
			end
			if
				(a_bar.parent /= Void) and
				(a_bar.is_maximized)
			then
				a_bar.unmaximize
			end
			if
				(a_bar.parent = Void) and
				a_bar.is_show_requested
			then
				if a_bar = left_panel then
					if Editor_left_side_cell.item then
						panel.set_second (left_panel)
					else
						panel.set_first (left_panel)
					end
				else
					if Editor_left_side_cell.item then
						panel.set_first (right_panel)
					else
						panel.set_second (right_panel)
					end
				end
				if panel.full then
					update_expanded_state_of_panel
					panel.set_split_position ((splitter_position.max (panel.minimum_split_position)).min (panel.maximum_split_position))
				end
			end
		end

	update_expanded_state_of_panel is
			-- If `panel' `is_full', update expanded status of widgets
			-- based on `editor_left_side_cell'. This must be performed
			-- after insertions or updates to `panel', ensuring that the
			-- non editor side does not resize when `panel' is enlarged.
		do
			if panel.full then
				if editor_left_side_cell.item then
					panel.enable_item_expand (panel.first)
					panel.disable_item_expand (panel.second)
				else
					panel.enable_item_expand (panel.second)
					panel.disable_item_expand (panel.first)
				end
			end
		end

	close_bar (a_bar: EB_EXPLORER_BAR) is
			-- An explorer bar asks to be closed.
		do
			if (a_bar.parent /= Void) then
				if other_bar (a_bar).parent /= Void then
					splitter_position := panel.split_position
				end
				panel.prune_all (a_bar)
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
				-- Do not force the bar to be shown if it is empty, as
				-- in that state it should be hidden.
			if left_panel.parent = Void and left_panel.count /= 0 then
				display_bar (left_panel)
			end
			if right_panel.parent = Void and right_panel.count /= 0 then
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

feature {NONE} -- Implementation / Commands

	show_tool_commands: ARRAYED_LIST [EB_SHOW_TOOL_COMMAND]
			-- Commands to show/hide a tool.

	show_toolbar_commands: ARRAYED_LIST [EB_SHOW_TOOLBAR_COMMAND]
			-- Commands to show/hide a toolbar.

	show_general_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			-- Command to show/hide the general toolbar.

	show_project_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			-- Command to show/hide the project toolbar.

	show_refactoring_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			-- Command to show/hide the refactoring toolbar.

	show_address_toolbar_command: EB_SHOW_TOOLBAR_COMMAND
			-- Command to show/hide the address toolbar.

	save_general_toolbar is
			-- Save the apparence of the general toolbar in the registry (or in .es5rc)
		do
			if general_customizable_toolbar.changed then
				preferences.development_window_data.general_toolbar_layout_preference.set_value (save_toolbar (general_customizable_toolbar))
				preferences.development_window_data.show_general_toolbar_preference.set_value (show_general_toolbar_command.is_visible)
				preferences.development_window_data.show_text_in_general_toolbar_preference.set_value (general_customizable_toolbar.is_text_important)
				preferences.development_window_data.show_all_text_in_general_toolbar_preference.set_value (general_customizable_toolbar.is_text_displayed)
			end
		end

	save_project_toolbar is
			-- Save the apparence of the project toolbar in the registry (or in .es5rc)
		do
			if project_customizable_toolbar.changed then
				Eb_debugger_manager.save_interface (project_customizable_toolbar)
			end
		end

	save_refactoring_toolbar is
			-- Save the apparence of the refactoring toolbar.
		do
			if refactoring_customizable_toolbar.changed then
				preferences.development_window_data.refactoring_toolbar_layout_preference.set_value (save_toolbar (refactoring_customizable_toolbar))
				preferences.development_window_data.show_refactoring_toolbar_preference.set_value (show_refactoring_toolbar_command.is_visible)
				preferences.development_window_data.show_text_in_refactoring_toolbar_preference.set_value (refactoring_customizable_toolbar.is_text_important)
				preferences.development_window_data.show_all_text_in_refactoring_toolbar_preference.set_value (refactoring_customizable_toolbar.is_text_displayed)
			end
		end


	save_toolbar_state is
			-- Write in the preferences whether to display the toolbars or not.
		do
			preferences.development_window_data.show_general_toolbar_preference.set_value (show_general_toolbar_command.is_visible)
			preferences.development_window_data.show_address_toolbar_preference.set_value (show_address_toolbar_command.is_visible)
			preferences.development_window_data.show_project_toolbar_preference.set_value (show_project_toolbar_command.is_visible)
			preferences.development_window_data.show_refactoring_toolbar_preference.set_value (show_refactoring_toolbar_command.is_visible)
--			preference.preferences.save
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

	editor_left_side_cell: CELL [BOOLEAN] is
			-- Is Editor and associated tools displayed on left side of window?
		once
			create Result.put (preferences.misc_data.editor_left_side)
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

end -- class EB_TOOL_MANAGER
