indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Region"

frozen external class
	SYSTEM_DRAWING_REGION

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_IDISPOSABLE

create
	make_region_1,
	make_region_2,
	make_region_3,
	make_region,
	make_region_4

feature {NONE} -- Initialization

	frozen make_region_1 (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL creator signature (System.Drawing.RectangleF) use System.Drawing.Region"
		end

	frozen make_region_2 (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Rectangle) use System.Drawing.Region"
		end

	frozen make_region_3 (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath) use System.Drawing.Region"
		end

	frozen make_region is
		external
			"IL creator use System.Drawing.Region"
		end

	frozen make_region_4 (rgn_data: SYSTEM_DRAWING_DRAWING2D_REGIONDATA) is
		external
			"IL creator signature (System.Drawing.Drawing2D.RegionData) use System.Drawing.Region"
		end

feature -- Basic Operations

	frozen intersect_region (region: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Intersect"
		end

	frozen union_rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Union"
		end

	frozen is_visible_single_single_graphics (x: REAL; y: REAL; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
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

	frozen is_visible_point_graphics (point: SYSTEM_DRAWING_POINT; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Point, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_int32_int32_graphics (x: INTEGER; y: INTEGER; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_rectangle_graphics (rect: SYSTEM_DRAWING_RECTANGLE; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen exclude (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Exclude"
		end

	frozen exclude_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Exclude"
		end

	frozen complement_rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Complement"
		end

	frozen is_visible_rectangle_f_graphics (rect: SYSTEM_DRAWING_RECTANGLEF; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_single_single_single_single_graphics (x: REAL; y: REAL; width: REAL; height: REAL; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen equals_region (region: SYSTEM_DRAWING_REGION; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Region, System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"Equals"
		end

	frozen clone: SYSTEM_DRAWING_REGION is
		external
			"IL signature (): System.Drawing.Region use System.Drawing.Region"
		alias
			"Clone"
		end

	frozen translate (dx: INTEGER; dy: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Drawing.Region"
		alias
			"Translate"
		end

	frozen is_empty (g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsEmpty"
		end

	frozen intersect (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
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

	frozen complement (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Complement"
		end

	frozen transform (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Region"
		alias
			"Transform"
		end

	frozen xor__rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Xor"
		end

	frozen is_visible_point_f_graphics (point: SYSTEM_DRAWING_POINTF; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
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

	frozen exclude_rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Exclude"
		end

	frozen is_visible_rectangle (rect: SYSTEM_DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen get_hrgn (g: SYSTEM_DRAWING_GRAPHICS): POINTER is
		external
			"IL signature (System.Drawing.Graphics): System.IntPtr use System.Drawing.Region"
		alias
			"GetHrgn"
		end

	frozen get_bounds (g: SYSTEM_DRAWING_GRAPHICS): SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL signature (System.Drawing.Graphics): System.Drawing.RectangleF use System.Drawing.Region"
		alias
			"GetBounds"
		end

	frozen intersect_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Intersect"
		end

	frozen from_hrgn (hrgn: POINTER): SYSTEM_DRAWING_REGION is
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

	frozen get_region_scans (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX): ARRAY [SYSTEM_DRAWING_RECTANGLEF] is
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

	frozen is_visible (rect: SYSTEM_DRAWING_RECTANGLEF): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen exclude_region (region: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Exclude"
		end

	frozen is_visible_point (point: SYSTEM_DRAWING_POINT): BOOLEAN is
		external
			"IL signature (System.Drawing.Point): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen get_region_data: SYSTEM_DRAWING_DRAWING2D_REGIONDATA is
		external
			"IL signature (): System.Drawing.Drawing2D.RegionData use System.Drawing.Region"
		alias
			"GetRegionData"
		end

	frozen union_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Union"
		end

	frozen xor__rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Xor"
		end

	frozen xor__region (region: SYSTEM_DRAWING_REGION) is
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

	frozen is_infinite (g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
		external
			"IL signature (System.Drawing.Graphics): System.Boolean use System.Drawing.Region"
		alias
			"IsInfinite"
		end

	frozen intersect_rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Region"
		alias
			"Intersect"
		end

	frozen complement_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Region"
		alias
			"Complement"
		end

	frozen Xor_ (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Xor"
		end

	frozen complement_region (region: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Complement"
		end

	frozen union_region (region: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Region"
		alias
			"Union"
		end

	frozen union (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Region"
		alias
			"Union"
		end

	frozen is_visible_point_f (point: SYSTEM_DRAWING_POINTF): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF): System.Boolean use System.Drawing.Region"
		alias
			"IsVisible"
		end

	frozen is_visible_int32_int32_int32_int32_graphics (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; g: SYSTEM_DRAWING_GRAPHICS): BOOLEAN is
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

end -- class SYSTEM_DRAWING_REGION
