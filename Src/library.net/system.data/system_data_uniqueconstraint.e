indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.UniqueConstraint"

external class
	SYSTEM_DATA_UNIQUECONSTRAINT

inherit
	SYSTEM_DATA_CONSTRAINT
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object
		end

create
	make_uniqueconstraint_1,
	make_uniqueconstraint_4,
	make_uniqueconstraint_2,
	make_uniqueconstraint,
	make_uniqueconstraint_3

feature {NONE} -- Initialization

	frozen make_uniqueconstraint_1 (column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL creator signature (System.Data.DataColumn) use System.Data.UniqueConstraint"
		end

	frozen make_uniqueconstraint_4 (name: STRING; column_names: ARRAY [STRING]; is_key: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String[], System.Boolean) use System.Data.UniqueConstraint"
		end

	frozen make_uniqueconstraint_2 (name: STRING; columns: ARRAY [SYSTEM_DATA_DATACOLUMN]) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[]) use System.Data.UniqueConstraint"
		end

	frozen make_uniqueconstraint (name: STRING; column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn) use System.Data.UniqueConstraint"
		end

	frozen make_uniqueconstraint_3 (columns: ARRAY [SYSTEM_DATA_DATACOLUMN]) is
		external
			"IL creator signature (System.Data.DataColumn[]) use System.Data.UniqueConstraint"
		end

feature -- Access

	get_columns: ARRAY [SYSTEM_DATA_DATACOLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.UniqueConstraint"
		alias
			"get_Columns"
		end

	get_table: SYSTEM_DATA_DATATABLE is
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

	equals_object (key2: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.UniqueConstraint"
		alias
			"Equals"
		end

end -- class SYSTEM_DATA_UNIQUECONSTRAINT
