indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileSystemEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_FILE_SYSTEM_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_file_system_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_file_system_event_args (change_type: SYSTEM_DLL_WATCHER_CHANGE_TYPES; directory: SYSTEM_STRING; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.WatcherChangeTypes, System.String, System.String) use System.IO.FileSystemEventArgs"
		end

feature -- Access

	frozen get_change_type: SYSTEM_DLL_WATCHER_CHANGE_TYPES is
		external
			"IL signature (): System.IO.WatcherChangeTypes use System.IO.FileSystemEventArgs"
		alias
			"get_ChangeType"
		end

	frozen get_full_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemEventArgs"
		alias
			"get_FullPath"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemEventArgs"
		alias
			"get_Name"
		end

end -- class SYSTEM_DLL_FILE_SYSTEM_EVENT_ARGS
