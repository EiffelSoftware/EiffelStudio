indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.AdjustableArrowCap"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_ADJUSTABLE_ARROW_CAP

inherit
	DRAWING_CUSTOM_LINE_CAP
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_adjustable_arrow_cap,
	make_drawing_adjustable_arrow_cap_1

feature {NONE} -- Initialization

	frozen make_drawing_adjustable_arrow_cap (width: REAL; height: REAL) is
		external
			"IL creator signature (System.Single, System.Single) use System.Drawing.Drawing2D.AdjustableArrowCap"
		end

	frozen make_drawing_adjustable_arrow_cap_1 (width: REAL; height: REAL; is_filled: BOOLEAN) is
		external
			"IL creator signature (System.Single, System.Single, System.Boolean) use System.Drawing.Drawing2D.AdjustableArrowCap"
		end

feature -- Access

	frozen get_height: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Drawing2D.AdjustableArrowCap"
		alias
			"get_Height"
		end

	frozen get_filled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Drawing2D.AdjustableArrowCap"
		alias
			"get_Filled"
		end

	frozen get_middle_inset: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Drawing2D.AdjustableArrowCap"
		alias
			"get_MiddleInset"
		end

	frozen get_width: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Drawing2D.AdjustableArrowCap"
		alias
			"get_Width"
		end

feature -- Element Change

	frozen set_height (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.AdjustableArrowCap"
		alias
			"set_Height"
		end

	frozen set_filled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Drawing2D.AdjustableArrowCap"
		alias
			"set_Filled"
		end

	frozen set_width (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.AdjustableArrowCap"
		alias
			"set_Width"
		end

	frozen set_middle_inset (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.AdjustableArrowCap"
		alias
			"set_MiddleInset"
		end

end -- class DRAWING_ADJUSTABLE_ARROW_CAP
