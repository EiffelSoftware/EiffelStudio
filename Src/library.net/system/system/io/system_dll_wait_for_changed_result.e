indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.WaitForChangedResult"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	SYSTEM_DLL_WAIT_FOR_CHANGED_RESULT

inherit
	VALUE_TYPE

feature -- Access

	frozen get_change_type: SYSTEM_DLL_WATCHER_CHANGE_TYPES is
		external
			"IL signature (): System.IO.WatcherChangeTypes use System.IO.WaitForChangedResult"
		alias
			"get_ChangeType"
		end

	frozen get_old_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.WaitForChangedResult"
		alias
			"get_OldName"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.WaitForChangedResult"
		alias
			"get_Name"
		end

	frozen get_timed_out: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.WaitForChangedResult"
		alias
			"get_TimedOut"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.WaitForChangedResult"
		alias
			"set_Name"
		end

	frozen set_timed_out (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.WaitForChangedResult"
		alias
			"set_TimedOut"
		end

	frozen set_change_type (value: SYSTEM_DLL_WATCHER_CHANGE_TYPES) is
		external
			"IL signature (System.IO.WatcherChangeTypes): System.Void use System.IO.WaitForChangedResult"
		alias
			"set_ChangeType"
		end

	frozen set_old_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.WaitForChangedResult"
		alias
			"set_OldName"
		end

end -- class SYSTEM_DLL_WAIT_FOR_CHANGED_RESULT
