indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.ConstraintCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_CONSTRAINT_COLLECTION

inherit
	DATA_INTERNAL_DATA_COLLECTION_BASE
		redefine
			get_list
		end
	ICOLLECTION
	IENUMERABLE

create {NONE}

feature -- Access

	get_item (index: INTEGER): DATA_CONSTRAINT is
		external
			"IL signature (System.Int32): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"get_Item"
		end

	get_item_string (name: SYSTEM_STRING): DATA_CONSTRAINT is
		external
			"IL signature (System.String): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.ConstraintCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.ConstraintCollection"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	add_string_array_data_column_array_data_column (name: SYSTEM_STRING; primary_key_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; foreign_key_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]): DATA_CONSTRAINT is
		external
			"IL signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[]): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	add_string_data_column_boolean (name: SYSTEM_STRING; column: DATA_DATA_COLUMN; primary_key: BOOLEAN): DATA_CONSTRAINT is
		external
			"IL signature (System.String, System.Data.DataColumn, System.Boolean): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	add_string_data_column_data_column (name: SYSTEM_STRING; primary_key_column: DATA_DATA_COLUMN; foreign_key_column: DATA_DATA_COLUMN): DATA_CONSTRAINT is
		external
			"IL signature (System.String, System.Data.DataColumn, System.Data.DataColumn): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	frozen remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.ConstraintCollection"
		alias
			"Remove"
		end

	frozen index_of (constraint: DATA_CONSTRAINT): INTEGER is
		external
			"IL signature (System.Data.Constraint): System.Int32 use System.Data.ConstraintCollection"
		alias
			"IndexOf"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.ConstraintCollection"
		alias
			"Clear"
		end

	frozen contains (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.ConstraintCollection"
		alias
			"Contains"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.ConstraintCollection"
		alias
			"RemoveAt"
		end

	frozen add_range (constraints: NATIVE_ARRAY [DATA_CONSTRAINT]) is
		external
			"IL signature (System.Data.Constraint[]): System.Void use System.Data.ConstraintCollection"
		alias
			"AddRange"
		end

	frozen add (constraint: DATA_CONSTRAINT) is
		external
			"IL signature (System.Data.Constraint): System.Void use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	add_string_array_data_column_boolean (name: SYSTEM_STRING; columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; primary_key: BOOLEAN): DATA_CONSTRAINT is
		external
			"IL signature (System.String, System.Data.DataColumn[], System.Boolean): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	frozen remove_constraint (constraint: DATA_CONSTRAINT) is
		external
			"IL signature (System.Data.Constraint): System.Void use System.Data.ConstraintCollection"
		alias
			"Remove"
		end

	frozen can_remove (constraint: DATA_CONSTRAINT): BOOLEAN is
		external
			"IL signature (System.Data.Constraint): System.Boolean use System.Data.ConstraintCollection"
		alias
			"CanRemove"
		end

	index_of_string (constraint_name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.ConstraintCollection"
		alias
			"IndexOf"
		end

feature {NONE} -- Implementation

	get_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.ConstraintCollection"
		alias
			"get_List"
		end

	on_collection_changed (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.ConstraintCollection"
		alias
			"OnCollectionChanged"
		end

end -- class DATA_CONSTRAINT_COLLECTION
