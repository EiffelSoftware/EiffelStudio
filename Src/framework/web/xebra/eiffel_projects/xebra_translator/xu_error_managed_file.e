note
	description: "[
		Manages the processing and ensuing error handling of a file.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_ERROR_MANAGED_FILE

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

feature -- Initialization

feature -- Access

	process_file (a_file_name: READABLE_STRING_8; a_action: PROCEDURE [ANY, TUPLE [file: KI_CHARACTER_INPUT_STREAM]])
			-- Manages error handling of a file and processes `a_action' with it
			-- `a_file_name': The filename/path
			-- `a_action': The action which should be executed with the file
		require
			a_file_name_attached: attached a_file_name
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_action_attached: attached a_action
		local
			l_file: KL_TEXT_INPUT_FILE
			l_generic_file_name: FILE_NAME
		do
			create l_generic_file_name.make_from_string (a_file_name)
			create l_file.make (l_generic_file_name)
			if (not l_file.exists) then
				error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_generic_file_name), false)
			else
				l_file.open_read
				if not l_file.is_open_read then
					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (l_generic_file_name), false)
				else
					a_action.call ([l_file])
					l_file.close
				end
			end
		rescue
			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
		end

--	read_file (a_filename: STRING): STRING
--			--reads a file into a string			
--		local
--			l_file: PLAIN_TEXT_FILE
--			l_failed: BOOLEAN
--		do
--			Result := ""
--			if l_failed then
--				error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_filename), false)
--			else
--				create l_file.make (a_filename)
--				if not l_file.exists then
--					error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_filename), false)
--				else
--					l_file.open_read
--					if not l_file.is_open_read then
--						error_manager.add_error (create {XERROR_FILE_NOT_FOUND}.make (a_filename), false)
--					else
--						from until l_file.end_of_file
--						loop
--							l_file.read_line

--							if attached {STRING} l_file.last_string as s then
--								Result.append(s)
--							else
--								Result.append ("")
--							end
--						end
--						l_file.close
--					end
--				end
--			end
--			rescue
--				l_failed := true
--				retry
--		end

end
