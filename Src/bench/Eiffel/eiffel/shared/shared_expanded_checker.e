class SHARED_EXPANDED_CHECKER
	
feature {NONE}

	Expanded_checker: EXPANDED_CHECKER is
			-- Controller of the expanded client relation
		once
			!!Result.make;
		end;

end

