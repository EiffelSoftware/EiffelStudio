indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	eesolve_eef (assembly: SYSTEM_REFLECTION_ASSEMBLY): ANY is
		external
			"IL deferred signature (System.Reflection.Assembly): System.Object use System.Runtime.InteropServices.ITypeLibExporterNotifySink"
		alias
			"ResolveRef"
		end

	eeport_event (event_kind: INTEGER; eventCode: INTEGER; eventMsg: STRING) is
			-- Valid values for `event_kind' are:
			-- NOTIF_TYPECONVERTED = 0
			-- NOTIF_CONVERTWARNING = 1
			-- ERROR_REFTOINVALIDASSEMBLY = 2
		require
			valid_exporter_event_kind: event_kind = 0 or event_kind = 1 or event_kind = 2
		external
			"IL deferred signature (enum System.Runtime.InteropServices.ExporterEventKind, System.Int32, System.String): System.Void use System.Runtime.InteropServices.ITypeLibExporterNotifySink"
		alias
			"ReportEvent"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ITYPELIBEXPORTERNOTIFYSINK
