indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.PEFileKinds"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	PEFILE_KINDS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen dll: PEFILE_KINDS is
		external
			"IL enum signature :System.Reflection.Emit.PEFileKinds use System.Reflection.Emit.PEFileKinds"
		alias
			"1"
		end

	frozen console_application: PEFILE_KINDS is
		external
			"IL enum signature :System.Reflection.Emit.PEFileKinds use System.Reflection.Emit.PEFileKinds"
		alias
			"2"
		end

	frozen window_application: PEFILE_KINDS is
		external
			"IL enum signature :System.Reflection.Emit.PEFileKinds use System.Reflection.Emit.PEFileKinds"
		alias
			"3"
		end

end -- class PEFILE_KINDS
