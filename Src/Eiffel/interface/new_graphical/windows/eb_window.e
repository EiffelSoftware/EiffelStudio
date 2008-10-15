indexing
	description	: "$EiffelGraphicalCompiler$ window. Ancestor of all windows in $EiffelGraphicalCompiler$."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_WINDOW

inherit
	ANY

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

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_RECYCLABLE
		redefine
			internal_detach_entities
		end

	EB_SHARED_DEBUGGER_MANAGER

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

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

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the button has became useless.
		do
			if window_menu /= Void then
				window_manager.remove_observer (window_menu)
			end
			if edit_menu /= Void then
				edit_menu.destroy
			end
			if file_menu /= Void then
				file_menu.destroy
			end
			if help_menu /= Void then
				help_menu.destroy
			end
			if window /= Void then
				window.destroy
			end
		end

	internal_detach_entities
			-- Detaches objects from their container
		do
			Precursor {EB_RECYCLABLE}
			window := Void
			edit_menu := Void
			help_menu := Void
			file_menu := Void
		ensure then
			window_detached: window = Void
			edit_menu_detached: edit_menu = Void
			help_menu_detached: help_menu = Void
			file_menu_detached: file_menu = Void
		end

feature -- Access

	window: EB_VISION_WINDOW
			-- Window representing Current.

	new_menu: EV_MENU is
			-- Menu to be used as a context menu displaying associated commands.
		require
			window_not_void: window /= Void
			window_not_destroyed: not window.is_destroyed
		local
			item: EV_MENU_ITEM
			sep: EV_MENU_SEPARATOR
		do
			create Result
			create item.make_with_text (Interface_names.m_Close_short)
			item.select_actions.extend (agent destroy)
			Result.extend (item)
			create item.make_with_text (Interface_names.m_Minimize)
			item.select_actions.extend (agent window.minimize)
			if window.is_minimized then
				item.disable_sensitive
			end
			Result.extend (item)
			create item.make_with_text (Interface_names.m_Maximize)
			item.select_actions.extend (agent window.maximize)
			if window.is_maximized then
				item.disable_sensitive
			end
			Result.extend (item)
			create item.make_with_text (Interface_names.m_Raise)
			item.select_actions.extend (agent show)
			Result.extend (item)

			create sep
			Result.extend (sep)

			create item.make_with_text (Interface_names.m_New_window)
			item.select_actions.extend (agent window_manager.create_window)
			Result.extend (item)
		end

feature -- Status report

	title: STRING_GENERAL
			-- Title of the window

	minimized_title: STRING_GENERAL
			-- Title of the window in minimized state

	pixmap: EV_PIXMAP is
			-- Pixmap for current window.
		deferred
		end

feature -- Status setting

	set_title (a_title: like title) is
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

	set_minimized_title (a_title: like title) is
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
			if lock_level = 0 then
				if ev_application.locked_window = Void and then window /= Void then
					window.lock_update
					unlock_needed := True
				else
					unlock_needed := False
				end
			end
			lock_level := lock_level + 1
		ensure
			lock_level_incremented: lock_level = old lock_level + 1
		end

	unlock_update is
			-- Unlock updates for this window on certain platforms.
		require
			lock_level_positive: lock_level > 0
		do
			lock_level := lock_level - 1
			if unlock_needed and then lock_level = 0 and then ev_application.locked_window = window then
				window.unlock_update
			end
		ensure
			lock_level_decremented: lock_level = old lock_level - 1
		end

feature -- Window management / Status Report

	unlock_needed: BOOLEAN
			-- Should call to `unlock_update' have an effect?

	lock_level: INTEGER
			-- Number of times `lock_update' has been called. So that `unlock_update' is only called once.

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
			-- Show current window.
		require
			exists: not destroyed
		do
			window_manager.show_window (Current)
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
			l_window: EB_WINDOW
		do
			if not destroyed then
				Exit_application_cmd.set_already_confirmed (False)
				l_window := Current
				if
					Debugger_manager.application_is_executing and then
					Eb_debugger_manager.debugging_window = l_window
				then
					Exit_application_cmd.set_already_confirmed (True)
					if Window_manager.development_windows_count > 1 then
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt_with_cancel (
							Warning_messages.w_Closing_stops_debugger, window, agent window_manager.try_to_destroy_window (Current), Void)
					else
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt_with_cancel (
							Warning_messages.w_Exiting_stops_debugger, window, agent window_manager.try_to_destroy_window (Current), Void)
					end
				else
					if Window_manager.development_windows_count > 1 and then
						Eb_debugger_manager.debugging_window = l_window and then
						Eb_debugger_manager.raised
					then
						Eb_debugger_manager.unraise
					end
					window_manager.try_to_destroy_window (Current)
				end
			end
		end

	refresh is
			-- Refresh window after a compilation, resynchronize everything.
		require
			exists: not destroyed
		do
			--| By default do nothing.			
		end

	refresh_all_commands is
			-- Refresh all commands.
		require
			exists: not destroyed
		do
			-- | By default do nothing.
		end

	refresh_external_commands is
			-- Refresh external commands.
		require
			exists: not destroyed
		do
			-- | By default do nothing.
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
			recycle
			destroyed := True
		end

feature {EB_DEVELOPMENT_WINDOW_MENU_BUILDER} -- Controls & widgets

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
			menu_item.select_actions.extend (agent destroy)
			file_menu.extend (menu_item)

			command_menu_item := Exit_application_cmd.new_menu_item
			auto_recycle (Command_menu_item)
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

feature {EB_WINDOW_MANAGER, EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_PART} -- Commands

	show_dynamic_lib_tool: EB_STANDARD_CMD
			-- Command to display the dynamic library editor.

feature {EB_DEVELOPMENT_WINDOW_MENU_BUILDER} -- Implementation / Flags

	window_displayed is
			-- `Current' has been displayed on screen.
		do
			--| redefine this feature to perform any processing post display.
		end

	initialized: BOOLEAN
			-- Is the "initialization sequence" finished?

	display_help_contents is
			-- Display the part of the help relative to EiffelStudio.
		local
			l_service: SERVICE_CONSUMER [HELP_PROVIDERS_S]
		do
			create l_service
			if l_service.is_service_available then
				l_service.service.show_help (create {ES_HELP_CUSTOM_CONTEXT}.make ("e34647c8-840e-159d-74b3-07353a27472e", Void))
			end
		end

	display_how_to_s is
			-- Display the part of the help relative to EiffelStudio.
		local
			l_service: SERVICE_CONSUMER [HELP_PROVIDERS_S]
		do
			create l_service
			if l_service.is_service_available then
				l_service.service.show_help (create {ES_HELP_CUSTOM_CONTEXT}.make ("10d806ce-5b43-26a5-6f0e-23b3b2faa2ed", Void))
			end
		end

	display_guided_tour is
			-- Display the guided tour of EiffelStudio.
		local
			l_service: SERVICE_CONSUMER [HELP_PROVIDERS_S]
		do
			create l_service
			if l_service.is_service_available then
				l_service.service.show_help (create {ES_HELP_CUSTOM_CONTEXT}.make ("4d68a136-f7c2-ddd3-d30d-e16ee7692302", Void))
			end
		end

	display_eiffel_introduction is
			-- Display the introduction to Eiffel.
		local
			l_service: SERVICE_CONSUMER [HELP_PROVIDERS_S]
		do
			create l_service
			if l_service.is_service_available then
				l_service.service.show_help (create {ES_HELP_CUSTOM_CONTEXT}.make ("ae6f212e-bdc6-d5f2-972a-1bfee586479e", Void))
			end
		end

invariant
	lock_level_nonnegative: lock_level >= 0

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

end -- class EB_WINDOW

