indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DataObject"

external class
	SYSTEM_WINDOWS_FORMS_DATAOBJECT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WINDOWS_FORMS_IDATAOBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (format: STRING; data: ANY) is
		external
			"IL creator signature (System.String, System.Object) use System.Windows.Forms.DataObject"
		end

	frozen make is
		external
			"IL creator use System.Windows.Forms.DataObject"
		end

	frozen make_1 (data: ANY) is
		external
			"IL creator signature (System.Object) use System.Windows.Forms.DataObject"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataObject"
		alias
			"ToString"
		end

	get_data_present_type (format: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Windows.Forms.DataObject"
		alias
			"GetDataPresent"
		end

	get_data_present_string_boolean (format: STRING; auto_convert: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.String, System.Boolean): System.Boolean use System.Windows.Forms.DataObject"
		alias
			"GetDataPresent"
		end

	get_data_string_boolean (format: STRING; auto_convert: BOOLEAN): ANY is
		external
			"IL signature (System.String, System.Boolean): System.Object use System.Windows.Forms.DataObject"
		alias
			"GetData"
		end

	get_data_present (format: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Windows.Forms.DataObject"
		alias
			"GetDataPresent"
		end

	get_data_type (format: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.Windows.Forms.DataObject"
		alias
			"GetData"
		end

	set_data_string_boolean (format: STRING; auto_convert: BOOLEAN; data: ANY) is
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

	get_formats: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Windows.Forms.DataObject"
		alias
			"GetFormats"
		end

	set_data_string_object (format: STRING; data: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Windows.Forms.DataObject"
		alias
			"SetData"
		end

	set_data (data: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DataObject"
		alias
			"SetData"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.DataObject"
		alias
			"Equals"
		end

	set_data_type (format: SYSTEM_TYPE; data: ANY) is
		external
			"IL signature (System.Type, System.Object): System.Void use System.Windows.Forms.DataObject"
		alias
			"SetData"
		end

	get_data (format: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Windows.Forms.DataObject"
		alias
			"GetData"
		end

	get_formats_boolean (auto_convert: BOOLEAN): ARRAY [STRING] is
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

end -- class SYSTEM_WINDOWS_FORMS_DATAOBJECT
