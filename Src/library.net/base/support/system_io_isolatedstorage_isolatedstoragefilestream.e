indexing
	Generator: "Eiffel Emitter 2.5b2"
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
			set_Length,
			seek,
			end_write,
			begin_write,
			end_read,
			begin_read,
			wipe_out,
			close,
			set_position,
			get_position,
			get_length,
			get_can_write,
			get_can_seek,
			get_can_read,
			finalize
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_dispose
		end

create
	make_isolated_storage_file_stream_1,
	make_isolated_storage_file_stream,
	make_isolated_storage_file_stream_6,
	make_isolated_storage_file_stream_7,
	make_isolated_storage_file_stream_4,
	make_isolated_storage_file_stream_5,
	make_isolated_storage_file_stream_2,
	make_isolated_storage_file_stream_3

feature {NONE} -- Initialization

	frozen make_isolated_storage_file_stream_1 (path: STRING; mode: INTEGER; isf: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE) is
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
			"IL creator signature (System.String, enum System.IO.FileMode, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream (path: STRING; mode: INTEGER) is
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
			"IL creator signature (System.String, enum System.IO.FileMode) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_6 (path: STRING; mode: INTEGER; access: INTEGER; share: INTEGER; bufferSize: INTEGER) is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare, System.Int32) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_7 (path: STRING; mode: INTEGER; access: INTEGER; share: INTEGER; bufferSize: INTEGER; isf: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE) is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare, System.Int32, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_4 (path: STRING; mode: INTEGER; access: INTEGER; share: INTEGER) is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_5 (path: STRING; mode: INTEGER; access: INTEGER; share: INTEGER; isf: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE) is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_2 (path: STRING; mode: INTEGER; access: INTEGER) is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

	frozen make_isolated_storage_file_stream_3 (path: STRING; mode: INTEGER; access: INTEGER; isf: SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILE) is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL creator signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, System.IO.IsolatedStorage.IsolatedStorageFile) use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		end

feature -- Access

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_Position"
		end

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_CanWrite"
		end

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"get_CanSeek"
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

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"WriteByte"
		end

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

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"SetLength"
		end

	write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Write"
		end

	end_read (asyncResult: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"EndRead"
		end

	begin_write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; numBytes: INTEGER; userCallback: SYSTEM_ASYNCCALLBACK; stateObject: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"BeginWrite"
		end

	wipe_out is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Flush"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Close"
		end

	seek (offset: INTEGER_64; origin: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int64, enum System.IO.SeekOrigin): System.Int64 use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Seek"
		end

	end_write (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"EndWrite"
		end

	begin_read (buffer: ARRAY [INTEGER_8]; offset: INTEGER; numBytes: INTEGER; userCallback: SYSTEM_ASYNCCALLBACK; stateObject: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"BeginRead"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.IO.IsolatedStorage.IsolatedStorageFileStream"
		alias
			"Finalize"
		end

end -- class SYSTEM_IO_ISOLATEDSTORAGE_ISOLATEDSTORAGEFILESTREAM
