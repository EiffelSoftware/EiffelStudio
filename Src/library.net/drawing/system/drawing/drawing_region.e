indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Region"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_REGION

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	IDISPOSABLE

create
	make_drawing_region_2,
	make_drawing_region_1,
	make_drawing_region,
	make_drawing_region_4,
	make_drawing_region_3

feature {NONE} -- Initialization

	frozen make_drawing_region_2 (rect: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Rectangle) use System.Drawing.Region"
		end

	frozen make_drawing_region_1 (rect: DRAWING_RECTANGLE_F) is
		external
			"IL creator signature (System.Drawing.RectangleF) use System.Drawing.Region"
		end

	frozen make_drawing_region is
		external
			"IL creator use System.Drawing.Region"
		end

	frozen make_drawing_region_4 (rgn_data: DRAWING_REGION_DATA) is
		external
			"IL creator signature (System.Drawing.Drawing2D.RegionData) use System.Drawing.Region"
		end

	frozen make_drawing_region_3 (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath) use System.Drawing.Region"
		end

feature -- Basic Operations

	frozen intersect_region (region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Intersect"
		end

	frozen xor_ (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Xor"
		end

	frozen union_rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Union"
		end

	frozen is_visible_single_single_graphics (x: REAL; y: REAL; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Region"
		alias
			"Dispose"
		end

	frozen is_visible_point_graphics (point: DRAWING_POINT; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_int32_int32_graphics (x: INTEGER; y: INTEGER; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_rectangle_graphics (rect: DRAWING_RECTANGLE; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen exclude (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Exclude"
		end

	frozen exclude_rectangle_f (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Exclude"
		end

	frozen complement_rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Complement"
		end

	frozen is_visible_rectangle_f_graphics (rect: DRAWING_RECTANGLE_F; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_single_single_single_single_graphics (x: REAL; y: REAL; width: REAL; height: REAL; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen equals_region (region: DRAWING_REGION; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Region, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"Equals"
		end

	frozen translate (dx: INTEGER; dy: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Drawing.Region"
		alias
			"Translate"
		end

	frozen is_empty (g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsEmpty"
		end

	frozen intersect (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Intersect"
		end

	frozen is_visible_single_single_single_single (x: REAL; y: REAL; width: REAL; height: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen complement (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Complement"
		end

	frozen transform (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Region"
		alias
			"Transform"
		end

	frozen xor__rectangle_f (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Xor"
		end

	frozen is_visible_point_f_graphics (point: DRAWING_POINT_F; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_int32_int32_int32_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen exclude_rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Exclude"
		end

	frozen is_visible_rectangle (rect: DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen get_hrgn (g: DRAWING_GRAPHICS): POINTER is
		external
			"IL signature (System.Drawing.Graphics): System.IntPtr use System.Drawing.Region"
		alias
			"GetHrgn"
		end

	frozen get_bounds (g: DRAWING_GRAPHICS): DRAWING_RECTANGLE_F is
		external
			"IL signature (System.Drawing.Graphics): System.Drawing.RectangleF use System.Drawing.Region"
		alias
			"GetBounds"
		end

	frozen intersect_rectangle_f (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Intersect"
		end

	frozen from_hrgn (hrgn: POINTER): DRAWING_REGION is
		external
			"IL static signature (System.IntPtr): System.Drawing.Region use System.Drawing.Region"
		alias
			"FromHrgn"
		end

	frozen translate_single (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Region"
		alias
			"Translate"
		end

	frozen get_region_scans (matrix: DRAWING_MATRIX): NATIVE_ARRAY [DRAWING_RECTANGLE_F] is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Drawing.RectangleF[] use System.Drawing.Region"
		alias
			"GetRegionScans"
		end

	frozen make_empty is
		external
			"IL signature (): System.Void use System.Drawing.Region"
		alias
			"MakeEmpty"
		end

	frozen is_visible (rect: DRAWING_RECTANGLE_F): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen exclude_region (region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Exclude"
		end

	frozen is_visible_point (point: DRAWING_POINT): BOOLEAN is
		external
			"IL signature (System.Drawing.Point): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen get_region_data: DRAWING_REGION_DATA is
		external
			"IL signature (): System.Drawing.Drawing2D.RegionData use System.Drawing.Region"
		alias
			"GetRegionData"
		end

	frozen union_rectangle_f (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Union"
		end

	frozen xor__rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Xor"
		end

	frozen xor__region (region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Xor"
		end

	frozen make_infinite is
		external
			"IL signature (): System.Void use System.Drawing.Region"
		alias
			"MakeInfinite"
		end

	frozen is_visible_single_single (x: REAL; y: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen clone_: DRAWING_REGION is
		external
			"IL signature (): System.Drawing.Region use System.Drawing.Region"
		alias
			"Clone"
		end

	frozen is_infinite (g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsInfinite"
		end

	frozen intersect_rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Intersect"
		end

	frozen complement_rectangle_f (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Complement"
		end

	frozen complement_region (region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Complement"
		end

	frozen union_region (region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Union"
		end

	frozen union (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Union"
		end

	frozen is_visible_point_f (point: DRAWING_POINT_F): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_int32_int32_int32_int32_graphics (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; g: DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Region"
		alias
			"Finalize"
		end

end -- class DRAWING_REGION
