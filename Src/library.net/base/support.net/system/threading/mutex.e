indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.Mutex"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MUTEX

inherit
	WAIT_HANDLE
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_mutex_1,
	make_mutex_3,
	make_mutex_2,
	make_mutex

feature {NONE} -- Initialization

	frozen make_mutex_1 (initially_owned: BOOLEAN; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Boolean, System.String) use System.Threading.Mutex"
		end

	frozen make_mutex_3 is
		external
			"IL creator use System.Threading.Mutex"
		end

	frozen make_mutex_2 (initially_owned: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Threading.Mutex"
		end

	frozen make_mutex (initially_owned: BOOLEAN; name: SYSTEM_STRING; created_new: BOOLEAN) is
		external
			"IL creator signature (System.Boolean, System.String, System.Boolean&) use System.Threading.Mutex"
		end

feature -- Basic Operations

	frozen release_mutex is
		external
			"IL signature (): System.Void use System.Threading.Mutex"
		alias
			"ReleaseMutex"
		end

end -- class MUTEX
