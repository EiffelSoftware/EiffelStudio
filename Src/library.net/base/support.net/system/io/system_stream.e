indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.Stream"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_STREAM

inherit
	MARSHAL_BY_REF_OBJECT
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	get_can_write: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IO.Stream"
		alias
			"get_CanWrite"
		end

	frozen null: SYSTEM_STREAM is
		external
			"IL static_field signature :System.IO.Stream use System.IO.Stream"
		alias
			"Null"
		end

	get_length: INTEGER_64 is
		external
			"IL deferred signature (): System.Int64 use System.IO.Stream"
		alias
			"get_Length"
		end

	get_can_seek: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IO.Stream"
		alias
			"get_CanSeek"
		end

	get_position: INTEGER_64 is
		external
			"IL deferred signature (): System.Int64 use System.IO.Stream"
		alias
			"get_Position"
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

	read (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.IO.Stream"
		alias
			"Read"
		end

	read_byte: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.Stream"
		alias
			"ReadByte"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.Stream"
		alias
			"Close"
		end

	set_length (value: INTEGER_64) is
		external
			"IL deferred signature (System.Int64): System.Void use System.IO.Stream"
		alias
			"SetLength"
		end

	flush is
		external
			"IL deferred signature (): System.Void use System.IO.Stream"
		alias
			"Flush"
		end

	end_write (async_result: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.Stream"
		alias
			"EndWrite"
		end

	begin_write (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.Stream"
		alias
			"BeginWrite"
		end

	begin_read (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.Stream"
		alias
			"BeginRead"
		end

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.Stream"
		alias
			"WriteByte"
		end

	end_read (async_result: IASYNC_RESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.IO.Stream"
		alias
			"EndRead"
		end

	write (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.Stream"
		alias
			"Write"
		end

	seek (offset: INTEGER_64; origin: SEEK_ORIGIN): INTEGER_64 is
		external
			"IL deferred signature (System.Int64, System.IO.SeekOrigin): System.Int64 use System.IO.Stream"
		alias
			"Seek"
		end

feature {NONE} -- Implementation

	create_wait_handle: WAIT_HANDLE is
		external
			"IL signature (): System.Threading.WaitHandle use System.IO.Stream"
		alias
			"CreateWaitHandle"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.IO.Stream"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_STREAM
