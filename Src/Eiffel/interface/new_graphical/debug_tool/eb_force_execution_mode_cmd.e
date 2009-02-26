note

	description:
		"Command to force the environment to stay in debug maode"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORCE_EXECUTION_MODE_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND
		redefine
			tooltext
		end

	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_manager: like eb_debugger_manager)
			-- Initialize `Current'.
		do
			eb_debugger_manager := a_manager
--			create accelerator.make_with_key_combination (
--				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f5),
--				False, False, False)
--			accelerator.actions.extend (agent execute)
		end

	eb_debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

feature -- Execution

	execute
			-- Execute
		do
			execute_for_opening (True)
		end

	execute_for_opening (a_save_tools_layout: BOOLEAN)
			-- Execute for opening Eiffel Studio directly into debug mode.
		do
			internal_is_selected := not internal_is_selected
			set_select (is_selected)
			if is_selected then
				eb_debugger_manager.force_execution_mode (a_save_tools_layout)
				if internal_managed_sd_toolbar_items /= Void then
					internal_managed_sd_toolbar_items.do_all (agent (a_button: like new_sd_toolbar_item) do
						a_button.set_tooltip (interface_names.e_restore_normal_mode)
					end)
				end
			else
				eb_debugger_manager.unforce_execution_mode
				if internal_managed_sd_toolbar_items /= Void then
					internal_managed_sd_toolbar_items.do_all (agent (a_button: like new_sd_toolbar_item) do
						a_button.set_tooltip (interface_names.e_force_execution_mode)
					end)
				end
			end
--			update_graphical
		end

feature -- Status

	internal_is_selected: BOOLEAN
			-- Is selected?

	is_selected: BOOLEAN
			-- Value of `internal_is_selected'.
		do
			Result := internal_is_selected --eb_debugger_manager.raised
		end

feature -- Status change

	synchronize_items
			-- Synchronize items.
		do
			set_select (is_selected)
		end

feature {NONE} -- Properties

	description: STRING_GENERAL
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_force_execution_mode
		end

	tooltext: STRING_GENERAL
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Force_execution_mode
		end

	name: STRING = "Force_debug_mode"
			-- Name of the command.

	menu_name: STRING_GENERAL
			-- Menu entry corresponding to `Current'.
		do
			Result := Interface_names.m_Force_execution_mode
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing `Current' on buttons.
		do
			Result := pixmaps.icon_pixmaps.debugger_environment_force_execution_mode_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debugger_environment_force_execution_mode_icon_buffer
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
