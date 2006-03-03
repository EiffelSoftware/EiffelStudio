indexing
	description: "Error for two classes with same name in same cluster."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_CLASSDBL

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_class: STRING) is
			-- Create.
		do
			text := "Duplicate class: "+a_class
		end

feature -- Access

	text: STRING

end
