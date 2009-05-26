note
	description: "Cocoa's NSResponder."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RESPONDER

inherit
	NS_OBJECT

feature -- Access

	initialize
		do
			set_responder_callback ($current, $responder_callback)
		end

feature -- Responding to Mouse Events

	mouse_down (a_event: NS_EVENT)
		do

		end

	mouse_up (a_event: NS_EVENT)
		do

		end

	mouse_moved (a_event: NS_EVENT)
		do

		end

feature {NONE} -- Implementation

	responder_callback (a_object: POINTER; a_data: POINTER)
		do

		end

	frozen set_responder_callback (a_object: POINTER; a_method: POINTER)
		external
			"C inline use %"ns_responder_category.h%""
		alias
			"setResponderCallback ($a_object, $a_method);"
		end

end
