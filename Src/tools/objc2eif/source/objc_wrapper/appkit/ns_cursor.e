note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CURSOR

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
	make_with_image__hot_spot_,
	make_with_image__foreground_color_hint__background_color_hint__hot_spot_,
	make

feature {NONE} -- Initialization

	make_with_image__hot_spot_ (a_new_image: detachable NS_IMAGE; a_point: NS_POINT)
			-- Initialize `Current'.
		local
			a_new_image__item: POINTER
		do
			if attached a_new_image as a_new_image_attached then
				a_new_image__item := a_new_image_attached.item
			end
			make_with_pointer (objc_init_with_image__hot_spot_(allocate_object, a_new_image__item, a_point.item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_image__foreground_color_hint__background_color_hint__hot_spot_ (a_new_image: detachable NS_IMAGE; a_fg: detachable NS_COLOR; a_bg: detachable NS_COLOR; a_hot_spot: NS_POINT)
			-- Initialize `Current'.
		local
			a_new_image__item: POINTER
			a_fg__item: POINTER
			a_bg__item: POINTER
		do
			if attached a_new_image as a_new_image_attached then
				a_new_image__item := a_new_image_attached.item
			end
			if attached a_fg as a_fg_attached then
				a_fg__item := a_fg_attached.item
			end
			if attached a_bg as a_bg_attached then
				a_bg__item := a_bg_attached.item
			end
			make_with_pointer (objc_init_with_image__foreground_color_hint__background_color_hint__hot_spot_(allocate_object, a_new_image__item, a_fg__item, a_bg__item, a_hot_spot.item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSCursor Externals

	objc_init_with_image__hot_spot_ (an_item: POINTER; a_new_image: POINTER; a_point: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCursor *)$an_item initWithImage:$a_new_image hotSpot:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_init_with_image__foreground_color_hint__background_color_hint__hot_spot_ (an_item: POINTER; a_new_image: POINTER; a_fg: POINTER; a_bg: POINTER; a_hot_spot: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCursor *)$an_item initWithImage:$a_new_image foregroundColorHint:$a_fg backgroundColorHint:$a_bg hotSpot:*((NSPoint *)$a_hot_spot)];
			 ]"
		end

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCursor *)$an_item image];
			 ]"
		end

	objc_hot_spot (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSCursor *)$an_item hotSpot];
			 ]"
		end

	objc_push (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCursor *)$an_item push];
			 ]"
		end

	objc_set (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCursor *)$an_item set];
			 ]"
		end

	objc_set_on_mouse_exited_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCursor *)$an_item setOnMouseExited:$a_flag];
			 ]"
		end

	objc_set_on_mouse_entered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCursor *)$an_item setOnMouseEntered:$a_flag];
			 ]"
		end

	objc_is_set_on_mouse_exited (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCursor *)$an_item isSetOnMouseExited];
			 ]"
		end

	objc_is_set_on_mouse_entered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCursor *)$an_item isSetOnMouseEntered];
			 ]"
		end

	objc_mouse_entered_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCursor *)$an_item mouseEntered:$a_the_event];
			 ]"
		end

	objc_mouse_exited_ (an_item: POINTER; a_the_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCursor *)$an_item mouseExited:$a_the_event];
			 ]"
		end

feature -- NSCursor

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

	hot_spot: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_hot_spot (item, Result.item)
		end

	push
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_push (item)
		end

	set
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set (item)
		end

	set_on_mouse_exited_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_on_mouse_exited_ (item, a_flag)
		end

	set_on_mouse_entered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_on_mouse_entered_ (item, a_flag)
		end

	is_set_on_mouse_exited: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_set_on_mouse_exited (item)
		end

	is_set_on_mouse_entered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_set_on_mouse_entered (item)
		end

	mouse_entered_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_mouse_entered_ (item, a_the_event__item)
		end

	mouse_exited_ (a_the_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			objc_mouse_exited_ (item, a_the_event__item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCursor"
		end

end
