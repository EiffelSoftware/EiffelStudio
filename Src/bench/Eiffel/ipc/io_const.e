-- Pipe numbers to do io on.
-- Must match the declarations in ipc/shared/ewbio.h

class IO_CONST
	
feature {NONE}

	Listen_to_const: INTEGER is 4; 
		--  Process reads from here
		-- #define EWBIN 4

	Send_to_to_const: INTEGER is 3 
		-- Process writes to there
		-- #define EWBOUT 3

end
