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
