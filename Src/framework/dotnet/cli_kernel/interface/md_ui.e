note
	description: "[
			Interaction with eventual UI
			for now: mostly used to call the DEGREE_OUTPUT.flush_output from time to time
			when generating IL code.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_UI

create
	default_create,
	make_with_action

feature {NONE} -- Initialization

	make_with_action (act: like action)
		do
			action := act
		end

feature -- Event

	checkpoint (m: detachable READABLE_STRING_GENERAL)
		do
			if attached action as act then
				act (m)
			end
		end

feature {NONE} -- Implementation

	action: detachable PROCEDURE [detachable READABLE_STRING_GENERAL]


end
