indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.PathData"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_PATHDATA

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Drawing2D.PathData"
		end

feature -- Access

	frozen get_types: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Drawing.Drawing2D.PathData"
		alias
			"get_Types"
		end

	frozen get_points: ARRAY [SYSTEM_DRAWING_POINTF] is
		external
			"IL signature (): System.Drawing.PointF[] use System.Drawing.Drawing2D.PathData"
		alias
			"get_Points"
		end

feature -- Element Change

	frozen set_points (value: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL signature (System.Drawing.PointF[]): System.Void use System.Drawing.Drawing2D.PathData"
		alias
			"set_Points"
		end

	frozen set_types (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Drawing.Drawing2D.PathData"
		alias
			"set_Types"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_PATHDATA
