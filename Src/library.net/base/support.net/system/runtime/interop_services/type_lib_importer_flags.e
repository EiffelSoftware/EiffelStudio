indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TypeLibImporterFlags"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	TYPE_LIB_IMPORTER_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen unsafe_interfaces: TYPE_LIB_IMPORTER_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibImporterFlags use System.Runtime.InteropServices.TypeLibImporterFlags"
		alias
			"2"
		end

	frozen safe_array_as_system_array: TYPE_LIB_IMPORTER_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibImporterFlags use System.Runtime.InteropServices.TypeLibImporterFlags"
		alias
			"4"
		end

	frozen primary_interop_assembly: TYPE_LIB_IMPORTER_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibImporterFlags use System.Runtime.InteropServices.TypeLibImporterFlags"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class TYPE_LIB_IMPORTER_FLAGS
