indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IDataObject"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IDATA_OBJECT

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_data_present_type (format: TYPE): BOOLEAN is
		external
			"IL deferred signature (System.Type): System.Boolean use System.Windows.Forms.IDataObject"
		alias
			"GetDataPresent"
		end

	get_data_present_string_boolean (format: SYSTEM_STRING; auto_convert: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.String, System.Boolean): System.Boolean use System.Windows.Forms.IDataObject"
		alias
			"GetDataPresent"
		end

	get_data_string_boolean (format: SYSTEM_STRING; auto_convert: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.Boolean): System.Object use System.Windows.Forms.IDataObject"
		alias
			"GetData"
		end

	get_data_present (format: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Windows.Forms.IDataObject"
		alias
			"GetDataPresent"
		end

	get_data_type (format: TYPE): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Type): System.Object use System.Windows.Forms.IDataObject"
		alias
			"GetData"
		end

	set_data_string_boolean (format: SYSTEM_STRING; auto_convert: BOOLEAN; data: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.String, System.Boolean, System.Object): System.Void use System.Windows.Forms.IDataObject"
		alias
			"SetData"
		end

	get_formats: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL deferred signature (): System.String[] use System.Windows.Forms.IDataObject"
		alias
			"GetFormats"
		end

	set_data_string_object (format: SYSTEM_STRING; data: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Windows.Forms.IDataObject"
		alias
			"SetData"
		end

	set_data (data: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Windows.Forms.IDataObject"
		alias
			"SetData"
		end

	set_data_type (format: TYPE; data: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Type, System.Object): System.Void use System.Windows.Forms.IDataObject"
		alias
			"SetData"
		end

	get_data (format: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String): System.Object use System.Windows.Forms.IDataObject"
		alias
			"GetData"
		end

	get_formats_boolean (auto_convert: BOOLEAN): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL deferred signature (System.Boolean): System.String[] use System.Windows.Forms.IDataObject"
		alias
			"GetFormats"
		end

end -- class WINFORMS_IDATA_OBJECT
