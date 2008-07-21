indexing

	description:
		"Command to manage exception handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ASSERTION_CHECKING_HANDLER_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND
		redefine
			tooltext
		end

	EB_CONSTANTS

	SHARED_DEBUGGER_MANAGER

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
--			create accelerator.make_with_key_combination (
--				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f5),
--				True, False, True)
--			accelerator.actions.extend (agent execute)
		end

feature -- Execution

	reset is
		do
			assertion_checking_changed := False
			update_items
			set_select (assertion_checking_changed)
		end

	execute is
			-- Pause the execution.
		local
			app_exec: APPLICATION_EXECUTION
		do
			if debugger_manager.application_initialized then
				app_exec := Debugger_manager.Application
				if
					not app_exec.is_running
					or else not app_exec.is_stopped
				then
					disable_sensitive
				else
					enable_sensitive
				end
				if assertion_checking_changed then
					assertion_checking_changed := False
					app_exec.restore_assertion_check
				else
					assertion_checking_changed := True
					app_exec.disable_assertion_check
				end
				set_select (assertion_checking_changed)
			end
			update_items
		end

	assertion_checking_changed: BOOLEAN

	is_selected: BOOLEAN is
		do
			Result := assertion_checking_changed
		end

feature {NONE} -- Attributes

	description: STRING_GENERAL is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Dbg_assertion_checking
		end

	tooltext: STRING_GENERAL is
			-- Text displayed on `Current's buttons.
		do
			if assertion_checking_changed then
				Result := Interface_names.b_Dbg_assertion_checking_restore
			else
				Result := Interface_names.b_Dbg_assertion_checking_disable
			end
		end

	name: STRING is "Assertion_checking_handler"
			-- Name of the command.

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		do
			if assertion_checking_changed then
				Result := Interface_names.m_Dbg_assertion_checking_restore
			else
				Result := Interface_names.m_Dbg_assertion_checking_disable
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			if assertion_checking_changed then
				Result := pixmaps.icon_pixmaps.debug_resume_assertions_icon
			else
				Result := pixmaps.icon_pixmaps.debug_disable_assertions_icon
			end
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			if assertion_checking_changed then
				Result := pixmaps.icon_pixmaps.debug_resume_assertions_icon_buffer
			else
				Result := pixmaps.icon_pixmaps.debug_disable_assertions_icon_buffer
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

end
