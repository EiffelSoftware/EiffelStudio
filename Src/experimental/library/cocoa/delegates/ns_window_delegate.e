note
	description: "Wrapper for delegate methods of NSWindow."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_WINDOW_DELEGATE

feature -- Creation

	make
		do
			item := window_delegate_class.create_instance.item
		end

feature -- Delegate Methods

	window_did_resize
			-- Sent by the default notification center immediately after an NSWindow object has been moved.
		do
		end

	window_did_move
		do
		end

feature {NS_OBJECT} -- Implementation

	window_delegate_class: OBJC_CLASS
			-- An Objective-C class which has the selectors of the delegate
		do
			create Result.make_with_name (generate_name)
			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSObject"))
			Result.add_method ("windowDidResize:", agent (a_ptr: POINTER) do window_did_resize end)
			Result.add_method ("windowDidMove:", agent (a_ptr: POINTER) do window_did_move end)
			-- windowDidBecomeKey:
			-- windowDidResignKey:
			-- windowShouldClose: / windowWillClose:
			Result.register
		end

	counter: SPECIAL [INTEGER]
		once
			create Result.make_empty (1)
			Result.extend (0)
		end

	generate_name: STRING
		do
			Result := "EiffelWrapperWindowDelegate" + counter.item (0).out
			counter.put (counter.item (0) + 1, 0)
		end

	item: POINTER

end
