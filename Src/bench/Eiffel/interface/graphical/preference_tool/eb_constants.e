indexing

	description:
		"Constants for `bench'.";
	date: "$Date$";
	revision: "$Revision$"

class EB_CONSTANTS

feature {NONE} -- Resources

	System_resources: SYSTEM_CATEGORY is
			-- General resources
		once
			!! Result.make
		end;

	Class_resources: CLASS_CATEGORY is
			-- Resources for the class tool
		once
			!! Result.make
		end

end -- class EB_CONSTANTS
