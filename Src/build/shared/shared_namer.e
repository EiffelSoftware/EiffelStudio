class SHARED_NAMER 
	
feature {NONE}

	Shared_namer_values: HASH_TABLE [INTEGER, STRING] is
		once
			!!Result.make (10)
		end;

end
