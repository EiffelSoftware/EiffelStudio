indexing
	description: "Shared instance of Cecil hash table Eiffel image."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_CECIL
	
feature {NONE}

	Cecil1: CECIL1 is
		once
			create Result.wipe_out
		end

	Cecil2: CECIL2 is
		once
			create Result.init (1)
		end

	Cecil3: CECIL3 is
		once
			create Result.init (1)
		end

end
