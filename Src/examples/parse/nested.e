--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Parenthesized expressions: "(" SUM ")"

class NESTED 

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
			Result := "NESTED"
		end; -- construct_name

	production: LINKED_LIST [CONSTRUCT] is
		local
			expression: SUM
		once
			create Result.make;
			Result.forth;
			keyword ("(");
			commit;
			create expression.make;
			put (expression);
			keyword (")")
		end; -- production

	post_action is
		do       
			child_start;
			child_forth;
			child.post_action
		end -- post_action

end -- class NESTED
