indexing
    description: "notion of command to be executed by the calculator"
    status: "See notice at end of class"
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

end -- class COMMAND_DATE
