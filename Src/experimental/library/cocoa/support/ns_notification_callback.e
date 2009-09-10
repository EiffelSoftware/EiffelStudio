note
	description: "A class for objects which can be used by NS_NOTIFICATION_CENTER to deliver callbacks."
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
			instance := class_.create_instance
			instance.init
			item := instance.item
			{NS_OBJECT_API}.retain (item)
			callback_marshal.register_object (current)
		end

feature -- Implementation

	class_: OBJC_CLASS
			-- Create a new Objective-C object with one method and use this as a callback.
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

	call_observer (a_object: NS_OBJECT)
		do
			callback.call ([create {NS_NOTIFICATION}.share_from_pointer (a_object.item)])
		end

	callback: PROCEDURE [ANY, TUPLE[NS_OBJECT]]

	instance: NS_OBJECT

end
