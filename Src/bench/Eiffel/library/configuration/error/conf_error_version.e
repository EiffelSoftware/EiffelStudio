indexing
	description: "Error for old versions."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_VERSION

inherit
	CONF_ERROR

feature -- Access

	text: STRING is "Config file format version missmatch."

end
