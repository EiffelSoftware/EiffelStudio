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
		do
			!! profile_tool.make (Current);
			profile_tool.display;
			profile_tool.raise
		end

feature -- Properties

	name: STRING is
		once
			Result := l_Profile_tool
		end

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
