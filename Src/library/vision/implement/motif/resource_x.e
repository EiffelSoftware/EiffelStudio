--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- RESOURCE_X: A resource X.

indexing

	date: "$Date$";
	revision: "$Revision$"

class RESOURCE_X 

inherit


creation

	make

	
feature 

	make (a_screen: SCREEN_I; an_identifier: POINTER; is_allocated_r: BOOLEAN) is
			-- Create a resource on `a_screen'
			-- with `an_identifier' as X identifier
		do
			screen := a_screen;
			identifier := an_identifier;
			is_allocated := is_allocated_r
		ensure
			screen = a_screen;
			identifier = an_identifier;
			is_allocated = is_allocated_r
		end; 

	screen: SCREEN_I;
			-- Pointer on the display used

	is_allocated: BOOLEAN;
			-- Is resource allocated by the program ?

	identifier: POINTER
			-- X identifier of the resource

end 
