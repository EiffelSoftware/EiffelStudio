indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.WatcherChangeTypes"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_WATCHER_CHANGE_TYPES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen changed: SYSTEM_DLL_WATCHER_CHANGE_TYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"4"
		end

	frozen all_: SYSTEM_DLL_WATCHER_CHANGE_TYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"15"
		end

	frozen renamed: SYSTEM_DLL_WATCHER_CHANGE_TYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"8"
		end

	frozen deleted: SYSTEM_DLL_WATCHER_CHANGE_TYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"2"
		end

	frozen created: SYSTEM_DLL_WATCHER_CHANGE_TYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DLL_WATCHER_CHANGE_TYPES
