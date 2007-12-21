indexing
	description	: "Command to clear debugging information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CLEAR_STOP_POINTS_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item,
			new_sd_toolbar_item,
			new_mini_toolbar_item,
			new_mini_sd_toolbar_item,
			mini_pixmap,
			mini_pixel_buffer,
			tooltext
		end

	EB_VETO_FACTORY

	SHARED_DEBUGGER_MANAGER

	SHARED_EIFFEL_PROJECT

	EB_SHARED_MANAGERS

	EB_CONSTANTS

	EB_SHARED_PREFERENCES

feature -- Access

	description: STRING_GENERAL is
			-- What is printed in the customize dialog.
		do
			Result := Interface_names.f_Clear_breakpoints
		end

	tooltip: STRING_GENERAL is
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING_GENERAL is
			-- Text for toolbar button
		do
			Result := Interface_names.b_bkpt_remove
		end

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.drop_actions.extend (agent drop_breakable (?))
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.extend (agent drop_class (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop_debuggable_feature_or_class)
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new docking toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.drop_actions.extend (agent drop_breakable (?))
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.extend (agent drop_class (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop_debuggable_feature_or_class)
		end

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.drop_actions.extend (agent drop_breakable (?))
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.extend (agent drop_class (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop_debuggable_feature_or_class)
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.drop_actions.extend (agent drop_breakable (?))
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.extend (agent drop_class (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop_debuggable_feature_or_class)
		end

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding tp `Current'.
		do
			Result := Interface_names.m_Clear_breakpoints
		end

	pixmap: EV_PIXMAP is
			-- Icon for `Current'.
		do
			Result := pixmaps.icon_pixmaps.breakpoints_delete_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.breakpoints_delete_icon_buffer
		end

	mini_pixmap: EV_PIXMAP is
			-- Icon for `Current'.
		do
			Result := pixmaps.mini_pixmaps.general_delete_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER is
			-- Icon for `Current'.
		do
			Result := pixmaps.mini_pixmaps.general_delete_icon_buffer
		end

	name: STRING is "Clear_bkpt"
			-- Name of `Current' to identify it.

feature -- Events

	drop_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		local
			index: INTEGER
			f: E_FEATURE
			body_index: INTEGER
			bpm: BREAKPOINTS_MANAGER
		do
			f := bs.routine
			if f.is_debuggable then
				body_index := bs.body_index
				index := bs.index
				bpm := Debugger_manager.breakpoints_manager
				bpm.remove_breakpoint (f, index)
				show_message_on_error (bpm)

					-- Update output tools
				bpm.notify_breakpoints_changes
			end
		end

	drop_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			bpm: BREAKPOINTS_MANAGER
		do
			f := fs.e_feature
			bpm := Debugger_manager.breakpoints_manager
			if f /= Void and then f.is_debuggable and then bpm.has_breakpoint_set (f) then
				bpm.remove_breakpoints_in_feature (f)
				show_message_on_error (bpm)

					-- Update output tools
				bpm.notify_breakpoints_changes
			end
		end

	drop_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			conv_fst: FEATURE_STONE
			bpm: BREAKPOINTS_MANAGER
		do
			conv_fst ?= cs
			if conv_fst = Void then
				bpm := Debugger_manager.breakpoints_manager
				bpm.remove_breakpoints_in_class (cs.e_class)
				show_message_on_error (bpm)

					-- Update output tools
				bpm.notify_breakpoints_changes
			end
		end

feature -- Execution

	execute is
			-- Execute with confirmation dialog.
		local
			l_question: ES_DISCARDABLE_QUESTION_PROMPT
			bpm: BREAKPOINTS_MANAGER
		do
			bpm := Debugger_manager.breakpoints_manager
			if bpm.has_breakpoints then
				create l_question.make_standard (warning_messages.w_clear_breakpoints, "", preferences.dialog_data.confirm_clear_breakpoints_string)
				l_question.set_title (interface_names.t_debugger_question)
				l_question.set_button_action (l_question.dialog_buttons.yes_button, agent clear_breakpoints)
				l_question.show_on_active_window

					-- Update output tools
				bpm.notify_breakpoints_changes
			end
		end

feature {NONE} -- Implementation

	quick_refresh_on_class_drop (unused: CLASSC_STONE) is
			-- Quick refresh all windows.
		do
			Window_manager.synchronize_all_about_breakpoints
		end

	quick_refresh_on_brk_drop (unused: BREAKABLE_STONE) is
			-- Quick refresh all windows.
		do
			Window_manager.synchronize_all_about_breakpoints
		end

	clear_breakpoints is
			-- Execute with confirmation dialog.
		do
			debugger_manager.clear_breakpoints
			show_message_on_error (debugger_manager.breakpoints_manager)
		end

	show_message_on_error (a_manager: BREAKPOINTS_MANAGER)
			-- Shows an error message on an error in `a_manager'
		require
			a_manager_attached: a_manager /= Void
		local
			l_error: ES_ERROR_PROMPT
		do
			if a_manager.error_in_bkpts then
				create l_error.make_standard (warning_messages.w_feature_is_not_compiled)
				l_error.set_title (interface_names.t_debugger_error)
				l_error.show_on_active_window
			end
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

end -- class EB_CLEAR_STOP_POINTS_COMMAND
