note
	description: "Database Store Procedure"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_STORE_PROCEDURE

inherit

	SHARED_ERROR

create
	data_reader, data_writer

feature -- Intialization

	data_reader (a_sp: STRING; a_parameters: HASH_TABLE [ANY, STRING_32])
			-- SQL data reader for the stored procedure `a_sp' with arguments `a_parameters'.
		local
			l_retried: BOOLEAN
		do
			write_information_log (generator + ".data_reader" + " execute store procedure: " + a_sp)
			write_debug_log (generator + ".data_reader" + " arguments:" + log_parameters (a_parameters))
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
							write_debug_log ( generator + ".data_reader: " + proc.text_32)
						end
					end
				else
					has_error := True
					error_message := proc.error_message_32
					error_code := proc.error_code
					write_error_log (generator + ".data_witer message:" + proc.error_message_32 + " code:" + proc.error_code.out)
				end
			else
				stored_procedure := a_sp
				parameters := a_parameters
				create proc.make (stored_procedure)
			end
		rescue
			set_last_error_from_exception ("SQL execution")
			write_critical_log (generator+ ".data_reader " + last_error_message)
			l_retried := True
			retry
		end

	data_writer (a_sp: STRING; a_parameters: HASH_TABLE [ANY, STRING_32])
			-- SQL data reader for the stored procedure `a_sp' with arguments `a_parameters'
		local
			l_retried: BOOLEAN
		do
			write_information_log (generator + ".data_reader" + " execute store procedure: " + a_sp)
			write_debug_log (generator + ".data_reader" + " arguments:" + log_parameters (a_parameters))
			if not l_retried then
				stored_procedure := a_sp
				parameters := a_parameters
				create proc.make (stored_procedure)
				proc.load
				proc.set_arguments_32 (a_parameters.current_keys, a_parameters.linear_representation.to_array)
				if proc.exists then
					if proc.text_32 /= Void then
						debug
							write_debug_log ( generator + ".data_writer: " + proc.text_32)
						end
					end
				else
					has_error := True
					error_message := proc.error_message_32
					error_code := proc.error_code
					write_error_log (generator + ".data_witer message:" + proc.error_message_32 + " code:" + proc.error_code.out)
				end
			else
				stored_procedure := a_sp
				parameters := a_parameters
				create proc.make (stored_procedure)
			end
		rescue
			set_last_error_from_exception ("SQL execution")
			write_critical_log (generator+ ".data_reader " + last_error_message)
			l_retried := True
			retry
		end

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
				Result.append (a_parameters.key_for_iteration)
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

end
