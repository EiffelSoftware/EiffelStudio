indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.HatchBrush"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_HATCH_BRUSH

inherit
	DRAWING_BRUSH
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_hatch_brush,
	make_drawing_hatch_brush_1

feature {NONE} -- Initialization

	frozen make_drawing_hatch_brush (hatchstyle: DRAWING_HATCH_STYLE; fore_color: DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Drawing2D.HatchStyle, System.Drawing.Color) use System.Drawing.Drawing2D.HatchBrush"
		end

	frozen make_drawing_hatch_brush_1 (hatchstyle: DRAWING_HATCH_STYLE; fore_color: DRAWING_COLOR; back_color: DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Drawing2D.HatchStyle, System.Drawing.Color, System.Drawing.Color) use System.Drawing.Drawing2D.HatchBrush"
		end

feature -- Access

	frozen get_background_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Drawing2D.HatchBrush"
		alias
			"get_BackgroundColor"
		end

	frozen get_foreground_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Drawing2D.HatchBrush"
		alias
			"get_ForegroundColor"
		end

	frozen get_hatch_style: DRAWING_HATCH_STYLE is
		external
			"IL signature (): System.Drawing.Drawing2D.HatchStyle use System.Drawing.Drawing2D.HatchBrush"
		alias
			"get_HatchStyle"
		end

feature -- Basic Operations

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.HatchBrush"
		alias
			"Clone"
		end

end -- class DRAWING_HATCH_BRUSH
