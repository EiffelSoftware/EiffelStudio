note
	description: "A result cursor for the relational backend which %
				%loads items in batches, using SQL `LIMIT' keyword."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RELATIONAL_RESULT_CURSOR

inherit
	ITERATION_CURSOR [PS_BACKEND_OBJECT]

	PS_ABEL_EXPORT

create
	make

feature -- Access

	item: PS_BACKEND_OBJECT
			-- <Precursor>

feature -- Status report	

	after: BOOLEAN
			-- <Precursor>

feature -- Cursor movement

	forth
			-- <Precursor>
		do
				-- Advance cursor
			sql_result.forth

				-- Try to load the next batch.
			if
				sql_result.after and
				connector.batch_retrieval_size > 0 and
					-- Don't try to load another batch when
					-- the last one wasn't full.
				item_count = batch_index
			then
				next_batch
			end

				-- Load the item
			if not sql_result.after then
				load_item
				item_count := item_count + 1
			else
				after := True
			end
		end

feature {NONE} -- Implementation: Static attributes

	type: PS_TYPE_METADATA
			-- The object type.

	attributes: PS_IMMUTABLE_STRUCTURE [STRING]
			-- The attributes to retrieve.

	transaction: PS_INTERNAL_TRANSACTION
			-- The active transaction.

	connector: PS_READ_RELATIONAL_CONNECTOR
			-- The connector.

	sql_template: STRING
			-- The basic template for queries.

feature {NONE} -- Implementation: Variable attributes

	batch_index: INTEGER
			-- The start index to the LIMIT clause.

	item_count: INTEGER
			-- The number of retrieved items.

	sql_result: ITERATION_CURSOR [PS_SQL_ROW]
			-- The current result cursor.
		require
			not_after: not after
		attribute
		end

feature {NONE} -- Implementation

	next_batch
			-- Send the SQL command to retrieve the next couple of results.
		local
			table: STRING
			connection: PS_SQL_CONNECTION
			res_list: ARRAYED_LIST [PS_BACKEND_OBJECT]

			primary: INTEGER
			object: PS_BACKEND_OBJECT

			sql: STRING
			visitor: PS_CRITERION_SQL_CONVERTER_VISITOR
		do

				-- Generate the SQL command.
			if connector.batch_retrieval_size > 0 then
				sql := sql_template + " LIMIT " + batch_index.out + "," + connector.batch_retrieval_size.out
				batch_index := batch_index + connector.batch_retrieval_size
			else
				sql := sql_template
			end

				-- Execute the command and update `sql_result'.
			connection := connector.get_connection (transaction)
			connection.execute_sql (sql)
			sql_result := connection.last_result
		end


	load_item
			-- Load the result of `sql_result' into `item'.
		require
			not_after: not after
		local
			values: PS_SQL_ROW
			primary: INTEGER
		do
			across
				attributes as attribute_cursor
			from
				values := sql_result.item

					-- Try to find a primary key column.
				if attached connector.managed_type_lookup (type) as id_column then
					primary := values.at (id_column).to_integer
				else
					primary := connector.new_primary
				end

				create item.make (primary, type)
			loop
				item.add_attribute (
						-- Attribute name.
					attribute_cursor.item,
						-- Attribute value.
					values.at (attribute_cursor.item),
						-- Runtime type: We return the statically declared type,
						-- because the backend doesn't support storing the runtime type.
					type.attribute_type (attribute_cursor.item).name)
			end
		end

feature {NONE} -- Initialization

	make (		a_type: like type;
				criteria: PS_CRITERION;
				a_attributes: like attributes;
				a_transaction: like transaction;
				a_connector: like connector)
			-- Initialization for `Current'.
		local
			table: STRING
			visitor: PS_CRITERION_SQL_CONVERTER_VISITOR
		do
			type := a_type
			attributes := a_attributes
			transaction := a_transaction
			connector := a_connector

			batch_index := 0
			item_count := 0

				-- Generate the basic SQL command.
			fixme ("Only load the required attributes.")
			table := type.name.as_lower
			sql_template := "SELECT * FROM " + table

				-- Add the WHERE clause.
			if not criteria.is_empty_criterion then
				create visitor
				sql_template.append (" WHERE " + visitor.visit (criteria))
			end

				-- Retrieve the first batch and load the result.
			next_batch

			if not sql_result.after then
				load_item
				item_count := 1
			else
				after := True
				create item.make ({INTEGER}.min_value, type)
			end
		end
end
