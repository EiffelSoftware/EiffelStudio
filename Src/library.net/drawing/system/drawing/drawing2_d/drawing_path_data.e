indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.PathData"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PATH_DATA

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Drawing2D.PathData"
		end

feature -- Access

	frozen get_types: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Drawing.Drawing2D.PathData"
		alias
			"get_Types"
		end

	frozen get_points: NATIVE_ARRAY [DRAWING_POINT_F] is
		external
			"IL signature (): System.Drawing.PointF[] use System.Drawing.Drawing2D.PathData"
		alias
			"get_Points"
		end

feature -- Element Change

	frozen set_points (value: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.PathData"
		alias
			"set_Points"
		end

	frozen set_types (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Drawing.Drawing2D.PathData"
		alias
			"set_Types"
		end

end -- class DRAWING_PATH_DATA
