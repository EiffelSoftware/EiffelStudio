indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileSystemWatcher"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_FILE_SYSTEM_WATCHER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			set_site,
			get_site,
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISUPPORT_INITIALIZE

create
	make_system_dll_file_system_watcher_1,
	make_system_dll_file_system_watcher_2,
	make_system_dll_file_system_watcher

feature {NONE} -- Initialization

	frozen make_system_dll_file_system_watcher_1 (path: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.FileSystemWatcher"
		end

	frozen make_system_dll_file_system_watcher_2 (path: SYSTEM_STRING; filter: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.IO.FileSystemWatcher"
		end

	frozen make_system_dll_file_system_watcher is
		external
			"IL creator use System.IO.FileSystemWatcher"
		end

feature -- Access

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemWatcher"
		alias
			"get_Path"
		end

	frozen get_filter: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemWatcher"
		alias
			"get_Filter"
		end

	frozen get_include_subdirectories: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileSystemWatcher"
		alias
			"get_IncludeSubdirectories"
		end

	frozen get_internal_buffer_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.FileSystemWatcher"
		alias
			"get_InternalBufferSize"
		end

	frozen get_notify_filter: SYSTEM_DLL_NOTIFY_FILTERS is
		external
			"IL signature (): System.IO.NotifyFilters use System.IO.FileSystemWatcher"
		alias
			"get_NotifyFilter"
		end

	frozen get_synchronizing_object: SYSTEM_DLL_ISYNCHRONIZE_INVOKE is
		external
			"IL signature (): System.ComponentModel.ISynchronizeInvoke use System.IO.FileSystemWatcher"
		alias
			"get_SynchronizingObject"
		end

	frozen get_enable_raising_events: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileSystemWatcher"
		alias
			"get_EnableRaisingEvents"
		end

	get_site: SYSTEM_DLL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.IO.FileSystemWatcher"
		alias
			"get_Site"
		end

feature -- Element Change

	frozen set_path (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_Path"
		end

	frozen remove_renamed (value: SYSTEM_DLL_RENAMED_EVENT_HANDLER) is
		external
			"IL signature (System.IO.RenamedEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Renamed"
		end

	frozen remove_error (value: SYSTEM_DLL_ERROR_EVENT_HANDLER) is
		external
			"IL signature (System.IO.ErrorEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Error"
		end

	frozen set_enable_raising_events (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_EnableRaisingEvents"
		end

	frozen remove_deleted (value: SYSTEM_DLL_FILE_SYSTEM_EVENT_HANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Deleted"
		end

	frozen set_filter (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_Filter"
		end

	frozen set_include_subdirectories (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_IncludeSubdirectories"
		end

	frozen remove_changed (value: SYSTEM_DLL_FILE_SYSTEM_EVENT_HANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Changed"
		end

	frozen add_created (value: SYSTEM_DLL_FILE_SYSTEM_EVENT_HANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"add_Created"
		end

	frozen set_notify_filter (value: SYSTEM_DLL_NOTIFY_FILTERS) is
		external
			"IL signature (System.IO.NotifyFilters): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_NotifyFilter"
		end

	frozen add_renamed (value: SYSTEM_DLL_RENAMED_EVENT_HANDLER) is
		external
			"IL signature (System.IO.RenamedEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"add_Renamed"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_Site"
		end

	frozen add_changed (value: SYSTEM_DLL_FILE_SYSTEM_EVENT_HANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"add_Changed"
		end

	frozen add_error (value: SYSTEM_DLL_ERROR_EVENT_HANDLER) is
		external
			"IL signature (System.IO.ErrorEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"add_Error"
		end

	frozen set_internal_buffer_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_InternalBufferSize"
		end

	frozen set_synchronizing_object (value: SYSTEM_DLL_ISYNCHRONIZE_INVOKE) is
		external
			"IL signature (System.ComponentModel.ISynchronizeInvoke): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_SynchronizingObject"
		end

	frozen remove_created (value: SYSTEM_DLL_FILE_SYSTEM_EVENT_HANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Created"
		end

	frozen add_deleted (value: SYSTEM_DLL_FILE_SYSTEM_EVENT_HANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"add_Deleted"
		end

feature -- Basic Operations

	frozen end_init is
		external
			"IL signature (): System.Void use System.IO.FileSystemWatcher"
		alias
			"EndInit"
		end

	frozen wait_for_changed_watcher_change_types_int32 (change_type: SYSTEM_DLL_WATCHER_CHANGE_TYPES; timeout: INTEGER): SYSTEM_DLL_WAIT_FOR_CHANGED_RESULT is
		external
			"IL signature (System.IO.WatcherChangeTypes, System.Int32): System.IO.WaitForChangedResult use System.IO.FileSystemWatcher"
		alias
			"WaitForChanged"
		end

	frozen wait_for_changed (change_type: SYSTEM_DLL_WATCHER_CHANGE_TYPES): SYSTEM_DLL_WAIT_FOR_CHANGED_RESULT is
		external
			"IL signature (System.IO.WatcherChangeTypes): System.IO.WaitForChangedResult use System.IO.FileSystemWatcher"
		alias
			"WaitForChanged"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.IO.FileSystemWatcher"
		alias
			"BeginInit"
		end

feature {NONE} -- Implementation

	frozen on_created (e: SYSTEM_DLL_FILE_SYSTEM_EVENT_ARGS) is
		external
			"IL signature (System.IO.FileSystemEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnCreated"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.FileSystemWatcher"
		alias
			"Dispose"
		end

	frozen on_deleted (e: SYSTEM_DLL_FILE_SYSTEM_EVENT_ARGS) is
		external
			"IL signature (System.IO.FileSystemEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnDeleted"
		end

	frozen on_renamed (e: SYSTEM_DLL_RENAMED_EVENT_ARGS) is
		external
			"IL signature (System.IO.RenamedEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnRenamed"
		end

	frozen on_error (e: SYSTEM_DLL_ERROR_EVENT_ARGS) is
		external
			"IL signature (System.IO.ErrorEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnError"
		end

	frozen on_changed (e: SYSTEM_DLL_FILE_SYSTEM_EVENT_ARGS) is
		external
			"IL signature (System.IO.FileSystemEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnChanged"
		end

end -- class SYSTEM_DLL_FILE_SYSTEM_WATCHER
