indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.Mutex"

frozen external class
	SYSTEM_THREADING_MUTEX

inherit
	SYSTEM_THREADING_WAITHANDLE
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_mutex_1,
	make_mutex_3,
	make_mutex_2,
	make_mutex

feature {NONE} -- Initialization

	frozen make_mutex_1 (initially_owned: BOOLEAN; name: STRING) is
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

	frozen make_mutex (initially_owned: BOOLEAN; name: STRING; got_ownership: BOOLEAN) is
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

end -- class SYSTEM_THREADING_MUTEX
