indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ProcessModule"

external class
	SYSTEM_DIAGNOSTICS_PROCESSMODULE

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			to_string
		end
	SYSTEM_IDISPOSABLE

create {NONE}

feature -- Access

	frozen get_module_name: STRING is
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

	frozen get_file_version_info: SYSTEM_DIAGNOSTICS_FILEVERSIONINFO is
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

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessModule"
		alias
			"get_FileName"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ProcessModule"
		alias
			"ToString"
		end

end -- class SYSTEM_DIAGNOSTICS_PROCESSMODULE
