note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DRAGGING_DESTINATION_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSDraggingDestination

	dragging_entered_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_DRAGGING_INFO_PROTOCOL): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_dragging_entered_ (a_ns_object.item, a_sender__item)
		end

	dragging_updated_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_DRAGGING_INFO_PROTOCOL): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_dragging_updated_ (a_ns_object.item, a_sender__item)
		end

	dragging_exited_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_DRAGGING_INFO_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_dragging_exited_ (a_ns_object.item, a_sender__item)
		end

	prepare_for_drag_operation_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_DRAGGING_INFO_PROTOCOL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_prepare_for_drag_operation_ (a_ns_object.item, a_sender__item)
		end

	perform_drag_operation_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_DRAGGING_INFO_PROTOCOL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_perform_drag_operation_ (a_ns_object.item, a_sender__item)
		end

	conclude_drag_operation_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_DRAGGING_INFO_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_conclude_drag_operation_ (a_ns_object.item, a_sender__item)
		end

	dragging_ended_ (a_ns_object: NS_OBJECT; a_sender: detachable NS_DRAGGING_INFO_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_dragging_ended_ (a_ns_object.item, a_sender__item)
		end

	wants_periodic_dragging_updates (a_ns_object: NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_wants_periodic_dragging_updates (a_ns_object.item)
		end

feature {NONE} -- NSDraggingDestination Externals

	objc_dragging_entered_ (an_item: POINTER; a_sender: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item draggingEntered:$a_sender];
			 ]"
		end

	objc_dragging_updated_ (an_item: POINTER; a_sender: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item draggingUpdated:$a_sender];
			 ]"
		end

	objc_dragging_exited_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item draggingExited:$a_sender];
			 ]"
		end

	objc_prepare_for_drag_operation_ (an_item: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item prepareForDragOperation:$a_sender];
			 ]"
		end

	objc_perform_drag_operation_ (an_item: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item performDragOperation:$a_sender];
			 ]"
		end

	objc_conclude_drag_operation_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item concludeDragOperation:$a_sender];
			 ]"
		end

	objc_dragging_ended_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item draggingEnded:$a_sender];
			 ]"
		end

	objc_wants_periodic_dragging_updates (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item wantsPeriodicDraggingUpdates];
			 ]"
		end

end
