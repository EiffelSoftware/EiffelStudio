-- Terms: SIMPLE_VAR | POLY_INTEGER | NESTED

class TERM 

inherit

	CHOICE
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

