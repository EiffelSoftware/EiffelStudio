--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Lines of the form VARIABLES ":" SUM
-- This is the top construct of the Polynomial language

class LINE 

inherit

	AGGREGATE
		export
			{PROCESS} all
		redefine 
			post_action
		end;

	POLYNOM

create

	make

feature 

	construct_name: STRING is
		once
			Result := "LINE"
		end; -- construct_name

	production: LINKED_LIST [CONSTRUCT] is
		local
			var: VARIABLES;
			sum: SUM
		once
			create Result.make;
			Result.forth;
			create var.make;
			put (var);
			keyword (":");
			create sum.make;
			put (sum)
		end; -- production

	post_action is
		do
			child_start;
			child.post_action;
			from
				child_finish;
			until
				info.end_session
			loop
				info.set_value;
				child.post_action;
				io.putstring ("value: ");
				io.putint (info.child_value);
				io.new_line
			end
		end -- post_action

end -- class LINE
