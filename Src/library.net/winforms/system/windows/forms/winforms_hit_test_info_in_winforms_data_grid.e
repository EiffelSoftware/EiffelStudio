indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGrid+HitTestInfo"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_HIT_TEST_INFO_IN_WINFORMS_DATA_GRID

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

	frozen nowhere: WINFORMS_HIT_TEST_INFO_IN_WINFORMS_DATA_GRID is
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

	frozen get_type_hit_test_type: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"ToString"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.DataGrid+HitTestInfo"
		alias
			"Equals"
		end

end -- class WINFORMS_HIT_TEST_INFO_IN_WINFORMS_DATA_GRID
