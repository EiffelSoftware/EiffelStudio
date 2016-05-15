note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLICATION

inherit
	NS_RESPONDER
		redefine
			wrapper_objc_class_name
		end

	NS_USER_INTERFACE_VALIDATIONS_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSApplication

	set_delegate_ (an_object: detachable NS_APPLICATION_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_APPLICATION_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	context: detachable NS_GRAPHICS_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	hide_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_hide_ (item, a_sender__item)
		end

	unhide_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_unhide_ (item, a_sender__item)
		end

	unhide_without_activation
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unhide_without_activation (item)
		end

	window_with_window_number_ (a_window_num: INTEGER_64): detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window_with_window_number_ (item, a_window_num)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_with_window_number_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_with_window_number_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	main_window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_main_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like main_window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like main_window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	key_window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key_window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key_window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_active: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_active (item)
		end

	is_hidden: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_hidden (item)
		end

	is_running: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_running (item)
		end

	deactivate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_deactivate (item)
		end

	activate_ignoring_other_apps_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_activate_ignoring_other_apps_ (item, a_flag)
		end

	hide_other_applications_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_hide_other_applications_ (item, a_sender__item)
		end

	unhide_all_applications_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_unhide_all_applications_ (item, a_sender__item)
		end

	finish_launching
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_finish_launching (item)
		end

	run
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_run (item)
		end

	run_modal_for_window_ (a_the_window: detachable NS_WINDOW): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_the_window__item: POINTER
		do
			if attached a_the_window as a_the_window_attached then
				a_the_window__item := a_the_window_attached.item
			end
			Result := objc_run_modal_for_window_ (item, a_the_window__item)
		end

	stop_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_stop_ (item, a_sender__item)
		end

	stop_modal
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_modal (item)
		end

	stop_modal_with_code_ (a_return_code: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_modal_with_code_ (item, a_return_code)
		end

	abort_modal
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_abort_modal (item)
		end

	modal_window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_modal_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like modal_window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like modal_window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	begin_modal_session_for_window_ (a_the_window: detachable NS_WINDOW): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_the_window__item: POINTER
--		do
--			if attached a_the_window as a_the_window_attached then
--				a_the_window__item := a_the_window_attached.item
--			end
--			result_pointer := objc_begin_modal_session_for_window_ (item, a_the_window__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like begin_modal_session_for_window_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like begin_modal_session_for_window_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	run_modal_session_ (a_session: UNSUPPORTED_TYPE): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_session__item: POINTER
--		do
--			if attached a_session as a_session_attached then
--				a_session__item := a_session_attached.item
--			end
--			Result := objc_run_modal_session_ (item, a_session__item)
--		end

--	end_modal_session_ (a_session: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_session__item: POINTER
--		do
--			if attached a_session as a_session_attached then
--				a_session__item := a_session_attached.item
--			end
--			objc_end_modal_session_ (item, a_session__item)
--		end

	terminate_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_terminate_ (item, a_sender__item)
		end

	request_user_attention_ (a_request_type: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_request_user_attention_ (item, a_request_type)
		end

	cancel_user_attention_request_ (a_request: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel_user_attention_request_ (item, a_request)
		end

--	begin_sheet__modal_for_window__modal_delegate__did_end_selector__context_info_ (a_sheet: detachable NS_WINDOW; a_doc_window: detachable NS_WINDOW; a_modal_delegate: detachable NS_OBJECT; a_did_end_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_sheet__item: POINTER
--			a_doc_window__item: POINTER
--			a_modal_delegate__item: POINTER
--			a_did_end_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_sheet as a_sheet_attached then
--				a_sheet__item := a_sheet_attached.item
--			end
--			if attached a_doc_window as a_doc_window_attached then
--				a_doc_window__item := a_doc_window_attached.item
--			end
--			if attached a_modal_delegate as a_modal_delegate_attached then
--				a_modal_delegate__item := a_modal_delegate_attached.item
--			end
--			if attached a_did_end_selector as a_did_end_selector_attached then
--				a_did_end_selector__item := a_did_end_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_begin_sheet__modal_for_window__modal_delegate__did_end_selector__context_info_ (item, a_sheet__item, a_doc_window__item, a_modal_delegate__item, a_did_end_selector__item, a_context_info__item)
--		end

	end_sheet_ (a_sheet: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_sheet__item: POINTER
		do
			if attached a_sheet as a_sheet_attached then
				a_sheet__item := a_sheet_attached.item
			end
			objc_end_sheet_ (item, a_sheet__item)
		end

	end_sheet__return_code_ (a_sheet: detachable NS_WINDOW; a_return_code: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_sheet__item: POINTER
		do
			if attached a_sheet as a_sheet_attached then
				a_sheet__item := a_sheet_attached.item
			end
			objc_end_sheet__return_code_ (item, a_sheet__item, a_return_code)
		end

	next_event_matching_mask__until_date__in_mode__dequeue_ (a_mask: NATURAL_64; a_expiration: detachable NS_DATE; a_mode: detachable NS_STRING; a_deq_flag: BOOLEAN): detachable NS_EVENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_expiration__item: POINTER
			a_mode__item: POINTER
		do
			if attached a_expiration as a_expiration_attached then
				a_expiration__item := a_expiration_attached.item
			end
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			result_pointer := objc_next_event_matching_mask__until_date__in_mode__dequeue_ (item, a_mask, a_expiration__item, a_mode__item, a_deq_flag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_event_matching_mask__until_date__in_mode__dequeue_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_event_matching_mask__until_date__in_mode__dequeue_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	discard_events_matching_mask__before_event_ (a_mask: NATURAL_64; a_last_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_last_event__item: POINTER
		do
			if attached a_last_event as a_last_event_attached then
				a_last_event__item := a_last_event_attached.item
			end
			objc_discard_events_matching_mask__before_event_ (item, a_mask, a_last_event__item)
		end

	post_event__at_start_ (a_event: detachable NS_EVENT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_post_event__at_start_ (item, a_event__item, a_flag)
		end

	current_event: detachable NS_EVENT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_event (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_event} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_event} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	send_event_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_send_event_ (item, a_the_event__item)
		end

	prevent_window_ordering
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_prevent_window_ordering (item)
		end

	make_windows_perform__in_order_ (a_selector: detachable OBJC_SELECTOR; a_flag: BOOLEAN): detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			result_pointer := objc_make_windows_perform__in_order_ (item, a_selector__item, a_flag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like make_windows_perform__in_order_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like make_windows_perform__in_order_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	windows: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_windows (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like windows} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like windows} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_windows_need_update_ (a_need_update: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_windows_need_update_ (item, a_need_update)
		end

	update_windows
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_windows (item)
		end

	set_main_menu_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_main_menu_ (item, a_menu__item)
		end

	main_menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_main_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like main_menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like main_menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_help_menu_ (a_help_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_help_menu__item: POINTER
		do
			if attached a_help_menu as a_help_menu_attached then
				a_help_menu__item := a_help_menu_attached.item
			end
			objc_set_help_menu_ (item, a_help_menu__item)
		end

	help_menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_help_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like help_menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like help_menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_application_icon_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_application_icon_image_ (item, a_image__item)
		end

	application_icon_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_application_icon_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like application_icon_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like application_icon_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	activation_policy: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_activation_policy (item)
		end

	set_activation_policy_ (a_activation_policy: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_set_activation_policy_ (item, a_activation_policy)
		end

	dock_tile: detachable NS_DOCK_TILE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dock_tile (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dock_tile} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dock_tile} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	send_action__to__from_ (a_the_action: detachable OBJC_SELECTOR; a_the_target: detachable NS_OBJECT; a_sender: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_action__item: POINTER
			a_the_target__item: POINTER
			a_sender__item: POINTER
		do
			if attached a_the_action as a_the_action_attached then
				a_the_action__item := a_the_action_attached.item
			end
			if attached a_the_target as a_the_target_attached then
				a_the_target__item := a_the_target_attached.item
			end
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			Result := objc_send_action__to__from_ (item, a_the_action__item, a_the_target__item, a_sender__item)
		end

	target_for_action_ (a_the_action: detachable OBJC_SELECTOR): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_the_action__item: POINTER
		do
			if attached a_the_action as a_the_action_attached then
				a_the_action__item := a_the_action_attached.item
			end
			result_pointer := objc_target_for_action_ (item, a_the_action__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like target_for_action_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like target_for_action_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	target_for_action__to__from_ (a_the_action: detachable OBJC_SELECTOR; a_the_target: detachable NS_OBJECT; a_sender: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_the_action__item: POINTER
			a_the_target__item: POINTER
			a_sender__item: POINTER
		do
			if attached a_the_action as a_the_action_attached then
				a_the_action__item := a_the_action_attached.item
			end
			if attached a_the_target as a_the_target_attached then
				a_the_target__item := a_the_target_attached.item
			end
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			result_pointer := objc_target_for_action__to__from_ (item, a_the_action__item, a_the_target__item, a_sender__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like target_for_action__to__from_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like target_for_action__to__from_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	report_exception_ (a_the_exception: detachable NS_EXCEPTION)
			-- Auto generated Objective-C wrapper.
		local
			a_the_exception__item: POINTER
		do
			if attached a_the_exception as a_the_exception_attached then
				a_the_exception__item := a_the_exception_attached.item
			end
			objc_report_exception_ (item, a_the_exception__item)
		end

	reply_to_application_should_terminate_ (a_should_terminate: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reply_to_application_should_terminate_ (item, a_should_terminate)
		end

	reply_to_open_or_print_ (a_reply: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reply_to_open_or_print_ (item, a_reply)
		end

	order_front_character_palette_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_character_palette_ (item, a_sender__item)
		end

	presentation_options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_presentation_options (item)
		end

	set_presentation_options_ (a_new_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_presentation_options_ (item, a_new_options)
		end

	current_system_presentation_options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_system_presentation_options (item)
		end

feature {NONE} -- NSApplication Externals

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item delegate];
			 ]"
		end

	objc_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item context];
			 ]"
		end

	objc_hide_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item hide:$a_sender];
			 ]"
		end

	objc_unhide_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item unhide:$a_sender];
			 ]"
		end

	objc_unhide_without_activation (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item unhideWithoutActivation];
			 ]"
		end

	objc_window_with_window_number_ (an_item: POINTER; a_window_num: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item windowWithWindowNumber:$a_window_num];
			 ]"
		end

	objc_main_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item mainWindow];
			 ]"
		end

	objc_key_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item keyWindow];
			 ]"
		end

	objc_is_active (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item isActive];
			 ]"
		end

	objc_is_hidden (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item isHidden];
			 ]"
		end

	objc_is_running (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item isRunning];
			 ]"
		end

	objc_deactivate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item deactivate];
			 ]"
		end

	objc_activate_ignoring_other_apps_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item activateIgnoringOtherApps:$a_flag];
			 ]"
		end

	objc_hide_other_applications_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item hideOtherApplications:$a_sender];
			 ]"
		end

	objc_unhide_all_applications_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item unhideAllApplications:$a_sender];
			 ]"
		end

	objc_finish_launching (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item finishLaunching];
			 ]"
		end

	objc_run (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item run];
			 ]"
		end

	objc_run_modal_for_window_ (an_item: POINTER; a_the_window: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item runModalForWindow:$a_the_window];
			 ]"
		end

	objc_stop_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item stop:$a_sender];
			 ]"
		end

	objc_stop_modal (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item stopModal];
			 ]"
		end

	objc_stop_modal_with_code_ (an_item: POINTER; a_return_code: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item stopModalWithCode:$a_return_code];
			 ]"
		end

	objc_abort_modal (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item abortModal];
			 ]"
		end

	objc_modal_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item modalWindow];
			 ]"
		end

--	objc_begin_modal_session_for_window_ (an_item: POINTER; a_the_window: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSApplication *)$an_item beginModalSessionForWindow:$a_the_window];
--			 ]"
--		end

--	objc_run_modal_session_ (an_item: POINTER; a_session: UNSUPPORTED_TYPE): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSApplication *)$an_item runModalSession:];
--			 ]"
--		end

--	objc_end_modal_session_ (an_item: POINTER; a_session: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSApplication *)$an_item endModalSession:];
--			 ]"
--		end

	objc_terminate_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item terminate:$a_sender];
			 ]"
		end

	objc_request_user_attention_ (an_item: POINTER; a_request_type: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item requestUserAttention:$a_request_type];
			 ]"
		end

	objc_cancel_user_attention_request_ (an_item: POINTER; a_request: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item cancelUserAttentionRequest:$a_request];
			 ]"
		end

--	objc_begin_sheet__modal_for_window__modal_delegate__did_end_selector__context_info_ (an_item: POINTER; a_sheet: POINTER; a_doc_window: POINTER; a_modal_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSApplication *)$an_item beginSheet:$a_sheet modalForWindow:$a_doc_window modalDelegate:$a_modal_delegate didEndSelector:$a_did_end_selector contextInfo:];
--			 ]"
--		end

	objc_end_sheet_ (an_item: POINTER; a_sheet: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item endSheet:$a_sheet];
			 ]"
		end

	objc_end_sheet__return_code_ (an_item: POINTER; a_sheet: POINTER; a_return_code: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item endSheet:$a_sheet returnCode:$a_return_code];
			 ]"
		end

	objc_next_event_matching_mask__until_date__in_mode__dequeue_ (an_item: POINTER; a_mask: NATURAL_64; a_expiration: POINTER; a_mode: POINTER; a_deq_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item nextEventMatchingMask:$a_mask untilDate:$a_expiration inMode:$a_mode dequeue:$a_deq_flag];
			 ]"
		end

	objc_discard_events_matching_mask__before_event_ (an_item: POINTER; a_mask: NATURAL_64; a_last_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item discardEventsMatchingMask:$a_mask beforeEvent:$a_last_event];
			 ]"
		end

	objc_post_event__at_start_ (an_item: POINTER; a_event: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item postEvent:$a_event atStart:$a_flag];
			 ]"
		end

	objc_current_event (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item currentEvent];
			 ]"
		end

	objc_send_event_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item sendEvent:$a_the_event];
			 ]"
		end

	objc_prevent_window_ordering (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item preventWindowOrdering];
			 ]"
		end

	objc_make_windows_perform__in_order_ (an_item: POINTER; a_selector: POINTER; a_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item makeWindowsPerform:$a_selector inOrder:$a_flag];
			 ]"
		end

	objc_windows (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item windows];
			 ]"
		end

	objc_set_windows_need_update_ (an_item: POINTER; a_need_update: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setWindowsNeedUpdate:$a_need_update];
			 ]"
		end

	objc_update_windows (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item updateWindows];
			 ]"
		end

	objc_set_main_menu_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setMainMenu:$a_menu];
			 ]"
		end

	objc_main_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item mainMenu];
			 ]"
		end

	objc_set_help_menu_ (an_item: POINTER; a_help_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setHelpMenu:$a_help_menu];
			 ]"
		end

	objc_help_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item helpMenu];
			 ]"
		end

	objc_set_application_icon_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setApplicationIconImage:$a_image];
			 ]"
		end

	objc_application_icon_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item applicationIconImage];
			 ]"
		end

	objc_activation_policy (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item activationPolicy];
			 ]"
		end

	objc_set_activation_policy_ (an_item: POINTER; a_activation_policy: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item setActivationPolicy:$a_activation_policy];
			 ]"
		end

	objc_dock_tile (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item dockTile];
			 ]"
		end

	objc_send_action__to__from_ (an_item: POINTER; a_the_action: POINTER; a_the_target: POINTER; a_sender: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item sendAction:$a_the_action to:$a_the_target from:$a_sender];
			 ]"
		end

	objc_target_for_action_ (an_item: POINTER; a_the_action: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item targetForAction:$a_the_action];
			 ]"
		end

	objc_target_for_action__to__from_ (an_item: POINTER; a_the_action: POINTER; a_the_target: POINTER; a_sender: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item targetForAction:$a_the_action to:$a_the_target from:$a_sender];
			 ]"
		end

	objc_report_exception_ (an_item: POINTER; a_the_exception: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item reportException:$a_the_exception];
			 ]"
		end

	objc_reply_to_application_should_terminate_ (an_item: POINTER; a_should_terminate: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item replyToApplicationShouldTerminate:$a_should_terminate];
			 ]"
		end

	objc_reply_to_open_or_print_ (an_item: POINTER; a_reply: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item replyToOpenOrPrint:$a_reply];
			 ]"
		end

	objc_order_front_character_palette_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item orderFrontCharacterPalette:$a_sender];
			 ]"
		end

	objc_presentation_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item presentationOptions];
			 ]"
		end

	objc_set_presentation_options_ (an_item: POINTER; a_new_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setPresentationOptions:$a_new_options];
			 ]"
		end

	objc_current_system_presentation_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item currentSystemPresentationOptions];
			 ]"
		end

feature -- NSWindowsMenu

	set_windows_menu_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_windows_menu_ (item, a_menu__item)
		end

	windows_menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_windows_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like windows_menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like windows_menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	arrange_in_front_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_arrange_in_front_ (item, a_sender__item)
		end

	remove_windows_item_ (a_win: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_win__item: POINTER
		do
			if attached a_win as a_win_attached then
				a_win__item := a_win_attached.item
			end
			objc_remove_windows_item_ (item, a_win__item)
		end

	add_windows_item__title__filename_ (a_win: detachable NS_WINDOW; a_string: detachable NS_STRING; a_is_filename: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_win__item: POINTER
			a_string__item: POINTER
		do
			if attached a_win as a_win_attached then
				a_win__item := a_win_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_add_windows_item__title__filename_ (item, a_win__item, a_string__item, a_is_filename)
		end

	change_windows_item__title__filename_ (a_win: detachable NS_WINDOW; a_string: detachable NS_STRING; a_is_filename: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_win__item: POINTER
			a_string__item: POINTER
		do
			if attached a_win as a_win_attached then
				a_win__item := a_win_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_change_windows_item__title__filename_ (item, a_win__item, a_string__item, a_is_filename)
		end

	update_windows_item_ (a_win: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_win__item: POINTER
		do
			if attached a_win as a_win_attached then
				a_win__item := a_win_attached.item
			end
			objc_update_windows_item_ (item, a_win__item)
		end

	miniaturize_all_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_miniaturize_all_ (item, a_sender__item)
		end

feature {NONE} -- NSWindowsMenu Externals

	objc_set_windows_menu_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setWindowsMenu:$a_menu];
			 ]"
		end

	objc_windows_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item windowsMenu];
			 ]"
		end

	objc_arrange_in_front_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item arrangeInFront:$a_sender];
			 ]"
		end

	objc_remove_windows_item_ (an_item: POINTER; a_win: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item removeWindowsItem:$a_win];
			 ]"
		end

	objc_add_windows_item__title__filename_ (an_item: POINTER; a_win: POINTER; a_string: POINTER; a_is_filename: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item addWindowsItem:$a_win title:$a_string filename:$a_is_filename];
			 ]"
		end

	objc_change_windows_item__title__filename_ (an_item: POINTER; a_win: POINTER; a_string: POINTER; a_is_filename: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item changeWindowsItem:$a_win title:$a_string filename:$a_is_filename];
			 ]"
		end

	objc_update_windows_item_ (an_item: POINTER; a_win: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item updateWindowsItem:$a_win];
			 ]"
		end

	objc_miniaturize_all_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item miniaturizeAll:$a_sender];
			 ]"
		end

feature -- NSFullKeyboardAccess

	is_full_keyboard_access_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_full_keyboard_access_enabled (item)
		end

feature {NONE} -- NSFullKeyboardAccess Externals

	objc_is_full_keyboard_access_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item isFullKeyboardAccessEnabled];
			 ]"
		end

feature -- NSServicesMenu

	set_services_menu_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_services_menu_ (item, a_menu__item)
		end

	services_menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_services_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like services_menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like services_menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	register_services_menu_send_types__return_types_ (a_send_types: detachable NS_ARRAY; a_return_types: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_send_types__item: POINTER
			a_return_types__item: POINTER
		do
			if attached a_send_types as a_send_types_attached then
				a_send_types__item := a_send_types_attached.item
			end
			if attached a_return_types as a_return_types_attached then
				a_return_types__item := a_return_types_attached.item
			end
			objc_register_services_menu_send_types__return_types_ (item, a_send_types__item, a_return_types__item)
		end

feature {NONE} -- NSServicesMenu Externals

	objc_set_services_menu_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setServicesMenu:$a_menu];
			 ]"
		end

	objc_services_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item servicesMenu];
			 ]"
		end

	objc_register_services_menu_send_types__return_types_ (an_item: POINTER; a_send_types: POINTER; a_return_types: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item registerServicesMenuSendTypes:$a_send_types returnTypes:$a_return_types];
			 ]"
		end

feature -- NSServicesHandling

	set_services_provider_ (a_provider: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_provider__item: POINTER
		do
			if attached a_provider as a_provider_attached then
				a_provider__item := a_provider_attached.item
			end
			objc_set_services_provider_ (item, a_provider__item)
		end

	services_provider: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_services_provider (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like services_provider} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like services_provider} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSServicesHandling Externals

	objc_set_services_provider_ (an_item: POINTER; a_provider: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item setServicesProvider:$a_provider];
			 ]"
		end

	objc_services_provider (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item servicesProvider];
			 ]"
		end

feature -- NSStandardAboutPanel

	order_front_standard_about_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_standard_about_panel_ (item, a_sender__item)
		end

	order_front_standard_about_panel_with_options_ (a_options_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_options_dictionary__item: POINTER
		do
			if attached a_options_dictionary as a_options_dictionary_attached then
				a_options_dictionary__item := a_options_dictionary_attached.item
			end
			objc_order_front_standard_about_panel_with_options_ (item, a_options_dictionary__item)
		end

feature {NONE} -- NSStandardAboutPanel Externals

	objc_order_front_standard_about_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item orderFrontStandardAboutPanel:$a_sender];
			 ]"
		end

	objc_order_front_standard_about_panel_with_options_ (an_item: POINTER; a_options_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item orderFrontStandardAboutPanelWithOptions:$a_options_dictionary];
			 ]"
		end

feature -- NSApplicationLayoutDirection

	user_interface_layout_direction: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_user_interface_layout_direction (item)
		end

feature {NONE} -- NSApplicationLayoutDirection Externals

	objc_user_interface_layout_direction (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSApplication *)$an_item userInterfaceLayoutDirection];
			 ]"
		end

feature -- NSColorPanel

	order_front_color_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_color_panel_ (item, a_sender__item)
		end

feature {NONE} -- NSColorPanel Externals

	objc_order_front_color_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item orderFrontColorPanel:$a_sender];
			 ]"
		end

feature -- NSApplicationHelpExtension

	activate_context_help_mode_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_activate_context_help_mode_ (item, a_sender__item)
		end

	show_help_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_show_help_ (item, a_sender__item)
		end

feature {NONE} -- NSApplicationHelpExtension Externals

	objc_activate_context_help_mode_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item activateContextHelpMode:$a_sender];
			 ]"
		end

	objc_show_help_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item showHelp:$a_sender];
			 ]"
		end

feature -- NSPageLayoutPanel

	run_page_layout_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_run_page_layout_ (item, a_sender__item)
		end

feature {NONE} -- NSPageLayoutPanel Externals

	objc_run_page_layout_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item runPageLayout:$a_sender];
			 ]"
		end

feature -- NSScripting

	ordered_documents: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ordered_documents (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ordered_documents} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ordered_documents} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	ordered_windows: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ordered_windows (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ordered_windows} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ordered_windows} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScripting Externals

	objc_ordered_documents (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item orderedDocuments];
			 ]"
		end

	objc_ordered_windows (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSApplication *)$an_item orderedWindows];
			 ]"
		end

feature -- NSUserInterfaceItemSearching

	register_user_interface_item_search_handler_ (a_handler: detachable NS_USER_INTERFACE_ITEM_SEARCHING_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_handler__item: POINTER
		do
			if attached a_handler as a_handler_attached then
				a_handler__item := a_handler_attached.item
			end
			objc_register_user_interface_item_search_handler_ (item, a_handler__item)
		end

	unregister_user_interface_item_search_handler_ (a_handler: detachable NS_USER_INTERFACE_ITEM_SEARCHING_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_handler__item: POINTER
		do
			if attached a_handler as a_handler_attached then
				a_handler__item := a_handler_attached.item
			end
			objc_unregister_user_interface_item_search_handler_ (item, a_handler__item)
		end

--	search_string__in_user_interface_item_string__search_range__found_range_ (a_search_string: detachable NS_STRING; a_string_to_search: detachable NS_STRING; a_search_range: NS_RANGE; a_found_range: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_search_string__item: POINTER
--			a_string_to_search__item: POINTER
--			a_found_range__item: POINTER
--		do
--			if attached a_search_string as a_search_string_attached then
--				a_search_string__item := a_search_string_attached.item
--			end
--			if attached a_string_to_search as a_string_to_search_attached then
--				a_string_to_search__item := a_string_to_search_attached.item
--			end
--			if attached a_found_range as a_found_range_attached then
--				a_found_range__item := a_found_range_attached.item
--			end
--			Result := objc_search_string__in_user_interface_item_string__search_range__found_range_ (item, a_search_string__item, a_string_to_search__item, a_search_range.item, a_found_range__item)
--		end

feature {NONE} -- NSUserInterfaceItemSearching Externals

	objc_register_user_interface_item_search_handler_ (an_item: POINTER; a_handler: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item registerUserInterfaceItemSearchHandler:$a_handler];
			 ]"
		end

	objc_unregister_user_interface_item_search_handler_ (an_item: POINTER; a_handler: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSApplication *)$an_item unregisterUserInterfaceItemSearchHandler:$a_handler];
			 ]"
		end

--	objc_search_string__in_user_interface_item_string__search_range__found_range_ (an_item: POINTER; a_search_string: POINTER; a_string_to_search: POINTER; a_search_range: POINTER; a_found_range: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSApplication *)$an_item searchString:$a_search_string inUserInterfaceItemString:$a_string_to_search searchRange:*((NSRange *)$a_search_range) foundRange:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSApplication"
		end

end
