class
	SET_DATE

inherit
    COMMAND_DATE

feature -- Access

    execute (d: DATE): DATE is
            -- Date choosen par user
		local
			year, month, day: INTEGER
        do
            Result := d;
			print (display_help)
			print ("%Nyear: ");
			io.readint;
			year:= io.lastint;
			print ("month: ");
			io.readint;
			month:= io.lastint;
			print ("day: ");
 			io.readint;
			day:= io.lastint;
			Result.make (year, month, day);
        end;

    display_help: STRING is
        do
            Result := "Enter new year then new month and new day"
        end;

end -- class SET_DATE


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

