indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TypeLibExporterFlags"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	TYPE_LIB_EXPORTER_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen only_reference_registered: TYPE_LIB_EXPORTER_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibExporterFlags use System.Runtime.InteropServices.TypeLibExporterFlags"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class TYPE_LIB_EXPORTER_FLAGS
