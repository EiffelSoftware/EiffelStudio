note
	description: "[
			The command response that contains the list of webapp beans.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_GET_WEBAPPS

inherit
	XC_COMMAND_RESPONSE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create webapps.make (1)
		ensure
			webapps_attached: webapps /= Void
		end

feature -- Access

	webapps: ARRAYED_LIST [XC_WEBAPP_BEAN]

invariant
	webapps_attached: webapps /= Void
end
