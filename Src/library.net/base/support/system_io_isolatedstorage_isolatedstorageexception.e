indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.IsolatedStorage.IsolatedStorageException"

external class
	SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_isolatedstorageexception_2,
	make_isolatedstorageexception,
	make_isolatedstorageexception_1

feature {NONE} -- Initialization

	frozen make_isolatedstorageexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.IsolatedStorage.IsolatedStorageException"
		end

	frozen make_isolatedstorageexception is
		external
			"IL creator use System.IO.IsolatedStorage.IsolatedStorageException"
		end

	frozen make_isolatedstorageexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.IO.IsolatedStorage.IsolatedStorageException"
		end

end -- class SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEEXCEPTION
