--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Products: Term "*" Term "*" ... "*" Term

class PRODUCT 

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
			Result := "PRODUCT"
		end

feature {NONE}

	separator: STRING is "*"

feature 

	production: LINKED_LIST [CONSTRUCT] is
		local
			base: TERM;
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
					if not child_after then
						int_value := 1
					end
				until
					child_after
				loop
					child.post_action;
					int_value := int_value * info.child_value;
					child_forth
				end;
				info.set_child_value (int_value)
			end
		end -- post_action

end -- class PRODUCT
