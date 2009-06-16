note
	description: "Wrapper for delegate methods of NSText."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_DELEGATE

inherit
	NS_OBJECT

feature -- Delegate Methods

	text_should_begin_editing (a_text_object: NS_TEXT): BOOLEAN
		do
			Result := text_field_text_should_begin_editing (item, a_text_object.item)
		end

	text_should_end_editing (a_text_object: NS_TEXT): BOOLEAN
		do
			Result := text_field_text_should_end_editing (item, a_text_object.item)
		end

	text_did_begin_editing (a_notification: NS_NOTIFICATION)
		do
			text_field_text_did_begin_editing (item, a_notification.item)
		end

	text_did_end_editing (a_notification: NS_NOTIFICATION)
		do
			text_field_text_did_end_editing (item, a_notification.item)
		end

	text_did_change (a_notification: NS_NOTIFICATION)
		do
			text_field_text_did_change (item, a_notification.item)
		end

feature -- Objective-C implementation

	frozen text_field_text_should_begin_editing (a_text_field: POINTER; a_text_object: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field textShouldBeginEditing: $a_text_object];"
		end

	frozen text_field_text_should_end_editing (a_text_field: POINTER; a_text_object: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTextField*)$a_text_field textShouldEndEditing: $a_text_object];"
		end

	frozen text_field_text_did_begin_editing (a_text_field: POINTER; a_notification: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field textDidBeginEditing: $a_notification];"
		end

	frozen text_field_text_did_end_editing (a_text_field: POINTER; a_notification: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field textDidEndEditing: $a_notification];"
		end

	frozen text_field_text_did_change (a_text_field: POINTER; a_notification: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTextField*)$a_text_field textDidChange: $a_notification];"
		end

end
