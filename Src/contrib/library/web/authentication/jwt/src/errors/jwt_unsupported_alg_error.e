note
	description: "Summary description for {JWT_UNSUPPORTED_ALG_ERROR}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_UNSUPPORTED_ALG_ERROR

inherit
	JWT_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_alg: READABLE_STRING_8)
		do
			alg := a_alg
		end

feature -- Access

	alg: READABLE_STRING_8

	id: STRING = "ALG"

	message: READABLE_STRING_8
		do
			Result := "Unsupported alg [" + alg + "]"
		end

end
