--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Variables

class VAR 

inherit

	IDENTIFIER
		redefine
			construct_name, action
		end;

	POLYNOM

create

	make

feature {NONE}

	construct_name: STRING is
		once
			Result := "VAR"
		end; -- construct_name

	action is
		do
			info.cons_id_table (token.string_value)
		end -- action

end -- class VAR
