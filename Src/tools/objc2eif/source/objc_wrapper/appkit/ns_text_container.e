note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TEXT_CONTAINER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_container_size_,
	make

feature {NONE} -- Initialization

	make_with_container_size_ (a_size: NS_SIZE)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_container_size_(allocate_object, a_size.item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSTextContainer Externals

	objc_init_with_container_size_ (an_item: POINTER; a_size: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextContainer *)$an_item initWithContainerSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_layout_manager (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextContainer *)$an_item layoutManager];
			 ]"
		end

	objc_set_layout_manager_ (an_item: POINTER; a_layout_manager: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextContainer *)$an_item setLayoutManager:$a_layout_manager];
			 ]"
		end

	objc_replace_layout_manager_ (an_item: POINTER; a_new_layout_manager: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextContainer *)$an_item replaceLayoutManager:$a_new_layout_manager];
			 ]"
		end

	objc_text_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSTextContainer *)$an_item textView];
			 ]"
		end

	objc_set_text_view_ (an_item: POINTER; a_text_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextContainer *)$an_item setTextView:$a_text_view];
			 ]"
		end

	objc_set_width_tracks_text_view_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextContainer *)$an_item setWidthTracksTextView:$a_flag];
			 ]"
		end

	objc_width_tracks_text_view (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextContainer *)$an_item widthTracksTextView];
			 ]"
		end

	objc_set_height_tracks_text_view_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextContainer *)$an_item setHeightTracksTextView:$a_flag];
			 ]"
		end

	objc_height_tracks_text_view (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextContainer *)$an_item heightTracksTextView];
			 ]"
		end

	objc_set_container_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextContainer *)$an_item setContainerSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_container_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSTextContainer *)$an_item containerSize];
			 ]"
		end

	objc_set_line_fragment_padding_ (an_item: POINTER; a_pad: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSTextContainer *)$an_item setLineFragmentPadding:$a_pad];
			 ]"
		end

	objc_line_fragment_padding (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextContainer *)$an_item lineFragmentPadding];
			 ]"
		end

--	objc_line_fragment_rect_for_proposed_rect__sweep_direction__movement_direction__remaining_rect_ (an_item: POINTER; result_pointer: POINTER; a_proposed_rect: POINTER; a_sweep_direction: NATURAL_64; a_movement_direction: NATURAL_64; a_remaining_rect: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRect *)$result_pointer = [(NSTextContainer *)$an_item lineFragmentRectForProposedRect:*((NSRect *)$a_proposed_rect) sweepDirection:$a_sweep_direction movementDirection:$a_movement_direction remainingRect:];
--			 ]"
--		end

	objc_is_simple_rectangular_text_container (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextContainer *)$an_item isSimpleRectangularTextContainer];
			 ]"
		end

	objc_contains_point_ (an_item: POINTER; a_point: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSTextContainer *)$an_item containsPoint:*((NSPoint *)$a_point)];
			 ]"
		end

feature -- NSTextContainer

	layout_manager: detachable NS_LAYOUT_MANAGER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_layout_manager (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like layout_manager} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like layout_manager} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_layout_manager_ (a_layout_manager: detachable NS_LAYOUT_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_layout_manager__item: POINTER
		do
			if attached a_layout_manager as a_layout_manager_attached then
				a_layout_manager__item := a_layout_manager_attached.item
			end
			objc_set_layout_manager_ (item, a_layout_manager__item)
		end

	replace_layout_manager_ (a_new_layout_manager: detachable NS_LAYOUT_MANAGER)
			-- Auto generated Objective-C wrapper.
		local
			a_new_layout_manager__item: POINTER
		do
			if attached a_new_layout_manager as a_new_layout_manager_attached then
				a_new_layout_manager__item := a_new_layout_manager_attached.item
			end
			objc_replace_layout_manager_ (item, a_new_layout_manager__item)
		end

	text_view: detachable NS_TEXT_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_view_ (a_text_view: detachable NS_TEXT_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_text_view__item: POINTER
		do
			if attached a_text_view as a_text_view_attached then
				a_text_view__item := a_text_view_attached.item
			end
			objc_set_text_view_ (item, a_text_view__item)
		end

	set_width_tracks_text_view_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_width_tracks_text_view_ (item, a_flag)
		end

	width_tracks_text_view: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_width_tracks_text_view (item)
		end

	set_height_tracks_text_view_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_height_tracks_text_view_ (item, a_flag)
		end

	height_tracks_text_view: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_height_tracks_text_view (item)
		end

	set_container_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_container_size_ (item, a_size.item)
		end

	container_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_container_size (item, Result.item)
		end

	set_line_fragment_padding_ (a_pad: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_fragment_padding_ (item, a_pad)
		end

	line_fragment_padding: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_fragment_padding (item)
		end

--	line_fragment_rect_for_proposed_rect__sweep_direction__movement_direction__remaining_rect_ (a_proposed_rect: NS_RECT; a_sweep_direction: NATURAL_64; a_movement_direction: NATURAL_64; a_remaining_rect: UNSUPPORTED_TYPE): NS_RECT
--			-- Auto generated Objective-C wrapper.
--		local
--			a_remaining_rect__item: POINTER
--		do
--			if attached a_remaining_rect as a_remaining_rect_attached then
--				a_remaining_rect__item := a_remaining_rect_attached.item
--			end
--			create Result.make
--			objc_line_fragment_rect_for_proposed_rect__sweep_direction__movement_direction__remaining_rect_ (item, Result.item, a_proposed_rect.item, a_sweep_direction, a_movement_direction, a_remaining_rect__item)
--		end

	is_simple_rectangular_text_container: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_simple_rectangular_text_container (item)
		end

	contains_point_ (a_point: NS_POINT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_contains_point_ (item, a_point.item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTextContainer"
		end

end
