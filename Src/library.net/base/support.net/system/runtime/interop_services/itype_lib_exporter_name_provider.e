indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ITypeLibExporterNameProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ITYPE_LIB_EXPORTER_NAME_PROVIDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL deferred signature (): System.String[] use System.Runtime.InteropServices.ITypeLibExporterNameProvider"
		alias
			"GetNames"
		end

end -- class ITYPE_LIB_EXPORTER_NAME_PROVIDER
