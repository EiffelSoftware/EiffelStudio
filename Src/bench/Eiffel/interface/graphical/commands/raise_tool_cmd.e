indexing

	description:
		"Command to raise a tool.";
	date: "$Date$";
	revision: "$Revision: "

class RAISE_TOOL_CMD

inherit
	TOOL_COMMAND
		redefine
			tool
		end
creation
	make

feature {NONE} -- Initialization

	make (a_tool: like tool) is
		do
			tool := a_tool
		end

feature -- Access

	tool: BAR_AND_TEXT

feature -- Execution

	work (arg: ANY) is
			-- Execute Current.
		do
			tool.raise_forced
		end

feature -- Status report

	name: STRING is
		do
			Result := tool.title
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := tool.title
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

end -- class RAISE_TOOL_CMD
