indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGrid+HitTestType"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen column_resize: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"8"
		end

	frozen row_resize: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"16"
		end

	frozen cell: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"1"
		end

	frozen parent_rows: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"64"
		end

	frozen row_header: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"4"
		end

	frozen none: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"0"
		end

	frozen caption: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
		external
			"IL enum signature :System.Windows.Forms.DataGrid+HitTestType use System.Windows.Forms.DataGrid+HitTestType"
		alias
			"32"
		end

	frozen column_header: WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID is
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

end -- class WINFORMS_HIT_TEST_TYPE_IN_WINFORMS_DATA_GRID
