note
	description: "Abstract Database Query"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATABASE_QUERY

create
	data_reader

feature -- Intialization

	data_reader (a_query: STRING; a_parameters: STRING_TABLE [ANY])
			-- SQL data reader for the stored query `a_query' with arguments `a_parameters'
		do
			query := a_query
			parameters := a_parameters
		end

	execute_reader (a_base_selection: DB_DYN_SELECTION): detachable LIST [DB_RESULT]
			-- Execute the Current store procedure.
		do
				-- Check test dynamic sequel. to redesign.
			create {ARRAYED_LIST [DB_RESULT]} Result.make (100)
			a_base_selection.set_container (Result)
			set_map_name (a_base_selection)
			a_base_selection.set_query (query)
			a_base_selection.execute_query
			a_base_selection.load_result
			Result := a_base_selection.container
			unset_map_name (a_base_selection)
			a_base_selection.terminate
		end

feature --  Access

	query: STRING
			-- SQL query to execute

	parameters: STRING_TABLE [ANY]
			-- query parameters

feature -- Status Report

	has_error: BOOLEAN
		-- is there an error?

	error_message: detachable STRING_32
		-- Error message if any.

	error_code: INTEGER
		-- Error code

feature {NONE} -- Implementation

	set_map_name (a_base_selection: DB_EXPRESSION)
			-- Store parameters `item' and their `key'.
		do
			from
				parameters.start
			until
				parameters.after
			loop
				a_base_selection.set_map_name (parameters.item_for_iteration, parameters.key_for_iteration)
				parameters.forth
			end
		end

	unset_map_name (a_base_selection: DB_EXPRESSION)
			-- Remove parameters item associated with key `key'.
		do
			from
				parameters.start
			until
				parameters.after
			loop
				a_base_selection.unset_map_name (parameters.key_for_iteration)
				parameters.forth
			end
		end

end -- ESA_DATABASE_QUERY
