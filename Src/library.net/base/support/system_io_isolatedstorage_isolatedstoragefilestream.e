indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.IsolatedStorage.IsolatedStorageFileStream"

external class
	SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILESTREAM

inherit
	SYSTEM_IO_FILESTREAM
		redefine
			get_handle,
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
			dispose,
			close,
			set_position,
			get_position,
			get_length,
			get_can_write,
			get_can_seek,
			get_can_read
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_isolatedstoragefilestream_1,
	make_isolatedstoragefilestream,
	make_isolatedstoragefilestream_6,
	make_isolatedstoragefilestream_7,
	make_isolatedstoragefilestream_4,
	make_isolatedstoragefilestream_5,
	make_isolatedstoragefilestream_2,
	make_isolatedstoragefilestream_3

feature {NONE} -- Initialization

	frozen make_isolatedstoragefilestream_1 (path: STRING; mode: SYSTEM_IO_FILEMODE; isf: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolatedstoragefilestream (path: STRING; mode: SYSTEM_IO_FILEMODE) is
		external
			"IL creator signature (System.String, System.IO.FileMode) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolatedstoragefilestream_6 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE; buffer_size: INTEGER) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare, System.Int32) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolatedstoragefilestream_7 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE; buffer_size: INTEGER; isf: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare, System.Int32, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolatedstoragefilestream_4 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolatedstoragefilestream_5 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE; isf: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolatedstoragefilestream_2 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolatedstoragefilestream_3 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; isf: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
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

	read (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
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

	end_write (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"EndWrite"
		end

	begin_write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; num_bytes: INTEGER; user_callback: SYSTEM_ASYNCCALLBACK; state_object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"BeginWrite"
		end

	begin_read (buffer: ARRAY [INTEGER_8]; offset: INTEGER; num_bytes: INTEGER; user_callback: SYSTEM_ASYNCCALLBACK; state_object: ANY): SYSTEM_IASYNCRESULT is
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

	end_read (async_result: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"EndRead"
		end

	write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Write"
		end

	seek (offset: INTEGER_64; origin: SYSTEM_IO_SEEKORIGIN): INTEGER_64 is
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

end -- class SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILESTREAM
