-- Shared instance of Cecil hash table Eiffel image

class SHARED_CECIL
	
feature {NONE}

	Cecil1: CECIL1 is
		once
			!!Result;
		end;

	Cecil2: CECIL2 is
		once
			!!Result.init (1);
		end;

	Cecil3: CECIL3 is
		once
			!!Result.init (1);
		end;

end
