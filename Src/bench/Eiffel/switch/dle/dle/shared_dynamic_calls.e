class SHARED_DYNAMIC_CALLS
	
feature {NONE}

	No_dynamic: DYNAMIC_NO_I is
		once
			!!Result;
		end;

	All_dynamic: DYNAMIC_ALL_I is
		once
			!!Result;
		end;

end -- class SHARED_DYNAMIC_CALLS
