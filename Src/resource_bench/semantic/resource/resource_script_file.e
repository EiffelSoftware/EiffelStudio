indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_SCRIPT_FILE

inherit
	S_RESOURCE_SCRIPT_FILE	
		export
			{PROCESS} all
		redefine
			process, pre_action
		end

	TABLE_OF_SYMBOLS
	
	ERROR_HANDLING

creation
	make

feature 

	pre_action is 
		local
			a_tds: TABLE_OF_SYMBOLS_STRUCTURE
		do
			!! a_tds.make
			set_tds (a_tds)
		end

feature -- Transformation

	process is
			-- Parse a specimen of the construct, then apply
			-- semantic actions if parsing successful.
		do
			parse;
			if parsed and not has_error then
				semantics
			end
		end;


end -- class RESOURCE_SCRIPT_FILE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

