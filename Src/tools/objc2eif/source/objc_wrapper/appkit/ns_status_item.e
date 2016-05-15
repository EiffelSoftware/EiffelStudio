note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STATUS_ITEM

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

feature -- NSStatusItem

	status_bar: detachable NS_STATUS_BAR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_status_bar (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like status_bar} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like status_bar} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	length: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_length (item)
		end

	set_length_ (a_length: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_length_ (item, a_length)
		end

feature {NONE} -- NSStatusItem Externals

	objc_status_bar (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item statusBar];
			 ]"
		end

	objc_length (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStatusItem *)$an_item length];
			 ]"
		end

	objc_set_length_ (an_item: POINTER; a_length: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setLength:$a_length];
			 ]"
		end

feature -- NSStatusItemCommon

	action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	set_action_ (a_action: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_action__item: POINTER
		do
			if attached a_action as a_action_attached then
				a_action__item := a_action_attached.item
			end
			objc_set_action_ (item, a_action__item)
		end

	double_action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_double_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	set_double_action_ (a_action: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_action__item: POINTER
		do
			if attached a_action as a_action_attached then
				a_action__item := a_action_attached.item
			end
			objc_set_double_action_ (item, a_action__item)
		end

	target: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_target (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like target} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like target} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_target_ (a_target: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			objc_set_target_ (item, a_target__item)
		end

	title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_title_ (a_title: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_set_title_ (item, a_title__item)
		end

	attributed_title: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_attributed_title_ (a_title: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_title__item: POINTER
		do
			if attached a_title as a_title_attached then
				a_title__item := a_title_attached.item
			end
			objc_set_attributed_title_ (item, a_title__item)
		end

	image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_image_ (item, a_image__item)
		end

	alternate_image: detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_alternate_image (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like alternate_image} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like alternate_image} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_alternate_image_ (a_image: detachable NS_IMAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_image__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			objc_set_alternate_image_ (item, a_image__item)
		end

	menu: detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_menu (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_menu_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_set_menu_ (item, a_menu__item)
		end

	is_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_enabled (item)
		end

	set_enabled_ (a_enabled: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_enabled_ (item, a_enabled)
		end

	tool_tip: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tool_tip (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tool_tip} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tool_tip} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_tool_tip_ (a_tool_tip: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_tool_tip__item: POINTER
		do
			if attached a_tool_tip as a_tool_tip_attached then
				a_tool_tip__item := a_tool_tip_attached.item
			end
			objc_set_tool_tip_ (item, a_tool_tip__item)
		end

	set_highlight_mode_ (a_highlight_mode: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_highlight_mode_ (item, a_highlight_mode)
		end

	highlight_mode: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_highlight_mode (item)
		end

	send_action_on_ (a_mask: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_send_action_on_ (item, a_mask)
		end

	pop_up_status_item_menu_ (a_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_menu__item: POINTER
		do
			if attached a_menu as a_menu_attached then
				a_menu__item := a_menu_attached.item
			end
			objc_pop_up_status_item_menu_ (item, a_menu__item)
		end

	draw_status_bar_background_in_rect__with_highlight_ (a_rect: NS_RECT; a_highlight: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_status_bar_background_in_rect__with_highlight_ (item, a_rect.item, a_highlight)
		end

feature {NONE} -- NSStatusItemCommon Externals

	objc_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item action];
			 ]"
		end

	objc_set_action_ (an_item: POINTER; a_action: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setAction:$a_action];
			 ]"
		end

	objc_double_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item doubleAction];
			 ]"
		end

	objc_set_double_action_ (an_item: POINTER; a_action: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setDoubleAction:$a_action];
			 ]"
		end

	objc_target (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item target];
			 ]"
		end

	objc_set_target_ (an_item: POINTER; a_target: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setTarget:$a_target];
			 ]"
		end

	objc_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item title];
			 ]"
		end

	objc_set_title_ (an_item: POINTER; a_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setTitle:$a_title];
			 ]"
		end

	objc_attributed_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item attributedTitle];
			 ]"
		end

	objc_set_attributed_title_ (an_item: POINTER; a_title: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setAttributedTitle:$a_title];
			 ]"
		end

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item image];
			 ]"
		end

	objc_set_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setImage:$a_image];
			 ]"
		end

	objc_alternate_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item alternateImage];
			 ]"
		end

	objc_set_alternate_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setAlternateImage:$a_image];
			 ]"
		end

	objc_menu (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item menu];
			 ]"
		end

	objc_set_menu_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setMenu:$a_menu];
			 ]"
		end

	objc_is_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStatusItem *)$an_item isEnabled];
			 ]"
		end

	objc_set_enabled_ (an_item: POINTER; a_enabled: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setEnabled:$a_enabled];
			 ]"
		end

	objc_tool_tip (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item toolTip];
			 ]"
		end

	objc_set_tool_tip_ (an_item: POINTER; a_tool_tip: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setToolTip:$a_tool_tip];
			 ]"
		end

	objc_set_highlight_mode_ (an_item: POINTER; a_highlight_mode: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setHighlightMode:$a_highlight_mode];
			 ]"
		end

	objc_highlight_mode (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStatusItem *)$an_item highlightMode];
			 ]"
		end

	objc_send_action_on_ (an_item: POINTER; a_mask: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSStatusItem *)$an_item sendActionOn:$a_mask];
			 ]"
		end

	objc_pop_up_status_item_menu_ (an_item: POINTER; a_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item popUpStatusItemMenu:$a_menu];
			 ]"
		end

	objc_draw_status_bar_background_in_rect__with_highlight_ (an_item: POINTER; a_rect: POINTER; a_highlight: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item drawStatusBarBackgroundInRect:*((NSRect *)$a_rect) withHighlight:$a_highlight];
			 ]"
		end

feature -- NSStatusItemView

	view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_view_ (item, a_view__item)
		end

feature {NONE} -- NSStatusItemView Externals

	objc_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSStatusItem *)$an_item view];
			 ]"
		end

	objc_set_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSStatusItem *)$an_item setView:$a_view];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSStatusItem"
		end

end
