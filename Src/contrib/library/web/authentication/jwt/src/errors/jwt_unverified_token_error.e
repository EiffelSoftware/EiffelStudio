note
	description: "Summary description for {JWT_UNVERIFIED_TOKEN_ERROR}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_UNVERIFIED_TOKEN_ERROR

inherit
	JWT_ERROR

feature -- Access

	id: STRING = "UNVERIFIED"

	message: READABLE_STRING_8
		do
			Result := "Unverified token"
		end

end
