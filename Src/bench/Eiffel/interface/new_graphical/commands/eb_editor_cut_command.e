indexing
	description	: "Command to perform a clipboard-cut operation"
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_EDITOR_CUT_COMMAND

inherit
	EB_CLIPBOARD_COMMAND
		redefine
			executable
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		redefine
			executable
		end

create
	make

feature -- Status report

	executable: BOOLEAN is
			-- Is the operation possible?
		do
			Result := is_sensitive
		end

feature -- Execution

	execute is
			-- Execute the cut/copy/paste operation.
		do
			editor.cut_selection
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Cut
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_cut
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Cut
		end

	description: STRING is
			-- Description for current command.
		do
			Result := Interface_names.e_Cut
		end

	name: STRING is "Editor_cut"
			-- Name of the command. Used to store the command in the
			-- preferences.

	editor: EB_EDITOR is
			-- Editor corresponding to `Current'.
		do
			Result := target.current_editor
		end

end -- class EB_CLIPBOARD_COMMAND
