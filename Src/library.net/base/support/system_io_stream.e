indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.Stream"

deferred external class
	SYSTEM_IO_STREAM

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_dispose
		end

feature -- Access

	get_position: INTEGER_64 is
		external
			"IL deferred signature (): System.Int64 use System.IO.Stream"
		alias
			"get_Position"
		end

	frozen null: SYSTEM_IO_STREAM is
		external
			"IL static_field signature :System.IO.Stream use System.IO.Stream"
		alias
			"Null"
		end

	get_can_write: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IO.Stream"
		alias
			"get_CanWrite"
		end

	get_can_Seek: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IO.Stream"
		alias
			"get_CanSeek"
		end

	get_length: INTEGER_64 is
		external
			"IL deferred signature (): System.Int64 use System.IO.Stream"
		alias
			"get_Length"
		end

	get_can_read: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IO.Stream"
		alias
			"get_CanRead"
		end

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL deferred signature (System.Int64): System.Void use System.IO.Stream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.Stream"
		alias
			"WriteByte"
		end

	read (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.IO.Stream"
		alias
			"Read"
		end

	read_byte: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.Stream"
		alias
			"ReadByte"
		end

	set_length (value: INTEGER_64) is
		external
			"IL deferred signature (System.Int64): System.Void use System.IO.Stream"
		alias
			"SetLength"
		end

	write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.Stream"
		alias
			"Write"
		end

	end_read (asyncResult: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.IO.Stream"
		alias
			"EndRead"
		end

	begin_write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER; callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.Stream"
		alias
			"BeginWrite"
		end

	wipe_out is
		external
			"IL deferred signature (): System.Void use System.IO.Stream"
		alias
			"Flush"
		end

	close is
		external
			"IL deferred signature (): System.Void use System.IO.Stream"
		alias
			"Close"
		end

	seek (offset: INTEGER_64; origin: INTEGER): INTEGER_64 is
			-- Valid values for `origin' are:
			-- Begin = 0
			-- Current = 1
			-- End = 2
		require
			valid_seek_origin: origin = 0 or origin = 1 or origin = 2
		external
			"IL deferred signature (System.Int64, enum System.IO.SeekOrigin): System.Int64 use System.IO.Stream"
		alias
			"Seek"
		end

	end_write (asyncResult: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.Stream"
		alias
			"EndWrite"
		end

	begin_read (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER; callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.Stream"
		alias
			"BeginRead"
		end

feature {NONE} -- Implementation

	create_wait_handle: SYSTEM_THREADING_WAITHANDLE is
		external
			"IL signature (): System.Threading.WaitHandle use System.IO.Stream"
		alias
			"CreateWaitHandle"
		end

	frozen disposable_dispose is
		external
			"IL signature (): System.Void use System.IO.Stream"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_IO_STREAM
