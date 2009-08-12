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
		local
			oldmethod: PROCEDURE [ANY, TUPLE]
		do
			class_.add_method ("mouseDown:", agent mouse_down)
		end

feature -- Responding to Mouse Events

	mouse_down (a_event: NS_EVENT)
		do
			io.put_string ("Mouse down (NSResponder)%N")
		end

	mouse_up (a_event: NS_EVENT)
		do
			io.put_string ("Mouse up%N")
		end

	mouse_moved (a_event: NS_EVENT)
		do

		end

feature {NONE} -- Implementation

end
