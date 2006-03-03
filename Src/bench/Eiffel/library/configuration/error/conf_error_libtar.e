indexing
	description: "Error that the library target has not been defined."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_LIBTAR

inherit
	CONF_ERROR

feature -- Access

	text: STRING is "The defined library target could not be found."

end
