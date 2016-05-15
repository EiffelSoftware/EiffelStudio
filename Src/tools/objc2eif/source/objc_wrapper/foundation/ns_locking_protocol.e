note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_LOCKING_PROTOCOL

inherit
	NS_COMMON

feature -- Required Methods

	lock
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_lock (item)
		end

	unlock
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unlock (item)
		end

feature {NONE} -- Required Methods Externals

	objc_lock (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSLocking>)$an_item lock];
			 ]"
		end

	objc_unlock (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSLocking>)$an_item unlock];
			 ]"
		end

end
