class SHARED_DEBUG_LEVEL 
	
feature {NONE}

	No_debug: DEBUG_NO_I is
		once
			!!Result;
		end;

	Yes_debug: DEBUG_YES_I is
		once
			!!Result;
		end;

end
