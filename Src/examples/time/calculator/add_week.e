class
	ADD_WEEK

inherit
    COMMAND_DATE

feature -- Access

    execute (d: DATE): DATE is
            -- Add `i' weeks to the date `d'
        do
            Result := d;
			print (display_help);
			io.readint;
            Result.day_add (io.lastint * d.days_in_week)
        end;

    display_help: STRING is
        do
            Result := "Enter the amount of weeks to add: "
        end;

end -- class ADD_WEEK

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

