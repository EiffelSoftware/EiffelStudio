indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.GridTablesFactory"

external class
	SYSTEM_WINDOWS_FORMS_GRIDTABLESFACTORY

create {NONE}

feature -- Basic Operations

	frozen create_grid_tables (grid_table: SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE; data_source: ANY; data_member: STRING; binding_manager: SYSTEM_WINDOWS_FORMS_BINDINGCONTEXT): ARRAY [SYSTEM_WINDOWS_FORMS_DATAGRIDTABLESTYLE] is
		external
			"IL static signature (System.Windows.Forms.DataGridTableStyle, System.Object, System.String, System.Windows.Forms.BindingContext): System.Windows.Forms.DataGridTableStyle[] use System.Windows.Forms.GridTablesFactory"
		alias
			"CreateGridTables"
		end

end -- class SYSTEM_WINDOWS_FORMS_GRIDTABLESFACTORY
