indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DataGrid+HitTestType"
	enum_type: "INTEGER"

frozen expanded external class
	HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen column_resize: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"8"
		end

	frozen row_resize: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"16"
		end

	frozen cell: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"1"
		end

	frozen parent_rows: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"64"
		end

	frozen row_header: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"4"
		end

	frozen none: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"0"
		end

	frozen caption: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"32"
		end

	frozen column_header: HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class HITTESTTYPE_IN_SYSTEM_WINDOWS_FORMS_DATAGRID
