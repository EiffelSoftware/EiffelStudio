indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ImporterEventKind"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	IMPORTER_EVENT_KIND

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen notif_typeconverted: IMPORTER_EVENT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.ImporterEventKind use System.Runtime.InteropServices.ImporterEventKind"
		alias
			"0"
		end

	frozen error_reftoinvalidtypelib: IMPORTER_EVENT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.ImporterEventKind use System.Runtime.InteropServices.ImporterEventKind"
		alias
			"2"
		end

	frozen notif_convertwarning: IMPORTER_EVENT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.ImporterEventKind use System.Runtime.InteropServices.ImporterEventKind"
		alias
			"1"
		end

end -- class IMPORTER_EVENT_KIND
