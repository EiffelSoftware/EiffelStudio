--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Terms: SIMPLE_VAR | POLY_INTEGER | NESTED

class TERM 

inherit

	CHOICE
		redefine
			post_action
		end;

	POLYNOM

create

	make

feature 

	construct_name: STRING is
		once
			Result := "TERM"
		end; -- construct_name

	production: LINKED_LIST [CONSTRUCT] is
		local
			id: SIMPLE_VAR;
			val: POLY_INTEGER;
			nest: NESTED
		once
			create Result.make;
			Result.forth;
			create id.make;
			put (id);
			create val.make;
			put (val);
			create nest.make;
			put (nest)
		end; -- production

	post_action is
		do
			retained.post_action
		end -- post_action

end -- class TERM
