indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Constraint"

deferred external class
	SYSTEM_DATA_CONSTRAINT

inherit
	ANY
		redefine
			to_string
		end

feature -- Access

	get_constraint_name: STRING is
		external
			"IL signature (): System.String use System.Data.Constraint"
		alias
			"get_ConstraintName"
		end

	get_table: SYSTEM_DATA_DATATABLE is
		external
			"IL deferred signature (): System.Data.DataTable use System.Data.Constraint"
		alias
			"get_Table"
		end

feature -- Element Change

	set_constraint_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Constraint"
		alias
			"set_ConstraintName"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.Constraint"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen check_state_for_property is
		external
			"IL signature (): System.Void use System.Data.Constraint"
		alias
			"CheckStateForProperty"
		end

	frozen set_data_set (data_set: SYSTEM_DATA_DATASET) is
		external
			"IL signature (System.Data.DataSet): System.Void use System.Data.Constraint"
		alias
			"SetDataSet"
		end

	get__data_set: SYSTEM_DATA_DATASET is
		external
			"IL signature (): System.Data.DataSet use System.Data.Constraint"
		alias
			"get__DataSet"
		end

end -- class SYSTEM_DATA_CONSTRAINT
