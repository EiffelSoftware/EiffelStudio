indexing

	description: "Command to display about."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ABOUT_COMMAND 

inherit
	EB_TOOL_COMMAND
--	NEW_EB_CONSTANTS
--	SYSTEM_CONSTANTS

creation
	make

feature -- Access

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := clone(Interface_names.f_About)
--			Result.append(" ")
--			Result.append(version_number)
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := clone(Interface_names.m_About)
--			Result.append(" ")
--			Result.append(version_number)
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

feature -- Execution

	execute (argument: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Popup the help window.
		local
			about_tool: EB_ABOUT_DIALOG
				-- Associated helpable object
		do
			create about_tool.make (tool.parent_window)
		end

end -- class EB_ABOUT_COMMAND
