note
	description: "Abstract Database Query"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_QUERY

inherit

	SHARED_LOGGER

	REFACTORING_HELPER

create
	data_reader

feature -- Intialization

	data_reader (a_query: READABLE_STRING_GENERAL; a_parameters: STRING_TABLE [ANY])
			-- SQL data reader for the query `a_query' with arguments `a_parameters'
		do
			debug
				log.write_information (generator + ".data_reader" + " execute query: " + a_query.to_string_8)
			end
			log.write_debug (generator + ".data_reader execute query: " + a_query.to_string_8  + " arguments:" + log_parameters (a_parameters))
			query := a_query.to_string_8
			parameters := a_parameters
		ensure
			query_set: query.same_string_general (a_query)
			parameters_set: parameters = a_parameters
		end

	execute_reader (a_base_selection: DB_SELECTION): detachable LIST [DB_RESULT]
			-- Execute the Current sql query.
		do
			to_implement ("Check test dynamic sequel. to redesign.")
			create {ARRAYED_LIST [DB_RESULT]} Result.make (100)
			a_base_selection.set_container (Result)
			set_map_name (a_base_selection)
			a_base_selection.set_query (query)
			a_base_selection.execute_query
			if a_base_selection.is_ok then
				a_base_selection.load_result
				Result := a_base_selection.container
			else
				log.write_error (generator + "." + a_base_selection.error_message_32.to_string_8)
			end
			unset_map_name (a_base_selection)
			a_base_selection.terminate
		end

	execute_change (a_base_change: DB_CHANGE)
			-- Execute the Current sql query .
		do
			to_implement ("Check test dynamic sequel. to redesign.")
			set_map_name (a_base_change)
			a_base_change.set_query (query)
			a_base_change.execute_query
			unset_map_name (a_base_change)
		end

feature --  Access

	query: STRING_8
			-- SQL query to execute.

	parameters: STRING_TABLE [ANY]
			-- query parameters.

feature -- Status Report

	has_error: BOOLEAN
		-- is there an error?

	error_message: detachable STRING_32
		-- Error message if any.

	error_code: INTEGER
		-- Error code.

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

	log_parameters (a_parameters: like parameters): STRING
			-- Parameters to log with name and value
			-- exclude sensitive information.
		do
			create Result.make_empty
			from
				a_parameters.start
			until
				a_parameters.after
			loop
				Result.append ("name:")
				Result.append (a_parameters.key_for_iteration.to_string_8)
				Result.append (", value:")
				if
					a_parameters.key_for_iteration.has_substring ("Password") or else
					a_parameters.key_for_iteration.has_substring ("password")
				then
					-- Data to exclude
				else
					if attached a_parameters.item_for_iteration as l_item  then
						Result.append (l_item.out)
					end
				end
				Result.append ("%N")
				a_parameters.forth
			end
		end


end -- ESA_DATABASE_QUERY
