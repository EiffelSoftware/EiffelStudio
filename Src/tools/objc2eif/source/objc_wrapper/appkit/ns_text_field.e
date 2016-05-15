note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_FIELD

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end

	NS_USER_INTERFACE_VALIDATIONS_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSTextField

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_draws_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_background_ (item, a_flag)
		end

	draws_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_background (item)
		end

	set_text_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_text_color_ (item, a_color__item)
		end

	text_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_bordered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bordered (item)
		end

	set_bordered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bordered_ (item, a_flag)
		end

	is_bezeled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bezeled (item)
		end

	set_bezeled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bezeled_ (item, a_flag)
		end

	is_editable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_editable (item)
		end

	set_editable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_editable_ (item, a_flag)
		end

	is_selectable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_selectable (item)
		end

	set_selectable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selectable_ (item, a_flag)
		end

	select_text_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_select_text_ (item, a_sender__item)
		end

	delegate: detachable NS_TEXT_FIELD_DELEGATE_PROTOCOL
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

	set_delegate_ (an_object: detachable NS_TEXT_FIELD_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	text_should_begin_editing_ (a_text_object: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_text_object__item: POINTER
		do
			if attached a_text_object as a_text_object_attached then
				a_text_object__item := a_text_object_attached.item
			end
			Result := objc_text_should_begin_editing_ (item, a_text_object__item)
		end

	text_should_end_editing_ (a_text_object: detachable NS_TEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_text_object__item: POINTER
		do
			if attached a_text_object as a_text_object_attached then
				a_text_object__item := a_text_object_attached.item
			end
			Result := objc_text_should_end_editing_ (item, a_text_object__item)
		end

	text_did_begin_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_begin_editing_ (item, a_notification__item)
		end

	text_did_end_editing_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_end_editing_ (item, a_notification__item)
		end

	text_did_change_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_text_did_change_ (item, a_notification__item)
		end

	set_bezel_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bezel_style_ (item, a_style)
		end

	bezel_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bezel_style (item)
		end

feature {NONE} -- NSTextField Externals

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextField *)$an_item backgroundColor];
			 ]"
		end

	objc_set_draws_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setDrawsBackground:$a_flag];
			 ]"
		end

	objc_draws_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item drawsBackground];
			 ]"
		end

	objc_set_text_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setTextColor:$a_color];
			 ]"
		end

	objc_text_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextField *)$an_item textColor];
			 ]"
		end

	objc_is_bordered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item isBordered];
			 ]"
		end

	objc_set_bordered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setBordered:$a_flag];
			 ]"
		end

	objc_is_bezeled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item isBezeled];
			 ]"
		end

	objc_set_bezeled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setBezeled:$a_flag];
			 ]"
		end

	objc_is_editable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item isEditable];
			 ]"
		end

	objc_set_editable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setEditable:$a_flag];
			 ]"
		end

	objc_is_selectable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item isSelectable];
			 ]"
		end

	objc_set_selectable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setSelectable:$a_flag];
			 ]"
		end

	objc_select_text_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item selectText:$a_sender];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextField *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_text_should_begin_editing_ (an_item: POINTER; a_text_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item textShouldBeginEditing:$a_text_object];
			 ]"
		end

	objc_text_should_end_editing_ (an_item: POINTER; a_text_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item textShouldEndEditing:$a_text_object];
			 ]"
		end

	objc_text_did_begin_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item textDidBeginEditing:$a_notification];
			 ]"
		end

	objc_text_did_end_editing_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item textDidEndEditing:$a_notification];
			 ]"
		end

	objc_text_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item textDidChange:$a_notification];
			 ]"
		end

	objc_set_bezel_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setBezelStyle:$a_style];
			 ]"
		end

	objc_bezel_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item bezelStyle];
			 ]"
		end

feature -- NSKeyboardUI

	set_title_with_mnemonic_ (a_string_with_ampersand: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string_with_ampersand__item: POINTER
		do
			if attached a_string_with_ampersand as a_string_with_ampersand_attached then
				a_string_with_ampersand__item := a_string_with_ampersand_attached.item
			end
			objc_set_title_with_mnemonic_ (item, a_string_with_ampersand__item)
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_set_title_with_mnemonic_ (an_item: POINTER; a_string_with_ampersand: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setTitleWithMnemonic:$a_string_with_ampersand];
			 ]"
		end

feature -- NSTextFieldAttributedStringMethods

	allows_editing_text_attributes: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_editing_text_attributes (item)
		end

	set_allows_editing_text_attributes_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_editing_text_attributes_ (item, a_flag)
		end

	imports_graphics: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_imports_graphics (item)
		end

	set_imports_graphics_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_imports_graphics_ (item, a_flag)
		end

feature {NONE} -- NSTextFieldAttributedStringMethods Externals

	objc_allows_editing_text_attributes (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item allowsEditingTextAttributes];
			 ]"
		end

	objc_set_allows_editing_text_attributes_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setAllowsEditingTextAttributes:$a_flag];
			 ]"
		end

	objc_imports_graphics (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextField *)$an_item importsGraphics];
			 ]"
		end

	objc_set_imports_graphics_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextField *)$an_item setImportsGraphics:$a_flag];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextField"
		end

end
