indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	resolve_ref (typeLib: ANY): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL deferred signature (System.Object): System.Reflection.Assembly use System.Runtime.InteropServices.ITypeLibImporterNotifySink"
		alias
			"ResolveRef"
		end

	report_event (event_kind: INTEGER; eventCode: INTEGER; eventMsg: STRING) is
			-- Valid values for `event_kind' are:
			-- NOTIF_TYPECONVERTED = 0
			-- NOTIF_CONVERTWARNING = 1
			-- ERROR_REFTOINVALIDTYPELIB = 2
		require
			valid_importer_event_kind: event_kind = 0 or event_kind = 1 or event_kind = 2
		external
			"IL deferred signature (enum System.Runtime.InteropServices.ImporterEventKind, System.Int32, System.String): System.Void use System.Runtime.InteropServices.ITypeLibImporterNotifySink"
		alias
			"ReportEvent"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBIMPORTERNOTIFYSINK
