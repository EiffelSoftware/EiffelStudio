indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.EncoderParameters"

frozen external class
	SYSTEM_DRAWING_IMAGING_ENCODERPARAMETERS

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

	frozen get_param: ARRAY [SYSTEM_DRAWING_IMAGING_ENCODERPARAMETER] is
		external
			"IL signature (): System.Drawing.Imaging.EncoderParameter[] use System.Drawing.Imaging.EncoderParameters"
		alias
			"get_Param"
		end

feature -- Element Change

	frozen set_param (value: ARRAY [SYSTEM_DRAWING_IMAGING_ENCODERPARAMETER]) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.EncoderParameters"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_DRAWING_IMAGING_ENCODERPARAMETERS
