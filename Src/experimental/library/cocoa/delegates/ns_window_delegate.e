note
	description: "Wrapper for delegate methods of NSWindow."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_WINDOW_DELEGATE

feature

	make
		do
			item := window_delegate_new ($current, $window_did_resize)
		end

	window_did_resize
		do
		end

feature {NONE} -- Objective-C implementation

	frozen window_delegate_new (an_object: POINTER; a_method: POINTER): POINTER
		external
			"C inline use %"ns_window_delegate.h%""
		alias
			"return [[WindowDelegate new] initWithCallbackObject: $an_object andMethod: $a_method];"
		end

feature {NS_OBJECT} -- Should be used by classes in native only

	item: POINTER
	 	-- The C-pointer to the Cocoa object
end
