note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BEZIER_PATH_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSBezierPath

	bezier_path: detachable NS_BEZIER_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bezier_path (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bezier_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bezier_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bezier_path_with_rect_ (a_rect: NS_RECT): detachable NS_BEZIER_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bezier_path_with_rect_ (l_objc_class.item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bezier_path_with_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bezier_path_with_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bezier_path_with_oval_in_rect_ (a_rect: NS_RECT): detachable NS_BEZIER_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bezier_path_with_oval_in_rect_ (l_objc_class.item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bezier_path_with_oval_in_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bezier_path_with_oval_in_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	bezier_path_with_rounded_rect__x_radius__y_radius_ (a_rect: NS_RECT; a_x_radius: REAL_64; a_y_radius: REAL_64): detachable NS_BEZIER_PATH
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_bezier_path_with_rounded_rect__x_radius__y_radius_ (l_objc_class.item, a_rect.item, a_x_radius, a_y_radius)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bezier_path_with_rounded_rect__x_radius__y_radius_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bezier_path_with_rounded_rect__x_radius__y_radius_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	fill_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_fill_rect_ (l_objc_class.item, a_rect.item)
		end

	stroke_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_stroke_rect_ (l_objc_class.item, a_rect.item)
		end

	clip_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_clip_rect_ (l_objc_class.item, a_rect.item)
		end

	stroke_line_from_point__to_point_ (a_point1: NS_POINT; a_point2: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_stroke_line_from_point__to_point_ (l_objc_class.item, a_point1.item, a_point2.item)
		end

--	draw_packed_glyphs__at_point_ (a_packed_glyphs: UNSUPPORTED_TYPE; a_point: NS_POINT)
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--		do
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			objc_draw_packed_glyphs__at_point_ (l_objc_class.item, , a_point.item)
--		end

	set_default_miter_limit_ (a_limit: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_miter_limit_ (l_objc_class.item, a_limit)
		end

	default_miter_limit: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_miter_limit (l_objc_class.item)
		end

	set_default_flatness_ (a_flatness: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_flatness_ (l_objc_class.item, a_flatness)
		end

	default_flatness: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_flatness (l_objc_class.item)
		end

	set_default_winding_rule_ (a_winding_rule: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_winding_rule_ (l_objc_class.item, a_winding_rule)
		end

	default_winding_rule: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_winding_rule (l_objc_class.item)
		end

	set_default_line_cap_style_ (a_line_cap_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_line_cap_style_ (l_objc_class.item, a_line_cap_style)
		end

	default_line_cap_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_line_cap_style (l_objc_class.item)
		end

	set_default_line_join_style_ (a_line_join_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_line_join_style_ (l_objc_class.item, a_line_join_style)
		end

	default_line_join_style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_line_join_style (l_objc_class.item)
		end

	set_default_line_width_ (a_line_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_set_default_line_width_ (l_objc_class.item, a_line_width)
		end

	default_line_width: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_line_width (l_objc_class.item)
		end

feature {NONE} -- NSBezierPath Externals

	objc_bezier_path (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object bezierPath];
			 ]"
		end

	objc_bezier_path_with_rect_ (a_class_object: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object bezierPathWithRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_bezier_path_with_oval_in_rect_ (a_class_object: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object bezierPathWithOvalInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_bezier_path_with_rounded_rect__x_radius__y_radius_ (a_class_object: POINTER; a_rect: POINTER; a_x_radius: REAL_64; a_y_radius: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object bezierPathWithRoundedRect:*((NSRect *)$a_rect) xRadius:$a_x_radius yRadius:$a_y_radius];
			 ]"
		end

	objc_fill_rect_ (a_class_object: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object fillRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_stroke_rect_ (a_class_object: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object strokeRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_clip_rect_ (a_class_object: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object clipRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_stroke_line_from_point__to_point_ (a_class_object: POINTER; a_point1: POINTER; a_point2: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object strokeLineFromPoint:*((NSPoint *)$a_point1) toPoint:*((NSPoint *)$a_point2)];
			 ]"
		end

	objc_draw_packed_glyphs__at_point_ (a_class_object: POINTER; a_packed_glyphs: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object drawPackedGlyphs:$a_packed_glyphs atPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_set_default_miter_limit_ (a_class_object: POINTER; a_limit: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultMiterLimit:$a_limit];
			 ]"
		end

	objc_default_miter_limit (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultMiterLimit];
			 ]"
		end

	objc_set_default_flatness_ (a_class_object: POINTER; a_flatness: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultFlatness:$a_flatness];
			 ]"
		end

	objc_default_flatness (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultFlatness];
			 ]"
		end

	objc_set_default_winding_rule_ (a_class_object: POINTER; a_winding_rule: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultWindingRule:$a_winding_rule];
			 ]"
		end

	objc_default_winding_rule (a_class_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultWindingRule];
			 ]"
		end

	objc_set_default_line_cap_style_ (a_class_object: POINTER; a_line_cap_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultLineCapStyle:$a_line_cap_style];
			 ]"
		end

	objc_default_line_cap_style (a_class_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultLineCapStyle];
			 ]"
		end

	objc_set_default_line_join_style_ (a_class_object: POINTER; a_line_join_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultLineJoinStyle:$a_line_join_style];
			 ]"
		end

	objc_default_line_join_style (a_class_object: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultLineJoinStyle];
			 ]"
		end

	objc_set_default_line_width_ (a_class_object: POINTER; a_line_width: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(Class)$a_class_object setDefaultLineWidth:$a_line_width];
			 ]"
		end

	objc_default_line_width (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultLineWidth];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSBezierPath"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
