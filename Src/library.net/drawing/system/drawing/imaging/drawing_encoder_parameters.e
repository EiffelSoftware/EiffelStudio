indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.EncoderParameters"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_ENCODER_PARAMETERS

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
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (count: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Drawing.Imaging.EncoderParameters"
		end

	frozen make_1 is
		external
			"IL creator use System.Drawing.Imaging.EncoderParameters"
		end

feature -- Access

	frozen get_param: NATIVE_ARRAY [DRAWING_ENCODER_PARAMETER] is
		external
			"IL signature (): System.Drawing.Imaging.EncoderParameter[] use System.Drawing.Imaging.EncoderParameters"
		alias
			"get_Param"
		end

feature -- Element Change

	frozen set_param (value: NATIVE_ARRAY [DRAWING_ENCODER_PARAMETER]) is
		external
			"IL signature (System.Drawing.Imaging.EncoderParameter[]): System.Void use System.Drawing.Imaging.EncoderParameters"
		alias
			"set_Param"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.EncoderParameters"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.EncoderParameters"
		alias
			"Dispose"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.EncoderParameters"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Imaging.EncoderParameters"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Imaging.EncoderParameters"
		alias
			"Finalize"
		end

end -- class DRAWING_ENCODER_PARAMETERS
