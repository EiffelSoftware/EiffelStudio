note
	description: "Cocoa's NSResponder."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class -- Should probably be a deferred class?
	NS_RESPONDER

inherit
	NS_OBJECT

create {NS_OBJECT}
	share_from_pointer

feature -- Access

	initialize_class
		do
			class_.add_method ("mouseDown:", agent mouse_down)
		end

feature -- Changing the First Responder

	accepts_first_responder: BOOLEAN
			-- Overridden by subclasses to return YES if the receiver accepts first responder status.
		do

		end

	become_first_responder: BOOLEAN
			-- Notifies the receiver that it's about to become first responder in its NS_WINDOW.
		do

		end

	resign_first_responder: BOOLEAN
			-- Notifies the receiver that it's been asked to relinquish its status as first responder in its window.
		do

		end

feature -- Managing the Next Responder

feature -- Responding to Mouse Events

	mouse_down (a_event: NS_EVENT)
			-- Informs the receiver that the user has pressed the left mouse button.
		do

		end

	mouse_up (a_event: NS_EVENT)
			-- Informs the receiver that the user has released the left mouse button.
		do

		end

	mouse_moved (a_event: NS_EVENT)
			-- Informs the receiver that the mouse has moved.
		do

		end

	mouse_entered (a_event: NS_EVENT)
			-- Informs the receiver that the cursor has entered a tracking rectangle.
		do

		end

	mouse_exited (a_event: NS_EVENT)
			-- Informs the receiver that the cursor has exited a tracking rectangle.
		do

		end

feature -- Responding to Key Events

	key_down (a_event: NS_EVENT)
			-- Informs the receiver that the user has pressed a key.
		local
			original_method: detachable OBJC_METHOD
			selector: OBJC_SELECTOR
		do
			create selector.make ("keyDown:")
			if attached class_.superclass as l_superclass then
				original_method := l_superclass.instance_method (selector.item)
				check
					original_method /= Void -- If this method is not a redefinition of a parent's method there is no precursor
				end
				call_original (original_method.implementation, item, selector.item, a_event.item)
			else
				check
					has_superclass: False -- class_ needs to have a superlcass, otherwise calling the precursor makes no sense.
				end
			end
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
