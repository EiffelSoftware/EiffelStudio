indexing

	description:
		"Command to raise a tool."
	date: "$Date$"
	revision: "$Revision: "

class
	EB_RAISE_TOOL_CMD

inherit
	EB_TOOL_COMMAND

creation
	make

feature -- Execution

	execute is
			-- Execute Current.
		do
			tool.raise
		end

feature -- Status report

--	name: STRING is
--		do
--			if tool = Project_tool then
--				Result := Interface_names.f_Raise_project
--			else
--				Result := tool.title
--			end
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			if tool = Project_tool then
--				Result := Interface_names.m_Raise_project
--			else
--				Result := tool.title
--			end
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			if tool = Project_tool then
--				Result := Interface_names.a_Raise_project
--			end
--		end

end -- class RAISE_TOOL_CMD
