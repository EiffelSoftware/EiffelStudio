indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.GraphicsPathIterator"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATHITERATOR

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_IDISPOSABLE

create
	make_graphicspathiterator

feature {NONE} -- Initialization

	frozen make_graphicspathiterator (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
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

	frozen enumerate (points: ARRAY [SYSTEM_DRAWING_POINTF]; types: ARRAY [INTEGER_8]): INTEGER is
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

	frozen copy_data (points: ARRAY [SYSTEM_DRAWING_POINTF]; types: ARRAY [INTEGER_8]; start_index: INTEGER; end_index: INTEGER): INTEGER is
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

	frozen next_subpath (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH; is_closed: BOOLEAN): INTEGER is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath, System.Boolean&): System.Int32 use System.Drawing.Drawing2D.GraphicsPathIterator"
		alias
			"NextSubpath"
		end

	frozen next_marker (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH): INTEGER is
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

end -- class SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATHITERATOR
