indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Text.Decoder"

deferred external class
	SYSTEM_TEXT_DECODER

feature -- Basic Operations

	get_char_count (bytes: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Text.Decoder"
		alias
			"GetCharCount"
		end

	get_chars (bytes: ARRAY [INTEGER_8]; byte_index: INTEGER; byte_count: INTEGER; chars: ARRAY [CHARACTER]; char_index: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32, System.Char[], System.Int32): System.Int32 use System.Text.Decoder"
		alias
			"GetChars"
		end

end -- class SYSTEM_TEXT_DECODER
