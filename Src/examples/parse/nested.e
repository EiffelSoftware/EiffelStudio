-- Parenthesized expressions: "(" SUM ")"

class NESTED 

inherit

	AGGREGATE
		redefine
			post_action
		end;

	POLYNOM
		undefine
			copy, is_equal
		end

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

