--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Difference expressions: PRODUCT "-" PRODUCT "-" ... "-" PRODUCT

class DIFF 

inherit

	AGGREGATE
		redefine
			post_action
		end;

	POLYNOM

create

	make

feature 

	construct_name: STRING is "DIFF"

feature {NONE}

	separator: STRING is "-"

feature 

	production: LINKED_LIST [CONSTRUCT] is
		local
			base: PRODUCT
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
			from
				child_start;
				if not no_components then
					child.post_action;
					int_value := info.child_value;
					child_forth
				end;
			until
				no_components or child_after
			loop
				child.post_action;
				int_value := int_value - info.child_value;
				child_forth
			end;
			info.set_child_value (int_value)
		end -- post_action

end -- class DIFF
