indexing
	description: "Base class for configuration errors."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_ERROR

inherit
	ANY
		redefine
			out
		end

feature -- Access

	text: STRING is
			-- The error message.
		deferred
		end

	out: STRING is
			-- Output
		do
			Result := text
		end


end
