indexing

	description:
		"Command to quit from the profile tool."
	date: "$Date$"
	revision: "$Revision$"

class EB_QUIT_PROFILE_TOOL

inherit
	EB_TOOL_COMMAND
		redefine
			tool
		end

	INTERFACE_NAMES

creation
	make

feature -- Access

--	name: STRING is
--			-- Name for Current
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

	tool: EB_PROFILE_TOOL
			-- Tool which Current relates to.

feature {NONE} -- Command execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current
		do
			if tool /= Void then
				tool.destroy
			end
		end

end -- class EB_QUIT_PROFILE_TOOL
