indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataObject"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATA_OBJECT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WINFORMS_IDATA_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (format: SYSTEM_STRING; data: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.String, System.Object) use System.Windows.Forms.DataObject"
		end

	frozen make is
		external
			"IL creator use System.Windows.Forms.DataObject"
		end

	frozen make_1 (data: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.Windows.Forms.DataObject"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataObject"
		alias
			"ToString"
		end

	get_data_present_type (format: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Windows.Forms.DataObject"
		alias
			"GetDataPresent"
		end

	get_data_present_string_boolean (format: SYSTEM_STRING; auto_convert: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.String, System.Boolean): System.Boolean use System.Windows.Forms.DataObject"
		alias
			"GetDataPresent"
		end

	get_data_string_boolean (format: SYSTEM_STRING; auto_convert: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Boolean): System.Object use System.Windows.Forms.DataObject"
		alias
			"GetData"
		end

	get_data_present (format: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Windows.Forms.DataObject"
		alias
			"GetDataPresent"
		end

	get_data_type (format: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.Windows.Forms.DataObject"
		alias
			"GetData"
		end

	set_data_string_boolean (format: SYSTEM_STRING; auto_convert: BOOLEAN; data: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Boolean, System.Object): System.Void use System.Windows.Forms.DataObject"
		alias
			"SetData"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataObject"
		alias
			"GetHashCode"
		end

	get_formats: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Windows.Forms.DataObject"
		alias
			"GetFormats"
		end

	set_data_string_object (format: SYSTEM_STRING; data: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Windows.Forms.DataObject"
		alias
			"SetData"
		end

	set_data (data: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DataObject"
		alias
			"SetData"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.DataObject"
		alias
			"Equals"
		end

	set_data_type (format: TYPE; data: SYSTEM_OBJECT) is
		external
			"IL signature (System.Type, System.Object): System.Void use System.Windows.Forms.DataObject"
		alias
			"SetData"
		end

	get_data (format: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Windows.Forms.DataObject"
		alias
			"GetData"
		end

	get_formats_boolean (auto_convert: BOOLEAN): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.Boolean): System.String[] use System.Windows.Forms.DataObject"
		alias
			"GetFormats"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.DataObject"
		alias
			"Finalize"
		end

end -- class WINFORMS_DATA_OBJECT
