indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.HatchBrush"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_HATCHBRUSH

inherit
	SYSTEM_DRAWING_BRUSH
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_hatchbrush,
	make_hatchbrush_1

feature {NONE} -- Initialization

	frozen make_hatchbrush (hatchstyle: SYSTEM_DRAWING_DRAWING2D_HATCHSTYLE; fore_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Drawing2D.HatchStyle, System.Drawing.Color) use System.Drawing.Drawing2D.HatchBrush"
		end

	frozen make_hatchbrush_1 (hatchstyle: SYSTEM_DRAWING_DRAWING2D_HATCHSTYLE; fore_color: SYSTEM_DRAWING_COLOR; back_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Drawing2D.HatchStyle, System.Drawing.Color, System.Drawing.Color) use System.Drawing.Drawing2D.HatchBrush"
		end

feature -- Access

	frozen get_background_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Drawing2D.HatchBrush"
		alias
			"get_BackgroundColor"
		end

	frozen get_foreground_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Drawing2D.HatchBrush"
		alias
			"get_ForegroundColor"
		end

	frozen get_hatch_style: SYSTEM_DRAWING_DRAWING2D_HATCHSTYLE is
		external
			"IL signature (): System.Drawing.Drawing2D.HatchStyle use System.Drawing.Drawing2D.HatchBrush"
		alias
			"get_HatchStyle"
		end

feature -- Basic Operations

	clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.HatchBrush"
		alias
			"Clone"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_HATCHBRUSH
