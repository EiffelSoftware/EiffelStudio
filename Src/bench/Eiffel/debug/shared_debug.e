
class SHARED_DEBUG

feature

	debug_info: DEBUG_INFO is
		once
			!!Result.make
		end;
	
	run_info: RUN_INFO is
		once
			!!Result.make
		end;

	quit_cmd: DEBUG_QUIT is
			-- Kills the child if any
		once
			!!Result.non_gui_make
		end;

end
