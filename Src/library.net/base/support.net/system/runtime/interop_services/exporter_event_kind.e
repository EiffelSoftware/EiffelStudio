indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ExporterEventKind"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	EXPORTER_EVENT_KIND

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen notif_typeconverted: EXPORTER_EVENT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.ExporterEventKind use System.Runtime.InteropServices.ExporterEventKind"
		alias
			"0"
		end

	frozen notif_convertwarning: EXPORTER_EVENT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.ExporterEventKind use System.Runtime.InteropServices.ExporterEventKind"
		alias
			"1"
		end

	frozen error_reftoinvalidassembly: EXPORTER_EVENT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.ExporterEventKind use System.Runtime.InteropServices.ExporterEventKind"
		alias
			"2"
		end

end -- class EXPORTER_EVENT_KIND
