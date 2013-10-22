note
	description: "Summary description for {PS_LAZY_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_LAZY_CURSOR

inherit
	ITERATION_CURSOR [PS_RETRIEVED_OBJECT]

	PS_EIFFELSTORE_EXPORT

create
	make

feature -- Access

	item: PS_RETRIEVED_OBJECT
			-- Item at current cursor position.
		do
			check attached internal_item as res then
				Result := res
			end
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?

feature -- Cursor movement

	forth
			-- Move to next position.
		do
			if internal_result_cursor.after and backend.lazy_loading_batch_size > 0 then
				next_batch
			end
			if not after then
				next_item
			else
				internal_item := Void
			end
		end


feature {NONE} -- Implementation

	internal_item: detachable like item

	type: PS_TYPE_METADATA

	criteria: PS_CRITERION

	attributes: PS_IMMUTABLE_STRUCTURE [STRING]

	transaction: PS_TRANSACTION

	backend: PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND

feature {NONE} -- Implementation

	next_item
		require
			not_after: not after
		local
			attribute_name: STRING
			attribute_value: STRING
			class_name_of_value: STRING
		do
			from
				create internal_item.make (internal_result_cursor.item.at (backend.SQL_Strings.Value_table_id_column).to_integer, type)
			until
				internal_result_cursor.after or else internal_result_cursor.item.at (backend.SQL_Strings.Value_table_id_column).to_integer /= item.primary_key
			loop
				-- fill all attributes - The result is ordered by the object id, therefore the attributes of a single object are grouped together.
				attribute_name := backend.db_metadata_manager.attribute_name_of_key (internal_result_cursor.item.at (backend.SQL_Strings.Value_table_attributeid_column).to_integer)
				attribute_value := internal_result_cursor.item.at (backend.SQL_Strings.Value_table_value_column)
				class_name_of_value := backend.db_metadata_manager.class_name_of_key (internal_result_cursor.item.at (backend.SQL_Strings.Value_table_runtimetype_column).to_integer)
				if not attribute_name.is_equal (backend.SQL_Strings.Existence_attribute) then
					item.add_attribute (attribute_name, attribute_value, class_name_of_value)
				end
				internal_result_cursor.forth
			end
--			from
--				create internal_item.make (internal_result_cursor.item.item(1).to_integer, type)
--			until
--				internal_result_cursor.after or else internal_result_cursor.item.item(1).to_integer /= item.primary_key
--			loop
--				-- fill all attributes - The result is ordered by the object id, therefore the attributes of a single object are grouped together.
--				attribute_name := backend.db_metadata_manager.attribute_name_of_key (internal_result_cursor.item.item(2).to_integer)
--				attribute_value := internal_result_cursor.item.item(4)
--				class_name_of_value := backend.db_metadata_manager.class_name_of_key (internal_result_cursor.item.item(3).to_integer)
--				if not attribute_name.is_equal (backend.SQL_Strings.Existence_attribute) then
--					item.add_attribute (attribute_name, attribute_value, class_name_of_value)
--				end
--				internal_result_cursor.forth
--			end
--			-- do NOT go forth - we are already pointing to the next item, otherwise the inner loop would not have stopped.
		end

	next_batch
		require
			not_after: not after
		local
			connection: PS_SQL_CONNECTION
			sql_string: STRING
			attribute_keys: LINKED_LIST[INTEGER]
		do

			if backend.db_metadata_manager.has_primary_key_of_class (type.base_class.name) then

				attribute_keys := backend.db_metadata_manager.attribute_keys_of_class (backend.db_metadata_manager.primary_key_of_class (type.base_class.name))
				sql_string := backend.sql_strings.query_values_from_class (backend.sql_strings.convert_to_sql (attribute_keys))

				if backend.lazy_loading_batch_size > 0 then
					sql_string.append (" LIMIT " + batch_index.out + "," + (backend.lazy_loading_batch_size * attribute_keys.count).out)
					batch_index := batch_index + (backend.lazy_loading_batch_size * attribute_keys.count)
				end

				if not transaction.is_readonly then
					sql_string.append (backend.sql_strings.For_update_appendix)
				end


				connection := backend.get_connection (transaction)
				connection.execute_sql (sql_string)

				internal_result_cursor := connection.last_result
				after := internal_result_cursor.after

			else
				-- No such objects
				after := True

				-- Void safety...
				internal_result_cursor := (create {LINKED_LIST[PS_SQL_ROW]}.make).new_cursor
			end
		end

	internal_result_cursor: ITERATION_CURSOR[PS_SQL_ROW]
		require
			not_after: not after
		attribute
		end

	batch_index: INTEGER

	batch_size: INTEGER

feature {NONE} -- Initialization

	make (t: PS_TYPE_METADATA; cr: PS_CRITERION; att: PS_IMMUTABLE_STRUCTURE [STRING]; tr: PS_TRANSACTION; b: PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND)
		do
			type := t
			criteria := cr
			attributes := att
			transaction := tr
			backend := b
			batch_index := 0

			next_batch
			if not after then
				next_item
			end
		end

invariant
	attached_when_not_after: not after implies attached internal_item

end
