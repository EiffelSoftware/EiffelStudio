-- Shared access to the inheritance table

class SHARED_INHERITED 
	
feature {NONE}

	Inherit_table: INHERIT_TABLE is
			-- inheritance table for second pass
		once
			!!Result.make (100);
		end;

end
