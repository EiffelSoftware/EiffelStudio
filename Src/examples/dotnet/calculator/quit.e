--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, CA 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Quit"
	external_name: "ISE.Examples.Calculator.Quit"
	
class 
	QUIT

inherit
	STATE
		redefine 
			process
		end

create
	make

feature -- Basic Operations
	
	operation is
		indexing
			description: "Useless"
			external_name: "Operation"
		do
		end

	process is
		indexing
			description: "Useless"
			external_name: "Process"
		do
		end

end -- class QUIT
