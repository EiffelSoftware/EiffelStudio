indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.Duplex"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_PRINTING_DUPLEX

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

	frozen default: SYSTEM_DRAWING_PRINTING_DUPLEX is
		external
			"IL enum signature :System.Drawing.Printing.Duplex use System.Drawing.Printing.Duplex"
		alias
			"-1"
		end

	frozen horizontal: SYSTEM_DRAWING_PRINTING_DUPLEX is
		external
			"IL enum signature :System.Drawing.Printing.Duplex use System.Drawing.Printing.Duplex"
		alias
			"3"
		end

	frozen vertical: SYSTEM_DRAWING_PRINTING_DUPLEX is
		external
			"IL enum signature :System.Drawing.Printing.Duplex use System.Drawing.Printing.Duplex"
		alias
			"2"
		end

	frozen simplex: SYSTEM_DRAWING_PRINTING_DUPLEX is
		external
			"IL enum signature :System.Drawing.Printing.Duplex use System.Drawing.Printing.Duplex"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_PRINTING_DUPLEX
