indexing

	description:
		"Command to raise a tool.";
	date: "$Date$";
	revision: "$Revision: "

class RAISE_TOOL_CMD

inherit
	TOOL_COMMAND

create
	make

feature {NONE} -- Initialization

	make (a_tool: like tool) is
		do
			tool := a_tool
		end

feature -- Execution

	work (arg: ANY) is
			-- Execute Current.
		do
			tool.force_raise
		end

feature -- Status report

	name: STRING is
		do
			if tool = Project_tool then
				Result := Interface_names.f_Raise_project
			else
				Result := tool.title
			end
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			if tool = Project_tool then
				Result := Interface_names.m_Raise_project
			else
				Result := tool.title
			end
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			if tool = Project_tool then
				Result := Interface_names.a_Raise_project
			end
		end;

end -- class RAISE_TOOL_CMD
