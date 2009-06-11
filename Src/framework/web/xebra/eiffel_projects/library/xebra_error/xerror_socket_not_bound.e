note
	description: "Summary description for {XERROR_SOCKET_NOT_BOUND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XERROR_SOCKET_NOT_BOUND

inherit
	ERROR_ERROR_INFO
		rename
			make as make_error
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_error ([""])
		end

feature -- Access


feature {NONE} -- Access

	dollar_description: STRING
			-- <Precursor>
		do
			Result := "Socket could not be bound."
		end


end
