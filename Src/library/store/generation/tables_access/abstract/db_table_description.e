indexing
	description: "Description of a table."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_TABLE_DESCRIPTION

inherit
	DB_TABLES_ACCESS_USE
	
feature -- Initialization

	make is
			-- Enable to ensure unicity of object.
		do
		end

feature -- Access (table description)

	Table_name: STRING is
			-- Database table name.
		deferred
		end

	Table_code: INTEGER is
			-- Eiffel table code, matches IDs definition in LOG_TABLE.
		deferred
		end

	Attribute_number: INTEGER is
			-- Number of attributes in the table.
		deferred
		end

	attribute_code_list: ARRAYED_LIST [INTEGER] is
			-- Feature code list.
		deferred
		end

	description_list: ARRAYED_LIST [STRING] is
			-- Feature name list. Can be interpreted as a list
			-- or a hash-table.
		deferred
		end

	type_list: ARRAYED_LIST [INTEGER] is
			-- Feature type list. Can be interpreted as a list
			-- or a hash-table.
		deferred
		end

	printable_type_table: HASH_TABLE [STRING, INTEGER] is
			-- Default string associated to attributes possible
			-- types.
		once
				-- Number of possible types.
			create Result.make (7)
			Result.extend ("character", Character_type)
			Result.extend ("boolean", Boolean_type)
			Result.extend ("integer", Integer_type)
			Result.extend ("real", Real_type)
			Result.extend ("double", Double_type)
			Result.extend ("string", String_type)
			Result.extend ("date_time", Date_time_type)
		end

	to_delete_fkey_from_table: HASH_TABLE [INTEGER, INTEGER] is
			-- List of tables depending on this one and their
			-- foreign key for this table.
			-- Deletion on this table may imply deletions on
			-- depending tables. 
		deferred
		end

	to_create_fkey_from_table: HASH_TABLE [INTEGER, INTEGER] is
			-- List of associated necessary tables and the  
			-- linking foreign keys.
			-- Creation on this table may imply creations on
			-- associated necessary tables.
		deferred
		end

	id_name: STRING is
			-- Table ID attribute name.
		do
			Result := description_list.i_th (Id_code)
		end

	Id_code: INTEGER is
			-- Table ID attribute code.
			--| 1 in general.
		deferred
		end

	No_id: INTEGER is 0
			-- `Id_code' value when no ID exists or ID constraint is not
			-- located to a single attribute.

	Character_type: INTEGER is 2;

	Boolean_type: INTEGER is 3;

	Integer_type: INTEGER is 4;

	Real_type: INTEGER is 5;

	Double_type: INTEGER is 6;

	String_type: INTEGER is 20;
	
	Date_time_type: INTEGER is 21;

feature -- Access (table row values)

	attribute (code: INTEGER): ANY is
			-- Value of attribute with `code'.
		require
			valid_code: valid (code)
		deferred
		end

	printable_attribute (code: INTEGER): STRING is
			-- String value of attribute with `code'.
		require
			valid_code: valid (code)
		local
			r_any: ANY
		do
			r_any := attribute (code)
			if r_any /= Void then
				Result := r_any.out
			else
				Result := ""
			end
		ensure
			result_not_void: Result /= Void
		end

	id: ANY is
			-- Table row ID.
		do
			Result := attribute (Id_code)
		end

	printable_id: STRING is
			-- String value of table row ID.
		do
			Result := id.out
		end

	attribute_list: ARRAYED_LIST [ANY] is
			-- Table row attribute values.
		do
			create Result.make (Attribute_number)
			from
				attribute_code_list.start
			until
				attribute_code_list.after
			loop
				Result.extend (attribute (attribute_code_list.item))
				attribute_code_list.forth
			end
		ensure
			not_void: Result /= Void
		end

	printable_attribute_list: ARRAYED_LIST [STRING] is
			-- Table row attribute string values.
		do
			create Result.make (Attribute_number)
			from
				attribute_code_list.start
			until
				attribute_code_list.after
			loop
				Result.extend (printable_attribute (attribute_code_list.item))
				attribute_code_list.forth
			end
		ensure
			not_void: Result /= Void
		end

	selected_attribute_list (list: ARRAYED_LIST [INTEGER]): ARRAYED_LIST [ANY] is
			-- Table row attribute values which codes are in `list'.
		require
			not_void: list /= Void
		do
			create Result.make (list.count)
			from
				list.start
			until
				list.after
			loop
				Result.extend (attribute (list.item))
				list.forth
			end
		ensure
			not_void: Result /= Void
		end

	selected_printable_attribute_list (list: ARRAYED_LIST [INTEGER]): ARRAYED_LIST [STRING] is
			-- Table row attribute values which codes are in `list'.
		require
			not_void: list /= Void
		do
			create Result.make (list.count)
			from
				list.start
			until
				list.after
			loop
				Result.extend (printable_attribute (list.item))
				list.forth
			end
		ensure
			not_void: Result /= Void
		end

	mapped_list (action: FUNCTION [ANY, TUPLE [STRING], STRING]): ARRAYED_LIST [STRING] is
			-- Feature list mapped with `action'.
			-- This can be useful to create tags.
		local
			tmp: STRING
		do
			create Result.make (Attribute_number)
			from
				description_list.start
			until
				description_list.after
			loop
				tmp := clone (description_list.item)
				action.call ([tmp])
				Result.extend (action.last_result)
				description_list.forth
			end
		end

feature -- Status report

	valid (code: INTEGER): BOOLEAN is
			-- Is `code' a valid attribute code?
		do
			Result := code > 0 and then code <= Attribute_number
		end

feature -- Basic operations

	set_attribute (code: INTEGER; value: ANY) is
			-- Set attribute with `code' to `value'.
			-- `value' must be of type STRING, INTEGER, BOOLEAN, CHARACTER,
			-- DOUBLE or DATE_TIME. References are made automatically from
			-- expanded types.
		require
			valid_code: valid (code)
		deferred
		end

	set_id (value: ANY) is
			-- Set ID of table row to `value'.
			-- `value' must be of type STRING, INTEGER
			-- (reference created automatically) or DATE_TIME.
		do
			set_attribute (Id_code, value)
		end

end -- class DB_TABLE_DESCRIPTION

