indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Diagnostics.ProcessModule"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

external class
	PROCESSMODULE

inherit
	COMPONENT
		redefine
			to_string
		end
	ICOMPONENT
	IDISPOSABLE

create {NONE}

feature -- Access

	frozen get_module_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessModule"
		alias
			"get_ModuleName"
		end

	frozen get_module_memory_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.ProcessModule"
		alias
			"get_ModuleMemorySize"
		end

	frozen get_entry_point_address: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.ProcessModule"
		alias
			"get_EntryPointAddress"
		end

	frozen get_file_version_info: FILEVERSIONINFO is
		external
			"IL signature (): System.Diagnostics.FileVersionInfo use System.Diagnostics.ProcessModule"
		alias
			"get_FileVersionInfo"
		end

	frozen get_base_address: POINTER is
		external
			"IL signature (): System.IntPtr use System.Diagnostics.ProcessModule"
		alias
			"get_BaseAddress"
		end

	frozen get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessModule"
		alias
			"get_FileName"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessModule"
		alias
			"ToString"
		end

end -- class PROCESSMODULE
