note
	description: "Abstract SELECT Query"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_DATABASE_QUERY

feature -- Query

	sql: STRING
			-- SQL query
		deferred
		end

feature -- Modifiers

	set_table (a_table: STRING)
			-- Table name
		require
			table_not_void: a_table /= Void
			table_not_empty: not a_table.is_empty
		deferred
		end

	add_field (a_field: STRING)
			-- Add table fied to SELECT
		require
			field_not_void: a_field /= Void
			field_not_empty: not a_field.is_empty
		deferred
		end

	add_condition (a_condition: STRING)
			-- Add selection condition
		require
			condition_not_void: a_condition /= Void
			condition_not_empty: not a_condition.is_empty
		deferred
		end

	is_distinct: BOOLEAN
			-- Set selection as DISTINCT
		deferred
		end

feature {NONE} -- Implementation

	table: STRING
		-- Table to apply query
	fields: ARRAYED_LIST[STRING]
		-- Selection fileds
	conditions: ARRAYED_LIST[STRING]
		-- Selection conditions

end -- ESA_DATABASE_QUERY
