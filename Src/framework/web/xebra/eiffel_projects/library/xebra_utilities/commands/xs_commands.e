note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_COMMANDS

create
	make, make_with_response

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create {LINKED_LIST [XS_COMMAND]}list.make
		ensure
			list_attached: list /= Void
		end

	make_with_response (a_response: XH_RESPONSE)
			-- Initialization for `Current'.
		do
			make
			list.force (create {XSC_DISPLAY_RESPONSE}.make_with_response(a_response))
		ensure
			list_attached: list /= Void
		end


feature -- Access

	list: LIST [XS_COMMAND]


invariant
	list_attached: list /= Void
end

