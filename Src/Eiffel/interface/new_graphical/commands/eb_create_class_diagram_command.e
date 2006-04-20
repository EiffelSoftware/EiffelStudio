indexing
	description	: "Command to change links layout."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CREATE_CLASS_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end

create
	make

feature -- Basic operations

	execute is
			-- Display information about `Current'.
		local
			dialog: EB_CREATE_CLASS_DIALOG
		do
			create dialog.make_default (tool.development_window)
			dialog.set_stone_when_finished
			dialog.call_default
		end

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		local
			a_stone: CREATE_CLASS_STONE
		do
			create a_stone
			Result := Precursor (display_text)
			Result.set_pebble (a_stone)
			Result.set_accept_cursor (Cursors.cur_Class)
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := Pixmaps.Icon_new_class
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_new_class
		end

	name: STRING is "Create_class"
			-- Name of the command. Used to store the command in the
			-- preferences.

	explain_dialog: EB_INFORMATION_DIALOG;
			-- Dialog explaining how to use `Current'.

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

end -- class EB_CREATE_CLASS_DIAGRAM_COMMAND
