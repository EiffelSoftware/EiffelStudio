indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Buffer"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	BUFFER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen get_byte (array: SYSTEM_ARRAY; index: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.Array, System.Int32): System.Byte use System.Buffer"
		alias
			"GetByte"
		end

	frozen byte_length (array: SYSTEM_ARRAY): INTEGER is
		external
			"IL static signature (System.Array): System.Int32 use System.Buffer"
		alias
			"ByteLength"
		end

	frozen set_byte (array: SYSTEM_ARRAY; index: INTEGER; value: INTEGER_8) is
		external
			"IL static signature (System.Array, System.Int32, System.Byte): System.Void use System.Buffer"
		alias
			"SetByte"
		end

	frozen block_copy (src: SYSTEM_ARRAY; src_offset: INTEGER; dst: SYSTEM_ARRAY; dst_offset: INTEGER; count: INTEGER) is
		external
			"IL static signature (System.Array, System.Int32, System.Array, System.Int32, System.Int32): System.Void use System.Buffer"
		alias
			"BlockCopy"
		end

end -- class BUFFER
