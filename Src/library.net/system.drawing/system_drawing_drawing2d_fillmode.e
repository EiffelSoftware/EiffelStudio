indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.FillMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_DRAWING2D_FILLMODE

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

	frozen winding: SYSTEM_DRAWING_DRAWING2D_FILLMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.FillMode use System.Drawing.Drawing2D.FillMode"
		alias
			"1"
		end

	frozen alternate: SYSTEM_DRAWING_DRAWING2D_FILLMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.FillMode use System.Drawing.Drawing2D.FillMode"
		alias
			"0"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_FILLMODE
