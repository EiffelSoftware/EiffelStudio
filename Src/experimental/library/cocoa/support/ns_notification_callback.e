note
	description: "Summary description for {NS_NOTIFICATION_CALLBACK}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_CALLBACK

inherit
	NS_OBJECT
		redefine
			class_
		end

create
	make_with_agent

feature -- Creation

	make_with_agent (a_callback: PROCEDURE [ANY, TUPLE[NS_OBJECT]])
		do
			callback := a_callback
			item := class_.create_instance.item
			callback_marshal.register_object (current)
		end

feature -- Implementation

	class_: OBJC_CLASS
			-- Create a new Objective-C object with one method and use this as a callback.
		local
			l_callback_object: NS_OBJECT
			l_sender: POINTER
		once
			create Result.make_with_name ("EiffelWrapperNotificationCallback")
			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSObject"))
			Result.add_method ("callbackMethod:", agent call_observer)
			Result.register
		end

	selector: POINTER
		do
			Result := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make ("callbackMethod:")).item)
		end

	call_observer (a_ptr: POINTER)
		do
			callback.call ([create {NS_OBJECT}.make_from_pointer (a_ptr)])
		end

	callback: PROCEDURE [ANY, TUPLE[NS_OBJECT]]

end
