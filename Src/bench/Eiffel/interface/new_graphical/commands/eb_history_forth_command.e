indexing
	description	: "Command to go forward in the history."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_HISTORY_FORTH_COMMAND

inherit
	EB_HISTORY_COMMAND
		redefine
			executable,
			mini_pixmap
		end

creation
	make
	
feature {NONE} -- Implementation

	operate is
			-- Move forward in the history.
		do
			history_manager.forth
		end

	executable: BOOLEAN is
			-- Is `operate' possible (i.e. can we go forth)?
		do
			Result := history_manager.is_forth_possible
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_forth
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Mini pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_mini_forth
		end

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_History_forth
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_History_forth
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.e_History_forth
		end

	name: STRING is "History_forth"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_HISTORY_FORTH_COMMAND
