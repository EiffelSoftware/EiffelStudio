note
	description: "Summary description for {UI_DISPATCHER_CONST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UI_DISPATCHER_CONST

feature -- Message constants

	UI_APPLICATION_DID_FINISH_LAUNCHING: NATURAL = 1
	UI_RESPONDER_TOUCHES_BEGAN: NATURAL = 2
	UI_RESPONDER_TOUCHES_MOVED: NATURAL = 3
	UI_RESPONDER_TOUCHES_CANCELLED: NATURAL = 4
	UI_RESPONDER_TOUCHES_ENDED: NATURAL = 5
	UI_RESPONDER_MOTION_BEGAN: NATURAL = 6
	UI_RESPONDER_MOTION_CANCELLED: NATURAL = 7
	UI_RESPONDER_MOTION_ENDED: NATURAL = 8
	UI_ACCELEROMETER_MSG: NATURAL = 9
	UI_APPLICATION_DID_RECEIVE_MEMORY_WARNING: NATURAL = 10

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
