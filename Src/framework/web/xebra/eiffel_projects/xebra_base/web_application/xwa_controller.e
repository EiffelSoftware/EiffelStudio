note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_CONTROLLER

feature -- Access

	current_request: detachable XH_REQUEST

feature -- Events

	on_page_load
			--
		deferred
		end

feature -- Status Change

	set_current_request (a_request: XH_REQUEST)
			--
		do
			current_request := a_request
		ensure
			current_request_attached: attached current_request
		end
end
