indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	SEMANTIQUE

inherit

	S_SEMANTIQUE
		redefine 
			post_action
		end;

	TABLE_OF_SYMBOLS

creation
	make

feature 
	post_action is
		do                
		end

end -- class SEMANTIQUE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
