-- Shared instance of intermediate structure for second pass and analysis
-- of selections

class SHARED_ORIGIN_TABLE
	
feature {NONE}

	Origin_table: ORIGIN_TABLE is
			-- Origin table associated to `feature_table': it is the table
			-- of features sorted by origins: necessary for handling the
			-- selections
		once
			create Result.make (500);
		end;

end
