indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Constraint"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_CONSTRAINT

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

feature -- Access

	get_constraint_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Constraint"
		alias
			"get_ConstraintName"
		end

	get_table: DATA_DATA_TABLE is
		external
			"IL deferred signature (): System.Data.DataTable use System.Data.Constraint"
		alias
			"get_Table"
		end

	frozen get_extended_properties: DATA_PROPERTY_COLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.Constraint"
		alias
			"get_ExtendedProperties"
		end

feature -- Element Change

	set_constraint_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Constraint"
		alias
			"set_ConstraintName"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
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

	frozen set_data_set (data_set: DATA_DATA_SET) is
		external
			"IL signature (System.Data.DataSet): System.Void use System.Data.Constraint"
		alias
			"SetDataSet"
		end

	get__data_set: DATA_DATA_SET is
		external
			"IL signature (): System.Data.DataSet use System.Data.Constraint"
		alias
			"get__DataSet"
		end

end -- class DATA_CONSTRAINT
