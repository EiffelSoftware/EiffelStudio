-- Shared access to the inheritance table

class SHARED_INHERITED 
	
feature {NONE}

	Inherit_table: INHERIT_TABLE is
			-- inheritance table for second pass
		once
			create Result.make (35);
		end;

end
