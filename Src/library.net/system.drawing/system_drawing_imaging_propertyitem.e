indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.PropertyItem"

frozen external class
	SYSTEM_DRAWING_IMAGING_PROPERTYITEM

create {NONE}

feature -- Access

	frozen get_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.PropertyItem"
		alias
			"get_Id"
		end

	frozen get_value: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Drawing.Imaging.PropertyItem"
		alias
			"get_Value"
		end

	frozen get_type_int16: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.PropertyItem"
		alias
			"get_Type"
		end

	frozen get_len: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.PropertyItem"
		alias
			"get_Len"
		end

feature -- Element Change

	frozen set_id (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.PropertyItem"
		alias
			"set_Id"
		end

	frozen set_len (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.PropertyItem"
		alias
			"set_Len"
		end

	frozen set_value (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Drawing.Imaging.PropertyItem"
		alias
			"set_Value"
		end

	frozen set_type (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.PropertyItem"
		alias
			"set_Type"
		end

end -- class SYSTEM_DRAWING_IMAGING_PROPERTYITEM
