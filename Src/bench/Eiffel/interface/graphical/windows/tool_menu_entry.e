indexing

	description:
		"Menu entry for tools created in a session";
	date: "$Date$";
	revision: "$Revision$"

class TOOL_MENU_ENTRY

inherit

	EB_MENU_ENTRY
		rename
			make as eb_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_cmd: like associated_command; a_parent: MENU; a_tool: like tool) is
			-- Initialize Current with `associated_command' set
			-- to `a_cmd' and `parent' set to `a_parent'.
		do
			tool := a_tool;
			make_default (a_cmd, a_parent)
		end

feature -- Access

	tool: TOOL_W

end -- class TOOL_MENU_ENTRY
