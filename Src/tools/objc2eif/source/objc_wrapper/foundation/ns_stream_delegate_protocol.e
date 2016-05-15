note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_STREAM_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	stream__handle_event_ (a_stream: detachable NS_STREAM; a_event_code: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		require
			has_stream__handle_event_: has_stream__handle_event_
		local
			a_stream__item: POINTER
		do
			if attached a_stream as a_stream_attached then
				a_stream__item := a_stream_attached.item
			end
			objc_stream__handle_event_ (item, a_stream__item, a_event_code)
		end

feature -- Status Report

	has_stream__handle_event_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_stream__handle_event_ (item)
		end

feature -- Status Report Externals

	objc_has_stream__handle_event_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(stream:handleEvent:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_stream__handle_event_ (an_item: POINTER; a_stream: POINTER; a_event_code: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(id <NSStreamDelegate>)$an_item stream:$a_stream handleEvent:$a_event_code];
			 ]"
		end

end
