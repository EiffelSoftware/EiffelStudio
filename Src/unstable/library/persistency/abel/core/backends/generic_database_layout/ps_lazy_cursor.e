note
	description: "A query result cursor which loads items in batches, using SQL `LIMIT' keyword."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_LAZY_CURSOR

inherit
	ITERATION_CURSOR [PS_BACKEND_OBJECT]

	PS_ABEL_EXPORT

create
	make

feature -- Access

	item: PS_BACKEND_OBJECT
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
			if internal_result_cursor.after and backend.batch_retrieval_size > 0 then
				next_batch
			elseif internal_result_cursor.after then
				after := True
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

	transaction: PS_INTERNAL_TRANSACTION

	backend: PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND

feature {NONE} -- Implementation

	next_item
			-- Build the next item from the SQL result cursor
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
					-- Fill all attributes. The result is ordered by the object id,
					-- therefore the attributes of a single object are grouped together.
				attribute_name := backend.db_metadata_manager.attribute_name_of_key (internal_result_cursor.item.at (backend.SQL_Strings.Value_table_attributeid_column).to_integer)
				attribute_value := internal_result_cursor.item.at (backend.SQL_Strings.Value_table_value_column)
				class_name_of_value := backend.db_metadata_manager.class_name_of_key (internal_result_cursor.item.at (backend.SQL_Strings.Value_table_runtimetype_column).to_integer)
				if not attribute_name.is_equal (backend.SQL_Strings.Existence_attribute) then
					item.add_attribute (attribute_name, attribute_value, class_name_of_value)
				else
					item.set_is_root (attribute_value.to_boolean)
				end
				internal_result_cursor.forth
			end
		end

	next_batch
			-- Retrieve the next batch of items from the database
		require
			not_after: not after
		local
			connection: PS_SQL_CONNECTION
			sql_string: STRING
			attribute_keys: ARRAYED_LIST [INTEGER]

			conv: PS_CRITERION_SQL_CONVERTER
		do
			create conv.make (backend.db_metadata_manager, type)

			if backend.db_metadata_manager.has_primary_key_of_class (type.name) then

				attribute_keys := backend.db_metadata_manager.attribute_keys_of_class (backend.db_metadata_manager.primary_key_of_class (type.name))
				sql_string := backend.sql_strings.query_values_from_class (backend.sql_strings.convert_to_sql (attribute_keys))

				if not criteria.is_empty_criterion then
					sql_string.append (" AND objectid IN (" + conv.visit (criteria) + ") ")
				end

				sql_string.append (backend.sql_strings.Order_by_appendix)

				if backend.batch_retrieval_size > 0 then
					sql_string.append (" LIMIT " + batch_index.out + "," + (backend.batch_retrieval_size * attribute_keys.count).out)
					batch_index := batch_index + (backend.batch_retrieval_size * attribute_keys.count)
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
				internal_result_cursor := (create {LINKED_LIST [PS_SQL_ROW]}.make).new_cursor
			end
		end

	internal_result_cursor: ITERATION_CURSOR [PS_SQL_ROW]
		require
			not_after: not after
		attribute
		end

	batch_index: INTEGER

	batch_size: INTEGER

feature {NONE} -- Initialization

	make (t: PS_TYPE_METADATA; cr: PS_CRITERION; att: PS_IMMUTABLE_STRUCTURE [STRING]; tr: PS_INTERNAL_TRANSACTION; b: PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND)
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
