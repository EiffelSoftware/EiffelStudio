indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.UniqueConstraint"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_UNIQUE_CONSTRAINT

inherit
	DATA_CONSTRAINT
		redefine
			get_hash_code,
			equals
		end

create
	make_data_unique_constraint_8,
	make_data_unique_constraint_6,
	make_data_unique_constraint_7,
	make_data_unique_constraint_4,
	make_data_unique_constraint,
	make_data_unique_constraint_2,
	make_data_unique_constraint_3,
	make_data_unique_constraint_1,
	make_data_unique_constraint_5

feature {NONE} -- Initialization

	frozen make_data_unique_constraint_8 (columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; is_primary_key: BOOLEAN) is
		external
			"IL creator signature (System.Data.DataColumn[], System.Boolean) use System.Data.UniqueConstraint"
		end

	frozen make_data_unique_constraint_6 (column: DATA_DATA_COLUMN; is_primary_key: BOOLEAN) is
		external
			"IL creator signature (System.Data.DataColumn, System.Boolean) use System.Data.UniqueConstraint"
		end

	frozen make_data_unique_constraint_7 (name: SYSTEM_STRING; columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; is_primary_key: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[], System.Boolean) use System.Data.UniqueConstraint"
		end

	frozen make_data_unique_constraint_4 (name: SYSTEM_STRING; column_names: NATIVE_ARRAY [SYSTEM_STRING]; is_primary_key: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String[], System.Boolean) use System.Data.UniqueConstraint"
		end

	frozen make_data_unique_constraint (name: SYSTEM_STRING; column: DATA_DATA_COLUMN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn) use System.Data.UniqueConstraint"
		end

	frozen make_data_unique_constraint_2 (name: SYSTEM_STRING; columns: NATIVE_ARRAY [DATA_DATA_COLUMN]) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[]) use System.Data.UniqueConstraint"
		end

	frozen make_data_unique_constraint_3 (columns: NATIVE_ARRAY [DATA_DATA_COLUMN]) is
		external
			"IL creator signature (System.Data.DataColumn[]) use System.Data.UniqueConstraint"
		end

	frozen make_data_unique_constraint_1 (column: DATA_DATA_COLUMN) is
		external
			"IL creator signature (System.Data.DataColumn) use System.Data.UniqueConstraint"
		end

	frozen make_data_unique_constraint_5 (name: SYSTEM_STRING; column: DATA_DATA_COLUMN; is_primary_key: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn, System.Boolean) use System.Data.UniqueConstraint"
		end

feature -- Access

	get_columns: NATIVE_ARRAY [DATA_DATA_COLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.UniqueConstraint"
		alias
			"get_Columns"
		end

	get_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.UniqueConstraint"
		alias
			"get_Table"
		end

	frozen get_is_primary_key: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.UniqueConstraint"
		alias
			"get_IsPrimaryKey"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.UniqueConstraint"
		alias
			"GetHashCode"
		end

	equals (key2: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.UniqueConstraint"
		alias
			"Equals"
		end

end -- class DATA_UNIQUE_CONSTRAINT
