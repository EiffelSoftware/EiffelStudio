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

