class SHARED_USED_TABLE
	
feature {NONE}

	Used_table: USED_TABLE is
			-- Shared access to the dead code removal controler
		once
			!!Result.make;
		end;

end
