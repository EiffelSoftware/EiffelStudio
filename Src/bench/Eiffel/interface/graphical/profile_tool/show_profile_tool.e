indexing

	description:
		"Command to show the profile tool.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_PROFILE_TOOL

inherit
	PIXMAP_COMMAND
		rename
			init as make
		end

creation
	make

feature {NONE} -- Execution

	work (arg: ANY) is
		local
			mp: MOUSE_PTR
		do
			!! mp.set_watch_cursor;
			!! profile_tool.make (Current);
			profile_tool.display;
			profile_tool.raise;
			mp.restore
		end

feature -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Profile_tool
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Profile_tool
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	symbol: PIXMAP is
		do
		end

feature {NONE} -- Properties

	profile_tool: PROFILE_TOOL;
			-- The profile tool

feature {PROFILE_TOOL} -- Implementation

	done_profiling is
			-- The profile has been closed.
		do
			profile_tool.destroy;
			profile_tool := Void
		end

end -- class SHOW_PROFILE_TOOL
