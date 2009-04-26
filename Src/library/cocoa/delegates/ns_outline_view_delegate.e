note
	description: "Summary description for {NS_OUTLINE_VIEW_DELEGATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_OUTLINE_VIEW_DELEGATE

feature

	new
		do
			cocoa_object := outline_view_delegate_new ($current, $selection_did_change)
		end

	selection_did_change
		deferred
		end


feature {NONE} -- Objective-C implementation

	frozen outline_view_delegate_new (an_object: POINTER; a_selection_did_change: POINTER): POINTER
		external
			"C inline use %"ns_outline_view_delegate.h%""
		alias
			"return [[OutlineViewDelegate new] initWithCallbackObject: $an_object andMethod: $a_selection_did_change];"
		end

feature {NS_OUTLINE_VIEW}

	cocoa_object: POINTER

end
