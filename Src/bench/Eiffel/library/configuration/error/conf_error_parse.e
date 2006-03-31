indexing
	description: "Parse parse error."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_PARSE

inherit
	CONF_ERROR

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_message: STRING) is
			-- Create.
		require
			a_message_not_void: a_message /= Void
		do
			message := a_message
		end

feature -- Access

	text: STRING is
		do
			Result := "Parse error"
			if file /= Void then
				Result.append (" in "+file)
			end
			if message /= Void then
				Result.append (": "+message)
			end
		end

feature -- Update

	set_file (a_file: STRING) is
			-- Set config file with error to `a_file'.
		do
			file := a_file
		end


	set_message (a_message: STRING) is
			-- Set the extended error message to `a_message'.
		do
			message := a_message
		end

feature {NONE} -- Implementation

	message: STRING
	file: STRING

end
