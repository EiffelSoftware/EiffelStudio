indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.Encoder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ENCODER

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	get_bytes (chars: NATIVE_ARRAY [CHARACTER]; char_index: INTEGER; char_count: INTEGER; bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER; flush: BOOLEAN): INTEGER is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32, System.Byte[], System.Int32, System.Boolean): System.Int32 use System.Text.Encoder"
		alias
			"GetBytes"
		end

	get_byte_count (chars: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER; flush: BOOLEAN): INTEGER is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32, System.Boolean): System.Int32 use System.Text.Encoder"
		alias
			"GetByteCount"
		end

end -- class ENCODER
