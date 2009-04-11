note

	description:
		"Traverse the OO model and save it in tables %
		%and columns."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

	make (model: ANY; a_tables: like tables; a_keys: like keys)
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

	traversal (object: ANY)
			-- System traversal.
		require else
			object_not_void: object /= Void
		local
			nb_fields, no_field: INTEGER;
			fld: detachable ANY;
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

	reference_obj_action (object: ANY; name: STRING; table: SQL_TABLE)
			-- Action for a reference type.
		require
			object_not_void: object /= Void;
			name_not_void: name /= Void;
			table_not_void: table /= Void
		local
			sql_column: SQL_COLUMN
			l_item: detachable STRING
		do
			if is_marked (object) or else
				table_exists (object.generator) then
				create sql_column.make (name,
					to_sql (keys.reference_key (object)));
				table.extend (sql_column);

			else
				l_item := keys.item (object.generator)
				check l_item /= Void end -- FIXME: implied by ...?
				create sql_column.make (l_item,
					to_sql (keys.reference_key (object)));
				table.extend (sql_column);
				traversal (object)
			end;
		ensure
			table_extended: not is_marked (object) implies
				table.count = old table.count + 1
		end;

	simple_obj_action (object: ANY; name: STRING; table: SQL_TABLE)
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

	list_obj_action (no_field: INTEGER; object: ANY; table: SQL_TABLE)
			-- Action for a list type.
		require
			object_not_void: object /= Void;
			table_not_void: table /= Void;
			field_attached: attached field (no_field, object) as lr_field
			contents_not_void: contents (lr_field) /= Void
		local
			tmp_table: SQL_TABLE;
			sql_column: SQL_COLUMN;
			any: ANY
			l_field: detachable ANY
			l_item, l_name: detachable STRING
		do
			l_name := table.name
			check l_name /= Void end -- FIXME: implied by `table' make's postcondition, but if creation method is `linked_list_make' ?
			create tmp_table.make_prefix (field_name (no_field, object), l_name);
			tables.extend (tmp_table);
			l_field := field (no_field, object)
			check l_field /= Void end -- implied by precondition `field_attached'
			any := contents (l_field);
			-- Key part 1
			l_item := keys.item (object.generator)
			check l_item /= Void end -- FIXME: implied by ...?
			create sql_column.make (l_item,
			   to_sql (keys.reference_key (object)));
			tmp_table.extend (sql_column);
			if is_simple_type (any) then
				-- Key part 2
				create sql_column.make (any.generator, to_sql (any));
				tmp_table.extend (sql_column)
			else
				-- Key part 2
				l_item := keys.item (any.generator)
				check l_item /= Void end -- FIXME: implied by ...?
				create sql_column.make (l_item,
				   to_sql (keys.reference_key (any)));
				tmp_table.extend (sql_column);
				traversal (any)
			end
		end;

feature {NONE}

	table_exists (name: STRING): BOOLEAN
		require
			name_not_void: name /= Void
		do
			from
				tables.start
			until
				tables.after or Result = true
			loop
				Result := tables.item.name ~ name
			end
		end;


invariant

	tables_not_void: tables /= Void;
	keys: keys /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MODEL_TRAVERSAL


