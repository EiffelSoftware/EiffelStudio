indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.Encoder"

deferred external class
	SYSTEM_TEXT_ENCODER

feature -- Basic Operations

	get_bytes (chars: ARRAY [CHARACTER]; char_index: INTEGER; char_count: INTEGER; bytes: ARRAY [INTEGER_8]; byte_index: INTEGER; flush: BOOLEAN): INTEGER is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32, System.Byte[], System.Int32, System.Boolean): System.Int32 use System.Text.Encoder"
		alias
			"GetBytes"
		end

	get_byte_count (chars: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER; flush: BOOLEAN): INTEGER is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32, System.Boolean): System.Int32 use System.Text.Encoder"
		alias
			"GetByteCount"
		end

end -- class SYSTEM_TEXT_ENCODER
