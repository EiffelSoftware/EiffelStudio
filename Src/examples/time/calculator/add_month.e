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
