indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.StringAlignment"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_STRINGALIGNMENT

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

	frozen near: SYSTEM_DRAWING_STRINGALIGNMENT is
		external
			"IL enum signature :System.Drawing.StringAlignment use System.Drawing.StringAlignment"
		alias
			"0"
		end

	frozen center: SYSTEM_DRAWING_STRINGALIGNMENT is
		external
			"IL enum signature :System.Drawing.StringAlignment use System.Drawing.StringAlignment"
		alias
			"1"
		end

	frozen far: SYSTEM_DRAWING_STRINGALIGNMENT is
		external
			"IL enum signature :System.Drawing.StringAlignment use System.Drawing.StringAlignment"
		alias
			"2"
		end

end -- class SYSTEM_DRAWING_STRINGALIGNMENT
