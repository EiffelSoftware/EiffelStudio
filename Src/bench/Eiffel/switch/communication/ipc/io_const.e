-- Pipe numbers to do io on.
-- Must match the declarations in ipc/shared/ewbio.h

class IO_CONST
	
feature {NONE}

	Listen_to_const: INTEGER is 8; 
		--  Process reads from here
		-- #define EWBIN 8

	Send_to_to_const: INTEGER is 7 
		-- Process writes to there
		-- #define EWBOUT 7

end
