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
	
--	NEW_EB_CONSTANTS

	EB_CONFIRM_SAVE_CALLBACK

creation

	make
	
feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
			-- The user has been warned that he will lose his stuff
		do
			tool_supervisor.remove (tool)
		end

feature -- Properties

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Quit 
--		end

feature {NONE} -- Implementation

	execute is
			-- Quit cautiously a file.
		local
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if tool.text_area.changed then
				create csd.make_and_launch (tool, Current)
			else
				process
			end
		end

feature {NONE} -- Attributes

	tool: EB_EDIT_TOOL

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
