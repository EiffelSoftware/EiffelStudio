indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.WatcherChangeTypes"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_IO_WATCHERCHANGETYPES

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen changed: SYSTEM_IO_WATCHERCHANGETYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"4"
		end

	frozen renamed: SYSTEM_IO_WATCHERCHANGETYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"8"
		end

	frozen All_: SYSTEM_IO_WATCHERCHANGETYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"15"
		end

	frozen deleted: SYSTEM_IO_WATCHERCHANGETYPES is
		external
			"IL enum signature :System.IO.WatcherChangeTypes use System.IO.WatcherChangeTypes"
		alias
			"2"
		end

	frozen created: SYSTEM_IO_WATCHERCHANGETYPES is
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

end -- class SYSTEM_IO_WATCHERCHANGETYPES
