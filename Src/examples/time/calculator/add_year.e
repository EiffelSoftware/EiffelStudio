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
