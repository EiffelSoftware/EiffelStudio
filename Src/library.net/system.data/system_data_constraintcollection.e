indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.ConstraintCollection"

external class
	SYSTEM_DATA_CONSTRAINTCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_DATA_INTERNALDATACOLLECTIONBASE
		redefine
			get_list
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	get_item (index: INTEGER): SYSTEM_DATA_CONSTRAINT is
		external
			"IL signature (System.Int32): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"get_Item"
		end

	get_item_string (name: STRING): SYSTEM_DATA_CONSTRAINT is
		external
			"IL signature (System.String): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.ConstraintCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.ConstraintCollection"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	add_string_array_data_column_array_data_column (name: STRING; primary_key_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; foreign_key_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]): SYSTEM_DATA_CONSTRAINT is
		external
			"IL signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[]): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	add_string_data_column_boolean (name: STRING; column: SYSTEM_DATA_DATACOLUMN; primary_key: BOOLEAN): SYSTEM_DATA_CONSTRAINT is
		external
			"IL signature (System.String, System.Data.DataColumn, System.Boolean): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	add_string_data_column_data_column (name: STRING; primary_key_column: SYSTEM_DATA_DATACOLUMN; foreign_key_column: SYSTEM_DATA_DATACOLUMN): SYSTEM_DATA_CONSTRAINT is
		external
			"IL signature (System.String, System.Data.DataColumn, System.Data.DataColumn): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	frozen remove (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.ConstraintCollection"
		alias
			"Remove"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.ConstraintCollection"
		alias
			"Clear"
		end

	frozen contains (name: STRING): BOOLEAN is
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

	frozen add_range (constraints: ARRAY [SYSTEM_DATA_CONSTRAINT]) is
		external
			"IL signature (System.Data.Constraint[]): System.Void use System.Data.ConstraintCollection"
		alias
			"AddRange"
		end

	frozen add (constraint: SYSTEM_DATA_CONSTRAINT) is
		external
			"IL signature (System.Data.Constraint): System.Void use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	add_string_array_data_column_boolean (name: STRING; columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; primary_key: BOOLEAN): SYSTEM_DATA_CONSTRAINT is
		external
			"IL signature (System.String, System.Data.DataColumn[], System.Boolean): System.Data.Constraint use System.Data.ConstraintCollection"
		alias
			"Add"
		end

	frozen remove_constraint (constraint: SYSTEM_DATA_CONSTRAINT) is
		external
			"IL signature (System.Data.Constraint): System.Void use System.Data.ConstraintCollection"
		alias
			"Remove"
		end

	frozen can_remove (constraint: SYSTEM_DATA_CONSTRAINT): BOOLEAN is
		external
			"IL signature (System.Data.Constraint): System.Boolean use System.Data.ConstraintCollection"
		alias
			"CanRemove"
		end

	index_of_string (constraint_name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.ConstraintCollection"
		alias
			"IndexOf"
		end

feature {NONE} -- Implementation

	frozen index_of (constraint: SYSTEM_DATA_CONSTRAINT): INTEGER is
		external
			"IL signature (System.Data.Constraint): System.Int32 use System.Data.ConstraintCollection"
		alias
			"IndexOf"
		end

	get_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.ConstraintCollection"
		alias
			"get_List"
		end

	on_collection_changed (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.ConstraintCollection"
		alias
			"OnCollectionChanged"
		end

end -- class SYSTEM_DATA_CONSTRAINTCOLLECTION
