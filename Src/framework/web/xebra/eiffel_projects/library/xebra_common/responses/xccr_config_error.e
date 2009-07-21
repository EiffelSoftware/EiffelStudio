note
	description: "[
		The error command response that occurs if the server cannot load the config file.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_CONFIG_ERROR

inherit
	XCCR_ERROR

feature -- Access

	description: STRING
			-- Describes the error
		do
			Result := "There was an error while loading the configuration file."
		end
end
