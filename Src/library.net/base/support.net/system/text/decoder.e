indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.Decoder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DECODER

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	get_char_count (bytes: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Text.Decoder"
		alias
			"GetCharCount"
		end

	get_chars (bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER; byte_count: INTEGER; chars: NATIVE_ARRAY [CHARACTER]; char_index: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32, System.Char[], System.Int32): System.Int32 use System.Text.Decoder"
		alias
			"GetChars"
		end

end -- class DECODER
