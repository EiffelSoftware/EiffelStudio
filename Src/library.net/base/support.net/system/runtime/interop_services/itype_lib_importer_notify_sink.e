indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ITypeLibImporterNotifySink"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ITYPE_LIB_IMPORTER_NOTIFY_SINK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	report_event (event_kind: IMPORTER_EVENT_KIND; event_code: INTEGER; event_msg: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.ImporterEventKind, System.Int32, System.String): System.Void use System.Runtime.InteropServices.ITypeLibImporterNotifySink"
		alias
			"ReportEvent"
		end

	resolve_ref (type_lib: SYSTEM_OBJECT): ASSEMBLY is
		external
			"IL deferred signature (System.Object): System.Reflection.Assembly use System.Runtime.InteropServices.ITypeLibImporterNotifySink"
		alias
			"ResolveRef"
		end

end -- class ITYPE_LIB_IMPORTER_NOTIFY_SINK
