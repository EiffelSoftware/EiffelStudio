indexing
	description	: "Command to perform a clipboard-copy operation"
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_EDITOR_COPY_COMMAND

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
				--| FIXME ARNAUD: waiting for Vision2 clipboard.
			Result := is_sensitive
		end

feature -- Execopyion

	execute is
			-- Execopye the copy/copy/paste operation
		do
				--| FIXME ARNAUD: waiting for Vision2 clipboard.
			editor.copy_selection
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Copy
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_copy
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Copy
		end

	description: STRING is
			-- Description for current command
		do
			Result := Interface_names.e_Copy
		end

	name: STRING is "Editor_copy"
			-- Name of the command. Used to store the command in the
			-- preferences.

	editor: EB_EDITOR is
			-- Editor corresponding to Current
		do
			Result := target.editor_tool.text_area
		end

end -- class EB_EDITOR_COPY_COMMAND
