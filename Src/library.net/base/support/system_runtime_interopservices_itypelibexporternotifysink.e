indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ITypeLibExporterNotifySink"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBEXPORTERNOTIFYSINK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	report_event (event_kind: SYSTEM_RUNTIME_INTEROPSERVICES_EXPORTEREVENTKIND; event_code: INTEGER; event_msg: STRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.ExporterEventKind, System.Int32, System.String): System.Void use System.Runtime.InteropServices.ITypeLibExporterNotifySink"
		alias
			"ReportEvent"
		end

	resolve_ref (assembly: SYSTEM_REFLECTION_ASSEMBLY): ANY is
		external
			"IL deferred signature (System.Reflection.Assembly): System.Object use System.Runtime.InteropServices.ITypeLibExporterNotifySink"
		alias
			"ResolveRef"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBEXPORTERNOTIFYSINK
