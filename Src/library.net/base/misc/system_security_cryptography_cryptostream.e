indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.CryptoStream"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOSTREAM

inherit
	SYSTEM_IO_STREAM
		redefine
			write,
			read
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_dispose
		end

create
	make_cryptostream

feature {NONE} -- Initialization

	frozen make_cryptostream (stream: SYSTEM_IO_STREAM; transform: SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM; mode: INTEGER) is
			-- Valid values for `mode' are:
			-- Read = 0
			-- Write = 1
		require
			valid_crypto_stream_mode: mode = 0 or mode = 1
		external
			"IL creator signature (System.IO.Stream, System.Security.Cryptography.ICryptoTransform, enum System.Security.Cryptography.CryptoStreamMode) use System.Security.Cryptography.CryptoStream"
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

	close is
		external
			"IL signature (): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Close"
		end

	seek (offset: INTEGER_64; origin: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int64, enum System.IO.SeekOrigin): System.Int64 use System.Security.Cryptography.CryptoStream"
		alias
			"Seek"
		end

	wipe_out is
		external
			"IL signature (): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Flush"
		end

	read (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Security.Cryptography.CryptoStream"
		alias
			"Read"
		end

	write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.CryptoStream"
		alias
			"Write"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOSTREAM
