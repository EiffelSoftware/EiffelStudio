indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DataGridCell"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_DATAGRIDCELL

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end



feature -- Initialization

	frozen make_datagridcell (r: INTEGER; c: INTEGER) is
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

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.DataGridCell"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataGridCell"
		alias
			"ToString"
		end

end -- class SYSTEM_WINDOWS_FORMS_DATAGRIDCELL
