class
	SHARED_ASSERTION_LEVEL
	
feature {NONE}

	No_level: NO_I is
		once
			!!Result
		end

	Default_level, Require_level: REQUIRE_I is
		once
			!!Result
		end

	Ensure_level: ENSURE_I is
		once
			!!Result
		end

	Invariant_level: INVARIANT_I is
		once
			!!Result
		end

	Loop_level: LOOP_I is
		once
			!!Result
		end

	Check_level: CHECK_I is
		once
			!!Result
		end

end
