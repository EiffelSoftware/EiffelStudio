indexing

	description:
		"Set execution format so that breakable point %
			%will be taken into account."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_DEBUG_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			Run as execution_mode
		redefine
			make,
			execute,
			tooltext,
			is_tooltext_important,
			new_sd_toolbar_item,
			initialize_sd_toolbar_item
		end

create
	make

feature -- Initialization

	make (a_manager: like eb_debugger_manager) is
			-- Initialize `Current'.
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			tooltext := Interface_names.b_run
			menu_name := Interface_names.m_Debug_run
			internal_tooltip := Interface_names.e_Exec_debug

			Precursor (a_manager)
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("run")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			set_referred_shortcut (l_shortcut)
			accelerator.actions.extend (agent execute_from_accelerator)
		end

feature -- Execution

	execute_from_accelerator is
			-- Execute from accelerator
		do
			execute
		end

	execute is
			-- <Precursor>
		do
			eb_debugger_manager.stop_at_breakpoints
			Precursor
		end

feature -- Access

	set_launched (a_launched: BOOLEAN) is
		do
			is_launched := a_launched
			if a_launched then
				tooltext := Interface_names.b_run
				menu_name := Interface_names.m_Debug_run
				internal_tooltip := Interface_names.e_Exec_debug_continue
			else
				tooltext := Interface_names.b_run
				menu_name := Interface_names.m_Debug_run
				internal_tooltip := Interface_names.e_Exec_debug
			end
			refresh_items
		end

	refresh_items is
		local
			l_sd_lst: like internal_managed_sd_toolbar_items
			l_sd_item: like new_sd_toolbar_item
			l_menu_lst: like internal_managed_menu_items
			l_menu_item: like new_menu_item
		do
			l_sd_lst := internal_managed_sd_toolbar_items
			if l_sd_lst /= Void then
				from
					l_sd_lst.start
				until
					l_sd_lst.after
				loop
					l_sd_item := l_sd_lst.item
					if l_sd_item /= Void then
						initialize_sd_toolbar_item (l_sd_item, not l_sd_item.text.is_empty)
					end
					l_sd_lst.forth
				end
			end
			l_menu_lst := internal_managed_menu_items
			if l_menu_lst /= Void then
				from
					l_menu_lst.start
				until
					l_menu_lst.after
				loop
					l_menu_item := l_menu_lst.item
					if l_menu_item /= Void then
						initialize_menu_item (l_menu_item)
					end
					l_menu_lst.forth
				end
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Redefine
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)

			Result.select_actions.put_front (agent execute_from (eb_debugger_manager.debugging_window.window))
			Result.pointer_button_press_actions.put_front (agent button_right_click_action)
		end

	initialize_sd_toolbar_item (a_item: EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON; display_text: BOOLEAN) is
			-- <Precursor>
		do
			Precursor (a_item, display_text)
			a_item.set_menu_function (agent drop_down_menu)
		end

feature {NONE} -- Attributes

	is_launched: BOOLEAN
			-- Is application launched ?

	pixmap: EV_PIXMAP is
			-- Pixmap for the button.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon_buffer
		end

	name: STRING is "Exec_debug"
			-- Name of the command.

	tooltext: STRING_GENERAL
			-- Default text displayed in toolbar button

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	internal_tooltip: STRING_GENERAL
			-- Tooltip displayed on `Current's buttons.

	menu_name: STRING_GENERAL;
			-- Name used in menu entry.

	drop_down_menu: EV_MENU is
			-- Drop down menu for `new_sd_toolbar_item'.
		local
			l_item: EV_MENU_ITEM
			l_submenu: EV_MENU
			l_cb_item: EV_CHECK_MENU_ITEM
			profs: DEBUGGER_PROFILES
			k, pn: STRING_32
			dbg: EB_DEBUGGER_MANAGER
		do
			create Result

			dbg := eb_debugger_manager

			Result.extend (new_menu_item_unmanaged)
			Result.extend (eb_debugger_manager.no_stop_cmd.new_menu_item_unmanaged)

			Result.extend (create {EV_MENU_SEPARATOR})

				--| Breakpoints status
			l_item := dbg.ignore_breakpoints_cmd.new_menu_item_unmanaged
			Result.extend (l_item)

				--| Catcall warning status
--| FIXME: we should create specific _CMD for thoses		
			if {exc_hdlr: DBG_EXCEPTION_HANDLER} (dbg.exceptions_handler) then
				create l_cb_item.make_with_text (interface_names.m_Dbg_disable_catcall_console_warning)
				Result.extend (l_cb_item)
				if exc_hdlr.catcall_console_warning_disabled then
					l_cb_item.enable_select
					l_cb_item.select_actions.extend (agent dbg.set_catcall_detection_in_console (True))
				else
					l_cb_item.select_actions.extend (agent dbg.set_catcall_detection_in_console (False))
				end

				create l_cb_item.make_with_text (interface_names.m_Dbg_disable_catcall_debugger_warning)
				Result.extend (l_cb_item)
				if exc_hdlr.catcall_debugger_warning_disabled then
					l_cb_item.enable_select
					l_cb_item.select_actions.extend (agent dbg.set_catcall_detection_in_debugger (True))
				else
					l_cb_item.select_actions.extend (agent dbg.set_catcall_detection_in_debugger (False))
				end
			end

				--| Execution replay recording status
			Result.extend (dbg.toggle_exec_replay_recording_mode_cmd.new_menu_item_unmanaged)
			Result.extend (create {EV_MENU_SEPARATOR})

				-- Run (workbench)
			Result.extend (dbg.run_workbench_cmd.new_menu_item_unmanaged)

				-- Run (finalized)
			Result.extend (dbg.run_finalized_cmd.new_menu_item_unmanaged)
			Result.extend (create {EV_MENU_SEPARATOR})

				--| Exception handling
			Result.extend (dbg.exception_handler_cmd.new_menu_item_unmanaged)

				--| Execution parameters
			Result.extend (dbg.options_cmd.new_menu_item_unmanaged)

				--| Execution profiles
			profs := dbg.profiles
			if profs /= Void and then profs.count > 0 then
				Result.extend (create {EV_MENU_SEPARATOR})

				create l_item.make_with_text (Interface_names.m_Execution_profiles)
				Result.extend (l_item)
				l_item.disable_sensitive

					--| Flat menu (no submenu)
				l_submenu := Result

				pn := profs.last_profile_name

				create l_cb_item.make_with_text (Interface_names.l_default)
				l_submenu.extend (l_cb_item)
				if pn = Void then
					l_cb_item.enable_select
				else
					l_cb_item.select_actions.extend (agent profs.set_last_profile_by_name (Void))
				end

				from
					profs.start
				until
					profs.after
				loop
					k := profs.key_for_iteration
					if k /= Void then
						create l_cb_item.make_with_text (k)
						l_submenu.extend (l_cb_item)
						if pn /= Void and then k.is_equal (pn) then
							l_cb_item.enable_select
						else
							l_cb_item.select_actions.extend (agent profs.set_last_profile_by_name (k))
						end
					end
					profs.forth
				end
			end
		ensure
			not_void: Result /= Void
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

end -- class EB_EXEC_NO_STOP_CMD
