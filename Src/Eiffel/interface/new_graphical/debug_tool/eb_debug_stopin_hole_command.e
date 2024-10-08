﻿note
	description	: "Command to stop in a feature while debugging."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_STOPIN_HOLE_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
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

feature -- Access

	description: STRING_GENERAL
			-- What is printed in the customize dialog.
		do
			Result := Interface_names.f_Enable_stop_points
		end

	tooltip: STRING_GENERAL
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_bkpt_enable
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new docking toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} (display_text)
			Result.drop_actions.extend (agent drop_breakable (?))
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.extend (agent drop_class (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop_debuggable_feature_or_class)
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new mini toolbar button for `Current'.
		do
			Result := Precursor {EB_TOOLBARABLE_AND_MENUABLE_COMMAND}
			Result.drop_actions.extend (agent drop_breakable (?))
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.extend (agent drop_class (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop_debuggable_feature_or_class)
		end

	menu_name: STRING_GENERAL
			-- Menu entry corresponding to `Current'.
		do
			Result := Interface_names.m_Enable_stop_points
		end

	pixmap: EV_PIXMAP
			-- Icon for `Current'.
		do
			Result := pixmaps.icon_pixmaps.breakpoints_enable_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.breakpoints_enable_icon_buffer
		end

	mini_pixmap: EV_PIXMAP
			-- Icon for `Current'.
		do
			Result := pixmaps.mini_pixmaps.breakpoints_enable_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- Icon for `Current'.
		do
			Result := pixmaps.mini_pixmaps.breakpoints_enable_icon_buffer
		end

	name: STRING = "Enable_bkpt"
			-- Name of `Current' to identify it.

feature -- Update

	drop_breakable (bs: BREAKABLE_STONE)
			-- Process breakable stone
		local
			index: INTEGER
			f: E_FEATURE
			body_index: INTEGER
			bpm: BREAKPOINTS_MANAGER
		do
			f := bs.routine
			if f.is_debuggable then
				index := bs.index
				body_index := bs.body_index
				bpm := Debugger_manager.breakpoints_manager
				bpm.enable_user_breakpoint (f, index)

				if bpm.error_in_bkpts then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (Warning_messages.w_Feature_is_not_compiled, Void, Void)
				end

				bpm.notify_breakpoints_changes
			end
		end

	drop_call_stack (dropped: CALL_STACK_STONE)
			-- Accept all stone types
		do
--			Project_window.process_call_stack (dropped)
		end
--| FIXME

	drop_feature (fs: FEATURE_STONE)
			-- Process feature stone.
		local
			f: E_FEATURE
			bpm: BREAKPOINTS_MANAGER
		do
			f := fs.e_feature
			if f.is_debuggable then
				bpm := Debugger_manager.breakpoints_manager
				if bpm.has_disabled_breakpoint (False) then
					bpm.enable_user_breakpoints_in_feature (f)
				end
				bpm.enable_first_user_breakpoint_of_feature (f)

				if bpm.error_in_bkpts then
					prompts.show_error_prompt (Warning_messages.w_Feature_is_not_compiled, Void, Void)
				end
				bpm.notify_breakpoints_changes
			end
		end

	drop_class (cs: CLASSC_STONE)
			-- Process class stone
		local
			bpm: BREAKPOINTS_MANAGER
		do
				-- If a feature stone was dropped, it is handled by the drop_feature feature.
			if not attached {FEATURE_STONE} cs then
				bpm := Debugger_manager.breakpoints_manager
				bpm.enable_first_user_breakpoints_in_class (cs.e_class)

				if bpm.error_in_bkpts then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (Warning_messages.w_Feature_is_not_compiled, Void, Void)
				end

				bpm.notify_breakpoints_changes
			end
		end

feature -- Execution

	execute
			-- Enable all breakpoints in the application.
		local
			bpm: BREAKPOINTS_MANAGER
		do
			bpm := debugger_manager.breakpoints_manager
			bpm.enable_all_user_breakpoints
			bpm.notify_breakpoints_changes
		end

feature {NONE} -- Implementation

	update_debuggable_for (f: E_FEATURE)
			-- Update the debuggable information for feature `f'.
			-- Set all breakpoints in `f'.
		require
			f_is_valid: f /= Void
			is_debuggable: f.is_debuggable
--		local
--			body_index: INTEGER
		do
			Debugger_manager.breakpoints_manager.enable_user_breakpoints_in_feature (f)
--| FIXME ARNAUD
--			body_index := f.body_index
--			tool_supervisor.feature_tool_mgr.show_stoppoint (body_index, 1)
--			debug_tool.show_stoppoint (body_index, 1)
--| END FIXME
		end

	quick_refresh_on_class_drop (unused: CLASSC_STONE)
			-- Quick refresh all windows.
		do
			window_manager.synchronize_all_about_breakpoints
		end

	quick_refresh_on_brk_drop (unused: BREAKABLE_STONE)
			-- Quick refresh all windows.
		do
			window_manager.synchronize_all_about_breakpoints
		end

	is_fst_debuggable (fst: FEATURE_STONE): BOOLEAN
			-- Does `fst' represent a feature that is debuggable?
		do
			Result := fst.e_feature.is_debuggable
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
