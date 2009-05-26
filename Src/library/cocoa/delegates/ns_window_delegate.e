note
	description: "Wrapper for delegate methods of NSWindow."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_WINDOW_DELEGATE

inherit
	NS_OBJECT

feature

	make
		do
			make_shared (window_delegate_new ($current, $window_did_resize))
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
end
