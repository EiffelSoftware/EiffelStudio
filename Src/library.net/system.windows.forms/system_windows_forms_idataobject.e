indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IDataObject"

deferred external class
	SYSTEM_WINDOWS_FORMS_IDATAOBJECT

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_data_present_type (format: SYSTEM_TYPE): BOOLEAN is
		external
			"IL deferred signature (System.Type): System.Boolean use System.Windows.Forms.IDataObject"
		alias
			"GetDataPresent"
		end

	get_data_present_string_boolean (format: STRING; auto_convert: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.String, System.Boolean): System.Boolean use System.Windows.Forms.IDataObject"
		alias
			"GetDataPresent"
		end

	get_data_string_boolean (format: STRING; auto_convert: BOOLEAN): ANY is
		external
			"IL deferred signature (System.String, System.Boolean): System.Object use System.Windows.Forms.IDataObject"
		alias
			"GetData"
		end

	get_data_present (format: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Windows.Forms.IDataObject"
		alias
			"GetDataPresent"
		end

	get_data_type (format: SYSTEM_TYPE): ANY is
		external
			"IL deferred signature (System.Type): System.Object use System.Windows.Forms.IDataObject"
		alias
			"GetData"
		end

	set_data_string_boolean (format: STRING; auto_convert: BOOLEAN; data: ANY) is
		external
			"IL deferred signature (System.String, System.Boolean, System.Object): System.Void use System.Windows.Forms.IDataObject"
		alias
			"SetData"
		end

	get_formats: ARRAY [STRING] is
		external
			"IL deferred signature (): System.String[] use System.Windows.Forms.IDataObject"
		alias
			"GetFormats"
		end

	set_data_string_object (format: STRING; data: ANY) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Windows.Forms.IDataObject"
		alias
			"SetData"
		end

	set_data (data: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Windows.Forms.IDataObject"
		alias
			"SetData"
		end

	set_data_type (format: SYSTEM_TYPE; data: ANY) is
		external
			"IL deferred signature (System.Type, System.Object): System.Void use System.Windows.Forms.IDataObject"
		alias
			"SetData"
		end

	get_data (format: STRING): ANY is
		external
			"IL deferred signature (System.String): System.Object use System.Windows.Forms.IDataObject"
		alias
			"GetData"
		end

	get_formats_boolean (auto_convert: BOOLEAN): ARRAY [STRING] is
		external
			"IL deferred signature (System.Boolean): System.String[] use System.Windows.Forms.IDataObject"
		alias
			"GetFormats"
		end

end -- class SYSTEM_WINDOWS_FORMS_IDATAOBJECT
