indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.IsolatedStorage.IsolatedStorageException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ISOLATED_STORAGE_EXCEPTION

inherit
	EXCEPTION
	ISERIALIZABLE

create
	make_isolated_storage_exception,
	make_isolated_storage_exception_2,
	make_isolated_storage_exception_1

feature {NONE} -- Initialization

	frozen make_isolated_storage_exception is
		external
			"IL creator use System.IO.IsolatedStorage.IsolatedStorageException"
		end

	frozen make_isolated_storage_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.IsolatedStorage.IsolatedStorageException"
		end

	frozen make_isolated_storage_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.IsolatedStorage.IsolatedStorageException"
		end

end -- class ISOLATED_STORAGE_EXCEPTION
