--|---------------------------------------------------------------
--|   Copyright (C) 1989 Interactive Software Engineering, Inc. --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Access to command-line arguments.

class ARGUMENTS 

feature 

	argument (i: INTEGER): STRING is
			-- Command line argument number `i'
			-- (the command name if `i' = 0)
		require
			0 <= i ; i < argument_count
		do
			Result := arg_option (i) 
		end;

	argument_count: INTEGER is
			-- Number of arguments on the command line
			-- (including command name)
		once
			Result := arg_number
		end;

feature {NONE} -- External features

	arg_number: INTEGER is
		external
			"C"
		end;

	arg_option (i: INTEGER): STRING is
		external
			"C"
		end;

end
