indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileSystemEventArgs"

external class
	SYSTEM_IO_FILESYSTEMEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_filesystemeventargs

feature {NONE} -- Initialization

	frozen make_filesystemeventargs (change_type: SYSTEM_IO_WATCHERCHANGETYPES; directory: STRING; name: STRING) is
		external
			"IL creator signature (System.IO.WatcherChangeTypes, System.String, System.String) use System.IO.FileSystemEventArgs"
		end

feature -- Access

	frozen get_change_type: SYSTEM_IO_WATCHERCHANGETYPES is
		external
			"IL signature (): System.IO.WatcherChangeTypes use System.IO.FileSystemEventArgs"
		alias
			"get_ChangeType"
		end

	frozen get_full_path: STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemEventArgs"
		alias
			"get_FullPath"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileSystemEventArgs"
		alias
			"get_Name"
		end

end -- class SYSTEM_IO_FILESYSTEMEVENTARGS
