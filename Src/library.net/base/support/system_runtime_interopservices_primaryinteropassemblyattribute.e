indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.PrimaryInteropAssemblyAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_PRIMARYINTEROPASSEMBLYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

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

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_PRIMARYINTEROPASSEMBLYATTRIBUTE
