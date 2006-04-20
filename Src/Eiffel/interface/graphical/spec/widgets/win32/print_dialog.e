indexing

	description:
		"Dialog that displays the printer choices."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class PRINT_DIALOG

inherit
	G_ANY_I; -- VISIONLITE
	CLOSEABLE

feature -- Removal

	close is
			-- Close the dialog.
		do
		end;

feature -- Update

	popup (a_cmd: TOOL_COMMAND) is
			-- Popup the dialog for command `a_cmd'.
		local
			a_parent: WEL_COMPOSITE_WINDOW;
			rich_edit: WEL_RICH_EDIT;
			file_name: STRING;
		do
			rich_edit ?= a_cmd.text_window.widget.implementation;
			if rich_edit /= Void then
				-- Rich edit may have been disabled hence the test.
				a_parent ?= a_cmd.popup_parent.implementation;
				dialog.activate (a_parent);
				if dialog.selected then
					file_name := a_cmd.tool.title;
					rich_edit.print_all (dialog.dc, file_name)
				end
			end
		end;

feature {NONE} -- Implementation

	dialog: WEL_PRINT_DIALOG is
			-- Printer dialog for windows
		once
			create Result.make
		end;

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

end -- class PRINT_DIALOG
