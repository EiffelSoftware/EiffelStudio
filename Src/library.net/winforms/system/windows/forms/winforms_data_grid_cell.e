indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataGridCell"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	WINFORMS_DATA_GRID_CELL

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_winforms_data_grid_cell (r: INTEGER; c: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Windows.Forms.DataGridCell"
		end

feature -- Access

	frozen get_column_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridCell"
		alias
			"get_ColumnNumber"
		end

	frozen get_row_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridCell"
		alias
			"get_RowNumber"
		end

feature -- Element Change

	frozen set_column_number (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGridCell"
		alias
			"set_ColumnNumber"
		end

	frozen set_row_number (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DataGridCell"
		alias
			"set_RowNumber"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataGridCell"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGridCell"
		alias
			"ToString"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.DataGridCell"
		alias
			"Equals"
		end

end -- class WINFORMS_DATA_GRID_CELL
