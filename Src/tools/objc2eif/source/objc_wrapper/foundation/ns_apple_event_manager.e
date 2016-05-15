note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLE_EVENT_MANAGER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSAppleEventManager

	set_event_handler__and_selector__for_event_class__and_event_i_d_ (a_handler: detachable NS_OBJECT; a_handle_event_selector: detachable OBJC_SELECTOR; a_event_class: NATURAL_32; a_event_id: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_handler__item: POINTER
			a_handle_event_selector__item: POINTER
		do
			if attached a_handler as a_handler_attached then
				a_handler__item := a_handler_attached.item
			end
			if attached a_handle_event_selector as a_handle_event_selector_attached then
				a_handle_event_selector__item := a_handle_event_selector_attached.item
			end
			objc_set_event_handler__and_selector__for_event_class__and_event_i_d_ (item, a_handler__item, a_handle_event_selector__item, a_event_class, a_event_id)
		end

	remove_event_handler_for_event_class__and_event_i_d_ (a_event_class: NATURAL_32; a_event_id: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_event_handler_for_event_class__and_event_i_d_ (item, a_event_class, a_event_id)
		end

--	dispatch_raw_apple_event__with_raw_reply__handler_ref_con_ (a_the_apple_event: UNSUPPORTED_TYPE; a_the_reply: UNSUPPORTED_TYPE; a_handler_ref_con: UNSUPPORTED_TYPE): INTEGER_16
--			-- Auto generated Objective-C wrapper.
--		local
--			a_the_apple_event__item: POINTER
--			a_the_reply__item: POINTER
--			a_handler_ref_con__item: POINTER
--		do
--			if attached a_the_apple_event as a_the_apple_event_attached then
--				a_the_apple_event__item := a_the_apple_event_attached.item
--			end
--			if attached a_the_reply as a_the_reply_attached then
--				a_the_reply__item := a_the_reply_attached.item
--			end
--			if attached a_handler_ref_con as a_handler_ref_con_attached then
--				a_handler_ref_con__item := a_handler_ref_con_attached.item
--			end
--			Result := objc_dispatch_raw_apple_event__with_raw_reply__handler_ref_con_ (item, a_the_apple_event__item, a_the_reply__item, a_handler_ref_con__item)
--		end

	current_apple_event: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_apple_event (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_apple_event} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_apple_event} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	current_reply_apple_event: detachable NS_APPLE_EVENT_DESCRIPTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_reply_apple_event (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_reply_apple_event} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_reply_apple_event} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	suspend_current_apple_event: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_suspend_current_apple_event (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like suspend_current_apple_event} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like suspend_current_apple_event} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	apple_event_for_suspension_i_d_ (a_suspension_id: UNSUPPORTED_TYPE): detachable NS_APPLE_EVENT_DESCRIPTOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_suspension_id__item: POINTER
--		do
--			if attached a_suspension_id as a_suspension_id_attached then
--				a_suspension_id__item := a_suspension_id_attached.item
--			end
--			result_pointer := objc_apple_event_for_suspension_i_d_ (item, a_suspension_id__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like apple_event_for_suspension_i_d_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like apple_event_for_suspension_i_d_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	reply_apple_event_for_suspension_i_d_ (a_suspension_id: UNSUPPORTED_TYPE): detachable NS_APPLE_EVENT_DESCRIPTOR
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_suspension_id__item: POINTER
--		do
--			if attached a_suspension_id as a_suspension_id_attached then
--				a_suspension_id__item := a_suspension_id_attached.item
--			end
--			result_pointer := objc_reply_apple_event_for_suspension_i_d_ (item, a_suspension_id__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like reply_apple_event_for_suspension_i_d_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like reply_apple_event_for_suspension_i_d_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	set_current_apple_event_and_reply_event_with_suspension_i_d_ (a_suspension_id: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_suspension_id__item: POINTER
--		do
--			if attached a_suspension_id as a_suspension_id_attached then
--				a_suspension_id__item := a_suspension_id_attached.item
--			end
--			objc_set_current_apple_event_and_reply_event_with_suspension_i_d_ (item, a_suspension_id__item)
--		end

--	resume_with_suspension_i_d_ (a_suspension_id: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_suspension_id__item: POINTER
--		do
--			if attached a_suspension_id as a_suspension_id_attached then
--				a_suspension_id__item := a_suspension_id_attached.item
--			end
--			objc_resume_with_suspension_i_d_ (item, a_suspension_id__item)
--		end

feature {NONE} -- NSAppleEventManager Externals

	objc_set_event_handler__and_selector__for_event_class__and_event_i_d_ (an_item: POINTER; a_handler: POINTER; a_handle_event_selector: POINTER; a_event_class: NATURAL_32; a_event_id: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventManager *)$an_item setEventHandler:$a_handler andSelector:$a_handle_event_selector forEventClass:$a_event_class andEventID:$a_event_id];
			 ]"
		end

	objc_remove_event_handler_for_event_class__and_event_i_d_ (an_item: POINTER; a_event_class: NATURAL_32; a_event_id: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSAppleEventManager *)$an_item removeEventHandlerForEventClass:$a_event_class andEventID:$a_event_id];
			 ]"
		end

--	objc_dispatch_raw_apple_event__with_raw_reply__handler_ref_con_ (an_item: POINTER; a_the_apple_event: UNSUPPORTED_TYPE; a_the_reply: UNSUPPORTED_TYPE; a_handler_ref_con: UNSUPPORTED_TYPE): INTEGER_16
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSAppleEventManager *)$an_item dispatchRawAppleEvent: withRawReply: handlerRefCon:];
--			 ]"
--		end

	objc_current_apple_event (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventManager *)$an_item currentAppleEvent];
			 ]"
		end

	objc_current_reply_apple_event (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAppleEventManager *)$an_item currentReplyAppleEvent];
			 ]"
		end

--	objc_suspend_current_apple_event (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleEventManager *)$an_item suspendCurrentAppleEvent];
--			 ]"
--		end

--	objc_apple_event_for_suspension_i_d_ (an_item: POINTER; a_suspension_id: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleEventManager *)$an_item appleEventForSuspensionID:];
--			 ]"
--		end

--	objc_reply_apple_event_for_suspension_i_d_ (an_item: POINTER; a_suspension_id: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSAppleEventManager *)$an_item replyAppleEventForSuspensionID:];
--			 ]"
--		end

--	objc_set_current_apple_event_and_reply_event_with_suspension_i_d_ (an_item: POINTER; a_suspension_id: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSAppleEventManager *)$an_item setCurrentAppleEventAndReplyEventWithSuspensionID:];
--			 ]"
--		end

--	objc_resume_with_suspension_i_d_ (an_item: POINTER; a_suspension_id: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSAppleEventManager *)$an_item resumeWithSuspensionID:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAppleEventManager"
		end

end
