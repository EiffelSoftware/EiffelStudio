note
	description: "Wrapper for delegate methods of NSText."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_TEXT_DELEGATE

inherit
	DELEGATE

feature -- Class

	delegate_class: OBJC_CLASS
		once
			create Result.make_with_name ("TextDelegate")
			Result.set_superclass (create {OBJC_CLASS}.make_with_name("NSObject"))
			Result.add_method ("textDidChange:", agent text_did_change_callback)
			Result.register
		end

	text_did_change_callback (a_notification: POINTER)
		do
			if attached text_did_change_actions_internal as actions then
				actions.call([])
			end
		end

	delegate: detachable NS_OBJECT

	init_delegate
		local
			l_delegate: like delegate
		do
			if attached l_delegate then
				l_delegate := delegate_class.create_instance
				l_delegate.init

				{NS_OUTLINE_VIEW_API}.set_delegate (item, l_delegate.item)
				delegate := l_delegate
			end
		end

	text_did_change_actions: ACTION_SEQUENCE [TUPLE[]]
		do
			if attached text_did_change_actions_internal as actions then
				Result := actions
			else
				create Result
				text_did_change_actions_internal := Result
			end
		end

feature {NONE} -- Implementation

	text_did_change_actions_internal: detachable ACTION_SEQUENCE [TUPLE[]]

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
