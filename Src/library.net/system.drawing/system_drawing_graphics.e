indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Graphics"

frozen external class
	SYSTEM_DRAWING_GRAPHICS

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_IDISPOSABLE

create {NONE}

feature -- Access

	frozen get_visible_clip_bounds: SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Graphics"
		alias
			"get_VisibleClipBounds"
		end

	frozen get_page_scale: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Graphics"
		alias
			"get_PageScale"
		end

	frozen get_smoothing_mode: SYSTEM_DRAWING_DRAWING2D_SMOOTHINGMODE is
		external
			"IL signature (): System.Drawing.Drawing2D.SmoothingMode use System.Drawing.Graphics"
		alias
			"get_SmoothingMode"
		end

	frozen get_text_rendering_hint: SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT is
		external
			"IL signature (): System.Drawing.Text.TextRenderingHint use System.Drawing.Graphics"
		alias
			"get_TextRenderingHint"
		end

	frozen get_dpi_y: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Graphics"
		alias
			"get_DpiY"
		end

	frozen get_dpi_x: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Graphics"
		alias
			"get_DpiX"
		end

	frozen get_clip_bounds: SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Graphics"
		alias
			"get_ClipBounds"
		end

	frozen get_transform: SYSTEM_DRAWING_DRAWING2D_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.Graphics"
		alias
			"get_Transform"
		end

	frozen get_pixel_offset_mode: SYSTEM_DRAWING_DRAWING2D_PIXELOFFSETMODE is
		external
			"IL signature (): System.Drawing.Drawing2D.PixelOffsetMode use System.Drawing.Graphics"
		alias
			"get_PixelOffsetMode"
		end

	frozen get_is_clip_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Graphics"
		alias
			"get_IsClipEmpty"
		end

	frozen get_compositing_mode: SYSTEM_DRAWING_DRAWING2D_COMPOSITINGMODE is
		external
			"IL signature (): System.Drawing.Drawing2D.CompositingMode use System.Drawing.Graphics"
		alias
			"get_CompositingMode"
		end

	frozen get_rendering_origin: SYSTEM_DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Drawing.Graphics"
		alias
			"get_RenderingOrigin"
		end

	frozen get_page_unit: SYSTEM_DRAWING_GRAPHICSUNIT is
		external
			"IL signature (): System.Drawing.GraphicsUnit use System.Drawing.Graphics"
		alias
			"get_PageUnit"
		end

	frozen get_compositing_quality: SYSTEM_DRAWING_DRAWING2D_COMPOSITINGQUALITY is
		external
			"IL signature (): System.Drawing.Drawing2D.CompositingQuality use System.Drawing.Graphics"
		alias
			"get_CompositingQuality"
		end

	frozen get_clip: SYSTEM_DRAWING_REGION is
		external
			"IL signature (): System.Drawing.Region use System.Drawing.Graphics"
		alias
			"get_Clip"
		end

	frozen get_interpolation_mode: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL signature (): System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Graphics"
		alias
			"get_InterpolationMode"
		end

	frozen get_text_contrast: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Graphics"
		alias
			"get_TextContrast"
		end

	frozen get_is_visible_clip_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Graphics"
		alias
			"get_IsVisibleClipEmpty"
		end

feature -- Element Change

	frozen set_compositing_quality (value: SYSTEM_DRAWING_DRAWING2D_COMPOSITINGQUALITY) is
		external
			"IL signature (System.Drawing.Drawing2D.CompositingQuality): System.Void use System.Drawing.Graphics"
		alias
			"set_CompositingQuality"
		end

	frozen set_page_unit (value: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"set_PageUnit"
		end

	frozen set_pixel_offset_mode (value: SYSTEM_DRAWING_DRAWING2D_PIXELOFFSETMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.PixelOffsetMode): System.Void use System.Drawing.Graphics"
		alias
			"set_PixelOffsetMode"
		end

	frozen set_text_rendering_hint (value: SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT) is
		external
			"IL signature (System.Drawing.Text.TextRenderingHint): System.Void use System.Drawing.Graphics"
		alias
			"set_TextRenderingHint"
		end

	frozen set_interpolation_mode (value: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.InterpolationMode): System.Void use System.Drawing.Graphics"
		alias
			"set_InterpolationMode"
		end

	frozen set_transform (value: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Graphics"
		alias
			"set_Transform"
		end

	frozen set_page_scale (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Graphics"
		alias
			"set_PageScale"
		end

	frozen set_text_contrast (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"set_TextContrast"
		end

	frozen set_clip_region (value: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Graphics"
		alias
			"set_Clip"
		end

	frozen set_compositing_mode (value: SYSTEM_DRAWING_DRAWING2D_COMPOSITINGMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.CompositingMode): System.Void use System.Drawing.Graphics"
		alias
			"set_CompositingMode"
		end

	frozen set_rendering_origin (value: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"set_RenderingOrigin"
		end

	frozen set_smoothing_mode (value: SYSTEM_DRAWING_DRAWING2D_SMOOTHINGMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.SmoothingMode): System.Void use System.Drawing.Graphics"
		alias
			"set_SmoothingMode"
		end

feature -- Basic Operations

	frozen draw_image_unscaled_image_int32_int32 (image: SYSTEM_DRAWING_IMAGE; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImageUnscaled"
		end

	frozen draw_bezier_pen_point_f (pen: SYSTEM_DRAWING_PEN; pt1: SYSTEM_DRAWING_POINTF; pt2: SYSTEM_DRAWING_POINTF; pt3: SYSTEM_DRAWING_POINTF; pt4: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF, System.Drawing.PointF, System.Drawing.PointF, System.Drawing.PointF): System.Void use System.Drawing.Graphics"
		alias
			"DrawBezier"
		end

	frozen enumerate_metafile_metafile_point_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINT; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen scale_transform (sx: REAL; sy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"ScaleTransform"
		end

	frozen draw_lines_pen_array_point_f (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawLines"
		end

	frozen draw_closed_curve_pen_array_point_f (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawClosedCurve"
		end

	frozen fill_rectangle_brush_rectangle_f (brush: SYSTEM_DRAWING_BRUSH; rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangle"
		end

	frozen draw_image_unscaled_image_int32_int32_int32 (image: SYSTEM_DRAWING_IMAGE; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImageUnscaled"
		end

	frozen draw_image_image_array_point_rectangle_graphics_unit (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_pie_brush_int32 (brush: SYSTEM_DRAWING_BRUSH; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; start_angle: INTEGER; sweep_angle: INTEGER) is
		external
			"IL signature (System.Drawing.Brush, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"FillPie"
		end

	frozen enumerate_metafile_metafile_array_point_f_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_image_rectangle_f (image: SYSTEM_DRAWING_IMAGE; rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_rectangle_single_single_single_single_graphics_unit (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_x: REAL; src_y: REAL; src_width: REAL; src_height: REAL; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Single, System.Single, System.Single, System.Single, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen measure_string_string_font_point_f (text: STRING; font: SYSTEM_DRAWING_FONT; origin: SYSTEM_DRAWING_POINTF; string_format: SYSTEM_DRAWING_STRINGFORMAT): SYSTEM_DRAWING_SIZEF is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.PointF, System.Drawing.StringFormat): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen enumerate_metafile (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen measure_string_string_font_size_f_string_format (text: STRING; font: SYSTEM_DRAWING_FONT; layout_area: SYSTEM_DRAWING_SIZEF; string_format: SYSTEM_DRAWING_STRINGFORMAT): SYSTEM_DRAWING_SIZEF is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.SizeF, System.Drawing.StringFormat): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen get_hdc: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Graphics"
		alias
			"GetHdc"
		end

	frozen enumerate_metafile_metafile_array_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_rectangle_pen_single (pen: SYSTEM_DRAWING_PEN; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangle"
		end

	frozen set_clip_graphics (g: SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Graphics): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen is_visible_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen enumerate_metafile_metafile_rectangle_f_rectangle_f_graphics_unit_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLEF; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen translate_transform (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"TranslateTransform"
		end

	frozen set_clip (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen set_clip_graphics_combine_mode (g: SYSTEM_DRAWING_GRAPHICS; combine_mode: SYSTEM_DRAWING_DRAWING2D_COMBINEMODE) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen measure_string_string_font_int32_string_format (text: STRING; font: SYSTEM_DRAWING_FONT; width: INTEGER; format: SYSTEM_DRAWING_STRINGFORMAT): SYSTEM_DRAWING_SIZEF is
		external
			"IL signature (System.String, System.Drawing.Font, System.Int32, System.Drawing.StringFormat): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen end_container (container: SYSTEM_DRAWING_DRAWING2D_GRAPHICSCONTAINER) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsContainer): System.Void use System.Drawing.Graphics"
		alias
			"EndContainer"
		end

	frozen fill_pie_brush_single (brush: SYSTEM_DRAWING_BRUSH; x: REAL; y: REAL; width: REAL; height: REAL; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillPie"
		end

	frozen measure_string_string_font_size_f_string_format_int32 (text: STRING; font: SYSTEM_DRAWING_FONT; layout_area: SYSTEM_DRAWING_SIZEF; string_format: SYSTEM_DRAWING_STRINGFORMAT; characters_fitted: INTEGER; lines_filled: INTEGER): SYSTEM_DRAWING_SIZEF is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.SizeF, System.Drawing.StringFormat, System.Int32&, System.Int32&): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen release_hdc (hdc: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"ReleaseHdc"
		end

	frozen draw_image_image_array_point_f_rectangle_f_graphics_unit_image_attributes_draw_image_abort (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES; callback: DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_ellipse_brush_int32 (brush: SYSTEM_DRAWING_BRUSH; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Brush, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"FillEllipse"
		end

	frozen draw_image_image_array_point_f_rectangle_f_graphics_unit (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen reset_clip is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"ResetClip"
		end

	frozen draw_image (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_polygon_brush_array_point_fill_mode (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINT]; fill_mode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[], System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"FillPolygon"
		end

	frozen measure_string (text: STRING; font: SYSTEM_DRAWING_FONT): SYSTEM_DRAWING_SIZEF is
		external
			"IL signature (System.String, System.Drawing.Font): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen fill_rectangles (brush: SYSTEM_DRAWING_BRUSH; rects: ARRAY [SYSTEM_DRAWING_RECTANGLE]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Rectangle[]): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangles"
		end

	frozen draw_image_image_point (image: SYSTEM_DRAWING_IMAGE; point: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_array_point_f_rectangle_f_graphics_unit_image_attributes_draw_image_abort_int32 (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES; callback: DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_path (pen: SYSTEM_DRAWING_PEN; path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Graphics"
		alias
			"DrawPath"
		end

	frozen is_visible_point (point: SYSTEM_DRAWING_POINT): BOOLEAN is
		external
			"IL signature (System.Drawing.Point): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_image_image_single_single_rectangle_f (image: SYSTEM_DRAWING_IMAGE; x: REAL; y: REAL; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.Image, System.Single, System.Single, System.Drawing.RectangleF, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_line_pen_int32 (pen: SYSTEM_DRAWING_PEN; x1: INTEGER; y1: INTEGER; x2: INTEGER; y2: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawLine"
		end

	frozen enumerate_metafile_metafile_rectangle_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLE; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_array_point_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; src_rect: SYSTEM_DRAWING_RECTANGLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen rotate_transform (angle: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Graphics"
		alias
			"RotateTransform"
		end

	frozen translate_clip (dx: INTEGER; dy: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"TranslateClip"
		end

	frozen clear (color: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Graphics"
		alias
			"Clear"
		end

	frozen draw_bezier (pen: SYSTEM_DRAWING_PEN; pt1: SYSTEM_DRAWING_POINT; pt2: SYSTEM_DRAWING_POINT; pt3: SYSTEM_DRAWING_POINT; pt4: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point, System.Drawing.Point, System.Drawing.Point, System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"DrawBezier"
		end

	frozen draw_polygon_pen_array_point_f (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawPolygon"
		end

	frozen intersect_clip_rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"IntersectClip"
		end

	frozen restore (gstate: SYSTEM_DRAWING_DRAWING2D_GRAPHICSSTATE) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsState): System.Void use System.Drawing.Graphics"
		alias
			"Restore"
		end

	frozen draw_lines (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawLines"
		end

	frozen enumerate_metafile_metafile_point_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_array_point_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen from_hdc_int_ptr_int_ptr (hdc: POINTER; hdevice: POINTER): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHdc"
		end

	frozen draw_image_image_int32_int32_int32_int32 (image: SYSTEM_DRAWING_IMAGE; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_rectangle_f_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLEF; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_arc_pen_int32 (pen: SYSTEM_DRAWING_PEN; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; start_angle: INTEGER; sweep_angle: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawArc"
		end

	frozen multiply_transform_matrix_matrix_order (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Graphics"
		alias
			"MultiplyTransform"
		end

	frozen draw_pie_pen_rectangle_f (pen: SYSTEM_DRAWING_PEN; rect: SYSTEM_DRAWING_RECTANGLEF; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.RectangleF, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawPie"
		end

	frozen enumerate_metafile_metafile_rectangle_rectangle_graphics_unit_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_point_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_image_rectangle_f_rectangle_f_graphics_unit (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLEF; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_array_point_rectangle_graphics_unit_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen set_clip_region_combine_mode (region: SYSTEM_DRAWING_REGION; combine_mode: SYSTEM_DRAWING_DRAWING2D_COMBINEMODE) is
		external
			"IL signature (System.Drawing.Region, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen enumerate_metafile_metafile_point_f_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINTF; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen fill_region (brush: SYSTEM_DRAWING_BRUSH; region: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Region): System.Void use System.Drawing.Graphics"
		alias
			"FillRegion"
		end

	frozen begin_container_rectangle_f (dstrect: SYSTEM_DRAWING_RECTANGLEF; srcrect: SYSTEM_DRAWING_RECTANGLEF; unit: SYSTEM_DRAWING_GRAPHICSUNIT): SYSTEM_DRAWING_DRAWING2D_GRAPHICSCONTAINER is
		external
			"IL signature (System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit): System.Drawing.Drawing2D.GraphicsContainer use System.Drawing.Graphics"
		alias
			"BeginContainer"
		end

	frozen enumerate_metafile_metafile_array_point_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Graphics"
		alias
			"ScaleTransform"
		end

	frozen draw_closed_curve_pen_array_point_single_fill_mode (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINT]; tension: REAL; fillmode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[], System.Single, System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"DrawClosedCurve"
		end

	frozen enumerate_metafile_metafile_rectangle_f_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLEF; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen is_visible_single_single (x: REAL; y: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_image_image_point_f (image: SYSTEM_DRAWING_IMAGE; point: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen measure_string_string_font_size_f (text: STRING; font: SYSTEM_DRAWING_FONT; layout_area: SYSTEM_DRAWING_SIZEF): SYSTEM_DRAWING_SIZEF is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.SizeF): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen fill_closed_curve_brush_array_point_f (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen draw_closed_curve (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawClosedCurve"
		end

	frozen draw_string_string_font_brush_rectangle_f_string_format (s: STRING; font: SYSTEM_DRAWING_FONT; brush: SYSTEM_DRAWING_BRUSH; layout_rectangle: SYSTEM_DRAWING_RECTANGLEF; format: SYSTEM_DRAWING_STRINGFORMAT) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Drawing.RectangleF, System.Drawing.StringFormat): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen draw_ellipse_pen_single (pen: SYSTEM_DRAWING_PEN; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawEllipse"
		end

	frozen add_metafile_comment (data: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Drawing.Graphics"
		alias
			"AddMetafileComment"
		end

	frozen fill_ellipse_brush_single (brush: SYSTEM_DRAWING_BRUSH; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillEllipse"
		end

	frozen from_hdc_internal (hdc: POINTER): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHdcInternal"
		end

	frozen from_hwnd_internal (hwnd: POINTER): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHwndInternal"
		end

	frozen enumerate_metafile_metafile_rectangle_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLEF; src_rect: SYSTEM_DRAWING_RECTANGLEF; unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_pie_pen_single (pen: SYSTEM_DRAWING_PEN; x: REAL; y: REAL; width: REAL; height: REAL; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawPie"
		end

	frozen is_visible_rectangle (rect: SYSTEM_DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_icon_icon_int32 (icon: SYSTEM_DRAWING_ICON; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Drawing.Icon, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawIcon"
		end

	frozen draw_line_pen_single (pen: SYSTEM_DRAWING_PEN; x1: REAL; y1: REAL; x2: REAL; y2: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawLine"
		end

	frozen draw_image_image_array_point_f_rectangle_f_graphics_unit_image_attributes (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_curve_pen_array_point_f (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen draw_curve_pen_array_point_single (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINT]; tension: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[], System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen exclude_clip_rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"ExcludeClip"
		end

	frozen draw_ellipse (pen: SYSTEM_DRAWING_PEN; rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawEllipse"
		end

	frozen draw_image_image_array_point (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_array_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_beziers_pen_array_point_f (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawBeziers"
		end

	frozen draw_pie_pen_int32 (pen: SYSTEM_DRAWING_PEN; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; start_angle: INTEGER; sweep_angle: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawPie"
		end

	frozen enumerate_metafile_metafile_array_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; src_rect: SYSTEM_DRAWING_RECTANGLEF; unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_image_rectangle_single_single_single_single_graphics_unit_image_attributes_draw_image_abort (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_x: REAL; src_y: REAL; src_width: REAL; src_height: REAL; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attrs: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES; callback: DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Single, System.Single, System.Single, System.Single, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_rectangle_single_single_single_single_graphics_unit_image_attributes_draw_image_abort_int_ptr (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_x: REAL; src_y: REAL; src_width: REAL; src_height: REAL; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attrs: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES; callback: DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Single, System.Single, System.Single, System.Single, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_point_rectangle_graphics_unit_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINT; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Graphics"
		alias
			"TranslateTransform"
		end

	frozen intersect_clip (region: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Graphics"
		alias
			"IntersectClip"
		end

	frozen fill_rectangle (brush: SYSTEM_DRAWING_BRUSH; rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangle"
		end

	frozen exclude_clip (region: SYSTEM_DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Graphics"
		alias
			"ExcludeClip"
		end

	frozen enumerate_metafile_metafile_point_f_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINTF; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen fill_ellipse_brush_rectangle_f (brush: SYSTEM_DRAWING_BRUSH; rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"FillEllipse"
		end

	frozen draw_ellipse_pen_rectangle_f (pen: SYSTEM_DRAWING_PEN; rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"DrawEllipse"
		end

	frozen draw_image_unscaled (image: SYSTEM_DRAWING_IMAGE; rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawImageUnscaled"
		end

	frozen begin_container_rectangle (dstrect: SYSTEM_DRAWING_RECTANGLE; srcrect: SYSTEM_DRAWING_RECTANGLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT): SYSTEM_DRAWING_DRAWING2D_GRAPHICSCONTAINER is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit): System.Drawing.Drawing2D.GraphicsContainer use System.Drawing.Graphics"
		alias
			"BeginContainer"
		end

	frozen is_visible_int32_int32_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_arc_pen_single (pen: SYSTEM_DRAWING_PEN; x: REAL; y: REAL; width: REAL; height: REAL; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawArc"
		end

	frozen draw_image_image_int32_int32_rectangle (image: SYSTEM_DRAWING_IMAGE; x: INTEGER; y: INTEGER; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32, System.Drawing.Rectangle, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_string_string_font_brush_single_single (s: STRING; font: SYSTEM_DRAWING_FONT; brush: SYSTEM_DRAWING_BRUSH; x: REAL; y: REAL) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen draw_image_image_int32_int32 (image: SYSTEM_DRAWING_IMAGE; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"Dispose"
		end

	frozen fill_closed_curve_brush_array_point_fill_mode_single (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINT]; fillmode: SYSTEM_DRAWING_DRAWING2D_FILLMODE; tension: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[], System.Drawing.Drawing2D.FillMode, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen release_hdc_internal (hdc: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"ReleaseHdcInternal"
		end

	frozen enumerate_metafile_metafile_rectangle_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLE; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINTF; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen get_halftone_palette: POINTER is
		external
			"IL static signature (): System.IntPtr use System.Drawing.Graphics"
		alias
			"GetHalftonePalette"
		end

	frozen draw_curve_pen_array_point_f_int32_int32_single (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]; offset: INTEGER; number_of_segments: INTEGER; tension: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[], System.Int32, System.Int32, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen fill_ellipse (brush: SYSTEM_DRAWING_BRUSH; rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"FillEllipse"
		end

	frozen from_image (image: SYSTEM_DRAWING_IMAGE): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL static signature (System.Drawing.Image): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromImage"
		end

	frozen draw_image_image_rectangle_int32_int32_int32_int32_graphics_unit_image_attributes (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_x: INTEGER; src_y: INTEGER; src_width: INTEGER; src_height: INTEGER; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_arc (pen: SYSTEM_DRAWING_PEN; rect: SYSTEM_DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawArc"
		end

	frozen draw_line (pen: SYSTEM_DRAWING_PEN; pt1: SYSTEM_DRAWING_POINT; pt2: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point, System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"DrawLine"
		end

	frozen draw_image_image_rectangle_int32_int32_int32_int32_graphics_unit_image_attributes_draw_image_abort (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_x: INTEGER; src_y: INTEGER; src_width: INTEGER; src_height: INTEGER; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES; callback: DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_rectangle (pen: SYSTEM_DRAWING_PEN; rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangle"
		end

	frozen draw_image_image_single_single (image: SYSTEM_DRAWING_IMAGE; x: REAL; y: REAL) is
		external
			"IL signature (System.Drawing.Image, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_array_point_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen measure_string_string_font_int32 (text: STRING; font: SYSTEM_DRAWING_FONT; width: INTEGER): SYSTEM_DRAWING_SIZEF is
		external
			"IL signature (System.String, System.Drawing.Font, System.Int32): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen draw_image_image_array_point_rectangle_graphics_unit_image_attributes_draw_image_abort (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES; callback: DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINTF; src_rect: SYSTEM_DRAWING_RECTANGLEF; unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_curve_pen_array_point_f_single (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]; tension: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[], System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen fill_polygon_brush_array_point_f_fill_mode (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINTF]; fill_mode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[], System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"FillPolygon"
		end

	frozen draw_image_image_single_single_single_single (image: SYSTEM_DRAWING_IMAGE; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Image, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_rectangles (pen: SYSTEM_DRAWING_PEN; rects: ARRAY [SYSTEM_DRAWING_RECTANGLE]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangles"
		end

	frozen is_visible_int32_int32 (x: INTEGER; y: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_curve (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen fill_closed_curve_brush_array_point_f_fill_mode (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINTF]; fillmode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[], System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen enumerate_metafile_metafile_rectangle_f_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLEF; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_point_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINT; src_rect: SYSTEM_DRAWING_RECTANGLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen from_hdc (hdc: POINTER): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHdc"
		end

	frozen measure_character_ranges (text: STRING; font: SYSTEM_DRAWING_FONT; layout_rect: SYSTEM_DRAWING_RECTANGLEF; string_format: SYSTEM_DRAWING_STRINGFORMAT): ARRAY [SYSTEM_DRAWING_REGION] is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.RectangleF, System.Drawing.StringFormat): System.Drawing.Region[] use System.Drawing.Graphics"
		alias
			"MeasureCharacterRanges"
		end

	frozen draw_line_pen_point_f (pen: SYSTEM_DRAWING_PEN; pt1: SYSTEM_DRAWING_POINTF; pt2: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF, System.Drawing.PointF): System.Void use System.Drawing.Graphics"
		alias
			"DrawLine"
		end

	frozen draw_string_string_font_brush_single_single_string_format (s: STRING; font: SYSTEM_DRAWING_FONT; brush: SYSTEM_DRAWING_BRUSH; x: REAL; y: REAL; format: SYSTEM_DRAWING_STRINGFORMAT) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Single, System.Single, System.Drawing.StringFormat): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen enumerate_metafile_metafile_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINTF; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_image_array_point_rectangle_graphics_unit_image_attributes_draw_image_abort_int32 (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES; callback: DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen multiply_transform (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Graphics"
		alias
			"MultiplyTransform"
		end

	frozen translate_clip_single (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"TranslateClip"
		end

	frozen draw_image_image_rectangle (image: SYSTEM_DRAWING_IMAGE; rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_path (brush: SYSTEM_DRAWING_BRUSH; path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Graphics"
		alias
			"FillPath"
		end

	frozen fill_pie (brush: SYSTEM_DRAWING_BRUSH; rect: SYSTEM_DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillPie"
		end

	frozen draw_icon (icon: SYSTEM_DRAWING_ICON; target_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Icon, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawIcon"
		end

	frozen fill_closed_curve_brush_array_point_fill_mode (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINT]; fillmode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[], System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen draw_string (s: STRING; font: SYSTEM_DRAWING_FONT; brush: SYSTEM_DRAWING_BRUSH; point: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Drawing.PointF): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen draw_curve_pen_array_point_f_int32_int32 (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]; offset: INTEGER; number_of_segments: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[], System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen draw_icon_unstretched (icon: SYSTEM_DRAWING_ICON; target_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Icon, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawIconUnstretched"
		end

	frozen draw_string_string_font_brush_point_f_string_format (s: STRING; font: SYSTEM_DRAWING_FONT; brush: SYSTEM_DRAWING_BRUSH; point: SYSTEM_DRAWING_POINTF; format: SYSTEM_DRAWING_STRINGFORMAT) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Drawing.PointF, System.Drawing.StringFormat): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen enumerate_metafile_metafile_rectangle_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLEF; src_rect: SYSTEM_DRAWING_RECTANGLEF; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen set_clip_graphics_path_combine_mode (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH; combine_mode: SYSTEM_DRAWING_DRAWING2D_COMBINEMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen set_clip_rectangle_f_combine_mode (rect: SYSTEM_DRAWING_RECTANGLEF; combine_mode: SYSTEM_DRAWING_DRAWING2D_COMBINEMODE) is
		external
			"IL signature (System.Drawing.RectangleF, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen is_visible (point: SYSTEM_DRAWING_POINTF): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_curve_pen_array_point_int32_int32_single (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINT]; offset: INTEGER; number_of_segments: INTEGER; tension: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[], System.Int32, System.Int32, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen rotate_transform_single_matrix_order (angle: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Graphics"
		alias
			"RotateTransform"
		end

	frozen get_nearest_color (color: SYSTEM_DRAWING_COLOR): SYSTEM_DRAWING_COLOR is
		external
			"IL signature (System.Drawing.Color): System.Drawing.Color use System.Drawing.Graphics"
		alias
			"GetNearestColor"
		end

	frozen draw_bezier_pen_single (pen: SYSTEM_DRAWING_PEN; x1: REAL; y1: REAL; x2: REAL; y2: REAL; x3: REAL; y3: REAL; x4: REAL; y4: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawBezier"
		end

	frozen is_visible_single_single_single (x: REAL; y: REAL; width: REAL; height: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen set_clip_graphics_path (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen draw_rectangle_pen_int32 (pen: SYSTEM_DRAWING_PEN; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangle"
		end

	frozen enumerate_metafile_metafile_array_point_f_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen fill_closed_curve_brush_array_point_f_fill_mode_single (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINTF]; fillmode: SYSTEM_DRAWING_DRAWING2D_FILLMODE; tension: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[], System.Drawing.Drawing2D.FillMode, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen draw_string_string_font_brush_rectangle_f (s: STRING; font: SYSTEM_DRAWING_FONT; brush: SYSTEM_DRAWING_BRUSH; layout_rectangle: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen draw_ellipse_pen_int32 (pen: SYSTEM_DRAWING_PEN; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawEllipse"
		end

	frozen begin_container: SYSTEM_DRAWING_DRAWING2D_GRAPHICSCONTAINER is
		external
			"IL signature (): System.Drawing.Drawing2D.GraphicsContainer use System.Drawing.Graphics"
		alias
			"BeginContainer"
		end

	frozen fill_polygon_brush_array_point_f (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"FillPolygon"
		end

	frozen fill_rectangle_brush_single (brush: SYSTEM_DRAWING_BRUSH; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangle"
		end

	frozen set_clip_rectangle (rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen fill_closed_curve (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen flush is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"Flush"
		end

	frozen draw_image_unscaled_image_point (image: SYSTEM_DRAWING_IMAGE; point: SYSTEM_DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"DrawImageUnscaled"
		end

	frozen enumerate_metafile_metafile_rectangle_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_rect: SYSTEM_DRAWING_RECTANGLE; unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen from_hwnd (hwnd: POINTER): SYSTEM_DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHwnd"
		end

	frozen transform_points_coordinate_space_coordinate_space_array_point_f (dest_space: SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE; src_space: SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE; pts: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.Drawing2D.CoordinateSpace, System.Drawing.Drawing2D.CoordinateSpace, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"TransformPoints"
		end

	frozen draw_image_image_rectangle_int32_int32_int32_int32_graphics_unit_image_attributes_draw_image_abort_int_ptr (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_x: INTEGER; src_y: INTEGER; src_width: INTEGER; src_height: INTEGER; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attrs: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES; callback: DRAWIMAGEABORT_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_array_point_rectangle_graphics_unit_image_attributes (image: SYSTEM_DRAWING_IMAGE; dest_points: ARRAY [SYSTEM_DRAWING_POINT]; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_polygon (brush: SYSTEM_DRAWING_BRUSH; points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"FillPolygon"
		end

	frozen enumerate_metafile_metafile_rectangle_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen fill_rectangles_brush_array_rectangle_f (brush: SYSTEM_DRAWING_BRUSH; rects: ARRAY [SYSTEM_DRAWING_RECTANGLEF]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.RectangleF[]): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangles"
		end

	frozen draw_image_image_rectangle_int32_int32_int32_int32_graphics_unit (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_x: INTEGER; src_y: INTEGER; src_width: INTEGER; src_height: INTEGER; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_rectangle_rectangle_graphics_unit (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_rect: SYSTEM_DRAWING_RECTANGLE; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen intersect_clip_rectangle_f (rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"IntersectClip"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"ResetTransform"
		end

	frozen flush_flush_intention (intention: SYSTEM_DRAWING_DRAWING2D_FLUSHINTENTION) is
		external
			"IL signature (System.Drawing.Drawing2D.FlushIntention): System.Void use System.Drawing.Graphics"
		alias
			"Flush"
		end

	frozen set_clip_rectangle_combine_mode (rect: SYSTEM_DRAWING_RECTANGLE; combine_mode: SYSTEM_DRAWING_DRAWING2D_COMBINEMODE) is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen draw_rectangles_pen_array_rectangle_f (pen: SYSTEM_DRAWING_PEN; rects: ARRAY [SYSTEM_DRAWING_RECTANGLEF]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.RectangleF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangles"
		end

	frozen save: SYSTEM_DRAWING_DRAWING2D_GRAPHICSSTATE is
		external
			"IL signature (): System.Drawing.Drawing2D.GraphicsState use System.Drawing.Graphics"
		alias
			"Save"
		end

	frozen draw_arc_pen_rectangle_f (pen: SYSTEM_DRAWING_PEN; rect: SYSTEM_DRAWING_RECTANGLEF; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.RectangleF, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawArc"
		end

	frozen draw_image_image_rectangle_single_single_single_single_graphics_unit_image_attributes (image: SYSTEM_DRAWING_IMAGE; dest_rect: SYSTEM_DRAWING_RECTANGLE; src_x: REAL; src_y: REAL; src_width: REAL; src_height: REAL; src_unit: SYSTEM_DRAWING_GRAPHICSUNIT; image_attrs: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Single, System.Single, System.Single, System.Single, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_point_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINT; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_polygon (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawPolygon"
		end

	frozen transform_points (dest_space: SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE; src_space: SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE; pts: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Drawing2D.CoordinateSpace, System.Drawing.Drawing2D.CoordinateSpace, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"TransformPoints"
		end

	frozen fill_rectangle_brush_int32 (brush: SYSTEM_DRAWING_BRUSH; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Brush, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangle"
		end

	frozen draw_beziers (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawBeziers"
		end

	frozen enumerate_metafile_metafile_rectangle_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_rect: SYSTEM_DRAWING_RECTANGLE; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_point_f_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_point: SYSTEM_DRAWING_POINTF; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_pie (pen: SYSTEM_DRAWING_PEN; rect: SYSTEM_DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawPie"
		end

	frozen enumerate_metafile_metafile_array_point_f_enumerate_metafile_proc (metafile: SYSTEM_DRAWING_IMAGING_METAFILE; dest_points: ARRAY [SYSTEM_DRAWING_POINTF]; callback: ENUMERATEMETAFILEPROC_IN_SYSTEM_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_closed_curve_pen_array_point_f_single_fill_mode (pen: SYSTEM_DRAWING_PEN; points: ARRAY [SYSTEM_DRAWING_POINTF]; tension: REAL; fillmode: SYSTEM_DRAWING_DRAWING2D_FILLMODE) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[], System.Single, System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"DrawClosedCurve"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"Finalize"
		end

end -- class SYSTEM_DRAWING_GRAPHICS
