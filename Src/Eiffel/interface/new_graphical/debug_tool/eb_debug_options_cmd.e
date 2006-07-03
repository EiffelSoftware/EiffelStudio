indexing
	description:
		"Set debugging options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_OPTIONS_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_manager: like debugger_manager) is
			-- Initialize `Current' and associate it with `a_manager'.
		do
			debugger_manager := a_manager
		end

feature -- Formatting

	execute_run_project is
		do
			if is_sensitive then
				debugger_manager.run_project_cmd.execute
			end
		end

	execute is
			-- Set the execution format to `stone'.
		local
			conv_dev: EB_DEVELOPMENT_WINDOW

			args_dialog: EB_ARGUMENT_DIALOG
			window: EB_DEVELOPMENT_WINDOW
			dev: EV_WINDOW
		do
			if is_sensitive then
				window ?= window_manager.last_focused_window
				if window /= Void then
					dev := window.window
					if not argument_dialog_is_valid then
						create args_dialog.make (window, agent execute_run_project)
						set_argument_dialog (args_dialog)
					else
						argument_dialog.update
					end
					if not argument_dialog.is_displayed then
						argument_dialog.show
					end
					if argument_dialog.is_minimized then
						argument_dialog.restore
					end
					argument_dialog.raise
				end
			end
		end

feature -- Properties

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

	tooltip: STRING is
			-- Tooltip for `Current'.
		do
			Result := "Debugging options"
		end

	pixmap: EV_PIXMAP is
			-- Pixmap for the button.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon
		end

	name: STRING is "Debugging_options"
			-- Name of the command.

	menu_name: STRING is "Debugging options"

	tooltext: STRING is
			-- Default text displayed in toolbar button
		do
			Result := "Debugging options"
		end

feature {NONE} -- Attributes

	description: STRING is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
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

end -- class EB_DEBUG_OPTIONS_CMD
