indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ITypeLibExporterNotifySink"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ITYPE_LIB_EXPORTER_NOTIFY_SINK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	report_event (event_kind: EXPORTER_EVENT_KIND; event_code: INTEGER; event_msg: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.ExporterEventKind, System.Int32, System.String): System.Void use System.Runtime.InteropServices.ITypeLibExporterNotifySink"
		alias
			"ReportEvent"
		end

	resolve_ref (assembly: ASSEMBLY): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Reflection.Assembly): System.Object use System.Runtime.InteropServices.ITypeLibExporterNotifySink"
		alias
			"ResolveRef"
		end

end -- class ITYPE_LIB_EXPORTER_NOTIFY_SINK
