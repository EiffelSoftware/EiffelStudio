note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSCR_GET_MODULES

inherit
	XS_COMMAND_RESPONSE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create modules.make
		ensure
			modules_attached: modules /= Void
		end

feature -- Access

	modules: LINKED_LIST [TUPLE[ name: STRING; launched: BOOLEAN; running: BOOLEAN]]

invariant
	modules_attached: modules /= Void
end

