indexing
	description: "Objects that represent a new show project settings command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHOW_HIDE_HISTORY_COMMAND

inherit

	GB_RESTORABLE_WINDOW_COMMAND

create
	make_with_components

feature {GB_COMMAND_HANDLER} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current'.
		do
			components := a_components
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			Result := Show_hide_history_window_menu_text
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_cmd_history
		end

feature -- Basic operations

	window: EV_DIALOG is
			-- Result is window referenced by
			-- `Current' command.
		do
			Result := components.tools.history_dialog
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_SHOW_HIDE_HISTORY_COMMAND
