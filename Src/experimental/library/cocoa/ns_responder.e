note
	description: "Cocoa's NSResponder."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RESPONDER

inherit
	NS_OBJECT

feature -- Access

	initialize_class
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

feature -- Responding to Key Events

	key_down (a_event: NS_EVENT)
			-- Informs the receiver that the user has pressed a key.
		local
			original_method: detachable OBJC_METHOD
			selector: OBJC_SELECTOR
			invocation: NS_INVOCATION
		do
			create selector.make ("keyDown:")
			original_method := class_.superclass.instance_method (selector.item)
			check
				original_method /= Void
			end
			call_original (original_method.implementation, item, selector.item, a_event.item)
		end

	key_up (a_event: NS_EVENT)
			-- Informs the receiver that the user has released a key.
		do

		end

feature {NONE} -- Implementation

	frozen call_original (a_method: POINTER; a_object: POINTER; a_selector: POINTER; a_arg: POINTER)
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"((IMP)$a_method) ($a_object, $a_selector, $a_arg);"
		end

end
