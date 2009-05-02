note
	description: "Summary description for {NS_BEZIER_PATH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BEZIER_PATH

inherit
	NS_OBJECT

create
	bezier_path,
	bezier_path_with_rect,
	bezier_path_with_oval_in_rect

feature

	bezier_path
			--(NSBezierPath *)bezierPath
		do
			cocoa_object := bezier_path_bezier_path
		end

	bezier_path_with_rect (a_rect: NS_RECT)
			--(NSBezierPath *)bezierPathWithRect:(NSRect)rect
		do
			cocoa_object := bezier_path_bezier_path_with_rect (a_rect.item)
		end

	bezier_path_with_oval_in_rect (a_rect: NS_RECT)
			--(NSBezierPath *)bezierPathWithOvalInRect:(NSRect)rect
		do
			cocoa_object := bezier_path_bezier_path_with_oval_in_rect (a_rect.item)
		end

--(NSBezierPath *)bezierPathWithRoundedRect:(NSRect)rect xRadius:(CGFloat)xRadius yRadius:(CGFloat)yRadius
--(void)fillRect:(NSRect)rect
--(void)strokeRect:(NSRect)rect
--(void)clipRect:(NSRect)rect
--(void)strokeLineFromPoint:(NSPoint)point1 toPoint:(NSPoint)point2
--(void)drawPackedGlyphs:(const char *)packedGlyphs atPoint:(NSPoint)point
--(void)setDefaultMiterLimit:(CGFloat)limit
--(CGFloat)defaultMiterLimit
--(void)setDefaultFlatness:(CGFloat)flatness
--(CGFloat)defaultFlatness
--(void)setDefaultWindingRule:(NSWindingRule)windingRule
--(NSWindingRule)defaultWindingRule
--(void)setDefaultLineCapStyle:(NSLineCapStyle)lineCapStyle
--(NSLineCapStyle)defaultLineCapStyle
--(void)setDefaultLineJoinStyle:(NSLineJoinStyle)lineJoinStyle
--(NSLineJoinStyle)defaultLineJoinStyle
--(void)setDefaultLineWidth:(CGFloat)lineWidth
--(CGFloat)defaultLineWidth

	move_to_point (a_point: NS_POINT)
		do
			bezier_path_move_to_point (cocoa_object, a_point.item)
		end

	line_to_point (a_point: NS_POINT)
		do
			bezier_path_line_to_point (cocoa_object, a_point.item)
		end

	close_path
		do
			bezier_path_close_path (cocoa_object)
		end

	remove_all_points
		do
			bezier_path_remove_all_points (cocoa_object)
		end

--	relative_move_to_point (a_point: NS_POINT)
--		do
--			bezier_path_relative_move_to_point (cocoa_object, a_point.cocoa_object)
--		end

--	relative_line_to_point (a_point: NS_POINT)
--		do
--			bezier_path_relative_line_to_point (cocoa_object, a_point.cocoa_object)
--		end

	line_width: REAL
		do
			Result := bezier_path_line_width (cocoa_object)
		end

	set_line_width (a_line_width: REAL)
		do
			bezier_path_set_line_width (cocoa_object, a_line_width)
		end

	line_cap_style: INTEGER
		do
			Result := bezier_path_line_cap_style (cocoa_object)
		end

	set_line_cap_style (a_line_cap_style: INTEGER)
		do
			bezier_path_set_line_cap_style (cocoa_object, a_line_cap_style)
		end

	line_join_style : INTEGER
		do
			Result := bezier_path_line_join_style (cocoa_object)
		end

	set_line_join_style (a_line_join_style: INTEGER)
		do
			bezier_path_set_line_join_style (cocoa_object, a_line_join_style)
		end

	winding_rule: INTEGER
		do
			Result := bezier_path_winding_rule (cocoa_object)
		end

	set_winding_rule (a_winding_rule: INTEGER)
		do
			bezier_path_set_winding_rule (cocoa_object, a_winding_rule)
		end

	miter_limit : REAL
		do
			Result := bezier_path_miter_limit (cocoa_object)
		end

	set_miter_limit( a_miter_limit: REAL)
		do
			bezier_path_set_miter_limit (cocoa_object, a_miter_limit)
		end

	flatness : REAL
		do
			Result := bezier_path_flatness (cocoa_object)
		end

	set_flatness( a_flatness: REAL)
		do
			bezier_path_set_flatness (cocoa_object, a_flatness)
		end

--	get_line_dash_count_phase( a_pattern: POINTER[FLOAT]; a_count: NS_INTEGER; a_phase: POINTER[FLOAT])
--		do
--			bezier_path_get_line_dash_count_phase (cocoa_object, a_pattern, a_count.cocoa_object, a_phase)
--		end

	set_line_dash_count_phase (a_pattern: LIST[REAL]; a_phase: REAL)
		local
			l_pattern: MANAGED_POINTER
			i: INTEGER
		do
			create l_pattern.make (a_pattern.count)
			from
				a_pattern.start
				i := 0
			until
				a_pattern.after
			loop
				l_pattern.put_real_32 (a_pattern.item, i)
				i := i + 4
				a_pattern.forth
			end
			bezier_path_set_line_dash_count_phase (cocoa_object, l_pattern.item, a_pattern.count, a_phase)
		end

	stroke
		do
			bezier_path_stroke (cocoa_object)
		end

	fill
		do
			bezier_path_fill (cocoa_object)
		end

	add_clip
		do
			bezier_path_add_clip (cocoa_object)
		end

	set_clip
		do
			bezier_path_set_clip (cocoa_object)
		end

--	bezier_path_by_flattening_path : NS_BEZIER_PATH
--		do
--			Result := bezier_path_bezier_path_by_flattening_path (cocoa_object)
--		end

--	bezier_path_by_reversing_path : NS_BEZIER_PATH
--		do
--			Result := bezier_path_bezier_path_by_reversing_path (cocoa_object)
--		end

--	transform_using_affine_transform( a_transform: NS_AFFINE_TRANSFORM)
--		do
--			bezier_path_transform_using_affine_transform (cocoa_object, a_transform.cocoa_object)
--		end

	is_empty : BOOLEAN
		do
			Result := bezier_path_is_empty (cocoa_object)
		end

--	current_point : NS_POINT
--		do
--			Result := bezier_path_current_point (cocoa_object)
--		end

--	control_point_bounds : NS_RECT
--		do
--			Result := bezier_path_control_point_bounds (cocoa_object)
--		end

--	bounds : NS_RECT
--		do
--			Result := bezier_path_bounds (cocoa_object)
--		end

--	element_count : INTEGER
--		do
--			Result := bezier_path_element_count (cocoa_object)
--		end

--	element_at_index( a_index: INTEGER): NS_BEZIER_PATH_ELEMENT
--		do
--			Result := bezier_path_element_at_index (cocoa_object, a_index)
--		end

--	set_associated_points_at_index( a_points: NS_POINT_ARRAY; a_index: INTEGER)
--		do
--			bezier_path_set_associated_points_at_index (cocoa_object, a_points.cocoa_object, a_index)
--		end

	append_bezier_path (a_path: NS_BEZIER_PATH)
		do
			bezier_path_append_bezier_path (cocoa_object, a_path.cocoa_object)
		end

	append_bezier_path_with_arc_with_center_radius_start_angle_end_angle (a_center: NS_POINT; a_radius: REAL; a_start_angle, a_end_angle: REAL)
		do
			bezier_path_append_bezier_path_with_arc_with_center_radius_start_angle_end_angle (cocoa_object, a_center.item, a_radius, a_start_angle, a_end_angle)
		end

--	append_bezier_path_with_rect( a_rect: NS_RECT)
--		do
--			bezier_path_append_bezier_path_with_rect (cocoa_object, a_rect.cocoa_object)
--		end

--	append_bezier_path_with_points_count( a_points: NS_POINT_ARRAY; a_count: INTEGER)
--		do
--			bezier_path_append_bezier_path_with_points_count (cocoa_object, a_points.cocoa_object, a_count)
--		end

--	append_bezier_path_with_oval_in_rect( a_rect: NS_RECT)
--		do
--			bezier_path_append_bezier_path_with_oval_in_rect (cocoa_object, a_rect.cocoa_object)
--		end

--	append_bezier_path_with_glyph_in_font( a_glyph: NS_GLYPH; a_font: NS_FONT)
--		do
--			bezier_path_append_bezier_path_with_glyph_in_font (cocoa_object, a_glyph.cocoa_object, a_font.cocoa_object)
--		end

--	append_bezier_path_with_packed_glyphs( a_packed_glyphs: POINTER[CHARACTER])
--		do
--			bezier_path_append_bezier_path_with_packed_glyphs (cocoa_object, a_packed_glyphs)
--		end

--	append_bezier_path_with_rounded_rect_x_radius_y_radius( a_rect: NS_RECT; a_x_radius: REAL; a_y_radius: REAL)
--		do
--			bezier_path_append_bezier_path_with_rounded_rect_x_radius_y_radius (cocoa_object, a_rect.cocoa_object, a_x_radius, a_y_radius)
--		end

--	contains_point( a_point: NS_POINT): BOOLEAN
--		do
--			Result := bezier_path_contains_point (cocoa_object, a_point.cocoa_object)
--		end

--	caches_bezier_path : BOOLEAN
--		do
--			Result := bezier_path_caches_bezier_path (cocoa_object)
--		end

--	set_caches_bezier_path( a_flag: BOOLEAN)
--		do
--			bezier_path_set_caches_bezier_path (cocoa_object, a_flag)
--		end

feature {NONE} -- Objective-C implementation

	frozen bezier_path_bezier_path: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBezierPath bezierPath];"
		end

	frozen bezier_path_bezier_path_with_rect (a_rect: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBezierPath bezierPathWithRect: *(NSRect *)$a_rect];"
		end

	frozen bezier_path_bezier_path_with_oval_in_rect (a_rect: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBezierPath bezierPathWithOvalInRect: *(NSRect *)$a_rect];"
		end

	frozen bezier_path_fill_rect (a_rect: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSBezierPath fillRect: *(NSRect *)$a_rect];"
		end

	frozen bezier_path_move_to_point (a_bezier_path: POINTER; a_point: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path moveToPoint: *(NSPoint*)$a_point];"
		end

	frozen bezier_path_line_to_point (a_bezier_path: POINTER; a_point: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path lineToPoint: *(NSPoint*) $a_point];"
		end

	frozen bezier_path_close_path (a_bezier_path: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path closePath];"
		end

	frozen bezier_path_remove_all_points (a_bezier_path: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path removeAllPoints];"
		end

--	frozen bezier_path_relative_move_to_point (a_bezier_path: POINTER; a_point: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path relativeMoveToPoint: $a_point];"
--		end

--	frozen bezier_path_relative_line_to_point (a_bezier_path: POINTER; a_point: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path relativeLineToPoint: $a_point];"
--		end

	frozen bezier_path_line_width (a_bezier_path: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path lineWidth];"
		end

	frozen bezier_path_set_line_width (a_bezier_path: POINTER; a_line_width: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setLineWidth: $a_line_width];"
		end

	frozen bezier_path_line_cap_style (a_bezier_path: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path lineCapStyle];"
		end

	frozen bezier_path_set_line_cap_style (a_bezier_path: POINTER; a_line_cap_style: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setLineCapStyle: $a_line_cap_style];"
		end

	frozen bezier_path_line_join_style (a_bezier_path: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path lineJoinStyle];"
		end

	frozen bezier_path_set_line_join_style (a_bezier_path: POINTER; a_line_join_style: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setLineJoinStyle: $a_line_join_style];"
		end

	frozen bezier_path_winding_rule (a_bezier_path: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path windingRule];"
		end

	frozen bezier_path_set_winding_rule (a_bezier_path: POINTER; a_winding_rule: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setWindingRule: $a_winding_rule];"
		end

	frozen bezier_path_miter_limit (a_bezier_path: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path miterLimit];"
		end

	frozen bezier_path_set_miter_limit (a_bezier_path: POINTER; a_miter_limit: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setMiterLimit: $a_miter_limit];"
		end

	frozen bezier_path_flatness (a_bezier_path: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path flatness];"
		end

	frozen bezier_path_set_flatness (a_bezier_path: POINTER; a_flatness: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setFlatness: $a_flatness];"
		end

--	frozen bezier_path_get_line_dash_count_phase (a_bezier_path: POINTER; a_pattern: POINTER[FLOAT]; a_count: POINTER; a_phase: POINTER[FLOAT])
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path getLineDash: $a_pattern count: $a_count phase: $a_phase];"
--		end

	frozen bezier_path_set_line_dash_count_phase (a_bezier_path: POINTER; a_pattern: POINTER; a_count: INTEGER; a_phase: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setLineDash: $a_pattern count: $a_count phase: $a_phase];"
		end

	frozen bezier_path_stroke (a_bezier_path: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path stroke];"
		end

	frozen bezier_path_fill (a_bezier_path: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path fill];"
		end

	frozen bezier_path_add_clip (a_bezier_path: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path addClip];"
		end

	frozen bezier_path_set_clip (a_bezier_path: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setClip];"
		end

	frozen bezier_path_bezier_path_by_flattening_path (a_bezier_path: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path bezierPathByFlatteningPath];"
		end

	frozen bezier_path_bezier_path_by_reversing_path (a_bezier_path: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path bezierPathByReversingPath];"
		end

	frozen bezier_path_transform_using_affine_transform (a_bezier_path: POINTER; a_transform: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path transformUsingAffineTransform: $a_transform];"
		end

	frozen bezier_path_is_empty (a_bezier_path: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path isEmpty];"
		end

--	frozen bezier_path_current_point (a_bezier_path: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSBezierPath*)$a_bezier_path currentPoint];"
--		end

--	frozen bezier_path_control_point_bounds (a_bezier_path: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSBezierPath*)$a_bezier_path controlPointBounds];"
--		end

--	frozen bezier_path_bounds (a_bezier_path: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSBezierPath*)$a_bezier_path bounds];"
--		end

	frozen bezier_path_element_count (a_bezier_path: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path elementCount];"
		end

	frozen bezier_path_element_at_index (a_bezier_path: POINTER; a_index: INTEGER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path elementAtIndex: $a_index];"
		end

--	frozen bezier_path_set_associated_points_at_index (a_bezier_path: POINTER; a_points: POINTER; a_index: INTEGER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path setAssociatedPoints: $a_points atIndex: $a_index];"
--		end

	frozen bezier_path_append_bezier_path (a_bezier_path: POINTER; a_path: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path appendBezierPath: $a_path];"
		end

	frozen bezier_path_append_bezier_path_with_arc_with_center_radius_start_angle_end_angle (a_bezier_path: POINTER; a_center: POINTER; a_radius: REAL; a_start_angle, a_end_angle: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path appendBezierPathWithArcWithCenter: *(NSPoint*) $a_center radius: $a_radius startAngle: $a_start_angle endAngle: $a_end_angle];"
		end

--	frozen bezier_path_append_bezier_path_with_rect (a_bezier_path: POINTER; a_rect: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path appendBezierPathWithRect: $a_rect];"
--		end

--	frozen bezier_path_append_bezier_path_with_points_count (a_bezier_path: POINTER; a_points: POINTER; a_count: INTEGER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path appendBezierPathWithPoints: $a_points count: $a_count];"
--		end

--	frozen bezier_path_append_bezier_path_with_oval_in_rect (a_bezier_path: POINTER; a_rect: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path appendBezierPathWithOvalInRect: $a_rect];"
--		end

	frozen bezier_path_append_bezier_path_with_glyph_in_font (a_bezier_path: POINTER; a_glyph: INTEGER; a_font: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path appendBezierPathWithGlyph: $a_glyph inFont: $a_font];"
		end

--	frozen bezier_path_append_bezier_path_with_packed_glyphs (a_bezier_path: POINTER; a_packed_glyphs: POINTER[CHARACTER])
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path appendBezierPathWithPackedGlyphs: $a_packed_glyphs];"
--		end

--	frozen bezier_path_append_bezier_path_with_rounded_rect_x_radius_y_radius (a_bezier_path: POINTER; a_rect: POINTER; a_x_radius: REAL; a_y_radius: REAL)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSBezierPath*)$a_bezier_path appendBezierPathWithRoundedRect: $a_rect xRadius: $a_x_radius yRadius: $a_y_radius];"
--		end

--	frozen bezier_path_contains_point (a_bezier_path: POINTER; a_point: POINTER): BOOLEAN
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSBezierPath*)$a_bezier_path containsPoint: $a_point];"
--		end

	frozen bezier_path_caches_bezier_path (a_bezier_path: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSBezierPath*)$a_bezier_path cachesBezierPath];"
		end

	frozen bezier_path_set_caches_bezier_path (a_bezier_path: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSBezierPath*)$a_bezier_path setCachesBezierPath: $a_flag];"
		end
end
