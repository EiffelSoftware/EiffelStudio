--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sums: DIFF "+" DIFF "+" ... "+" DIFF

class SUM 

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
			Result := "SUM"
		end -- construct_name

feature {NONE}

	separator: STRING is "+"

feature 

	production: LINKED_LIST [CONSTRUCT] is
		local
			base: DIFF
		once
			create Result.make;
			Result.forth;
			create base.make;
			put (base)
		end; -- production

	post_action is
		local
			int_value: INTEGER
		do
			if not no_components then
				from
					child_start;
				until
					child_after
				loop
					child.post_action;
					int_value := int_value + info.child_value;
					child_forth
				end;
				info.set_child_value (int_value)
			end
		end -- post_action

end -- class SUM
