indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.GraphicsPath"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_GRAPHICS_PATH

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_graphics_path,
	make_drawing_graphics_path_5,
	make_drawing_graphics_path_4,
	make_drawing_graphics_path_1,
	make_drawing_graphics_path_2,
	make_drawing_graphics_path_3

feature {NONE} -- Initialization

	frozen make_drawing_graphics_path is
		external
			"IL creator use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_drawing_graphics_path_5 (pts: NATIVE_ARRAY [DRAWING_POINT]; types: NATIVE_ARRAY [INTEGER_8]; fill_mode: DRAWING_FILL_MODE) is
		external
			"IL creator signature (System.Drawing.Point[], System.Byte[], System.Drawing.Drawing2D.FillMode) use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_drawing_graphics_path_4 (pts: NATIVE_ARRAY [DRAWING_POINT]; types: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Drawing.Point[], System.Byte[]) use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_drawing_graphics_path_1 (fill_mode: DRAWING_FILL_MODE) is
		external
			"IL creator signature (System.Drawing.Drawing2D.FillMode) use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_drawing_graphics_path_2 (pts: NATIVE_ARRAY [DRAWING_POINT_F]; types: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Drawing.PointF[], System.Byte[]) use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_drawing_graphics_path_3 (pts: NATIVE_ARRAY [DRAWING_POINT_F]; types: NATIVE_ARRAY [INTEGER_8]; fill_mode: DRAWING_FILL_MODE) is
		external
			"IL creator signature (System.Drawing.PointF[], System.Byte[], System.Drawing.Drawing2D.FillMode) use System.Drawing.Drawing2D.GraphicsPath"
		end

feature -- Access

	frozen get_point_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_PointCount"
		end

	frozen get_path_types: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_PathTypes"
		end

	frozen get_path_data: DRAWING_PATH_DATA is
		external
			"IL signature (): System.Drawing.Drawing2D.PathData use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_PathData"
		end

	frozen get_path_points: NATIVE_ARRAY [DRAWING_POINT_F] is
		external
			"IL signature (): System.Drawing.PointF[] use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_PathPoints"
		end

	frozen get_fill_mode: DRAWING_FILL_MODE is
		external
			"IL signature (): System.Drawing.Drawing2D.FillMode use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_FillMode"
		end

feature -- Element Change

	frozen set_fill_mode (value: DRAWING_FILL_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"set_FillMode"
		end

feature -- Basic Operations

	frozen warp_array_point_f_rectangle_f_matrix (dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Warp"
		end

	frozen add_curve_array_point_single (points: NATIVE_ARRAY [DRAWING_POINT]; tension: REAL) is
		external
			"IL signature (System.Drawing.Point[], System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen transform (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Transform"
		end

	frozen is_outline_visible_int32_int32_pen (x: INTEGER; y: INTEGER; pen: DRAWING_PEN): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Pen): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_rectangle_rectangle_f (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddRectangle"
		end

	frozen is_visible_int32_int32_graphics (x: INTEGER; y: INTEGER; graphics: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen flatten is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Flatten"
		end

	frozen add_string_string_font_family_int32_single_rectangle (s: SYSTEM_STRING; family: DRAWING_FONT_FAMILY; style: INTEGER; em_size: REAL; layout_rect: DRAWING_RECTANGLE; format: DRAWING_STRING_FORMAT) is
		external
			"IL signature (System.String, System.Drawing.FontFamily, System.Int32, System.Single, System.Drawing.Rectangle, System.Drawing.StringFormat): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddString"
		end

	frozen add_beziers (points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBeziers"
		end

	frozen is_outline_visible_point_f_pen_graphics (pt: DRAWING_POINT_F; pen: DRAWING_PEN; graphics: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.Pen, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen set_markers is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"SetMarkers"
		end

	frozen add_pie_single (x: REAL; y: REAL; width: REAL; height: REAL; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddPie"
		end

	frozen is_outline_visible_point_f_pen (point: DRAWING_POINT_F; pen: DRAWING_PEN): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.Pen): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_curve (points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen add_pie (rect: DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddPie"
		end

	frozen clear_markers is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"ClearMarkers"
		end

	frozen add_line_int32 (x1: INTEGER; y1: INTEGER; x2: INTEGER; y2: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLine"
		end

	frozen is_visible_single_single_graphics (x: REAL; y: REAL; graphics: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen add_closed_curve_array_point_f_single (points: NATIVE_ARRAY [DRAWING_POINT_F]; tension: REAL) is
		external
			"IL signature (System.Drawing.PointF[], System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddClosedCurve"
		end

	frozen widen_pen_matrix_single (pen: DRAWING_PEN; matrix: DRAWING_MATRIX; flatness: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Drawing2D.Matrix, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Widen"
		end

	frozen add_ellipse (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddEllipse"
		end

	frozen add_bezier_int32 (x1: INTEGER; y1: INTEGER; x2: INTEGER; y2: INTEGER; x3: INTEGER; y3: INTEGER; x4: INTEGER; y4: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBezier"
		end

	frozen warp (dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.PointF[], System.Drawing.RectangleF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Warp"
		end

	frozen add_arc (rect: DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddArc"
		end

	frozen add_polygon_array_point_f (points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddPolygon"
		end

	frozen close_figure is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"CloseFigure"
		end

	frozen add_arc_single (x: REAL; y: REAL; width: REAL; height: REAL; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddArc"
		end

	frozen flatten_matrix (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Flatten"
		end

	frozen is_visible (point: DRAWING_POINT): BOOLEAN is
		external
			"IL signature (System.Drawing.Point): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen add_closed_curve_array_point_single (points: NATIVE_ARRAY [DRAWING_POINT]; tension: REAL) is
		external
			"IL signature (System.Drawing.Point[], System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddClosedCurve"
		end

	frozen add_rectangles_array_rectangle_f (rects: NATIVE_ARRAY [DRAWING_RECTANGLE_F]) is
		external
			"IL signature (System.Drawing.RectangleF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddRectangles"
		end

	frozen add_lines (points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLines"
		end

	frozen add_curve_array_point_f_int32_int32_single (points: NATIVE_ARRAY [DRAWING_POINT_F]; offset: INTEGER; number_of_segments: INTEGER; tension: REAL) is
		external
			"IL signature (System.Drawing.PointF[], System.Int32, System.Int32, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen is_outline_visible_single_single_pen_graphics (x: REAL; y: REAL; pen: DRAWING_PEN; graphics: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Pen, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_ellipse_single (x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddEllipse"
		end

	frozen get_bounds_matrix (matrix: DRAWING_MATRIX): DRAWING_RECTANGLE_F is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Drawing.RectangleF use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"GetBounds"
		end

	frozen add_pie_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddPie"
		end

	frozen add_string_string_font_family_int32_single_point (s: SYSTEM_STRING; family: DRAWING_FONT_FAMILY; style: INTEGER; em_size: REAL; origin: DRAWING_POINT; format: DRAWING_STRING_FORMAT) is
		external
			"IL signature (System.String, System.Drawing.FontFamily, System.Int32, System.Single, System.Drawing.Point, System.Drawing.StringFormat): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddString"
		end

	frozen is_outline_visible (point: DRAWING_POINT; pen: DRAWING_PEN): BOOLEAN is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Pen): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_path (adding_path: DRAWING_GRAPHICS_PATH; connect: BOOLEAN) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath, System.Boolean): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddPath"
		end

	frozen is_visible_int32_int32 (x: INTEGER; y: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen is_visible_point_f (point: DRAWING_POINT_F): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen add_line_point_f (pt1: DRAWING_POINT_F; pt2: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLine"
		end

	frozen add_arc_rectangle_f (rect: DRAWING_RECTANGLE_F; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.RectangleF, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddArc"
		end

	frozen add_curve_array_point_f_single (points: NATIVE_ARRAY [DRAWING_POINT_F]; tension: REAL) is
		external
			"IL signature (System.Drawing.PointF[], System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen reverse is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Reverse"
		end

	frozen is_visible_point_graphics (pt: DRAWING_POINT; graphics: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen add_rectangles (rects: NATIVE_ARRAY [DRAWING_RECTANGLE]) is
		external
			"IL signature (System.Drawing.Rectangle[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddRectangles"
		end

	frozen get_bounds_matrix_pen (matrix: DRAWING_MATRIX; pen: DRAWING_PEN): DRAWING_RECTANGLE_F is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Pen): System.Drawing.RectangleF use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"GetBounds"
		end

	frozen close_all_figures is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"CloseAllFigures"
		end

	frozen widen_pen_matrix (pen: DRAWING_PEN; matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Widen"
		end

	frozen add_string (s: SYSTEM_STRING; family: DRAWING_FONT_FAMILY; style: INTEGER; em_size: REAL; layout_rect: DRAWING_RECTANGLE_F; format: DRAWING_STRING_FORMAT) is
		external
			"IL signature (System.String, System.Drawing.FontFamily, System.Int32, System.Single, System.Drawing.RectangleF, System.Drawing.StringFormat): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddString"
		end

	frozen add_line_single (x1: REAL; y1: REAL; x2: REAL; y2: REAL) is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLine"
		end

	frozen add_beziers_array_point_f (points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBeziers"
		end

	frozen add_rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddRectangle"
		end

	frozen add_ellipse_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddEllipse"
		end

	frozen is_outline_visible_single_single_pen (x: REAL; y: REAL; pen: DRAWING_PEN): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Pen): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_arc_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddArc"
		end

	frozen is_visible_single_single (x: REAL; y: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen is_outline_visible_point_pen_graphics (pt: DRAWING_POINT; pen: DRAWING_PEN; graphics: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Pen, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_line (pt1: DRAWING_POINT; pt2: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Point): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLine"
		end

	frozen widen (pen: DRAWING_PEN) is
		external
			"IL signature (System.Drawing.Pen): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Widen"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Clone"
		end

	frozen add_closed_curve_array_point_f (points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddClosedCurve"
		end

	frozen add_bezier_point_f (pt1: DRAWING_POINT_F; pt2: DRAWING_POINT_F; pt3: DRAWING_POINT_F; pt4: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.PointF, System.Drawing.PointF, System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBezier"
		end

	frozen get_last_point: DRAWING_POINT_F is
		external
			"IL signature (): System.Drawing.PointF use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"GetLastPoint"
		end

	frozen start_figure is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"StartFigure"
		end

	frozen warp_array_point_f_rectangle_f_matrix_warp_mode (dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; matrix: DRAWING_MATRIX; warp_mode: DRAWING_WARP_MODE) is
		external
			"IL signature (System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.WarpMode): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Warp"
		end

	frozen add_closed_curve (points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddClosedCurve"
		end

	frozen add_lines_array_point_f (points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLines"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Reset"
		end

	frozen add_curve_array_point_f (points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen add_ellipse_rectangle_f (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddEllipse"
		end

	frozen get_bounds: DRAWING_RECTANGLE_F is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"GetBounds"
		end

	frozen add_bezier_single (x1: REAL; y1: REAL; x2: REAL; y2: REAL; x3: REAL; y3: REAL; x4: REAL; y4: REAL) is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBezier"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Dispose"
		end

	frozen flatten_matrix_single (matrix: DRAWING_MATRIX; flatness: REAL) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Flatten"
		end

	frozen add_bezier (pt1: DRAWING_POINT; pt2: DRAWING_POINT; pt3: DRAWING_POINT; pt4: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Point, System.Drawing.Point, System.Drawing.Point): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBezier"
		end

	frozen is_outline_visible_int32_int32_pen_graphics (x: INTEGER; y: INTEGER; pen: DRAWING_PEN; graphics: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Pen, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_polygon (points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddPolygon"
		end

	frozen warp_array_point_f_rectangle_f_matrix_warp_mode_single (dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; matrix: DRAWING_MATRIX; warp_mode: DRAWING_WARP_MODE; flatness: REAL) is
		external
			"IL signature (System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.WarpMode, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Warp"
		end

	frozen add_string_string_font_family_int32_single_point_f (s: SYSTEM_STRING; family: DRAWING_FONT_FAMILY; style: INTEGER; em_size: REAL; origin: DRAWING_POINT_F; format: DRAWING_STRING_FORMAT) is
		external
			"IL signature (System.String, System.Drawing.FontFamily, System.Int32, System.Single, System.Drawing.PointF, System.Drawing.StringFormat): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddString"
		end

	frozen add_curve_array_point_int32_int32_single (points: NATIVE_ARRAY [DRAWING_POINT]; offset: INTEGER; number_of_segments: INTEGER; tension: REAL) is
		external
			"IL signature (System.Drawing.Point[], System.Int32, System.Int32, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen is_visible_point_f_graphics (pt: DRAWING_POINT_F; graphics: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Finalize"
		end

end -- class DRAWING_GRAPHICS_PATH
