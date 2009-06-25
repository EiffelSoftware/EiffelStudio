note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_GET_MODULES

inherit
	XC_COMMAND_RESPONSE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create modules.make (1)
		ensure
			modules_attached: modules /= Void
		end

feature -- Access

	modules: ARRAYED_LIST [XC_SERVER_MODULE_BEAN]

invariant
	modules_attached: modules /= Void
end

