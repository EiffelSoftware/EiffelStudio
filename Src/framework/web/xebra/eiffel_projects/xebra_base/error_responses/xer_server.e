note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XER_SERVER

inherit
	X_ERROR_RESPONSE

feature -- Access

	producer: STRING
			-- <Presursor>
		do
			Result := "Xebra Server "
		end
end
