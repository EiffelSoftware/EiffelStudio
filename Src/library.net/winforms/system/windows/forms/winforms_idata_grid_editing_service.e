indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IDataGridEditingService"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IDATA_GRID_EDITING_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	begin_edit (grid_column: WINFORMS_DATA_GRID_COLUMN_STYLE; row_number: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.DataGridColumnStyle, System.Int32): System.Boolean use System.Windows.Forms.IDataGridEditingService"
		alias
			"BeginEdit"
		end

	end_edit (grid_column: WINFORMS_DATA_GRID_COLUMN_STYLE; row_number: INTEGER; should_abort: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.DataGridColumnStyle, System.Int32, System.Boolean): System.Boolean use System.Windows.Forms.IDataGridEditingService"
		alias
			"EndEdit"
		end

end -- class WINFORMS_IDATA_GRID_EDITING_SERVICE
