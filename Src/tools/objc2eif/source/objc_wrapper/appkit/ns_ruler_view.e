note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RULER_VIEW

inherit
	NS_VIEW
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_scroll_view__orientation_,
	make_with_frame_,
	make

feature {NONE} -- Initialization

	make_with_scroll_view__orientation_ (a_scroll_view: detachable NS_SCROLL_VIEW; a_orientation: NATURAL_64)
			-- Initialize `Current'.
		local
			a_scroll_view__item: POINTER
		do
			if attached a_scroll_view as a_scroll_view_attached then
				a_scroll_view__item := a_scroll_view_attached.item
			end
			make_with_pointer (objc_init_with_scroll_view__orientation_(allocate_object, a_scroll_view__item, a_orientation))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSRulerView Externals

	objc_init_with_scroll_view__orientation_ (an_item: POINTER; a_scroll_view: POINTER; a_orientation: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerView *)$an_item initWithScrollView:$a_scroll_view orientation:$a_orientation];
			 ]"
		end

	objc_set_scroll_view_ (an_item: POINTER; a_scroll_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setScrollView:$a_scroll_view];
			 ]"
		end

	objc_scroll_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerView *)$an_item scrollView];
			 ]"
		end

	objc_set_orientation_ (an_item: POINTER; a_orientation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setOrientation:$a_orientation];
			 ]"
		end

	objc_orientation (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerView *)$an_item orientation];
			 ]"
		end

	objc_baseline_location (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerView *)$an_item baselineLocation];
			 ]"
		end

	objc_required_thickness (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerView *)$an_item requiredThickness];
			 ]"
		end

	objc_set_rule_thickness_ (an_item: POINTER; a_thickness: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setRuleThickness:$a_thickness];
			 ]"
		end

	objc_rule_thickness (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerView *)$an_item ruleThickness];
			 ]"
		end

	objc_set_reserved_thickness_for_markers_ (an_item: POINTER; a_thickness: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setReservedThicknessForMarkers:$a_thickness];
			 ]"
		end

	objc_reserved_thickness_for_markers (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerView *)$an_item reservedThicknessForMarkers];
			 ]"
		end

	objc_set_reserved_thickness_for_accessory_view_ (an_item: POINTER; a_thickness: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setReservedThicknessForAccessoryView:$a_thickness];
			 ]"
		end

	objc_reserved_thickness_for_accessory_view (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerView *)$an_item reservedThicknessForAccessoryView];
			 ]"
		end

	objc_set_measurement_units_ (an_item: POINTER; a_unit_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setMeasurementUnits:$a_unit_name];
			 ]"
		end

	objc_measurement_units (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerView *)$an_item measurementUnits];
			 ]"
		end

	objc_set_origin_offset_ (an_item: POINTER; a_offset: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setOriginOffset:$a_offset];
			 ]"
		end

	objc_origin_offset (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerView *)$an_item originOffset];
			 ]"
		end

	objc_set_client_view_ (an_item: POINTER; a_client: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setClientView:$a_client];
			 ]"
		end

	objc_client_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerView *)$an_item clientView];
			 ]"
		end

	objc_set_markers_ (an_item: POINTER; a_markers: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setMarkers:$a_markers];
			 ]"
		end

	objc_add_marker_ (an_item: POINTER; a_marker: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item addMarker:$a_marker];
			 ]"
		end

	objc_remove_marker_ (an_item: POINTER; a_marker: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item removeMarker:$a_marker];
			 ]"
		end

	objc_markers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerView *)$an_item markers];
			 ]"
		end

	objc_track_marker__with_mouse_event_ (an_item: POINTER; a_marker: POINTER; a_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRulerView *)$an_item trackMarker:$a_marker withMouseEvent:$a_event];
			 ]"
		end

	objc_set_accessory_view_ (an_item: POINTER; a_accessory: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item setAccessoryView:$a_accessory];
			 ]"
		end

	objc_accessory_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRulerView *)$an_item accessoryView];
			 ]"
		end

	objc_move_rulerline_from_location__to_location_ (an_item: POINTER; a_old_location: REAL_64; a_new_location: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item moveRulerlineFromLocation:$a_old_location toLocation:$a_new_location];
			 ]"
		end

	objc_invalidate_hash_marks (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item invalidateHashMarks];
			 ]"
		end

	objc_draw_hash_marks_and_labels_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item drawHashMarksAndLabelsInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_draw_markers_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRulerView *)$an_item drawMarkersInRect:*((NSRect *)$a_rect)];
			 ]"
		end

feature -- NSRulerView

	set_scroll_view_ (a_scroll_view: detachable NS_SCROLL_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_scroll_view__item: POINTER
		do
			if attached a_scroll_view as a_scroll_view_attached then
				a_scroll_view__item := a_scroll_view_attached.item
			end
			objc_set_scroll_view_ (item, a_scroll_view__item)
		end

	scroll_view: detachable NS_SCROLL_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_scroll_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like scroll_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like scroll_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_orientation_ (a_orientation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_orientation_ (item, a_orientation)
		end

	orientation: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_orientation (item)
		end

	baseline_location: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_baseline_location (item)
		end

	required_thickness: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_required_thickness (item)
		end

	set_rule_thickness_ (a_thickness: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_rule_thickness_ (item, a_thickness)
		end

	rule_thickness: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_rule_thickness (item)
		end

	set_reserved_thickness_for_markers_ (a_thickness: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_reserved_thickness_for_markers_ (item, a_thickness)
		end

	reserved_thickness_for_markers: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_reserved_thickness_for_markers (item)
		end

	set_reserved_thickness_for_accessory_view_ (a_thickness: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_reserved_thickness_for_accessory_view_ (item, a_thickness)
		end

	reserved_thickness_for_accessory_view: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_reserved_thickness_for_accessory_view (item)
		end

	set_measurement_units_ (a_unit_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_unit_name__item: POINTER
		do
			if attached a_unit_name as a_unit_name_attached then
				a_unit_name__item := a_unit_name_attached.item
			end
			objc_set_measurement_units_ (item, a_unit_name__item)
		end

	measurement_units: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_measurement_units (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like measurement_units} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like measurement_units} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_origin_offset_ (a_offset: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_origin_offset_ (item, a_offset)
		end

	origin_offset: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_origin_offset (item)
		end

	set_client_view_ (a_client: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_client__item: POINTER
		do
			if attached a_client as a_client_attached then
				a_client__item := a_client_attached.item
			end
			objc_set_client_view_ (item, a_client__item)
		end

	client_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_client_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like client_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like client_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_markers_ (a_markers: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_markers__item: POINTER
		do
			if attached a_markers as a_markers_attached then
				a_markers__item := a_markers_attached.item
			end
			objc_set_markers_ (item, a_markers__item)
		end

	add_marker_ (a_marker: detachable NS_RULER_MARKER)
			-- Auto generated Objective-C wrapper.
		local
			a_marker__item: POINTER
		do
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			objc_add_marker_ (item, a_marker__item)
		end

	remove_marker_ (a_marker: detachable NS_RULER_MARKER)
			-- Auto generated Objective-C wrapper.
		local
			a_marker__item: POINTER
		do
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			objc_remove_marker_ (item, a_marker__item)
		end

	markers: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_markers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like markers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like markers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	track_marker__with_mouse_event_ (a_marker: detachable NS_RULER_MARKER; a_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_marker__item: POINTER
			a_event__item: POINTER
		do
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			Result := objc_track_marker__with_mouse_event_ (item, a_marker__item, a_event__item)
		end

	set_accessory_view_ (a_accessory: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_accessory__item: POINTER
		do
			if attached a_accessory as a_accessory_attached then
				a_accessory__item := a_accessory_attached.item
			end
			objc_set_accessory_view_ (item, a_accessory__item)
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

	move_rulerline_from_location__to_location_ (a_old_location: REAL_64; a_new_location: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_move_rulerline_from_location__to_location_ (item, a_old_location, a_new_location)
		end

	invalidate_hash_marks
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate_hash_marks (item)
		end

	draw_hash_marks_and_labels_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_hash_marks_and_labels_in_rect_ (item, a_rect.item)
		end

	draw_markers_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_markers_in_rect_ (item, a_rect.item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRulerView"
		end

end
