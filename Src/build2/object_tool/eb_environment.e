indexing
	description: "EiffelBuild environment."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"


class EB_ENVIRONMENT 

	--| FIXME extracted from Build, minor changes.
	--| A lot of things removed from version shipped
	--| with Build.

inherit

	OPERATING_ENVIRONMENT

	EXECUTION_ENVIRONMENT
		rename
			put as environment_put
		end

feature -- Directory names for projects

	Common_directory: DIRECTORY_NAME is
			-- Directory known by EiffelBench used to move 
			-- information between both tools.
		do
			create Result.make_from_string ("D:\work\object_editor\Generated")
		end
		
end	-- class EB_ENVIRONMENT
