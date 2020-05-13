note
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_STORE_PROCEDURE

inherit
	LOCALIZED_PRINTER

create
	data_reader, data_writer, new_store_2, new_store

feature {NONE} -- Intialization

	data_reader (a_sp: STRING; a_parameters: HASH_TABLE [detachable ANY, STRING_32])
			-- SQL data reader for the stored procedure `a_sp' with arguments `a_parameters'.
		local
			l_retried: BOOLEAN
		do
			io.put_string (generator + ".data_reader" + " execute store procedure: " + a_sp)
			io.put_string (generator + ".data_reader" + " arguments:" + log_parameters (a_parameters))
		    if not l_retried then
				stored_procedure := a_sp
				parameters := a_parameters
				create proc.make (stored_procedure)
				proc.load
				if not a_parameters.is_empty then
					proc.set_arguments_32 (a_parameters.current_keys, a_parameters.linear_representation.to_array)
				end
				if proc.exists then
					if proc.text_32 /= Void then
						debug
							io.put_string (generator + ".data_reader: ")
							io.put_string_32 (proc.text_32)
						end
					end
				else
					has_error := True
					error_message := proc.error_message_32
					error_code := proc.error_code
					io.put_string (generator + ".data_reader message:")
					io.put_string_32 (proc.error_message_32)
					io.put_string (" code:" + proc.error_code.out)
				end
			else
				stored_procedure := a_sp
				parameters := a_parameters
				create proc.make (stored_procedure)
			end
		rescue
			if attached error_message as l_message then
				io.put_string (generator + ".data_reader ")
				io.put_string_32 (l_message)
			end
			l_retried := True
			retry
		end

	data_writer (a_sp: STRING; a_parameters: HASH_TABLE [ANY, STRING_32])
			-- SQL data reader for the stored procedure `a_sp' with arguments `a_parameters'
		local
			l_retried: BOOLEAN
		do
			io.put_string (generator + ".data_writer" + " execute store procedure: " + a_sp)
			io.put_string (generator + ".data_writer" + " arguments:" + log_parameters (a_parameters))
			if not l_retried then
				stored_procedure := a_sp
				parameters := a_parameters
				create proc.make (stored_procedure)
				proc.load
				if not a_parameters.is_empty then
					proc.set_arguments_32 (a_parameters.current_keys, a_parameters.linear_representation.to_array)
				end
				if proc.exists then
					if proc.text_32 /= Void then
						debug
							io.put_string (generator + ".data_writer: ")
							io.put_string_32 (proc.text_32)
						end
					end
				else
					has_error := True
					error_message := proc.error_message_32
					error_code := proc.error_code
					io.put_string (generator + ".data_witer message:")
					io.put_string_32 (proc.error_message_32)
					io.put_string (" code:" + proc.error_code.out)
				end
			else
				stored_procedure := a_sp
				parameters := a_parameters
				create proc.make (stored_procedure)
			end
		rescue
			if attached error_message as l_message then
				io.put_string (generator + ".data_writer ")
				io.put_string_32 (l_message)
			end
			l_retried := True
			retry
		end

	new_store (a_name: STRING; a_store: STRING; a_parameters: HASH_TABLE [detachable ANY, STRING_32])
			do
				create proc.make (a_name)
				proc.load
				if not a_parameters.is_empty then
					proc.set_arguments_32 (a_parameters.current_keys, a_parameters.linear_representation.to_array)
				end
				if not proc.exists then
					proc.store (a_store)
				end
				stored_procedure := a_store
				parameters := a_parameters
			end

	new_store_2 (a_name: STRING; a_store: STRING)
		local
			l_proc: like proc
			l_db_change: DB_CHANGE
		do
			stored_procedure := a_store
			create parameters.make (0)

			create l_proc.make (a_name)
			proc := l_proc
			l_proc.load

			if l_proc.exists then
				if attached l_proc.text_32 as t then
					io.put_string ("Stored procedure text: ")
					localized_print (t)
					io.put_new_line
				end
			else
				create l_db_change.make
				l_db_change.set_query (a_store)
				l_db_change.execute_query
				if l_db_change.is_ok then
					l_proc.load
					io.putstring ("Procedure created.%N")
				else
					io.putstring ("Procedure creation failed.%N")
				end
			end
		end

feature -- Execution

	execute_reader (a_base_selection: DB_SELECTION): detachable LIST [DB_RESULT]
			-- Execute the Current store procedure.
		do
			create {ARRAYED_LIST [DB_RESULT]} Result.make (100)
			a_base_selection.set_container (Result)
			set_map_name (a_base_selection)
			proc.execute (a_base_selection)
			a_base_selection.load_result
			Result := a_base_selection.container
			unset_map_name (a_base_selection)
			a_base_selection.terminate
		end

	execute_writer (a_base_change: DB_CHANGE)
			-- Execute the Current store procedure.
		do
			set_map_name (a_base_change)
			proc.execute (a_base_change)
			unset_map_name (a_base_change)
		end


feature --  Access

	proc: DB_PROC
			-- object to create and execute stored procedure.

	parameters: HASH_TABLE [detachable ANY, STRING_32]
			-- Parameters to be used by the stored procedure.

	stored_procedure: STRING
			-- Store procedure to execute

feature -- Status Report

	has_error: BOOLEAN
			-- Is there an error.

	error_message: detachable STRING_32
			-- Last error message.

	error_code: INTEGER
			-- Last error code.

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
				Result.append ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_parameters.key_for_iteration))
				Result.append (", value:")
				if
					a_parameters.key_for_iteration.has_substring ("Password") or else
					a_parameters.key_for_iteration.has_substring ("password")
				then
					-- Data to exclude
				else
					if attached a_parameters.item_for_iteration as l_item then
						if attached {READABLE_STRING_GENERAL} l_item as s then
							Result.append ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s))
						else
							Result.append (l_item.out)
						end
					end
				end
				Result.append ("%N")
				a_parameters.forth
			end
		end

end
