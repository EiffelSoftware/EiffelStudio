class
	ADD_MONTH

inherit
	COMMAND_DATE

feature -- Access
	
	execute (d: DATE): DATE is
			-- Add `i' days to the date `d'
		do
			Result := d;
			print (display_help);
			io.readint;
			Result.month_add (io.lastint)
		end;

	display_help: STRING is
		do
			Result := "Enter the amount of month to add: "
		end;

end -- class ADD_DAY

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
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

