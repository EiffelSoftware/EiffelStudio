indexing
	description: "Command that super melts a class or a routine and add a breakpoint at%
			%the first instruction oc each routine.";
	date: "$Date$";
	revision: "$Revision$"

class
	BREAKPOINT_INSERTER

inherit
	EB_CONSTANTS

	TOOL_COMMAND
		rename
			init as make
		end

	SHARED_APPLICATION_EXECUTION

creation
	make, do_nothing

feature -- Access

	name: STRING is
		do
			Result := Interface_names.f_Stoppable
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Stoppable
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	insert_breakpoint: BOOLEAN is True
			-- To force a breakpoint at the first line.

feature -- Execution

	work (arg: ANY) is
		do
		end

end -- class BREAKPOINT_INSERTER
