indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.IsolatedStorage.IsolatedStorageFileStream"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ISOLATED_STORAGE_FILE_STREAM

inherit
	FILE_STREAM
		redefine
			get_handle,
			dispose,
			get_is_async,
			write_byte,
			write,
			read_byte,
			read,
			set_length,
			seek,
			end_write,
			begin_write,
			end_read,
			begin_read,
			flush,
			close,
			set_position,
			get_position,
			get_length,
			get_can_write,
			get_can_seek,
			get_can_read
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_isolated_storage_file_stream_1,
	make_isolated_storage_file_stream_3,
	make_isolated_storage_file_stream_2,
	make_isolated_storage_file_stream_5,
	make_isolated_storage_file_stream_4,
	make_isolated_storage_file_stream_7,
	make_isolated_storage_file_stream_6,
	make_isolated_storage_file_stream

feature {NONE} -- Initialization

	frozen make_isolated_storage_file_stream_1 (path: SYSTEM_STRING; mode: FILE_MODE; isf: ISOLATED_STORAGE_FILE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_3 (path: SYSTEM_STRING; mode: FILE_MODE; access: FILE_ACCESS; isf: ISOLATED_STORAGE_FILE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_2 (path: SYSTEM_STRING; mode: FILE_MODE; access: FILE_ACCESS) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_5 (path: SYSTEM_STRING; mode: FILE_MODE; access: FILE_ACCESS; share: FILE_SHARE; isf: ISOLATED_STORAGE_FILE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_4 (path: SYSTEM_STRING; mode: FILE_MODE; access: FILE_ACCESS; share: FILE_SHARE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_7 (path: SYSTEM_STRING; mode: FILE_MODE; access: FILE_ACCESS; share: FILE_SHARE; buffer_size: INTEGER; isf: ISOLATED_STORAGE_FILE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare, System.Int32, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_6 (path: SYSTEM_STRING; mode: FILE_MODE; access: FILE_ACCESS; share: FILE_SHARE; buffer_size: INTEGER) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare, System.Int32) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream (path: SYSTEM_STRING; mode: FILE_MODE) is
		external
			"IL creator signature (System.String, System.IO.FileMode) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

feature -- Access

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_CanWrite"
		end

	get_is_async: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_IsAsync"
		end

	get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_Length"
		end

	get_can_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_CanRead"
		end

	get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_Handle"
		end

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_CanSeek"
		end

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_Position"
		end

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	read (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Read"
		end

	read_byte: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"ReadByte"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Close"
		end

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"SetLength"
		end

	flush is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Flush"
		end

	end_write (async_result: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"EndWrite"
		end

	begin_write (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; num_bytes: INTEGER; user_callback: ASYNC_CALLBACK; state_object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"BeginWrite"
		end

	begin_read (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; num_bytes: INTEGER; user_callback: ASYNC_CALLBACK; state_object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"BeginRead"
		end

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"WriteByte"
		end

	end_read (async_result: IASYNC_RESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"EndRead"
		end

	write (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Write"
		end

	seek (offset: INTEGER_64; origin: SEEK_ORIGIN): INTEGER_64 is
		external
			"IL signature (System.Int64, System.IO.SeekOrigin): System.Int64 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Seek"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Dispose"
		end

end -- class ISOLATED_STORAGE_FILE_STREAM
