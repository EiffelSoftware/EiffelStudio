indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.IDataGridEditingService"

deferred external class
	SYSTEM_WINDOWS_FORMS_IDATAGRIDEDITINGSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	begin_edit (grid_column: SYSTEM_WINDOWS_FORMS_DATAGRIDCOLUMNSTYLE; row_number: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.DataGridColumnStyle, System.Int32): System.Boolean use System.Windows.Forms.IDataGridEditingService"
		alias
			"BeginEdit"
		end

	end_edit (grid_column: SYSTEM_WINDOWS_FORMS_DATAGRIDCOLUMNSTYLE; row_number: INTEGER; should_abort: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.Windows.Forms.DataGridColumnStyle, System.Int32, System.Boolean): System.Boolean use System.Windows.Forms.IDataGridEditingService"
		alias
			"EndEdit"
		end

end -- class SYSTEM_WINDOWS_FORMS_IDATAGRIDEDITINGSERVICE
