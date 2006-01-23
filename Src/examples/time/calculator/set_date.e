indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SET_DATE


