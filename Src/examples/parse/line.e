-- Lines of the form VARIABLES ":" SUM
-- This is the top construct of the Polynomial language

class LINE 

inherit

	AGGREGATE
		export
			{PROCESS} all
		undefine
			copy, is_equal
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

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

