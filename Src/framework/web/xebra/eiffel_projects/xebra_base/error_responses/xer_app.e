note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XER_APP

inherit
	X_ERROR_RESPONSE

feature -- Access

	producer: STRING
			-- <Presursor>
		do
			Result := "Xebra Web Application "
		end
end
