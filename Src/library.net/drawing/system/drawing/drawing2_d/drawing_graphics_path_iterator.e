indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.GraphicsPathIterator"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_GRAPHICS_PATH_ITERATOR

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	IDISPOSABLE

create
	make_drawing_graphics_path_iterator

feature {NONE} -- Initialization

	frozen make_drawing_graphics_path_iterator (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath) use System.Drawing.Drawing2D.GraphicsPathIterator"
		end

feature -- Access

	frozen get_subpath_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"get_SubpathCount"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"get_Count"
		end

feature -- Basic Operations

	frozen enumerate (points: NATIVE_ARRAY [DRAWING_POINT_F]; types: NATIVE_ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.Drawing.PointF[]&, System.Byte[]&): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"Enumerate"
		end

	frozen next_subpath_int32 (start_index: INTEGER; end_index: INTEGER; is_closed: BOOLEAN): INTEGER is
		external
			"IL signature (System.Int32&, System.Int32&, System.Boolean&): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"NextSubpath"
		end

	frozen copy_data (points: NATIVE_ARRAY [DRAWING_POINT_F]; types: NATIVE_ARRAY [INTEGER_8]; start_index: INTEGER; end_index: INTEGER): INTEGER is
		external
			"IL signature (System.Drawing.PointF[]&, System.Byte[]&, System.Int32, System.Int32): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"CopyData"
		end

	frozen next_path_type (path_type: INTEGER_8; start_index: INTEGER; end_index: INTEGER): INTEGER is
		external
			"IL signature (System.Byte&, System.Int32&, System.Int32&): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"NextPathType"
		end

	frozen has_curve: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"HasCurve"
		end

	frozen next_subpath (path: DRAWING_GRAPHICS_PATH; is_closed: BOOLEAN): INTEGER is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath, System.Boolean&): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"NextSubpath"
		end

	frozen next_marker (path: DRAWING_GRAPHICS_PATH): INTEGER is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"NextMarker"
		end

	frozen rewind is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"Rewind"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"Dispose"
		end

	frozen next_marker_int32 (start_index: INTEGER; end_index: INTEGER): INTEGER is
		external
			"IL signature (System.Int32&, System.Int32&): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"NextMarker"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"Finalize"
		end

end -- class DRAWING_GRAPHICS_PATH_ITERATOR
