indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.FileStream"

external class
	SYSTEM_IO_FILESTREAM

inherit
	SYSTEM_IO_STREAM
		redefine
			write_byte,
			write,
			read_byte,
			read,
			end_write,
			begin_write,
			end_read,
			begin_read,
			finalize
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_dispose
		end

create
	make_file_stream_8,
	make_file_stream,
	make_file_stream_2,
	make_file_stream_3,
	make_file_stream_1,
	make_file_stream_6,
	make_file_stream_7,
	make_file_stream_4,
	make_file_stream_5

feature {NONE} -- Initialization

	frozen make_file_stream_8 (handle2: POINTER; access: INTEGER; ownsHandle: BOOLEAN; bufferSize: INTEGER; isAsync2: BOOLEAN) is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL creator signature (System.IntPtr, enum System.IO.FileAccess, System.Boolean, System.Int32, System.Boolean) use System.IO.FileStream"
		end

	frozen make_file_stream (path: STRING; mode: INTEGER) is
			-- Valid values for `mode' are:
			-- CreateNew = 1
			-- Create = 2
			-- Open = 3
			-- OpenOrCreate = 4
			-- Truncate = 5
			-- Append = 6
		require
			valid_file_mode: mode = 1 or mode = 2 or mode = 3 or mode = 4 or mode = 5 or mode = 6
		external
			"IL creator signature (System.String, enum System.IO.FileMode) use System.IO.FileStream"
		end

	frozen make_file_stream_2 (path: STRING; mode: INTEGER; access: INTEGER; share: INTEGER) is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare) use System.IO.FileStream"
		end

	frozen make_file_stream_3 (path: STRING; mode: INTEGER; access: INTEGER; share: INTEGER; bufferSize: INTEGER) is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare, System.Int32) use System.IO.FileStream"
		end

	frozen make_file_stream_1 (path: STRING; mode: INTEGER; access: INTEGER) is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess) use System.IO.FileStream"
		end

	frozen make_file_stream_6 (handle2: POINTER; access: INTEGER; ownsHandle: BOOLEAN) is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL creator signature (System.IntPtr, enum System.IO.FileAccess, System.Boolean) use System.IO.FileStream"
		end

	frozen make_file_stream_7 (handle2: POINTER; access: INTEGER; ownsHandle: BOOLEAN; bufferSize: INTEGER) is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL creator signature (System.IntPtr, enum System.IO.FileAccess, System.Boolean, System.Int32) use System.IO.FileStream"
		end

	frozen make_file_stream_4 (path: STRING; mode: INTEGER; access: INTEGER; share: INTEGER; bufferSize: INTEGER; useAsync: BOOLEAN) is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare, System.Int32, System.Boolean) use System.IO.FileStream"
		end

	frozen make_file_stream_5 (handle2: POINTER; access: INTEGER) is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL creator signature (System.IntPtr, enum System.IO.FileAccess) use System.IO.FileStream"
		end

feature -- Access

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileStream"
		alias
			"get_CanSeek"
		end

	get_can_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileStream"
		alias
			"get_CanRead"
		end

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileStream"
		alias
			"get_CanWrite"
		end

	get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.IO.FileStream"
		alias
			"get_Handle"
		end

	get_is_async: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.FileStream"
		alias
			"get_IsAsync"
		end

	get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.FileStream"
		alias
			"get_Length"
		end

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.FileStream"
		alias
			"get_Position"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileStream"
		alias
			"get_Name"
		end

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.FileStream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	close is
		external
			"IL signature (): System.Void use System.IO.FileStream"
		alias
			"Close"
		end

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.FileStream"
		alias
			"WriteByte"
		end

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

	unlock (position2: INTEGER_64; length2: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Int64): System.Void use System.IO.FileStream"
		alias
			"Unlock"
		end

	write (array: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.FileStream"
		alias
			"Write"
		end

	end_read (asyncResult: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.IO.FileStream"
		alias
			"EndRead"
		end

	begin_write (array: ARRAY [INTEGER_8]; offset: INTEGER; numBytes: INTEGER; userCallback: SYSTEM_ASYNCCALLBACK; stateObject: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.FileStream"
		alias
			"BeginWrite"
		end

	wipe_out is
		external
			"IL signature (): System.Void use System.IO.FileStream"
		alias
			"Flush"
		end

	lock (position2: INTEGER_64; length2: INTEGER_64) is
		external
			"IL signature (System.Int64, System.Int64): System.Void use System.IO.FileStream"
		alias
			"Lock"
		end

	seek (offset: INTEGER_64; origin: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int64, enum System.IO.SeekOrigin): System.Int64 use System.IO.FileStream"
		alias
			"Seek"
		end

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.FileStream"
		alias
			"SetLength"
		end

	end_write (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.FileStream"
		alias
			"EndWrite"
		end

	begin_read (array: ARRAY [INTEGER_8]; offset: INTEGER; numBytes: INTEGER; userCallback: SYSTEM_ASYNCCALLBACK; stateObject: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.FileStream"
		alias
			"BeginRead"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.IO.FileStream"
		alias
			"Finalize"
		end

end -- class SYSTEM_IO_FILESTREAM
