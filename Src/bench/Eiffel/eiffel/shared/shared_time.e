-- Shared instance of time stamp checker

class SHARED_TIME
	
feature {NONE}

	Time_checker: TIME_CHECKER is
			-- Time stamp checker
		once
			create Result;
		end;

end
