note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_PORT_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	handle_port_message_ (a_message: detachable NS_PORT_MESSAGE)
			-- Auto generated Objective-C wrapper.
		require
			has_handle_port_message_: has_handle_port_message_
		local
			a_message__item: POINTER
		do
			if attached a_message as a_message_attached then
				a_message__item := a_message_attached.item
			end
			objc_handle_port_message_ (item, a_message__item)
		end

feature -- Status Report

	has_handle_port_message_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_handle_port_message_ (item)
		end

feature -- Status Report Externals

	objc_has_handle_port_message_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(handlePortMessage:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_handle_port_message_ (an_item: POINTER; a_message: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSPortDelegate>)$an_item handlePortMessage:$a_message];
			 ]"
		end

end
