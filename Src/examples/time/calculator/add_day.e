class
	ADD_DAY

inherit
	COMMAND_DATE

feature -- Access

	execute (d: DATE): DATE is
			-- Add `i' days to the date `d'
		do
			Result := d;
			print (display_help);
			io.readint;
			Result.day_add (io.lastint)
		end;

	display_help: STRING is
		do
			Result := "Enter the amount of days to add: "
		end;

end -- class ADD_DAY
