-- Shared access to the pattern table

class SHARED_PATTERN_TABLE

inherit
	SHARED_WORKBENCH
	
feature {NONE}

	Pattern_table: PATTERN_TABLE is
			-- Pattern table of the system
		do
			Result := System.pattern_table;
		end;

end
