indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.CryptoStream"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CRYPTO_STREAM

inherit
	SYSTEM_STREAM
		redefine
			close,
			finalize
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose_void
		select
			system_idisposable_dispose_void
		end

create
	make_crypto_stream

feature {NONE} -- Initialization

	frozen make_crypto_stream (stream: SYSTEM_STREAM; transform: ICRYPTO_TRANSFORM; mode: CRYPTO_STREAM_MODE) is
		external
			"IL creator signature (System.IO.Stream, System.Security.Cryptography.ICryptoTransform, System.Security.Cryptography.CryptoStreamMode) use System.Security.Cryptography.CryptoStream"
		end

feature -- Access

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.CryptoStream"
		alias
			"get_CanWrite"
		end

	get_can_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.CryptoStream"
		alias
			"get_CanRead"
		end

	get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Security.Cryptography.CryptoStream"
		alias
			"get_Length"
		end

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.CryptoStream"
		alias
			"get_CanSeek"
		end

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Security.Cryptography.CryptoStream"
		alias
			"get_Position"
		end

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	read (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Security.Cryptography.CryptoStream"
		alias
			"Read"
		end

	close is
		external
			"IL signature (): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Close"
		end

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"SetLength"
		end

	frozen flush_final_block is
		external
			"IL signature (): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"FlushFinalBlock"
		end

	flush is
		external
			"IL signature (): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Flush"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Clear"
		end

	write (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Write"
		end

	seek (offset: INTEGER_64; origin: SEEK_ORIGIN): INTEGER_64 is
		external
			"IL signature (System.Int64, System.IO.SeekOrigin): System.Int64 use System.Security.Cryptography.CryptoStream"
		alias
			"Seek"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose_void is
		external
			"IL signature (): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"System.IDisposable.Dispose"
		end

end -- class CRYPTO_STREAM
