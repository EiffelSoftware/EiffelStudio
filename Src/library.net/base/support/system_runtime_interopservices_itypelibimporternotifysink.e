indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ITypeLibImporterNotifySink"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBIMPORTERNOTIFYSINK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	report_event (event_kind: SYSTEM_RUNTIME_INTEROPSERVICES_IMPORTEREVENTKIND; event_code: INTEGER; event_msg: STRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.ImporterEventKind, System.Int32, System.String): System.Void use System.Runtime.InteropServices.ITypeLibImporterNotifySink"
		alias
			"ReportEvent"
		end

	resolve_ref (type_lib: ANY): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL deferred signature (System.Object): System.Reflection.Assembly use System.Runtime.InteropServices.ITypeLibImporterNotifySink"
		alias
			"ResolveRef"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBIMPORTERNOTIFYSINK
