indexing
	description: "Shared instance of Cecil hash table Eiffel image."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_CECIL
	
feature {NONE}

	cecil_routine_table: CECIL_ROUTINE_TABLE is
		once
			create Result.init (1)
		end

	cecil_class_table: CECIL_CLASS_TABLE is
		once
			create Result.init (1)
		end

end
