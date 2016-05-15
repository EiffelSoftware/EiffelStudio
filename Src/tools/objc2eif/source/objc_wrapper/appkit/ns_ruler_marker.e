note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RULER_MARKER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_ruler_view__marker_location__image__image_origin_,
	make

feature {NONE} -- Initialization

	make_with_ruler_view__marker_location__image__image_origin_ (a_ruler: detachable NS_RULER_VIEW; a_location: REAL_64; a_image: detachable NS_IMAGE; a_image_origin: NS_POINT)
			-- Initialize `Current'.
		local
			a_ruler__item: POINTER
			a_image__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			make_with_pointer (objc_init_with_ruler_view__marker_location__image__image_origin_(allocate_object, a_ruler__item, a_location, a_image__item, a_image_origin.item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSRulerMarker Externals

	objc_init_with_ruler_view__marker_location__image__image_origin_ (an_item: POINTER; a_ruler: POINTER; a_location: REAL_64; a_image: POINTER; a_image_origin: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerMarker *)$an_item initWithRulerView:$a_ruler markerLocation:$a_location image:$a_image imageOrigin:*((NSPoint *)$a_image_origin)];
			 ]"
		end

	objc_ruler (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerMarker *)$an_item ruler];
			 ]"
		end

	objc_set_marker_location_ (an_item: POINTER; a_location: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerMarker *)$an_item setMarkerLocation:$a_location];
			 ]"
		end

	objc_marker_location (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerMarker *)$an_item markerLocation];
			 ]"
		end

	objc_set_image_ (an_item: POINTER; a_image: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerMarker *)$an_item setImage:$a_image];
			 ]"
		end

	objc_image (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerMarker *)$an_item image];
			 ]"
		end

	objc_set_image_origin_ (an_item: POINTER; a_image_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerMarker *)$an_item setImageOrigin:*((NSPoint *)$a_image_origin)];
			 ]"
		end

	objc_image_origin (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSRulerMarker *)$an_item imageOrigin];
			 ]"
		end

	objc_set_movable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerMarker *)$an_item setMovable:$a_flag];
			 ]"
		end

	objc_set_removable_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerMarker *)$an_item setRemovable:$a_flag];
			 ]"
		end

	objc_is_movable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerMarker *)$an_item isMovable];
			 ]"
		end

	objc_is_removable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerMarker *)$an_item isRemovable];
			 ]"
		end

	objc_is_dragging (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerMarker *)$an_item isDragging];
			 ]"
		end

	objc_set_represented_object_ (an_item: POINTER; a_represented_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerMarker *)$an_item setRepresentedObject:$a_represented_object];
			 ]"
		end

	objc_represented_object (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerMarker *)$an_item representedObject];
			 ]"
		end

	objc_image_rect_in_ruler (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSRulerMarker *)$an_item imageRectInRuler];
			 ]"
		end

	objc_thickness_required_in_ruler (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerMarker *)$an_item thicknessRequiredInRuler];
			 ]"
		end

	objc_draw_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerMarker *)$an_item drawRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_track_mouse__adding_ (an_item: POINTER; a_mouse_down_event: POINTER; a_is_adding: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerMarker *)$an_item trackMouse:$a_mouse_down_event adding:$a_is_adding];
			 ]"
		end

feature -- NSRulerMarker

	ruler: detachable NS_RULER_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_ruler (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ruler} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ruler} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_marker_location_ (a_location: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_marker_location_ (item, a_location)
		end

	marker_location: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_marker_location (item)
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

	set_image_origin_ (a_image_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_image_origin_ (item, a_image_origin.item)
		end

	image_origin: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_image_origin (item, Result.item)
		end

	set_movable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_movable_ (item, a_flag)
		end

	set_removable_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_removable_ (item, a_flag)
		end

	is_movable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_movable (item)
		end

	is_removable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_removable (item)
		end

	is_dragging: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_dragging (item)
		end

	set_represented_object_ (a_represented_object: detachable NS_COPYING_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_represented_object__item: POINTER
		do
			if attached a_represented_object as a_represented_object_attached then
				a_represented_object__item := a_represented_object_attached.item
			end
			objc_set_represented_object_ (item, a_represented_object__item)
		end

	represented_object: detachable NS_COPYING_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_represented_object (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like represented_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like represented_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	image_rect_in_ruler: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_image_rect_in_ruler (item, Result.item)
		end

	thickness_required_in_ruler: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_thickness_required_in_ruler (item)
		end

	draw_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_rect_ (item, a_rect.item)
		end

	track_mouse__adding_ (a_mouse_down_event: detachable NS_EVENT; a_is_adding: BOOLEAN): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_mouse_down_event__item: POINTER
		do
			if attached a_mouse_down_event as a_mouse_down_event_attached then
				a_mouse_down_event__item := a_mouse_down_event_attached.item
			end
			Result := objc_track_mouse__adding_ (item, a_mouse_down_event__item, a_is_adding)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRulerMarker"
		end

end
