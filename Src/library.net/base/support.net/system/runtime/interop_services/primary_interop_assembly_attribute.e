indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.PrimaryInteropAssemblyAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PRIMARY_INTEROP_ASSEMBLY_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_primary_interop_assembly_attribute

feature {NONE} -- Initialization

	frozen make_primary_interop_assembly_attribute (major: INTEGER; minor: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Runtime.InteropServices.PrimaryInteropAssemblyAttribute"
		end

feature -- Access

	frozen get_minor_version: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.PrimaryInteropAssemblyAttribute"
		alias
			"get_MinorVersion"
		end

	frozen get_major_version: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.PrimaryInteropAssemblyAttribute"
		alias
			"get_MajorVersion"
		end

end -- class PRIMARY_INTEROP_ASSEMBLY_ATTRIBUTE
