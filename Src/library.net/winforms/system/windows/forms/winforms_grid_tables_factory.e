indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.GridTablesFactory"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_GRID_TABLES_FACTORY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen create_grid_tables (grid_table: WINFORMS_DATA_GRID_TABLE_STYLE; data_source: SYSTEM_OBJECT; data_member: SYSTEM_STRING; binding_manager: WINFORMS_BINDING_CONTEXT): NATIVE_ARRAY [WINFORMS_DATA_GRID_TABLE_STYLE] is
		external
			"IL static signature (System.Windows.Forms.DataGridTableStyle, System.Object, System.String, System.Windows.Forms.BindingContext): System.Windows.Forms.DataGridTableStyle[] use System.Windows.Forms.GridTablesFactory"
		alias
			"CreateGridTables"
		end

end -- class WINFORMS_GRID_TABLES_FACTORY
