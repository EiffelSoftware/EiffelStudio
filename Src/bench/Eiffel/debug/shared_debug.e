
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

end
