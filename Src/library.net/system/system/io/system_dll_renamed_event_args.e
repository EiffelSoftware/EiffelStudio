indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.RenamedEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_RENAMED_EVENT_ARGS

inherit
	SYSTEM_DLL_FILE_SYSTEM_EVENT_ARGS

create
	make_system_dll_renamed_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_renamed_event_args (change_type: SYSTEM_DLL_WATCHER_CHANGE_TYPES; directory: SYSTEM_STRING; name: SYSTEM_STRING; old_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.WatcherChangeTypes, System.String, System.String, System.String) use System.IO.RenamedEventArgs"
		end

feature -- Access

	frozen get_old_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.RenamedEventArgs"
		alias
			"get_OldName"
		end

	frozen get_old_full_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.RenamedEventArgs"
		alias
			"get_OldFullPath"
		end

end -- class SYSTEM_DLL_RENAMED_EVENT_ARGS
