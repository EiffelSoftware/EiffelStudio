indexing

	description:	
		"Window for licensing.";
	date: "$Date$";
	revision: "$Revision$"

class LICENSE_W

inherit

	COMMAND_W;
	LICENSE_WINDOW
		rename
			make as license_window_make,
			dot as cursor_dot
		undefine
			execute, watch_cursor, license
		end;
	SHARED_BENCH_LICENSES

create

	make

feature -- Initialization

	make is
		do
			license_window_make ("License window", Project_tool);
		end;

end -- LICENSE_W
