indexing

	description: "Command to de/activate the execution recording"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOGGLE_EXECUTION_REPLAY_RECORDING_MODE_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND
		redefine
			tooltext,
			mini_pixel_buffer, mini_pixmap,
			set_select
		end

	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_manager: like debugger_manager) is
			-- Initialize `Current'.
		do
			debugger_manager := a_manager
		end

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

feature -- Execution

	reset is
		do
			set_select (False)
		end

	execute is
			-- Pause the execution.
		do
			debugger_manager.activate_execution_replay_recording (not execution_recording_activated)
		end

feature -- Status

	execution_recording_activated: BOOLEAN
			-- Is recording activated ?

	is_selected: BOOLEAN is
		do
			Result := execution_recording_activated
		end

feature -- Change text

	set_select (b: BOOLEAN) is
			-- <Precursor>
		do
			execution_recording_activated := b
			Precursor (b)
			update_items
		end

feature {NONE} -- Properties

	description: STRING_GENERAL is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL is
			-- Tooltip displayed on `Current's buttons.
		do
			if not is_selected then
				Result := Interface_names.e_Activate_execution_recording
			else
				Result := Interface_names.e_Deactivate_execution_recording
			end
		end

	tooltext: STRING_GENERAL is
			-- Text displayed on `Current's buttons.
		do
			if not is_selected then
				Result := Interface_names.b_Activate_execution_recording
			else
				Result := Interface_names.b_Deactivate_execution_recording
			end
		end

	name: STRING is "debug_recording_mode"
			-- Name of the command.

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		do
			if not is_selected then
				Result := Interface_names.m_Activate_execution_recording
			else
				Result := Interface_names.m_Deactivate_execution_recording
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			Result := pixmaps.icon_pixmaps.execution_record_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.execution_record_icon_buffer
		end

	mini_pixmap: EV_PIXMAP is
		do
			Result := pixmaps.mini_pixmaps.execution_record_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER is
		do
			Result := pixmaps.mini_pixmaps.execution_record_icon_buffer
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
