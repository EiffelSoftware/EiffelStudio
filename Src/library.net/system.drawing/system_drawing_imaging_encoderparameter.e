indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.EncoderParameter"

frozen external class
	SYSTEM_DRAWING_IMAGING_ENCODERPARAMETER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE

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
	make_9,
	make_8,
	make_12

feature {NONE} -- Initialization

	frozen make_13 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; rangebegin: ARRAY [INTEGER_64]; rangeend: ARRAY [INTEGER_64]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int64[], System.Int64[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_10 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: ARRAY [INTEGER_16]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int16[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_11 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: ARRAY [INTEGER_64]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int64[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: INTEGER_8) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Byte) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_7 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: STRING) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.String) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_6 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; numerator1: INTEGER; demoninator1: INTEGER; numerator2: INTEGER; demoninator2: INTEGER) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32, System.Int32, System.Int32, System.Int32) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_5 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; rangebegin: INTEGER_64; rangeend: INTEGER_64) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int64, System.Int64) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_4 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; numerator: INTEGER; demoninator: INTEGER) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32, System.Int32) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_3 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: INTEGER_64) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int64) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_2 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: INTEGER_16) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int16) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_1 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: INTEGER_8; undefined: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Byte, System.Boolean) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_14 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; numerator1: ARRAY [INTEGER]; denominator1: ARRAY [INTEGER]; numerator2: ARRAY [INTEGER]; denominator2: ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32[], System.Int32[], System.Int32[], System.Int32[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_9 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: ARRAY [INTEGER_8]; undefined: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Byte[], System.Boolean) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_8 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; value: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Byte[]) use System.Drawing.Imaging.EncoderParameter"
		end

	frozen make_12 (encoder: SYSTEM_DRAWING_IMAGING_ENCODER; numerator: ARRAY [INTEGER]; denominator: ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Drawing.Imaging.Encoder, System.Int32[], System.Int32[]) use System.Drawing.Imaging.EncoderParameter"
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.EncoderParameter"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_DRAWING_IMAGING_ENCODERPARAMETER
