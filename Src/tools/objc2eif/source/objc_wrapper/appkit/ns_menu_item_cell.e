note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MENU_ITEM_CELL

inherit
	NS_BUTTON_CELL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSMenuItemCell

	set_menu_item_ (a_item: detachable NS_MENU_ITEM)
			-- Auto generated Objective-C wrapper.
		local
			a_item__item: POINTER
		do
			if attached a_item as a_item_attached then
				a_item__item := a_item_attached.item
			end
			objc_set_menu_item_ (item, a_item__item)
		end

	menu_item: detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_menu_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_needs_sizing_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_sizing_ (item, a_flag)
		end

	needs_sizing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_needs_sizing (item)
		end

	calc_size
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_calc_size (item)
		end

	set_needs_display_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_display_ (item, a_flag)
		end

	needs_display: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_needs_display (item)
		end

	state_image_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_state_image_width (item)
		end

	image_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_image_width (item)
		end

	title_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_title_width (item)
		end

	key_equivalent_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_key_equivalent_width (item)
		end

	state_image_rect_for_bounds_ (a_cell_frame: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_state_image_rect_for_bounds_ (item, Result.item, a_cell_frame.item)
		end

	key_equivalent_rect_for_bounds_ (a_cell_frame: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_key_equivalent_rect_for_bounds_ (item, Result.item, a_cell_frame.item)
		end

	draw_separator_item_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_separator_item_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	draw_state_image_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_state_image_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	draw_image_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_image_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	draw_title_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_title_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	draw_key_equivalent_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_key_equivalent_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

	draw_border_and_background_with_frame__in_view_ (a_cell_frame: NS_RECT; a_control_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_control_view__item: POINTER
		do
			if attached a_control_view as a_control_view_attached then
				a_control_view__item := a_control_view_attached.item
			end
			objc_draw_border_and_background_with_frame__in_view_ (item, a_cell_frame.item, a_control_view__item)
		end

feature {NONE} -- NSMenuItemCell Externals

	objc_set_menu_item_ (an_item: POINTER; a_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item setMenuItem:$a_item];
			 ]"
		end

	objc_menu_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSMenuItemCell *)$an_item menuItem];
			 ]"
		end

	objc_set_needs_sizing_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item setNeedsSizing:$a_flag];
			 ]"
		end

	objc_needs_sizing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItemCell *)$an_item needsSizing];
			 ]"
		end

	objc_calc_size (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item calcSize];
			 ]"
		end

	objc_set_needs_display_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item setNeedsDisplay:$a_flag];
			 ]"
		end

	objc_needs_display (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItemCell *)$an_item needsDisplay];
			 ]"
		end

	objc_state_image_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItemCell *)$an_item stateImageWidth];
			 ]"
		end

	objc_image_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItemCell *)$an_item imageWidth];
			 ]"
		end

	objc_title_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItemCell *)$an_item titleWidth];
			 ]"
		end

	objc_key_equivalent_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSMenuItemCell *)$an_item keyEquivalentWidth];
			 ]"
		end

	objc_state_image_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_cell_frame: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSMenuItemCell *)$an_item stateImageRectForBounds:*((NSRect *)$a_cell_frame)];
			 ]"
		end

	objc_key_equivalent_rect_for_bounds_ (an_item: POINTER; result_pointer: POINTER; a_cell_frame: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSMenuItemCell *)$an_item keyEquivalentRectForBounds:*((NSRect *)$a_cell_frame)];
			 ]"
		end

	objc_draw_separator_item_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item drawSeparatorItemWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_draw_state_image_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item drawStateImageWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_draw_image_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item drawImageWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_draw_title_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item drawTitleWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_draw_key_equivalent_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item drawKeyEquivalentWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

	objc_draw_border_and_background_with_frame__in_view_ (an_item: POINTER; a_cell_frame: POINTER; a_control_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSMenuItemCell *)$an_item drawBorderAndBackgroundWithFrame:*((NSRect *)$a_cell_frame) inView:$a_control_view];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMenuItemCell"
		end

end
