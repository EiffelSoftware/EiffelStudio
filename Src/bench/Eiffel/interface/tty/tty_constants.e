indexing

	description:
		"Constants for `tty'.";
	date: "$Date$";
	revision: "$Revision$"

class TTY_CONSTANTS

feature {NONE} -- Resources

	General_resources: GENERAL_CATEGORY is
			-- General resources
		once
			!! Result.make
		end;

	Class_resources: CLASS_CATEGORY is
			-- Resources for the class tool
		once
			!! Result.make
		end;

	Feature_resources: ROUTINE_CATEGORY is
			-- Resources for the feature tool
		once
			!! Result.make
		end;

end -- class TTY_CONSTANTS
