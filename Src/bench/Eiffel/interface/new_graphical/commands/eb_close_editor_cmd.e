indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLOSE_EDITOR_CMD

inherit
	EB_CLOSE_TOOL_CMD
		redefine
			tool, execute
		end

	EB_SHARED_INTERFACE_TOOLS
	
	NEW_EB_CONSTANTS

creation

	make
	
feature -- Callbacks

	exit_anyway is
			-- The user has been warned that he will lose his stuff
		do
			tool_supervisor.remove (tool)
		end

	user_warned: BOOLEAN
			-- Has user been warned that he could lose the changes?

feature -- Properties

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Quit 
--		end

feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Quit cautiously a file.
		local
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if (not user_warned) and then tool.text_window.changed then
				create csd.make_and_launch (tool, Current, argument)
				user_warned := True
			else
				exit_anyway
			end
		end

feature {NONE} -- Attributes

	tool: EB_EDITOR

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Exit
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Exit
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

end -- class EB_CLOSE_EDITOR_CMD
