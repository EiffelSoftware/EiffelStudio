indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.IsolatedStorage.IsolatedStorageException"

external class
	SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_isolated_storage_exception_2,
	make_isolated_storage_exception,
	make_isolated_storage_exception_1

feature {NONE} -- Initialization

	frozen make_isolated_storage_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.IsolatedStorage.IsolatedStorageException"
		end

	frozen make_isolated_storage_exception is
		external
			"IL creator use System.IO.IsolatedStorage.IsolatedStorageException"
		end

	frozen make_isolated_storage_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.IO.IsolatedStorage.IsolatedStorageException"
		end

end -- class SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEEXCEPTION
