--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Constants for memory statistics
-- DO NOT CHANGE (run-time dependencies)

indexing

	date: "$Date$";
	revision: "$Revision$"

class MEM_CONST

feature

-- Memory types:

	Total_memory: INTEGER is 0;
			-- Code for all the memory managed by the garbage collector

	Eiffel_memory: INTEGER is 1;
			-- Code for the Eiffel memory managed by the garbage collector
	
	C_memory: INTEGER is 2;
			-- Code for the C memory managed by the garbage collector

-- Collector types:

	Full_collector: INTEGER is 0;
			-- Statistics for full collections

	Incremental_collector: INTEGER is 1
			-- Statistics for incremental collections

end

