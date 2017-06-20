note
	description: "Summary description for {JWT_ERROR}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JWT_ERROR

feature -- Access

	id: STRING
		deferred
		end

	message: READABLE_STRING_8
		deferred
		end

end
