--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Simple variables

class SIMPLE_VAR 

inherit

	IDENTIFIER
		redefine 
			action, construct_name
		end;

	POLYNOM

create

	make

feature {NONE}

	construct_name: STRING is
		once
			Result := "SIMPLE_VAR"
		end; -- construct_name

	action is
		do
			info.set_child_value (info.int_value (token.string_value))
		end -- action

end -- class SIMPLE_VAR
