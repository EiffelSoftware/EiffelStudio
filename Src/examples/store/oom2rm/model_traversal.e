indexing

	description:
		"Traverse the OO model and save it in tables %
		%and columns.";
	Status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MODEL_TRAVERSAL inherit

	INTERNAL;

	SUPPORT_CLASS;

	TRANSLATE
		undefine
			field_name,
			traversal
		end;

create

	make

feature

	tables: LINKED_LIST [SQL_TABLE];
			-- SQL tables of the model.
	
	keys: KEYS
			-- Keys description.
	
	make (model: ANY; a_tables: like tables; a_keys: like keys) is
			-- Create object.
		require
			model_not_void: model /= Void;
			tables_not_void: a_tables /= Void;
			keys_not_void: a_keys /= Void
		do
			tables := a_tables;
			keys := a_keys;
			traversal (model)
		ensure
			tables_not_void: tables = a_tables;
			keys_not_void: keys = a_keys
		end;

	traversal (object: ANY) is
			-- System traversal.
		require else
			object_not_void: object /= Void
		local
			nb_fields, no_field: INTEGER;
			fld: ANY;
			fld_name: STRING;
			table: SQL_TABLE
		do
			create table.make (object.generator);
			tables.extend (table);
			from
				nb_fields := field_count (object);
				no_field := 1
			until
				no_field > nb_fields
			loop
				fld := field (no_field, object);
				if fld /= Void then
					fld_name := field_name (no_field, object);
					if not is_simple_type (fld) then
						mark (object);
						if is_supported_container (fld) then
							list_obj_action (no_field, object, table)
						else
							reference_obj_action (fld, fld_name, table)
						end;
					else
						simple_obj_action (fld, fld_name, table)
					end;
				end;
				no_field := no_field + 1
			end;
		end;
	
	reference_obj_action (object: ANY; name: STRING; table: SQL_TABLE) is
			-- Action for a reference type.
		require
			object_not_void: object /= Void;
			name_not_void: name /= Void;
			table_not_void: table /= Void
		local
			sql_column: SQL_COLUMN
		do
			if is_marked (object) or else 
				table_exists (object.generator) then
				create sql_column.make (name, 
					to_sql (keys.reference_key (object)));
				table.extend (sql_column);

			else
				create sql_column.make (keys.item (object.generator), 
					to_sql (keys.reference_key (object)));
				table.extend (sql_column);
				traversal (object)
			end;
		ensure
			table_extended: not is_marked (object) implies
				table.count = old table.count + 1
		end;

	simple_obj_action (object: ANY; name: STRING; table: SQL_TABLE) is
			-- Action for simple type.
		require
			object_not_void: object /= Void;
			name_not_void: name /= Void;
			table_not_void: table /= Void
		local
			sql_column: SQL_COLUMN
		do
			create sql_column.make (name, to_sql (object));
			table.extend (sql_column)
		ensure
			table_extended: table.count = old table.count + 1
		end;
	
	list_obj_action (no_field: INTEGER; object: ANY; table: SQL_TABLE) is
			-- Action for a list type.
		require
			object_not_void: object /= Void;
			table_not_void: table /= Void;
			contents_not_void: contents (field (no_field, object)) /= Void
		local
			tmp_table: SQL_TABLE;
			sql_column: SQL_COLUMN;
			any: ANY
		do
			create tmp_table.make_prefix (field_name (no_field, object), table.name);
			tables.extend (tmp_table);
			any := contents (field (no_field, object));
			-- Key part 1
			create sql_column.make (keys.item (object.generator),
			   to_sql (keys.reference_key (object)));
			tmp_table.extend (sql_column);
			if is_simple_type (any) then
				-- Key part 2
				create sql_column.make (any.generator, to_sql (any));
				tmp_table.extend (sql_column)	
			else
				-- Key part 2
				create sql_column.make (keys.item (any.generator),
				   to_sql (keys.reference_key (any)));
				tmp_table.extend (sql_column);
				traversal (any)
			end
		end;

feature {NONE}

	table_exists (name: STRING): BOOLEAN is
		require
			name_not_void: name /= Void
		do
			from
				tables.start
			until
				tables.after or Result = true
			loop
				Result := tables.item.name.is_equal (name)
			end
		end;
				
			
invariant

	tables_not_void: tables /= Void;
	keys: keys /= Void

end -- class MODEL_TRAVERSAL


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

