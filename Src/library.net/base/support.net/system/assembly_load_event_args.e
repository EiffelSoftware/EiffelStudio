indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.AssemblyLoadEventArgs"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ASSEMBLY_LOAD_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_assembly_load_event_args

feature {NONE} -- Initialization

	frozen make_assembly_load_event_args (loaded_assembly: ASSEMBLY) is
		external
			"IL creator signature (System.Reflection.Assembly) use System.AssemblyLoadEventArgs"
		end

feature -- Access

	frozen get_loaded_assembly: ASSEMBLY is
		external
			"IL signature (): System.Reflection.Assembly use System.AssemblyLoadEventArgs"
		alias
			"get_LoadedAssembly"
		end

end -- class ASSEMBLY_LOAD_EVENT_ARGS
