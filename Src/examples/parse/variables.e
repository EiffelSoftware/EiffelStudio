--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Variable lists

class VARIABLES 

inherit

	AGGREGATE
		redefine
			post_action
		end;

	POLYNOM

create

	make

feature 

	construct_name: STRING is
		once
			Result := "VARIABLES"
		end -- construct_name

feature {NONE}

	separator: STRING is ";"

feature 

	production: LINKED_LIST [IDENTIFIER] is
		local
			base: VAR
		once
			create Result.make;
			Result.forth;
			create base.make;
			put (base)
		end; -- production

	post_action is
		do
			if not no_components then
				from
					child_start
				until
					child_after
				loop
					child.post_action;
					child_forth
				end
			end
		end -- post_action

end -- class VARIABLES
