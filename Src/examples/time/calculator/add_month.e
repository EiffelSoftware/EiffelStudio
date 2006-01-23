indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


end -- class ADD_DAY

