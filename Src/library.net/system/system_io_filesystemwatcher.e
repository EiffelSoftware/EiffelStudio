indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileSystemWatcher"

external class
	SYSTEM_IO_FILESYSTEMWATCHER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose,
			set_site,
			get_site,
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ISUPPORTINITIALIZE

create
	make_filesystemwatcher_1,
	make_filesystemwatcher_2,
	make_filesystemwatcher

feature {NONE} -- Initialization

	frozen make_filesystemwatcher_1 (path: STRING) is
		external
			"IL creator signature (System.String) use System.IO.FileSystemWatcher"
		end

	frozen make_filesystemwatcher_2 (path: STRING; filter: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.IO.FileSystemWatcher"
		end

	frozen make_filesystemwatcher is
		external
			"IL creator use System.IO.FileSystemWatcher"
		end

feature -- Access

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemWatcher"
		alias
			"get_Path"
		end

	frozen get_filter: STRING is
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

	frozen get_notify_filter: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL signature (): System.IO.NotifyFilters use System.IO.FileSystemWatcher"
		alias
			"get_NotifyFilter"
		end

	frozen get_synchronizing_object: SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE is
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

	get_site: SYSTEM_COMPONENTMODEL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.IO.FileSystemWatcher"
		alias
			"get_Site"
		end

feature -- Element Change

	frozen set_path (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_Path"
		end

	frozen remove_renamed (value: SYSTEM_IO_RENAMEDEVENTHANDLER) is
		external
			"IL signature (System.IO.RenamedEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Renamed"
		end

	frozen remove_error (value: SYSTEM_IO_ERROREVENTHANDLER) is
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

	frozen remove_deleted (value: SYSTEM_IO_FILESYSTEMEVENTHANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Deleted"
		end

	frozen set_filter (value: STRING) is
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

	frozen remove_changed (value: SYSTEM_IO_FILESYSTEMEVENTHANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Changed"
		end

	frozen add_created (value: SYSTEM_IO_FILESYSTEMEVENTHANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"add_Created"
		end

	frozen set_notify_filter (value: SYSTEM_IO_NOTIFYFILTERS) is
		external
			"IL signature (System.IO.NotifyFilters): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_NotifyFilter"
		end

	frozen add_renamed (value: SYSTEM_IO_RENAMEDEVENTHANDLER) is
		external
			"IL signature (System.IO.RenamedEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"add_Renamed"
		end

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_Site"
		end

	frozen add_changed (value: SYSTEM_IO_FILESYSTEMEVENTHANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"add_Changed"
		end

	frozen add_error (value: SYSTEM_IO_ERROREVENTHANDLER) is
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

	frozen set_synchronizing_object (value: SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE) is
		external
			"IL signature (System.ComponentModel.ISynchronizeInvoke): System.Void use System.IO.FileSystemWatcher"
		alias
			"set_SynchronizingObject"
		end

	frozen remove_created (value: SYSTEM_IO_FILESYSTEMEVENTHANDLER) is
		external
			"IL signature (System.IO.FileSystemEventHandler): System.Void use System.IO.FileSystemWatcher"
		alias
			"remove_Created"
		end

	frozen add_deleted (value: SYSTEM_IO_FILESYSTEMEVENTHANDLER) is
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

	dispose is
		external
			"IL signature (): System.Void use System.IO.FileSystemWatcher"
		alias
			"Dispose"
		end

	frozen wait_for_changed_watcher_change_types_int32 (change_type: SYSTEM_IO_WATCHERCHANGETYPES; timeout: INTEGER): SYSTEM_IO_WAITFORCHANGEDRESULT is
		external
			"IL signature (System.IO.WatcherChangeTypes, System.Int32): System.IO.WaitForChangedResult use System.IO.FileSystemWatcher"
		alias
			"WaitForChanged"
		end

	frozen wait_for_changed (change_type: SYSTEM_IO_WATCHERCHANGETYPES): SYSTEM_IO_WAITFORCHANGEDRESULT is
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

	frozen on_created (e: SYSTEM_IO_FILESYSTEMEVENTARGS) is
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

	frozen on_deleted (e: SYSTEM_IO_FILESYSTEMEVENTARGS) is
		external
			"IL signature (System.IO.FileSystemEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnDeleted"
		end

	frozen on_renamed (e: SYSTEM_IO_RENAMEDEVENTARGS) is
		external
			"IL signature (System.IO.RenamedEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnRenamed"
		end

	frozen on_error (e: SYSTEM_IO_ERROREVENTARGS) is
		external
			"IL signature (System.IO.ErrorEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnError"
		end

	frozen on_changed (e: SYSTEM_IO_FILESYSTEMEVENTARGS) is
		external
			"IL signature (System.IO.FileSystemEventArgs): System.Void use System.IO.FileSystemWatcher"
		alias
			"OnChanged"
		end

end -- class SYSTEM_IO_FILESYSTEMWATCHER
