indexing
	description	: "Command to go backward in the history."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_HISTORY_BACK_COMMAND

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
			-- Move backward in the history.
		do
			history_manager.back
		end

	executable: BOOLEAN is
			-- Is `operate' possible (i.e. can we go back)?
		do
			Result := history_manager.is_back_possible
		end

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_History_back
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_back
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Mini pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_mini_back
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_history_back
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.e_history_back
		end

	name: STRING is "History_back"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_HISTORY_BACK_COMMAND
