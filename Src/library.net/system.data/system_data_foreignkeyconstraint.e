indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.ForeignKeyConstraint"

external class
	SYSTEM_DATA_FOREIGNKEYCONSTRAINT

inherit
	SYSTEM_DATA_CONSTRAINT
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object
		end

create
	make_foreignkeyconstraint_1,
	make_foreignkeyconstraint_2,
	make_foreignkeyconstraint_3,
	make_foreignkeyconstraint,
	make_foreignkeyconstraint_4

feature {NONE} -- Initialization

	frozen make_foreignkeyconstraint_1 (constraint_name: STRING; parent_column: SYSTEM_DATA_DATACOLUMN; child_column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn, System.Data.DataColumn) use System.Data.ForeignKeyConstraint"
		end

	frozen make_foreignkeyconstraint_2 (parent_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; child_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]) is
		external
			"IL creator signature (System.Data.DataColumn[], System.Data.DataColumn[]) use System.Data.ForeignKeyConstraint"
		end

	frozen make_foreignkeyconstraint_3 (constraint_name: STRING; parent_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; child_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[]) use System.Data.ForeignKeyConstraint"
		end

	frozen make_foreignkeyconstraint (parent_column: SYSTEM_DATA_DATACOLUMN; child_column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL creator signature (System.Data.DataColumn, System.Data.DataColumn) use System.Data.ForeignKeyConstraint"
		end

	frozen make_foreignkeyconstraint_4 (constraint_name: STRING; parent_table_name: STRING; parent_column_names: ARRAY [STRING]; child_column_names: ARRAY [STRING]; accept_reject_rule: SYSTEM_DATA_ACCEPTREJECTRULE; delete_rule: SYSTEM_DATA_RULE; update_rule: SYSTEM_DATA_RULE) is
		external
			"IL creator signature (System.String, System.String, System.String[], System.String[], System.Data.AcceptRejectRule, System.Data.Rule, System.Data.Rule) use System.Data.ForeignKeyConstraint"
		end

feature -- Access

	get_columns: ARRAY [SYSTEM_DATA_DATACOLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.ForeignKeyConstraint"
		alias
			"get_Columns"
		end

	get_related_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.ForeignKeyConstraint"
		alias
			"get_RelatedTable"
		end

	get_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.ForeignKeyConstraint"
		alias
			"get_Table"
		end

	get_delete_rule: SYSTEM_DATA_RULE is
		external
			"IL signature (): System.Data.Rule use System.Data.ForeignKeyConstraint"
		alias
			"get_DeleteRule"
		end

	get_related_columns: ARRAY [SYSTEM_DATA_DATACOLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.ForeignKeyConstraint"
		alias
			"get_RelatedColumns"
		end

	get_accept_reject_rule: SYSTEM_DATA_ACCEPTREJECTRULE is
		external
			"IL signature (): System.Data.AcceptRejectRule use System.Data.ForeignKeyConstraint"
		alias
			"get_AcceptRejectRule"
		end

	get_update_rule: SYSTEM_DATA_RULE is
		external
			"IL signature (): System.Data.Rule use System.Data.ForeignKeyConstraint"
		alias
			"get_UpdateRule"
		end

feature -- Element Change

	set_delete_rule (value: SYSTEM_DATA_RULE) is
		external
			"IL signature (System.Data.Rule): System.Void use System.Data.ForeignKeyConstraint"
		alias
			"set_DeleteRule"
		end

	set_update_rule (value: SYSTEM_DATA_RULE) is
		external
			"IL signature (System.Data.Rule): System.Void use System.Data.ForeignKeyConstraint"
		alias
			"set_UpdateRule"
		end

	set_accept_reject_rule (value: SYSTEM_DATA_ACCEPTREJECTRULE) is
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

	equals_object (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.ForeignKeyConstraint"
		alias
			"Equals"
		end

end -- class SYSTEM_DATA_FOREIGNKEYCONSTRAINT
