indexing

	description:
		"Command to bring up the explain window. %
		%It'll open a help file for the profile tool.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILE_HELP_CMD

inherit
	TOOL_COMMAND

feature -- Access

	name: STRING is
			-- Name for Current
		do
			Result := Interface_names.f_Help
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Help
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature {NONE} -- Execution

	work (arg: ANY) is
			-- Execute Current
		local
			explain: EXPLAIN_W
		do
			explain := window_manager.explain_window;
				--| FIXME:
				--| Open up a help file needs to
				--| be done by Dino V.
			explain.display;
			explain.raise
		end

end -- class PROFILE_HELP_CMD
