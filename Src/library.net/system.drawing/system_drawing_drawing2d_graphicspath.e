indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.GraphicsPath"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_graphicspath_2,
	make_graphicspath_3,
	make_graphicspath_4,
	make_graphicspath,
	make_graphicspath_5,
	make_graphicspath_1

feature {NONE} -- Initialization

	frozen make_graphicspath_2 (pts: ARRAY [SYSTEM_DRAWING_POINTF]; types: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Drawing.PointF[], System.Byte[]) use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_graphicspath_3 (pts: ARRAY [SYSTEM_DRAWING_POINTF]; types: ARRAY [INTEGER_8]; fill_mode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL creator signature (System.Drawing.PointF[], System.Byte[], System.Drawing.Drawing2D.FillMode) use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_graphicspath_4 (pts: ARRAY [SYSTEM_DRAWING_POINT]; types: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Drawing.Point[], System.Byte[]) use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_graphicspath is
		external
			"IL creator use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_graphicspath_5 (pts: ARRAY [SYSTEM_DRAWING_POINT]; types: ARRAY [INTEGER_8]; fill_mode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL creator signature (System.Drawing.Point[], System.Byte[], System.Drawing.Drawing2D.FillMode) use System.Drawing.Drawing2D.GraphicsPath"
		end

	frozen make_graphicspath_1 (fill_mode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL creator signature (System.Drawing.Drawing2D.FillMode) use System.Drawing.Drawing2D.GraphicsPath"
		end

feature -- Access

	frozen get_point_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_PointCount"
		end

	frozen get_path_types: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_PathTypes"
		end

	frozen get_path_data: SYSTEM_DRAWING_DRAWING2D_PATHDATA is
		external
			"IL signature (): System.Drawing.Drawing2D.PathData use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_PathData"
		end

	frozen get_path_points: ARRAY [SYSTEM_DRAWING_POINTF] is
		external
			"IL signature (): System.Drawing.PointF[] use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_PathPoints"
		end

	frozen get_fill_mode: SYSTEM_DRAWING_DRAWING2D_FILLMODE is
		external
			"IL signature (): System.Drawing.Drawing2D.FillMode use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"get_FillMode"
		end

feature -- Element Change

	frozen set_fill_mode (value: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"set_FillMode"
		end

feature -- Basic Operations

	frozen warp_array_point_f_rectangle_f_matrix (dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Warp"
		end

	frozen add_curve_array_point_single (points: ARRAY [SYSTEM_DRAWING_POINT]; tension: REAL) is
		external
			"IL signature (System.Drawing.Point[], System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen transform (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Transform"
		end

	frozen is_outline_visible_int32_int32_pen (x: INTEGER; y: INTEGER; pen: SYSTEM_DRAWING_PEN): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Pen): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_rectangle_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddRectangle"
		end

	frozen is_visible_int32_int32_graphics (x: INTEGER; y: INTEGER; graphics: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
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

	frozen add_string_string_font_family_int32_single_rectangle (s: STRING; family: SYSTEM_DRAWING_FONTFAMILY; style: INTEGER; em_size: REAL; layout_rect: SYSTEM_DRAWING_RECTANGLE; format: SYSTEM_DRAWING_STRINGFORMAT) is
		external
			"IL signature (System.String, System.Drawing.FontFamily, System.Int32, System.Single, System.Drawing.Rectangle, System.Drawing.StringFormat): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddString"
		end

	frozen add_beziers (points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBeziers"
		end

	frozen is_outline_visible_point_f_pen_graphics (pt: SYSTEM_DRAWING_POINTF; pen: SYSTEM_DRAWING_PEN; graphics: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
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

	frozen is_outline_visible_point_f_pen (point: SYSTEM_DRAWING_POINTF; pen: SYSTEM_DRAWING_PEN): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.Pen): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_curve (points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen add_pie (rect: SYSTEM_DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
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

	frozen is_visible_single_single_graphics (x: REAL; y: REAL; graphics: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen add_closed_curve_array_point_f_single (points: ARRAY [SYSTEM_DRAWING_POINTF]; tension: REAL) is
		external
			"IL signature (System.Drawing.PointF[], System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddClosedCurve"
		end

	frozen widen_pen_matrix_single (pen: SYSTEM_DRAWING_PEN; matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; flatness: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Drawing2D.Matrix, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Widen"
		end

	frozen add_ellipse (rect: SYSTEM_DRAWING_RECTANGLE) is
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

	frozen warp (dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.PointF[], System.Drawing.RectangleF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Warp"
		end

	frozen add_arc (rect: SYSTEM_DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddArc"
		end

	frozen add_polygon_array_point_f (points: ARRAY [SYSTEM_DRAWING_POINTF]) is
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

	frozen is_visible (point: SYSTEM_DRAWING_POINT): BOOLEAN is
		external
			"IL signature (System.Drawing.Point): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen add_closed_curve_array_point_single (points: ARRAY [SYSTEM_DRAWING_POINT]; tension: REAL) is
		external
			"IL signature (System.Drawing.Point[], System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddClosedCurve"
		end

	frozen add_rectangles_array_rectangle_f (rects: ARRAY [SYSTEM_DRAWING_RECTANGLEF]) is
		external
			"IL signature (System.Drawing.RectangleF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddRectangles"
		end

	frozen add_lines (points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLines"
		end

	frozen add_curve_array_point_f_int32_int32_single (points: ARRAY [SYSTEM_DRAWING_POINTF]; offset: INTEGER; number_of_segments: INTEGER; tension: REAL) is
		external
			"IL signature (System.Drawing.PointF[], System.Int32, System.Int32, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen is_outline_visible_single_single_pen_graphics (x: REAL; y: REAL; pen: SYSTEM_DRAWING_PEN; graphics: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
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

	frozen get_bounds_matrix (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX): SYSTEM_DRAWING_RECTANGLEF is
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

	frozen add_string_string_font_family_int32_single_point (s: STRING; family: SYSTEM_DRAWING_FONTFAMILY; style: INTEGER; em_size: REAL; origin: SYSTEM_DRAWING_POINT; format: SYSTEM_DRAWING_STRINGFORMAT) is
		external
			"IL signature (System.String, System.Drawing.FontFamily, System.Int32, System.Single, System.Drawing.Point, System.Drawing.StringFormat): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddString"
		end

	frozen is_outline_visible (point: SYSTEM_DRAWING_POINT; pen: SYSTEM_DRAWING_PEN): BOOLEAN is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Pen): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_path (adding_path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH; connect: BOOLEAN) is
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

	frozen is_visible_point_f (point: SYSTEM_DRAWING_POINTF): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen add_line_point_f (pt1: SYSTEM_DRAWING_POINTF; pt2: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLine"
		end

	frozen add_arc_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.RectangleF, System.Single, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddArc"
		end

	frozen add_curve_array_point_f_single (points: ARRAY [SYSTEM_DRAWING_POINTF]; tension: REAL) is
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

	frozen is_visible_point_graphics (pt: SYSTEM_DRAWING_POINT; graphics: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsVisible"
		end

	frozen add_rectangles (rects: ARRAY [SYSTEM_DRAWING_RECTANGLE]) is
		external
			"IL signature (System.Drawing.Rectangle[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddRectangles"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Clone"
		end

	frozen get_bounds_matrix_pen (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; pen: SYSTEM_DRAWING_PEN): SYSTEM_DRAWING_RECTANGLEF is
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

	frozen widen_pen_matrix (pen: SYSTEM_DRAWING_PEN; matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Widen"
		end

	frozen add_string (s: STRING; family: SYSTEM_DRAWING_FONTFAMILY; style: INTEGER; em_size: REAL; layout_rect: SYSTEM_DRAWING_RECTANGLEF; format: SYSTEM_DRAWING_STRINGFORMAT) is
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

	frozen add_beziers_array_point_f (points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBeziers"
		end

	frozen add_rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
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

	frozen is_outline_visible_single_single_pen (x: REAL; y: REAL; pen: SYSTEM_DRAWING_PEN): BOOLEAN is
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

	frozen is_outline_visible_point_pen_graphics (pt: SYSTEM_DRAWING_POINT; pen: SYSTEM_DRAWING_PEN; graphics: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Pen, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_line (pt1: SYSTEM_DRAWING_POINT; pt2: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Point): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddLine"
		end

	frozen widen (pen: SYSTEM_DRAWING_PEN) is
		external
			"IL signature (System.Drawing.Pen): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Widen"
		end

	frozen flatten_matrix (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Flatten"
		end

	frozen add_closed_curve_array_point_f (points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddClosedCurve"
		end

	frozen add_bezier_point_f (pt1: SYSTEM_DRAWING_POINTF; pt2: SYSTEM_DRAWING_POINTF; pt3: SYSTEM_DRAWING_POINTF; pt4: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.PointF, System.Drawing.PointF, System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBezier"
		end

	frozen get_last_point: SYSTEM_DRAWING_POINTF is
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

	frozen warp_array_point_f_rectangle_f_matrix_warp_mode (dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; warp_mode: SYSTEM_DRAWING_DRAWING2D_WARPMODE) is
		external
			"IL signature (System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.WarpMode): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Warp"
		end

	frozen add_closed_curve (points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddClosedCurve"
		end

	frozen add_lines_array_point_f (points: ARRAY [SYSTEM_DRAWING_POINTF]) is
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

	frozen add_curve_array_point_f (points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen add_ellipse_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddEllipse"
		end

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLEF is
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

	frozen flatten_matrix_single (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; flatness: REAL) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Flatten"
		end

	frozen add_bezier (pt1: SYSTEM_DRAWING_POINT; pt2: SYSTEM_DRAWING_POINT; pt3: SYSTEM_DRAWING_POINT; pt4: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Point, System.Drawing.Point, System.Drawing.Point): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddBezier"
		end

	frozen is_outline_visible_int32_int32_pen_graphics (x: INTEGER; y: INTEGER; pen: SYSTEM_DRAWING_PEN; graphics: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Pen, System.Drawing.Graphics): System.Boolean use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"IsOutlineVisible"
		end

	frozen add_polygon (points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Point[]): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddPolygon"
		end

	frozen warp_array_point_f_rectangle_f_matrix_warp_mode_single (dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; warp_mode: SYSTEM_DRAWING_DRAWING2D_WARPMODE; flatness: REAL) is
		external
			"IL signature (System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.WarpMode, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"Warp"
		end

	frozen add_string_string_font_family_int32_single_point_f (s: STRING; family: SYSTEM_DRAWING_FONTFAMILY; style: INTEGER; em_size: REAL; origin: SYSTEM_DRAWING_POINTF; format: SYSTEM_DRAWING_STRINGFORMAT) is
		external
			"IL signature (System.String, System.Drawing.FontFamily, System.Int32, System.Single, System.Drawing.PointF, System.Drawing.StringFormat): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddString"
		end

	frozen add_curve_array_point_int32_int32_single (points: ARRAY [SYSTEM_DRAWING_POINT]; offset: INTEGER; number_of_segments: INTEGER; tension: REAL) is
		external
			"IL signature (System.Drawing.Point[], System.Int32, System.Int32, System.Single): System.Void use System.Drawing.Drawing2D.GraphicsPath"
		alias
			"AddCurve"
		end

	frozen is_visible_point_f_graphics (pt: SYSTEM_DRAWING_POINTF; graphics: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
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

end -- class SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH
