indexing
	description: "Command that raises the Import Eiffel Build Code window."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class

	RAISE_IMPORT_WINDOW_CMD

inherit

	COMMAND

	WINDOWS

feature

	execute (arg: ANY) is
			-- Raise the window to specify from where and
			-- what to import.
		local
			an_import_window: IMPORT_WINDOW
		do
			if main_panel.project_initialized then
--				!! an_import_window.make (new_main_panel.base)
				!! an_import_window.make (main_panel.base)
				an_import_window.popup
			end
		end

end -- class RAISE_IMPORT_WINDOW_CMD
