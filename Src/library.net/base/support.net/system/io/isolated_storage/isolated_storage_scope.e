indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.IsolatedStorage.IsolatedStorageScope"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	ISOLATED_STORAGE_SCOPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen user: ISOLATED_STORAGE_SCOPE is
		external
			"IL enum signature :System.IO.IsolatedStorage.IsolatedStorageScope use System.IO.IsolatedStorage.IsolatedStorageScope"
		alias
			"1"
		end

	frozen assembly: ISOLATED_STORAGE_SCOPE is
		external
			"IL enum signature :System.IO.IsolatedStorage.IsolatedStorageScope use System.IO.IsolatedStorage.IsolatedStorageScope"
		alias
			"4"
		end

	frozen roaming: ISOLATED_STORAGE_SCOPE is
		external
			"IL enum signature :System.IO.IsolatedStorage.IsolatedStorageScope use System.IO.IsolatedStorage.IsolatedStorageScope"
		alias
			"8"
		end

	frozen none: ISOLATED_STORAGE_SCOPE is
		external
			"IL enum signature :System.IO.IsolatedStorage.IsolatedStorageScope use System.IO.IsolatedStorage.IsolatedStorageScope"
		alias
			"0"
		end

	frozen domain: ISOLATED_STORAGE_SCOPE is
		external
			"IL enum signature :System.IO.IsolatedStorage.IsolatedStorageScope use System.IO.IsolatedStorage.IsolatedStorageScope"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class ISOLATED_STORAGE_SCOPE
