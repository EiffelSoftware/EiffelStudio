indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.PropertyItem"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PROPERTY_ITEM

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.PropertyItem"
		alias
			"get_Id"
		end

	frozen get_value: NATIVE_ARRAY [INTEGER_8] is
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

	frozen set_value (value: NATIVE_ARRAY [INTEGER_8]) is
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

end -- class DRAWING_PROPERTY_ITEM
