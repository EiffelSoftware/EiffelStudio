class
	ADD_YEAR

inherit
    COMMAND_DATE

feature -- Access

    execute (d: DATE): DATE is
            -- Add `i' years to the date `d'
        do
            Result := d;
			print (display_help);
			io.readint;
            Result.year_add (io.lastint)
        end;

    display_help: STRING is
        do
            Result := "Enter the amount of years to add: "
        end;

end -- class ADD_YEAR

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------

