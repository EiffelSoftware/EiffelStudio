indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.EncoderParameter"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_ENCODER_PARAMETER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE

create
	make_13,
	make_10,
	make_11,
	make,
	make_7,
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make_1,
	make_14,
	make_15,
	make_9,
	make_8,
	make_12

feature {NONE} -- Initialization

	frozen make_13 (encoder: DRAWING_ENCODER; rangebegin: NATIVE_ARRAY [INTEGER_64]; rangeend: NATIVE_ARRAY [INTEGER_64]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int64[], System.Int64[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_10 (encoder: DRAWING_ENCODER; value: NATIVE_ARRAY [INTEGER_16]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int16[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_11 (encoder: DRAWING_ENCODER; value: NATIVE_ARRAY [INTEGER_64]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int64[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make (encoder: DRAWING_ENCODER; value: INTEGER_8) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Byte) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_7 (encoder: DRAWING_ENCODER; value: SYSTEM_STRING) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.String) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_6 (encoder: DRAWING_ENCODER; numerator1: INTEGER; demoninator1: INTEGER; numerator2: INTEGER; demoninator2: INTEGER) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32, System.Int32, System.Int32, System.Int32) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_5 (encoder: DRAWING_ENCODER; rangebegin: INTEGER_64; rangeend: INTEGER_64) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int64, System.Int64) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_4 (encoder: DRAWING_ENCODER; numerator: INTEGER; demoninator: INTEGER) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32, System.Int32) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_3 (encoder: DRAWING_ENCODER; value: INTEGER_64) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int64) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_2 (encoder: DRAWING_ENCODER; value: INTEGER_16) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int16) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_1 (encoder: DRAWING_ENCODER; value: INTEGER_8; undefined: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Byte, System.Boolean) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_14 (encoder: DRAWING_ENCODER; numerator1: NATIVE_ARRAY [INTEGER]; denominator1: NATIVE_ARRAY [INTEGER]; numerator2: NATIVE_ARRAY [INTEGER]; denominator2: NATIVE_ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32[], System.Int32[], System.Int32[], System.Int32[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_15 (encoder: DRAWING_ENCODER; number_of_values: INTEGER; type: INTEGER; value: INTEGER) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32, System.Int32, System.Int32) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_9 (encoder: DRAWING_ENCODER; value: NATIVE_ARRAY [INTEGER_8]; undefined: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Byte[], System.Boolean) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_8 (encoder: DRAWING_ENCODER; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Byte[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_12 (encoder: DRAWING_ENCODER; numerator: NATIVE_ARRAY [INTEGER]; denominator: NATIVE_ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32[], System.Int32[]) use System.Drawing.Imaging.EncoderParameter"
		end

feature -- Access

	frozen get_number_of_values: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.EncoderParameter"
		alias
			"get_NumberOfValues"
		end

	frozen get_encoder: DRAWING_ENCODER is
		external
			"IL signature (): System.Drawing.Imaging.Encoder use System.Drawing.Imaging.EncoderParameter"
		alias
			"get_Encoder"
		end

	frozen get_type_encoder_parameter_value_type: DRAWING_ENCODER_PARAMETER_VALUE_TYPE is
		external
			"IL signature (): System.Drawing.Imaging.EncoderParameterValueType use System.Drawing.Imaging.EncoderParameter"
		alias
			"get_Type"
		end

	frozen get_value_type: DRAWING_ENCODER_PARAMETER_VALUE_TYPE is
		external
			"IL signature (): System.Drawing.Imaging.EncoderParameterValueType use System.Drawing.Imaging.EncoderParameter"
		alias
			"get_ValueType"
		end

feature -- Element Change

	frozen set_encoder (value: DRAWING_ENCODER) is
		external
			"IL signature (System.Drawing.Imaging.Encoder): System.Void use System.Drawing.Imaging.EncoderParameter"
		alias
			"set_Encoder"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.EncoderParameter"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.EncoderParameter"
		alias
			"Dispose"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.EncoderParameter"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Imaging.EncoderParameter"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.EncoderParameter"
		alias
			"Finalize"
		end

end -- class DRAWING_ENCODER_PARAMETER
