indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Text.TextRenderingHint"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen single_bit_per_pixel_grid_fit: SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT is
		external
			"IL enum signature :System.Drawing.Text.TextRenderingHint use System.Drawing.Text.TextRenderingHint"
		alias
			"1"
		end

	frozen anti_alias: SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT is
		external
			"IL enum signature :System.Drawing.Text.TextRenderingHint use System.Drawing.Text.TextRenderingHint"
		alias
			"4"
		end

	frozen system_default: SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT is
		external
			"IL enum signature :System.Drawing.Text.TextRenderingHint use System.Drawing.Text.TextRenderingHint"
		alias
			"0"
		end

	frozen single_bit_per_pixel: SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT is
		external
			"IL enum signature :System.Drawing.Text.TextRenderingHint use System.Drawing.Text.TextRenderingHint"
		alias
			"2"
		end

	frozen clear_type_grid_fit: SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT is
		external
			"IL enum signature :System.Drawing.Text.TextRenderingHint use System.Drawing.Text.TextRenderingHint"
		alias
			"5"
		end

	frozen anti_alias_grid_fit: SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT is
		external
			"IL enum signature :System.Drawing.Text.TextRenderingHint use System.Drawing.Text.TextRenderingHint"
		alias
			"3"
		end

end -- class SYSTEM_DRAWING_TEXT_TEXTRENDERINGHINT
