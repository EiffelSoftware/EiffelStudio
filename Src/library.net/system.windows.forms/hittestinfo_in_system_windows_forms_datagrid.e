indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DataGrid+HitTestInfo"

frozen external class
	HITTESTINFO_IN_SYSTEM_WINDOWS_FORMS_DATAGRID

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create {NONE}

feature -- Access

	frozen nowhere: HITTESTINFO_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL static_field signature :System.Windows.Forms.DataGrid+HitTestInfo use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"Nowhere"
		end

	frozen get_column: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"get_Column"
		end

	frozen get_type_hit_test_type: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL signature (): System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"get_Type"
		end

	frozen get_row: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"get_Row"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"GetHashCode"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"ToString"
		end

end -- class HITTESTINFO_IN_SYSTEM_WINDOWS_FORMS_DATAGRID
