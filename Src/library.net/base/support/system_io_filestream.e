indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileStream"

external class
	SYSTEM_IO_FILESTREAM

inherit
	SYSTEM_IO_STREAM
		redefine
			write_byte,
			read_byte,
			end_write,
			begin_write,
			end_read,
			begin_read,
			dispose,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_filestream_8,
	make_filestream,
	make_filestream_2,
	make_filestream_3,
	make_filestream_1,
	make_filestream_6,
	make_filestream_7,
	make_filestream_4,
	make_filestream_5

feature {NONE} -- Initialization

	frozen make_filestream_8 (handle: POINTER; access: SYSTEM_IO_FILEACCESS; owns_handle: BOOLEAN; buffer_size: INTEGER; is_async: BOOLEAN) is
		external
			"IL creator signature (System.IntPtr, System.IO.FileAccess, System.Boolean, System.Int32, System.Boolean) use System.IO.FileStream"
		end

	frozen make_filestream (path: STRING; mode: SYSTEM_IO_FILEMODE) is
		external
			"IL creator signature (System.String, System.IO.FileMode) use System.IO.FileStream"
		end

	frozen make_filestream_2 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare) use System.IO.FileStream"
		end

	frozen make_filestream_3 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE; buffer_size: INTEGER) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare, System.Int32) use System.IO.FileStream"
		end

	frozen make_filestream_1 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess) use System.IO.FileStream"
		end

	frozen make_filestream_6 (handle: POINTER; access: SYSTEM_IO_FILEACCESS; owns_handle: BOOLEAN) is
		external
			"IL creator signature (System.IntPtr, System.IO.FileAccess, System.Boolean) use System.IO.FileStream"
		end

	frozen make_filestream_7 (handle: POINTER; access: SYSTEM_IO_FILEACCESS; owns_handle: BOOLEAN; buffer_size: INTEGER) is
		external
			"IL creator signature (System.IntPtr, System.IO.FileAccess, System.Boolean, System.Int32) use System.IO.FileStream"
		end

	frozen make_filestream_4 (path: STRING; mode: SYSTEM_IO_FILEMODE; access: SYSTEM_IO_FILEACCESS; share: SYSTEM_IO_FILESHARE; buffer_size: INTEGER; use_async: BOOLEAN) is
		external
			"IL creator signature (System.String, System.IO.FileMode, System.IO.FileAccess, System.IO.FileShare, System.Int32, System.Boolean) use System.IO.FileStream"
		end

	frozen make_filestream_5 (handle: POINTER; access: SYSTEM_IO_FILEACCESS) is
		external
			"IL creator signature (System.IntPtr, System.IO.FileAccess) use System.IO.FileStream"
		end

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileStream"
		alias
			"get_Name"
		end

	get_is_async: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileStream"
		alias
			"get_IsAsync"
		end

	get_can_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileStream"
		alias
			"get_CanRead"
		end

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.FileStream"
		alias
			"get_Position"
		end

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileStream"
		alias
			"get_CanSeek"
		end

	get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.FileStream"
		alias
			"get_Length"
		end

	get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.IO.FileStream"
		alias
			"get_Handle"
		end

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileStream"
		alias
			"get_CanWrite"
		end

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.FileStream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	read (array: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.IO.FileStream"
		alias
			"Read"
		end

	read_byte: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.FileStream"
		alias
			"ReadByte"
		end

	end_write (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.FileStream"
		alias
			"EndWrite"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.FileStream"
		alias
			"Close"
		end

	seek (offset: INTEGER_64; origin: SYSTEM_IO_SEEKORIGIN): INTEGER_64 is
		external
			"IL signature (System.Int64, System.IO.SeekOrigin): System.Int64 use System.IO.FileStream"
		alias
			"Seek"
		end

	flush is
		external
			"IL signature (): System.Void use System.IO.FileStream"
		alias
			"Flush"
		end

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.FileStream"
		alias
			"SetLength"
		end

	begin_write (array: ARRAY [INTEGER_8]; offset: INTEGER; num_bytes: INTEGER; user_callback: SYSTEM_ASYNCCALLBACK; state_object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.FileStream"
		alias
			"BeginWrite"
		end

	begin_read (array: ARRAY [INTEGER_8]; offset: INTEGER; num_bytes: INTEGER; user_callback: SYSTEM_ASYNCCALLBACK; state_object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.FileStream"
		alias
			"BeginRead"
		end

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.FileStream"
		alias
			"WriteByte"
		end

	end_read (async_result: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.IO.FileStream"
		alias
			"EndRead"
		end

	lock (position: INTEGER_64; length: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Int64): System.Void use System.IO.FileStream"
		alias
			"Lock"
		end

	write (array: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.FileStream"
		alias
			"Write"
		end

	unlock (position: INTEGER_64; length: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Int64): System.Void use System.IO.FileStream"
		alias
			"Unlock"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.FileStream"
		alias
			"Dispose"
		end

end -- class SYSTEM_IO_FILESTREAM
