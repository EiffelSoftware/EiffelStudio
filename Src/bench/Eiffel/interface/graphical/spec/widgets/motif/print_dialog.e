indexing

	description:
		"Dialog that displays the printer choices.";
	date: "$Date$";
	revision: "$Revision$"

class PRINT_DIALOG

inherit

	CLOSEABLE

feature -- Removal

	close is
			-- Close the dialog.
		do
		end;

feature -- Update

	popup (a_cmd: TOOL_COMMAND) is
			-- Popup the dialog for command `a_cmd'.
		do
		end;

end -- class PRINTER_DIALOG
