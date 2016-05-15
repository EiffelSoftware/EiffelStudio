note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BEZIER_PATH

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
	make

feature -- NSBezierPath

	move_to_point_ (a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_move_to_point_ (item, a_point.item)
		end

	line_to_point_ (a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_line_to_point_ (item, a_point.item)
		end

	curve_to_point__control_point1__control_point2_ (a_end_point: NS_POINT; a_control_point1: NS_POINT; a_control_point2: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_curve_to_point__control_point1__control_point2_ (item, a_end_point.item, a_control_point1.item, a_control_point2.item)
		end

	close_path
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_close_path (item)
		end

	remove_all_points
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_points (item)
		end

	relative_move_to_point_ (a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_relative_move_to_point_ (item, a_point.item)
		end

	relative_line_to_point_ (a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_relative_line_to_point_ (item, a_point.item)
		end

	relative_curve_to_point__control_point1__control_point2_ (a_end_point: NS_POINT; a_control_point1: NS_POINT; a_control_point2: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_relative_curve_to_point__control_point1__control_point2_ (item, a_end_point.item, a_control_point1.item, a_control_point2.item)
		end

	line_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_width (item)
		end

	set_line_width_ (a_line_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_width_ (item, a_line_width)
		end

	line_cap_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_cap_style (item)
		end

	set_line_cap_style_ (a_line_cap_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_cap_style_ (item, a_line_cap_style)
		end

	line_join_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_line_join_style (item)
		end

	set_line_join_style_ (a_line_join_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_join_style_ (item, a_line_join_style)
		end

	winding_rule: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_winding_rule (item)
		end

	set_winding_rule_ (a_winding_rule: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_winding_rule_ (item, a_winding_rule)
		end

	miter_limit: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_miter_limit (item)
		end

	set_miter_limit_ (a_miter_limit: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_miter_limit_ (item, a_miter_limit)
		end

	flatness: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_flatness (item)
		end

	set_flatness_ (a_flatness: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_flatness_ (item, a_flatness)
		end

--	get_line_dash__count__phase_ (a_pattern: UNSUPPORTED_TYPE; a_count: UNSUPPORTED_TYPE; a_phase: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_pattern__item: POINTER
--			a_count__item: POINTER
--			a_phase__item: POINTER
--		do
--			if attached a_pattern as a_pattern_attached then
--				a_pattern__item := a_pattern_attached.item
--			end
--			if attached a_count as a_count_attached then
--				a_count__item := a_count_attached.item
--			end
--			if attached a_phase as a_phase_attached then
--				a_phase__item := a_phase_attached.item
--			end
--			objc_get_line_dash__count__phase_ (item, a_pattern__item, a_count__item, a_phase__item)
--		end

--	set_line_dash__count__phase_ (a_pattern: UNSUPPORTED_TYPE; a_count: INTEGER_64; a_phase: REAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_pattern__item: POINTER
--		do
--			if attached a_pattern as a_pattern_attached then
--				a_pattern__item := a_pattern_attached.item
--			end
--			objc_set_line_dash__count__phase_ (item, a_pattern__item, a_count, a_phase)
--		end

	stroke
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stroke (item)
		end

	fill
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_fill (item)
		end

	add_clip
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_add_clip (item)
		end

	set_clip
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_clip (item)
		end

	bezier_path_by_flattening_path: detachable NS_BEZIER_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bezier_path_by_flattening_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bezier_path_by_flattening_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bezier_path_by_flattening_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bezier_path_by_reversing_path: detachable NS_BEZIER_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bezier_path_by_reversing_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bezier_path_by_reversing_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bezier_path_by_reversing_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	transform_using_affine_transform_ (a_transform: detachable NS_AFFINE_TRANSFORM)
			-- Auto generated Objective-C wrapper.
		local
			a_transform__item: POINTER
		do
			if attached a_transform as a_transform_attached then
				a_transform__item := a_transform_attached.item
			end
			objc_transform_using_affine_transform_ (item, a_transform__item)
		end

	is_empty: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_empty (item)
		end

	current_point: NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_current_point (item, Result.item)
		end

	control_point_bounds: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_control_point_bounds (item, Result.item)
		end

	bounds: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_bounds (item, Result.item)
		end

	element_count: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_element_count (item)
		end

--	element_at_index__associated_points_ (a_index: INTEGER_64; a_points: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_points__item: POINTER
--		do
--			if attached a_points as a_points_attached then
--				a_points__item := a_points_attached.item
--			end
--			Result := objc_element_at_index__associated_points_ (item, a_index, a_points__item)
--		end

	element_at_index_ (a_index: INTEGER_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_element_at_index_ (item, a_index)
		end

--	set_associated_points__at_index_ (a_points: UNSUPPORTED_TYPE; a_index: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_points__item: POINTER
--		do
--			if attached a_points as a_points_attached then
--				a_points__item := a_points_attached.item
--			end
--			objc_set_associated_points__at_index_ (item, a_points__item, a_index)
--		end

	append_bezier_path_ (a_path: detachable NS_BEZIER_PATH)
			-- Auto generated Objective-C wrapper.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_append_bezier_path_ (item, a_path__item)
		end

	append_bezier_path_with_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_append_bezier_path_with_rect_ (item, a_rect.item)
		end

--	append_bezier_path_with_points__count_ (a_points: UNSUPPORTED_TYPE; a_count: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_points__item: POINTER
--		do
--			if attached a_points as a_points_attached then
--				a_points__item := a_points_attached.item
--			end
--			objc_append_bezier_path_with_points__count_ (item, a_points__item, a_count)
--		end

	append_bezier_path_with_oval_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_append_bezier_path_with_oval_in_rect_ (item, a_rect.item)
		end

	append_bezier_path_with_arc_with_center__radius__start_angle__end_angle__clockwise_ (a_center: NS_POINT; a_radius: REAL_64; a_start_angle: REAL_64; a_end_angle: REAL_64; a_clockwise: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_append_bezier_path_with_arc_with_center__radius__start_angle__end_angle__clockwise_ (item, a_center.item, a_radius, a_start_angle, a_end_angle, a_clockwise)
		end

	append_bezier_path_with_arc_with_center__radius__start_angle__end_angle_ (a_center: NS_POINT; a_radius: REAL_64; a_start_angle: REAL_64; a_end_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_append_bezier_path_with_arc_with_center__radius__start_angle__end_angle_ (item, a_center.item, a_radius, a_start_angle, a_end_angle)
		end

	append_bezier_path_with_arc_from_point__to_point__radius_ (a_point1: NS_POINT; a_point2: NS_POINT; a_radius: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_append_bezier_path_with_arc_from_point__to_point__radius_ (item, a_point1.item, a_point2.item, a_radius)
		end

	append_bezier_path_with_glyph__in_font_ (a_glyph: NATURAL_32; a_font: detachable NS_FONT)
			-- Auto generated Objective-C wrapper.
		local
			a_font__item: POINTER
		do
			if attached a_font as a_font_attached then
				a_font__item := a_font_attached.item
			end
			objc_append_bezier_path_with_glyph__in_font_ (item, a_glyph, a_font__item)
		end

--	append_bezier_path_with_glyphs__count__in_font_ (a_glyphs: UNSUPPORTED_TYPE; a_count: INTEGER_64; a_font: detachable NS_FONT)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyphs__item: POINTER
--			a_font__item: POINTER
--		do
--			if attached a_glyphs as a_glyphs_attached then
--				a_glyphs__item := a_glyphs_attached.item
--			end
--			if attached a_font as a_font_attached then
--				a_font__item := a_font_attached.item
--			end
--			objc_append_bezier_path_with_glyphs__count__in_font_ (item, a_glyphs__item, a_count, a_font__item)
--		end

--	append_bezier_path_with_packed_glyphs_ (a_packed_glyphs: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_append_bezier_path_with_packed_glyphs_ (item, )
--		end

	append_bezier_path_with_rounded_rect__x_radius__y_radius_ (a_rect: NS_RECT; a_x_radius: REAL_64; a_y_radius: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_append_bezier_path_with_rounded_rect__x_radius__y_radius_ (item, a_rect.item, a_x_radius, a_y_radius)
		end

	contains_point_ (a_point: NS_POINT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_contains_point_ (item, a_point.item)
		end

feature {NONE} -- NSBezierPath Externals

	objc_move_to_point_ (an_item: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item moveToPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_line_to_point_ (an_item: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item lineToPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_curve_to_point__control_point1__control_point2_ (an_item: POINTER; a_end_point: POINTER; a_control_point1: POINTER; a_control_point2: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item curveToPoint:*((NSPoint *)$a_end_point) controlPoint1:*((NSPoint *)$a_control_point1) controlPoint2:*((NSPoint *)$a_control_point2)];
			 ]"
		end

	objc_close_path (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item closePath];
			 ]"
		end

	objc_remove_all_points (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item removeAllPoints];
			 ]"
		end

	objc_relative_move_to_point_ (an_item: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item relativeMoveToPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_relative_line_to_point_ (an_item: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item relativeLineToPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_relative_curve_to_point__control_point1__control_point2_ (an_item: POINTER; a_end_point: POINTER; a_control_point1: POINTER; a_control_point2: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item relativeCurveToPoint:*((NSPoint *)$a_end_point) controlPoint1:*((NSPoint *)$a_control_point1) controlPoint2:*((NSPoint *)$a_control_point2)];
			 ]"
		end

	objc_line_width (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item lineWidth];
			 ]"
		end

	objc_set_line_width_ (an_item: POINTER; a_line_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item setLineWidth:$a_line_width];
			 ]"
		end

	objc_line_cap_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item lineCapStyle];
			 ]"
		end

	objc_set_line_cap_style_ (an_item: POINTER; a_line_cap_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item setLineCapStyle:$a_line_cap_style];
			 ]"
		end

	objc_line_join_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item lineJoinStyle];
			 ]"
		end

	objc_set_line_join_style_ (an_item: POINTER; a_line_join_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item setLineJoinStyle:$a_line_join_style];
			 ]"
		end

	objc_winding_rule (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item windingRule];
			 ]"
		end

	objc_set_winding_rule_ (an_item: POINTER; a_winding_rule: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item setWindingRule:$a_winding_rule];
			 ]"
		end

	objc_miter_limit (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item miterLimit];
			 ]"
		end

	objc_set_miter_limit_ (an_item: POINTER; a_miter_limit: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item setMiterLimit:$a_miter_limit];
			 ]"
		end

	objc_flatness (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item flatness];
			 ]"
		end

	objc_set_flatness_ (an_item: POINTER; a_flatness: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item setFlatness:$a_flatness];
			 ]"
		end

--	objc_get_line_dash__count__phase_ (an_item: POINTER; a_pattern: UNSUPPORTED_TYPE; a_count: UNSUPPORTED_TYPE; a_phase: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBezierPath *)$an_item getLineDash: count: phase:];
--			 ]"
--		end

--	objc_set_line_dash__count__phase_ (an_item: POINTER; a_pattern: UNSUPPORTED_TYPE; a_count: INTEGER_64; a_phase: REAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBezierPath *)$an_item setLineDash: count:$a_count phase:$a_phase];
--			 ]"
--		end

	objc_stroke (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item stroke];
			 ]"
		end

	objc_fill (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item fill];
			 ]"
		end

	objc_add_clip (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item addClip];
			 ]"
		end

	objc_set_clip (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item setClip];
			 ]"
		end

	objc_bezier_path_by_flattening_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBezierPath *)$an_item bezierPathByFlatteningPath];
			 ]"
		end

	objc_bezier_path_by_reversing_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSBezierPath *)$an_item bezierPathByReversingPath];
			 ]"
		end

	objc_transform_using_affine_transform_ (an_item: POINTER; a_transform: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item transformUsingAffineTransform:$a_transform];
			 ]"
		end

	objc_is_empty (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item isEmpty];
			 ]"
		end

	objc_current_point (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSBezierPath *)$an_item currentPoint];
			 ]"
		end

	objc_control_point_bounds (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSBezierPath *)$an_item controlPointBounds];
			 ]"
		end

	objc_bounds (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSBezierPath *)$an_item bounds];
			 ]"
		end

	objc_element_count (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item elementCount];
			 ]"
		end

--	objc_element_at_index__associated_points_ (an_item: POINTER; a_index: INTEGER_64; a_points: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSBezierPath *)$an_item elementAtIndex:$a_index associatedPoints:];
--			 ]"
--		end

	objc_element_at_index_ (an_item: POINTER; a_index: INTEGER_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item elementAtIndex:$a_index];
			 ]"
		end

--	objc_set_associated_points__at_index_ (an_item: POINTER; a_points: UNSUPPORTED_TYPE; a_index: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBezierPath *)$an_item setAssociatedPoints: atIndex:$a_index];
--			 ]"
--		end

	objc_append_bezier_path_ (an_item: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item appendBezierPath:$a_path];
			 ]"
		end

	objc_append_bezier_path_with_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item appendBezierPathWithRect:*((NSRect *)$a_rect)];
			 ]"
		end

--	objc_append_bezier_path_with_points__count_ (an_item: POINTER; a_points: UNSUPPORTED_TYPE; a_count: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBezierPath *)$an_item appendBezierPathWithPoints: count:$a_count];
--			 ]"
--		end

	objc_append_bezier_path_with_oval_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item appendBezierPathWithOvalInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_append_bezier_path_with_arc_with_center__radius__start_angle__end_angle__clockwise_ (an_item: POINTER; a_center: POINTER; a_radius: REAL_64; a_start_angle: REAL_64; a_end_angle: REAL_64; a_clockwise: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item appendBezierPathWithArcWithCenter:*((NSPoint *)$a_center) radius:$a_radius startAngle:$a_start_angle endAngle:$a_end_angle clockwise:$a_clockwise];
			 ]"
		end

	objc_append_bezier_path_with_arc_with_center__radius__start_angle__end_angle_ (an_item: POINTER; a_center: POINTER; a_radius: REAL_64; a_start_angle: REAL_64; a_end_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item appendBezierPathWithArcWithCenter:*((NSPoint *)$a_center) radius:$a_radius startAngle:$a_start_angle endAngle:$a_end_angle];
			 ]"
		end

	objc_append_bezier_path_with_arc_from_point__to_point__radius_ (an_item: POINTER; a_point1: POINTER; a_point2: POINTER; a_radius: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item appendBezierPathWithArcFromPoint:*((NSPoint *)$a_point1) toPoint:*((NSPoint *)$a_point2) radius:$a_radius];
			 ]"
		end

	objc_append_bezier_path_with_glyph__in_font_ (an_item: POINTER; a_glyph: NATURAL_32; a_font: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item appendBezierPathWithGlyph:$a_glyph inFont:$a_font];
			 ]"
		end

--	objc_append_bezier_path_with_glyphs__count__in_font_ (an_item: POINTER; a_glyphs: UNSUPPORTED_TYPE; a_count: INTEGER_64; a_font: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBezierPath *)$an_item appendBezierPathWithGlyphs: count:$a_count inFont:$a_font];
--			 ]"
--		end

--	objc_append_bezier_path_with_packed_glyphs_ (an_item: POINTER; a_packed_glyphs: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSBezierPath *)$an_item appendBezierPathWithPackedGlyphs:$a_packed_glyphs];
--			 ]"
--		end

	objc_append_bezier_path_with_rounded_rect__x_radius__y_radius_ (an_item: POINTER; a_rect: POINTER; a_x_radius: REAL_64; a_y_radius: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSBezierPath *)$an_item appendBezierPathWithRoundedRect:*((NSRect *)$a_rect) xRadius:$a_x_radius yRadius:$a_y_radius];
			 ]"
		end

	objc_contains_point_ (an_item: POINTER; a_point: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSBezierPath *)$an_item containsPoint:*((NSPoint *)$a_point)];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBezierPath"
		end

end
