indexing

	description:
		"Dialog that displays the printer choices.";
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
			!! Result.make
		end;

end -- class PRINT_DIALOG
