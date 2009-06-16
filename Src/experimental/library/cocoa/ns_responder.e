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
			c: OBJC_CLASS
		do
			create c.make_with_name ("NSButton")
			oldmethod := c.replace_method ("mouseDown:", agent mouse_down_z)
		end

	mouse_down_z (a_event: POINTER)
		do
			io.put_string ("Mouse down in NSRESPONDER%N")
		end

feature -- Responding to Mouse Events

	mouse_down (a_event: NS_EVENT)
		do
			io.put_string ("Mouse down%N")
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
