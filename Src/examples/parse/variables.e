-- Variable lists

class VARIABLES 

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

