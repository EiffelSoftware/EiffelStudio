indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.RenamedEventArgs"

external class
	SYSTEM_IO_RENAMEDEVENTARGS

inherit
	SYSTEM_IO_FILESYSTEMEVENTARGS

create
	make_renamedeventargs

feature {NONE} -- Initialization

	frozen make_renamedeventargs (change_type: SYSTEM_IO_WATCHERCHANGETYPES; directory: STRING; name: STRING; old_name: STRING) is
		external
			"IL creator signature (System.IO.WatcherChangeTypes, System.String, System.String, System.String) use System.IO.RenamedEventArgs"
		end

feature -- Access

	frozen get_old_name: STRING is
		external
			"IL signature (): System.String use System.IO.RenamedEventArgs"
		alias
			"get_OldName"
		end

	frozen get_old_full_path: STRING is
		external
			"IL signature (): System.String use System.IO.RenamedEventArgs"
		alias
			"get_OldFullPath"
		end

end -- class SYSTEM_IO_RENAMEDEVENTARGS
