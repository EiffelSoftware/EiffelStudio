note
	description: "All SQL strings that are needed to access a database with a generic layout."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_GENERIC_LAYOUT_SQL_STRINGS

feature {PS_METADATA_TABLES_MANAGER} -- Table creation

	Create_value_table: STRING
		deferred
		end

	Create_class_table: STRING
		deferred
		end

	Create_attribute_table: STRING
		deferred
		end

feature {PS_METADATA_TABLES_MANAGER} -- Data querying - Key manager

	Show_tables: STRING
		deferred
		end

	Query_class_table: STRING = "[
			SELECT classid, classname 
			FROM ps_class
		]"

	Query_attribute_table: STRING = "[
			SELECT attributeid, name, class
			FROM ps_attribute
		]"

	Query_new_id_of_class (class_name: STRING): STRING
		do
			Result := "SELECT classid FROM ps_class WHERE classname = '" + class_name + "'"
		end

	Query_new_id_of_attribute (attribute_name: STRING; class_key: INTEGER): STRING
		do
			Result := "SELECT attributeid FROM ps_attribute WHERE name = '" + attribute_name + "' AND class = " + class_key.out
		end


feature {PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND} -- Data querying - Backend implementation

	Query_values_from_class (attributes: STRING): STRING
		do
			Result := "[
				SELECT objectid, attributeid, runtimetype, value
				FROM ps_value
				WHERE attributeid IN
			]"
			Result := Result + attributes + " ORDER BY objectid "
		end

	For_update_appendix: STRING
		deferred
		end

	convert_to_sql (primary_keys: LIST [INTEGER]): STRING
			-- Convert `primary_keys' to a string with format `( 0, 1, 2 )'.
			-- If empty, the result is `( 0 )'.
		do
			Result := " ( 0, "
			across
				primary_keys as key
			loop
				Result.append (key.item.out + ", ")
			end
			Result.remove_tail (2)
			Result.append (" )")
		end

	Query_new_primary_of_object (attribute_id: INTEGER; object_identifier: STRING): STRING
		do
			Result := "SELECT objectid FROM ps_value WHERE attributeid = " + attribute_id.out + "  AND value = '" + object_identifier + "'"
		end

	Query_present_attributes_of_object (primary_key: INTEGER): STRING
		do
			Result := "SELECT attributeid FROM ps_value WHERE objectid = " + primary_key.out
		end

	Query_last_object_autoincrement: STRING
		deferred
		end

feature {PS_METADATA_TABLES_MANAGER} -- Data modification - Key manager

	Insert_class_use_autoincrement (class_name: STRING): STRING
		deferred
		end

	Insert_attribute_use_autoincrement (attribute_name: STRING; class_key: INTEGER): STRING
		deferred
		end

feature {PS_GENERIC_LAYOUT_SQL_BACKEND, PS_GENERIC_LAYOUT_SQL_READWRITE_BACKEND} -- Data modification - Backend

	Insert_value_use_autoincrement (attribute_id, runtimetype: INTEGER; value: STRING): STRING
		deferred
		end

	Remove_old_object_identifier (existence_attribute_of_class: INTEGER; object_identifier: STRING): STRING
		do
			Result := "UPDATE ps_value SET value = '' WHERE attributeid = " + existence_attribute_of_class.out + "  AND value = '" + object_identifier + "'"
		end

	Delete_values_of_object (primary_key: INTEGER): STRING
		do
			Result := "DELETE FROM ps_value WHERE objectid = " + primary_key.out
		end

	Update_value (object_primary, attribute_id: INTEGER; new_runtime_type: INTEGER; new_value: STRING): STRING
		do
			Result := "UPDATE ps_value SET runtimetype = " + new_runtime_type.out + ", value = '" + new_value + "' WHERE objectid = " + object_primary.out + " AND attributeid = " + attribute_id.out
		end

	Assemble_multi_replace (tuples: LIST[STRING]): STRING
		deferred
		end

	Insert_value (object_primary, attribute_id, runtime_type: INTEGER; value: STRING): STRING
		do
			Result := "INSERT INTO ps_value (objectid, attributeid, runtimetype, value) VALUES ( " + object_primary.out + ", " + attribute_id.out + ", " + runtime_type.out + ", '" + value + "')"
		end

feature {PS_EIFFELSTORE_EXPORT} -- Table and column names

	Class_table: STRING = "ps_class"

	Class_table_id_column: STRING = "classid"

	Class_table_name_column: STRING = "classname"

	Attribute_table: STRING = "ps_attribute"

	Attribute_table_id_column: STRING = "attributeid"

	Attribute_table_name_column: STRING = "name"

	Attribute_table_class_column: STRING = "class"

	Value_table: STRING = "ps_value"

	Value_table_id_column: STRING = "objectid"

	Value_table_attributeid_column: STRING = "attributeid"

	Value_table_runtimetype_column: STRING = "runtimetype"

	Value_table_value_column: STRING = "value"

feature {PS_EIFFELSTORE_EXPORT} -- Special attributes and classes

	None_class: STRING = "NONE"

	Existence_attribute: STRING = "ps_existence"

feature {PS_EIFFELSTORE_EXPORT} -- Management and testing

	Delete_all_values: STRING = "DELETE FROM ps_value"

	Drop_value_table: STRING = "DROP TABLE ps_value"

	Drop_attribute_table: STRING = "DROP TABLE ps_attribute"

	Drop_class_table: STRING = "DROP TABLE ps_class"

end
