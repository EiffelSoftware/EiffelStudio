note
	description: "Abstract Database Query"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_QUERY

inherit
	REFACTORING_HELPER

	SHARED_LOGGER

create
	data_reader

feature {NONE} -- Intialization

	data_reader (a_query: STRING; a_parameters: like parameters)
			-- SQL data reader for the query `a_query' with arguments `a_parameters'
		do
			debug ("cms_storage")
				write_information_log (generator + ".data_reader" + " execute query: " + a_query)
				write_debug_log (generator + ".data_reader" + " arguments:" + log_parameters (a_parameters))
			end
			query := a_query
			parameters := a_parameters
		ensure
			query_set: query = a_query
			parameters_set: parameters = a_parameters
		end

feature -- Execution		

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
				debug ("cms_storage")
					write_error_log (generator + "." + a_base_selection.error_message_32)
				end
			end
			unset_map_name (a_base_selection)
			a_base_selection.terminate
		end

	execute_change (a_base_change: DB_CHANGE)
			-- Execute the Current sql query to change/update data in the database.
		do
			to_implement ("Check test dynamic sequel. to redesign.")
			set_map_name (a_base_change)
			a_base_change.set_query (query)
			a_base_change.execute_query
			unset_map_name (a_base_change)
		end

feature --  Access

	query: STRING
			-- SQL query to execute.

	parameters: detachable STRING_TABLE [detachable ANY]
			-- query parameters.

feature {NONE} -- Implementation

	set_map_name (a_base_selection: DB_EXPRESSION)
			-- Store parameters `item' and their `key'.
		do
			if attached parameters as l_parameters then
				across
					l_parameters as ic
				loop
					a_base_selection.set_map_name (ic.item, ic.key)
				end
			end
		end

	unset_map_name (a_base_selection: DB_EXPRESSION)
			-- Remove parameters item associated with key `key'.
		do
			if attached parameters as l_parameters then
				across
					l_parameters as ic
				loop
					a_base_selection.unset_map_name (ic.key)
				end
			end
		end

	log_parameters (a_parameters: like parameters): STRING
			-- Parameters to log with name and value
			-- exclude sensitive information.
		do
			create Result.make_empty
			if a_parameters /= Void then
				across
					a_parameters as ic
				loop
					Result.append ("name:")
					Result.append (ic.key.as_string_32)
					Result.append (", value:")
					if
						ic.key.has_substring ("Password") or else
						ic.key.has_substring ("password")
					then
						-- Data to exclude
					else
						if attached ic.item as l_item  then
							Result.append (l_item.out)
						end
					end
					Result.append ("%N")
				end
			end
		end


end -- DATABASE_QUERY
