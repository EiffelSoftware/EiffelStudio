indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.AdjustableArrowCap"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_ADJUSTABLEARROWCAP

inherit
	SYSTEM_DRAWING_DRAWING2D_CUSTOMLINECAP
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_adjustablearrowcap_1,
	make_adjustablearrowcap

feature {NONE} -- Initialization

	frozen make_adjustablearrowcap_1 (width: REAL; height: REAL; is_filled: BOOLEAN) is
		external
			"IL creator signature (System.Single, System.Single, System.Boolean) use System.Drawing.Drawing2D.AdjustableArrowCap"
		end

	frozen make_adjustablearrowcap (width: REAL; height: REAL) is
		external
			"IL creator signature (System.Single, System.Single) use System.Drawing.Drawing2D.AdjustableArrowCap"
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

end -- class SYSTEM_DRAWING_DRAWING2D_ADJUSTABLEARROWCAP
