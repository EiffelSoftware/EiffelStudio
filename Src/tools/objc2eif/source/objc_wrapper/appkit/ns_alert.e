note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ALERT

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

feature -- NSAlert

	set_message_text_ (a_message_text: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_message_text__item: POINTER
		do
			if attached a_message_text as a_message_text_attached then
				a_message_text__item := a_message_text_attached.item
			end
			objc_set_message_text_ (item, a_message_text__item)
		end

	set_informative_text_ (a_informative_text: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_informative_text__item: POINTER
		do
			if attached a_informative_text as a_informative_text_attached then
				a_informative_text__item := a_informative_text_attached.item
			end
			objc_set_informative_text_ (item, a_informative_text__item)
		end

	message_text: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_message_text (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like message_text} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like message_text} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	informative_text: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_informative_text (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like informative_text} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like informative_text} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_icon_ (a_icon: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_icon__item: POINTER
		do
			if attached a_icon as a_icon_attached then
				a_icon__item := a_icon_attached.item
			end
			objc_set_icon_ (item, a_icon__item)
		end

	icon: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_icon (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like icon} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like icon} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_button_with_title_ (a_title: detachable NS_STRING): detachable NS_BUTTON
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			result_pointer := objc_add_button_with_title_ (item, a_title__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like add_button_with_title_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like add_button_with_title_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	buttons: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_buttons (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like buttons} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like buttons} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_shows_help_ (a_shows_help: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_help_ (item, a_shows_help)
		end

	shows_help: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_help (item)
		end

	set_help_anchor_ (a_anchor: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_anchor__item: POINTER
		do
			if attached a_anchor as a_anchor_attached then
				a_anchor__item := a_anchor_attached.item
			end
			objc_set_help_anchor_ (item, a_anchor__item)
		end

	help_anchor: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_help_anchor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like help_anchor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like help_anchor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_alert_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alert_style_ (item, a_style)
		end

	alert_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alert_style (item)
		end

	set_delegate_ (a_delegate: detachable NS_ALERT_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_ALERT_DELEGATE_PROTOCOL
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

	set_shows_suppression_button_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_suppression_button_ (item, a_flag)
		end

	shows_suppression_button: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_suppression_button (item)
		end

	suppression_button: detachable NS_BUTTON
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_suppression_button (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like suppression_button} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like suppression_button} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_accessory_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_accessory_view_ (item, a_view__item)
		end

	accessory_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessory_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessory_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessory_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	layout
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_layout (item)
		end

	run_modal: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_run_modal (item)
		end

--	begin_sheet_modal_for_window__modal_delegate__did_end_selector__context_info_ (a_window: detachable NS_WINDOW; a_delegate: detachable NS_OBJECT; a_did_end_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_window__item: POINTER
--			a_delegate__item: POINTER
--			a_did_end_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_window as a_window_attached then
--				a_window__item := a_window_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_end_selector as a_did_end_selector_attached then
--				a_did_end_selector__item := a_did_end_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_begin_sheet_modal_for_window__modal_delegate__did_end_selector__context_info_ (item, a_window__item, a_delegate__item, a_did_end_selector__item, a_context_info__item)
--		end

	window: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSAlert Externals

	objc_set_message_text_ (an_item: POINTER; a_message_text: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setMessageText:$a_message_text];
			 ]"
		end

	objc_set_informative_text_ (an_item: POINTER; a_informative_text: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setInformativeText:$a_informative_text];
			 ]"
		end

	objc_message_text (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item messageText];
			 ]"
		end

	objc_informative_text (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item informativeText];
			 ]"
		end

	objc_set_icon_ (an_item: POINTER; a_icon: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setIcon:$a_icon];
			 ]"
		end

	objc_icon (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item icon];
			 ]"
		end

	objc_add_button_with_title_ (an_item: POINTER; a_title: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item addButtonWithTitle:$a_title];
			 ]"
		end

	objc_buttons (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item buttons];
			 ]"
		end

	objc_set_shows_help_ (an_item: POINTER; a_shows_help: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setShowsHelp:$a_shows_help];
			 ]"
		end

	objc_shows_help (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAlert *)$an_item showsHelp];
			 ]"
		end

	objc_set_help_anchor_ (an_item: POINTER; a_anchor: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setHelpAnchor:$a_anchor];
			 ]"
		end

	objc_help_anchor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item helpAnchor];
			 ]"
		end

	objc_set_alert_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setAlertStyle:$a_style];
			 ]"
		end

	objc_alert_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAlert *)$an_item alertStyle];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item delegate];
			 ]"
		end

	objc_set_shows_suppression_button_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setShowsSuppressionButton:$a_flag];
			 ]"
		end

	objc_shows_suppression_button (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAlert *)$an_item showsSuppressionButton];
			 ]"
		end

	objc_suppression_button (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item suppressionButton];
			 ]"
		end

	objc_set_accessory_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item setAccessoryView:$a_view];
			 ]"
		end

	objc_accessory_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item accessoryView];
			 ]"
		end

	objc_layout (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAlert *)$an_item layout];
			 ]"
		end

	objc_run_modal (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAlert *)$an_item runModal];
			 ]"
		end

--	objc_begin_sheet_modal_for_window__modal_delegate__did_end_selector__context_info_ (an_item: POINTER; a_window: POINTER; a_delegate: POINTER; a_did_end_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSAlert *)$an_item beginSheetModalForWindow:$a_window modalDelegate:$a_delegate didEndSelector:$a_did_end_selector contextInfo:];
--			 ]"
--		end

	objc_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAlert *)$an_item window];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAlert"
		end

end
