indexing
	description	: "$EiffelGraphicalCompiler$ window. Ancestor of all windows in $EiffelGraphicalCompiler$."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_WINDOW

inherit
	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	SHARED_PLATFORM_CONSTANTS
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	EB_RECYCLER
		rename
			destroy as destroy_recyclable_items
		export
			{NONE} all
		end
	
feature {NONE} -- Initialization

	make is
			-- Create a new window.
		do
				-- Vision2 initialization
			create window
			init_size_and_position
			window.close_request_actions.wipe_out
			window.close_request_actions.put_front (~destroy)
			window.set_icon_pixmap (pixmap)

				-- Initialize commands and connect them.
			init_commands

				-- Build widget system & menus.
			build_interface
			build_menus

				-- Set up the minimize title if it's not done
			if minimized_title = Void or else minimized_title.is_empty then
				set_minimized_title (title)
			end
			create help_engine.make

			window.focus_in_actions.extend (window_manager~set_focused_window (Current))
		
			initialized := True
		end

	init_size_and_position is
			-- Initialize the size and position of the window.
		do
			--| redefine this feature if you want to set a particular
			--| size or position at launch time.
		end

	init_commands is
			-- Initialize commands.
		do
			create show_dynamic_lib_tool.make
		end

	build_interface is
			-- Build all the windows widgets.
		deferred
		end

	build_menus is
			-- Build all menus.
		do
				-- Build each menu
			build_file_menu
			build_edit_menu
			build_window_menu
			build_help_menu

				-- Build the menu bar.
			build_menu_bar
		end

feature -- Access

	window: EB_VISION_WINDOW
			-- Window representing Current.

	new_menu: EV_MENU is
			-- Menu to be used as a context menu displaying associated commands.
		local
			item: EV_MENU_ITEM
			sep: EV_MENU_SEPARATOR
		do
			create Result
			create item.make_with_text (Interface_names.m_Close)
			item.select_actions.extend (~destroy)
			Result.extend (item)
			create item.make_with_text (Interface_names.m_Minimize)
			item.select_actions.extend (window~minimize)
			if window.is_minimized then
				item.disable_sensitive
			end
			Result.extend (item)
			create item.make_with_text (Interface_names.m_Maximize)
			item.select_actions.extend (window~maximize)
			if window.is_maximized then
				item.disable_sensitive
			end
			Result.extend (item)
			create item.make_with_text (Interface_names.m_Raise)
			item.select_actions.extend (~raise)
			Result.extend (item)

			create sep
			Result.extend (sep)
		
			create item.make_with_text (Interface_names.m_New_window)
			item.select_actions.extend (window_manager~create_window)
			Result.extend (item)
		end

feature -- Status report

	title: STRING
			-- Title of the window

	minimized_title: STRING
			-- Title of the window in minimized state

	pixmap: EV_PIXMAP is
			-- Pixmap for current window.
		deferred
		end

feature -- Status setting

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		require
			valid_title: a_title /= Void
		do
			if not equal (title, a_title) then
				title := a_title
				window.set_title (a_title)
				
					-- By default, the minimized title is the title.
				set_minimized_title (a_title)

					-- Notify the window manager of a change in this window.
				window_manager.record_window_change (Current)
			end
		end

	set_minimized_title (a_title: STRING) is
			-- Set `minimized_title' to `a_title'.
		do
			if not equal (minimized_title, a_title) then
				minimized_title := a_title
				window.set_icon_name (a_title)

					-- Notify the window manager of a change in this window.
				window_manager.record_window_change (Current)
			end
		end

	lock_update is
			-- Lock updates for this window on certain platforms until
			-- `unlock_update' is called.
			--
			-- Note: The window cannot be moved while update is locked.
		do
			if (create {EV_ENVIRONMENT}).application.locked_window = Void then
				window.lock_update
			end			
		end

	unlock_update is
			-- Unlock updates for this window on certain platforms.
		do
			if (create {EV_ENVIRONMENT}).application.locked_window = window then
				window.unlock_update
			end
		end

feature -- Window management / Status Report

	destroyed: BOOLEAN
			-- Is Current destroyed?

	is_visible: BOOLEAN is
			-- Is Current shown on the screen?
		require
			exists: not destroyed
		do
			Result := window.is_show_requested
		end

feature -- Window management / Status Setting

	show is
			-- Make tool visible.
		require
			exists: not destroyed
		do
			window_manager.show_window (Current)
		ensure
			shown: is_visible
		end

	raise is
			-- Raise window in front, bringing it into focus.
		require
			exists: not destroyed
		do
			window_manager.raise_window (Current)
		ensure
			shown: is_visible
		end

	hide is
			-- Hide current window.
		require
			exists: not destroyed
		do
			window_manager.hide_window (Current)
		ensure
			hidden: not is_visible
		end

	destroy is
			-- Destroy Current window.
		local
			cd: EV_CONFIRMATION_DIALOG
		do
			if not destroyed then
				if debugger_manager.debugging_window = Current then
					Exit_application_cmd.set_already_save_confirmed (True)
					if Window_manager.development_windows_count > 1 then
						create cd.make_with_text (Warning_messages.w_Closing_stops_debugger)
					else
						create cd.make_with_text (Warning_messages.w_Exiting_stops_debugger)
					end
					cd.button ("OK").select_actions.extend (window_manager~destroy_window (Current))
					cd.show_modal_to_window (window)
				else
					window_manager.destroy_window (Current)
				end
			end
			Exit_application_cmd.set_already_save_confirmed (False)
		end

	refresh is
			-- Refresh window after a compilation, resynchronize everything.
		require
			exists: not destroyed
		do
			--| By default do nothing.			
		end

feature {EB_WINDOW_MANAGER} -- Window management / Implementation

	show_imp is
			-- Make window visible.
		do
			window.show
		end

	raise_imp is
			-- Raise window in front, bringing it into focus.
		do
			window.show
			--| FIXME ARNAUD: The Focus...
		end

	hide_imp is
			-- Hide window.
		do
			window.hide
		end

	destroy_imp is
			-- Destroy window.
		do
			window_manager.remove_observer (window_menu)
			destroy_recyclable_items
			edit_menu.destroy
			file_menu.destroy
			help_menu.destroy
				-- The tools menu is never created?!
--			tools_menu.destroy
			destroyed := True
			window.destroy
			window := Void
		end

feature {NONE} -- Controls & widgets

	file_menu: EV_MENU
			-- "File" menu

	edit_menu: EV_MENU
			-- "Edit" menu

	tools_menu: EV_MENU
			-- "Tools" menu

	window_menu: EB_WINDOW_MANAGER_MENU
			-- "Window" menu

	help_menu: EV_MENU
			-- "Help" menu

feature {NONE} -- Menus initializations

	build_file_menu is
			-- Create and build `file_menu'.
		local
			menu_item: EV_MENU_ITEM
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			create file_menu.make_with_text (Interface_names.m_File)

			create menu_item.make_with_text (Interface_names.m_Close)
			menu_item.select_actions.extend (~destroy)
			file_menu.extend (menu_item)

			command_menu_item := Exit_application_cmd.new_menu_item
			add_recyclable (Command_menu_item)
			file_menu.extend (command_menu_item)
		ensure
			file_menu_created: file_menu /= Void
		end

	build_edit_menu is
			-- Create and build `edit_menu'
		do
			create edit_menu.make_with_text (Interface_names.m_Edit)
		ensure
			edit_menu_created: edit_menu /= Void
		end
	
	build_tools_menu is
			-- Create and build `tools_menu'
		local
			show_profiler: EB_SHOW_PROFILE_TOOL
			menu_item: EV_MENU_ITEM
			command_menu_item: EB_COMMAND_MENU_ITEM
		do
			create tools_menu.make_with_text (Interface_names.m_Tools)

					-- Dynamic Library Window
			create menu_item.make_with_text (Interface_names.m_New_dynamic_lib)
			menu_item.select_actions.extend (show_dynamic_lib_tool~execute)
			tools_menu.extend (menu_item)

					-- Profiler Window
			create show_profiler
			create menu_item.make_with_text (Interface_names.m_Profile_tool)
			menu_item.select_actions.extend (show_profiler~execute)
			tools_menu.extend (menu_item)

					-- Precompile Wizard
			command_menu_item := wizard_precompile_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)

			tools_menu.extend (create {EV_MENU_SEPARATOR})

					-- Preferences
			command_menu_item := Show_preferences_cmd.new_menu_item
			add_recyclable (command_menu_item)
			tools_menu.extend (command_menu_item)
		ensure
			tools_menu_created: tools_menu /= Void
		end
	
	build_window_menu is
			-- Create and build `edit_menu'
		do
			window_menu := window_manager.new_menu
			add_recyclable (window_menu)
		ensure
			window_menu_created: window_menu /= Void
		end
	
	build_help_menu is
			-- Create and build `help_menu'
		local
			menu_item: EV_MENU_ITEM
			about_cmd: EB_ABOUT_COMMAND
			menu_sep: EV_MENU_SEPARATOR
		do
			create help_menu.make_with_text (Interface_names.m_Help)

				-- Guided Tour
			create menu_item.make_with_text (Interface_names.m_Guided_tour)
			menu_item.select_actions.extend (~display_guided_tour)
			help_menu.extend (menu_item)

				-- Contents
			create menu_item.make_with_text (Interface_names.m_Contents)
			menu_item.select_actions.extend (~display_help_contents)
			help_menu.extend (menu_item)

				-- How to's
			create menu_item.make_with_text (Interface_names.m_How_to_s)
			menu_item.select_actions.extend (~display_how_to_s)
			help_menu.extend (menu_item)

				-- Eiffel introduction
			create menu_item.make_with_text (Interface_names.m_Eiffel_introduction)
			menu_item.select_actions.extend (~display_eiffel_introduction)
			help_menu.extend (menu_item)

				-- Add the separator
			create menu_sep
			help_menu.extend (menu_sep)

				-- About
			create menu_item.make_with_text (Interface_names.m_About)
			create about_cmd
			menu_item.select_actions.extend (about_cmd~execute) 
			help_menu.extend (menu_item)
		ensure
			help_menu_created: help_menu /= Void
		end

	build_menu_bar is
				-- Build the menu bar and put it into the window.
		local
			menu_bar: EV_MENU_BAR
		do
			create menu_bar
			menu_bar.extend (file_menu)
			menu_bar.extend (edit_menu)
			menu_bar.extend (tools_menu)
			menu_bar.extend (window_menu)
			menu_bar.extend (help_menu)

			window.set_menu_bar (menu_bar)
		end

feature {EB_WINDOW_MANAGER} -- Commands

	show_dynamic_lib_tool: EB_STANDARD_CMD
			-- Command to display the dynamic library editor.

feature {NONE} -- Implementation / Flags

	initialized: BOOLEAN
			-- Is the "initialization sequence" finished?

	help_csts: EB_HELP_CONTEXTS_BASES is
			-- Shared constants for the help URLs
		once
			create Result
		end

	help_engine: EB_HELP_ENGINE
			-- Help engine used to display help pages.

	display_help (ctxt: EB_HELP_CONTEXT) is
			-- Pop up the eiffelstudio chm at the URL corresponding to `ctxt'.
		require
			valid_ctxt: ctxt /= Void
		local
			wd: EV_WARNING_DIALOG
		do
			help_engine.show (ctxt)
			if not help_engine.last_show_successful then
				create wd.make_with_text (help_engine.last_error_message)
				wd.show_modal_to_window (window)
			end
		end

	display_help_contents is
			-- Display the part of the help relative to EiffelStudio.
		local
			ctxt: EB_HELP_CONTEXT
		do
			create ctxt.make (help_csts.Hc_reference, "")
			display_help (ctxt)
		end

	display_how_to_s is
			-- Display the part of the help relative to EiffelStudio.
		local
			ctxt: EB_HELP_CONTEXT
		do
			create ctxt.make (help_csts.Hc_how_to_s, "")
			display_help (ctxt)
		end

	display_guided_tour is
			-- Display the guided tour of EiffelStudio.
		local
			ctxt: EB_HELP_CONTEXT
		do
			create ctxt.make (help_csts.Hc_guided_tour, "")
			display_help (ctxt)
		end

	display_eiffel_introduction is
			-- Display the introduction to Eiffel.
		local
			ctxt: EB_HELP_CONTEXT
		do
			create ctxt.make (help_csts.Hc_root, "general/guided_tour/language/")
			display_help (ctxt)
		end

feature -- Obsolete

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		obsolete
			"use `is_visible' instead"
		do
			Result := window.is_show_requested
		end

end -- class EB_WINDOW

