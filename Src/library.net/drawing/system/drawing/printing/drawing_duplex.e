indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.Duplex"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_DUPLEX

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen default_: DRAWING_DUPLEX is
		external
			"IL enum signature :System.Drawing.Printing.Duplex use System.Drawing.Printing.Duplex"
		alias
			"-1"
		end

	frozen horizontal: DRAWING_DUPLEX is
		external
			"IL enum signature :System.Drawing.Printing.Duplex use System.Drawing.Printing.Duplex"
		alias
			"3"
		end

	frozen vertical: DRAWING_DUPLEX is
		external
			"IL enum signature :System.Drawing.Printing.Duplex use System.Drawing.Printing.Duplex"
		alias
			"2"
		end

	frozen simplex: DRAWING_DUPLEX is
		external
			"IL enum signature :System.Drawing.Printing.Duplex use System.Drawing.Printing.Duplex"
		alias
			"1"
		end

end -- class DRAWING_DUPLEX
