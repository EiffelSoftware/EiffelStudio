indexing

	description:
		"Command to manage exception handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXCEPTION_HANDLER_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
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
		end

feature -- Formatting

	execute is
			-- Pause the execution.
		do
			if is_sensitive and debugger_manager.system_defined then
				if handler_dialog = Void or else handler_dialog.is_destroyed then
					build_handler_dialog
				end

				handler_dialog.show_relative_to_window (window_manager.last_focused_window.window)
				handler_dialog.raise
			end
		end

feature -- Dialog

	build_handler_dialog is
			-- Build handler dialog
		local
			dialog: ES_EXCEPTION_HANDLER_DIALOG
		do
			create dialog.make
			dialog.set_handler (Debugger_manager.exceptions_handler)
			handler_dialog := dialog
		end

	handler_dialog: EV_DIALOG
			-- last opened handler dialog.

feature {NONE} -- Attributes

	name: STRING is "Exception_handler"
			-- Name of the command.

	description: STRING_GENERAL is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING_GENERAL is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Dbg_exception_handler
		end

	tooltext: STRING_GENERAL is
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Dbg_exception_handler
		end

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		once
			Result := Interface_names.m_Dbg_exception_handler
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' on buttons.
		do
			Result := pixmaps.icon_pixmaps.debug_exception_handling_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_exception_handling_icon_buffer
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
