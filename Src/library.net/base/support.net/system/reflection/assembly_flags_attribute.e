indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyFlagsAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_FLAGS_ATTRIBUTE

inherit
	ATTRIBUTE

create {NONE}

feature -- Access

	frozen get_flags: INTEGER is
		external
			"IL signature (): System.UInt32 use System.Reflection.AssemblyFlagsAttribute"
		alias
			"get_Flags"
		end

end -- class ASSEMBLY_FLAGS_ATTRIBUTE
