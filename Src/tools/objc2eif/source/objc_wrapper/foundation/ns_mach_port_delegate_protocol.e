note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_MACH_PORT_DELEGATE_PROTOCOL

inherit
	NS_PORT_DELEGATE_PROTOCOL

feature -- Optional Methods

--	handle_mach_message_ (a_msg: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		require
--			has_handle_mach_message_: has_handle_mach_message_
--		local
--			a_msg__item: POINTER
--		do
--			if attached a_msg as a_msg_attached then
--				a_msg__item := a_msg_attached.item
--			end
--			objc_handle_mach_message_ (item, a_msg__item)
--		end

feature -- Status Report

--	has_handle_mach_message_: BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		do
--			Result := objc_has_handle_mach_message_ (item)
--		end

feature -- Status Report Externals

--	objc_has_handle_mach_message_ (an_item: POINTER): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(id)$an_item respondsToSelector:@selector(handleMachMessage:)];
--			 ]"
--		end

feature {NONE} -- Optional Methods Externals

--	objc_handle_mach_message_ (an_item: POINTER; a_msg: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(id <NSMachPortDelegate>)$an_item handleMachMessage:];
--			 ]"
--		end

end
