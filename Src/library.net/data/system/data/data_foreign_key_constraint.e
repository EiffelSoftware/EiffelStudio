indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.ForeignKeyConstraint"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_FOREIGN_KEY_CONSTRAINT

inherit
	DATA_CONSTRAINT
		redefine
			get_hash_code,
			equals
		end

create
	make_data_foreign_key_constraint_1,
	make_data_foreign_key_constraint,
	make_data_foreign_key_constraint_4,
	make_data_foreign_key_constraint_3,
	make_data_foreign_key_constraint_2

feature {NONE} -- Initialization

	frozen make_data_foreign_key_constraint_1 (constraint_name: SYSTEM_STRING; parent_column: DATA_DATA_COLUMN; child_column: DATA_DATA_COLUMN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn, System.Data.DataColumn) use System.Data.ForeignKeyConstraint"
		end

	frozen make_data_foreign_key_constraint (parent_column: DATA_DATA_COLUMN; child_column: DATA_DATA_COLUMN) is
		external
			"IL creator signature (System.Data.DataColumn, System.Data.DataColumn) use System.Data.ForeignKeyConstraint"
		end

	frozen make_data_foreign_key_constraint_4 (constraint_name: SYSTEM_STRING; parent_table_name: SYSTEM_STRING; parent_column_names: NATIVE_ARRAY [SYSTEM_STRING]; child_column_names: NATIVE_ARRAY [SYSTEM_STRING]; accept_reject_rule: DATA_ACCEPT_REJECT_RULE; delete_rule: DATA_RULE; update_rule: DATA_RULE) is
		external
			"IL creator signature (System.String, System.String, System.String[], System.String[], System.Data.AcceptRejectRule, System.Data.Rule, System.Data.Rule) use System.Data.ForeignKeyConstraint"
		end

	frozen make_data_foreign_key_constraint_3 (constraint_name: SYSTEM_STRING; parent_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; child_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[]) use System.Data.ForeignKeyConstraint"
		end

	frozen make_data_foreign_key_constraint_2 (parent_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; child_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]) is
		external
			"IL creator signature (System.Data.DataColumn[], System.Data.DataColumn[]) use System.Data.ForeignKeyConstraint"
		end

feature -- Access

	get_columns: NATIVE_ARRAY [DATA_DATA_COLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.ForeignKeyConstraint"
		alias
			"get_Columns"
		end

	get_related_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.ForeignKeyConstraint"
		alias
			"get_RelatedTable"
		end

	get_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.ForeignKeyConstraint"
		alias
			"get_Table"
		end

	get_delete_rule: DATA_RULE is
		external
			"IL signature (): System.Data.Rule use System.Data.ForeignKeyConstraint"
		alias
			"get_DeleteRule"
		end

	get_related_columns: NATIVE_ARRAY [DATA_DATA_COLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.ForeignKeyConstraint"
		alias
			"get_RelatedColumns"
		end

	get_accept_reject_rule: DATA_ACCEPT_REJECT_RULE is
		external
			"IL signature (): System.Data.AcceptRejectRule use System.Data.ForeignKeyConstraint"
		alias
			"get_AcceptRejectRule"
		end

	get_update_rule: DATA_RULE is
		external
			"IL signature (): System.Data.Rule use System.Data.ForeignKeyConstraint"
		alias
			"get_UpdateRule"
		end

feature -- Element Change

	set_delete_rule (value: DATA_RULE) is
		external
			"IL signature (System.Data.Rule): System.Void use System.Data.ForeignKeyConstraint"
		alias
			"set_DeleteRule"
		end

	set_update_rule (value: DATA_RULE) is
		external
			"IL signature (System.Data.Rule): System.Void use System.Data.ForeignKeyConstraint"
		alias
			"set_UpdateRule"
		end

	set_accept_reject_rule (value: DATA_ACCEPT_REJECT_RULE) is
		external
			"IL signature (System.Data.AcceptRejectRule): System.Void use System.Data.ForeignKeyConstraint"
		alias
			"set_AcceptRejectRule"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.ForeignKeyConstraint"
		alias
			"GetHashCode"
		end

	equals (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.ForeignKeyConstraint"
		alias
			"Equals"
		end

end -- class DATA_FOREIGN_KEY_CONSTRAINT
