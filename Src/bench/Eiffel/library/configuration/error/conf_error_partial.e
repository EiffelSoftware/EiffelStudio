indexing
	description: "Error during merging of partial classes."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_PARTIAL

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (an_error: STRING) is
			-- Create.
		do
			text := "Error during merging of partial classes: "
			if an_error /= Void then
				text.append (an_error)
			end
		end

feature -- Access

	text: STRING

end
