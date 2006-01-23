indexing
    description: "notion of command to be executed by the calculator"
	legal: "See notice at end of class."
    status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"
    access: date, time

deferred class
	COMMAND_DATE

feature

	execute (d: DATE): DATE is
		require
			d_exists: d /= Void		 
		deferred
		ensure
			result_exists: Result /= Void
		end;

	display_help: STRING is
		deferred
		ensure
			result_exists: Result /= Void
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


end -- class COMMAND_DATE

