indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Text.GenericFontFamilies"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_TEXT_GENERICFONTFAMILIES

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

	frozen serif: SYSTEM_DRAWING_TEXT_GENERICFONTFAMILIES is
		external
			"IL enum signature :System.Drawing.Text.GenericFontFamilies use System.Drawing.Text.GenericFontFamilies"
		alias
			"0"
		end

	frozen sans_serif: SYSTEM_DRAWING_TEXT_GENERICFONTFAMILIES is
		external
			"IL enum signature :System.Drawing.Text.GenericFontFamilies use System.Drawing.Text.GenericFontFamilies"
		alias
			"1"
		end

	frozen monospace: SYSTEM_DRAWING_TEXT_GENERICFONTFAMILIES is
		external
			"IL enum signature :System.Drawing.Text.GenericFontFamilies use System.Drawing.Text.GenericFontFamilies"
		alias
			"2"
		end

end -- class SYSTEM_DRAWING_TEXT_GENERICFONTFAMILIES
