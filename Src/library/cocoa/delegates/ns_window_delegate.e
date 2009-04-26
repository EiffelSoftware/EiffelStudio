note
	description: "Summary description for {NS_WINDOW_DELEGATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_WINDOW_DELEGATE

feature

	new
		do
			cocoa_object := window_delegate_new ($current, $window_did_resize)
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

feature {NS_WINDOW}

	cocoa_object: POINTER

end
