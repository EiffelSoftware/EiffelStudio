indexing
	description: "Facilities concerning the command line management"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_ARGUMENTS

feature -- Access
	
	current_cmd_line_argument: STRING is
			-- Current selected command line argument.
		local
			shared_eiffel: SHARED_EIFFEL_PROJECT
			l_args_file: RAW_FILE
			l_last_string: STRING
			l_project: PROJECT_CONTEXT
		do
			if current_selected_cmd_line_argument.item /= Void then
				Result := Current_selected_cmd_line_argument.item
			else
				create l_project
				create l_args_file.make (l_project.Arguments_file_name)
				if not l_args_file.exists then
					create shared_eiffel
					if not shared_eiffel.Eiffel_ace.lace.argument_list.is_empty then
						Result := shared_eiffel.Eiffel_ace.lace.argument_list.i_th (1)
						if Result.is_equal (" ") then
							Result := ""
						else
								-- If it contains some environment variables, they are translated.
							Result := (create {ENV_INTERP}).interpreted_string (Result)
						end
					else
						Result := ""
					end
				else
					if not l_args_file.is_empty then
						l_args_file.open_read
						l_args_file.start
						l_args_file.read_line
						l_last_string := l_args_file.last_string.twin
						l_args_file.close
						if 
							l_last_string /= Void and 
							not (l_last_string.is_empty or else
								l_last_string.is_equal (No_argument_string) or else
								l_last_string.is_equal (" "))
						then
							if l_last_string.item (1) = '[' then
									-- If it contains some environment variables, they are translated.
								if l_last_string.item (l_last_string.count) = 'o' then
									l_last_string.remove (l_last_string.count)
								end
								l_last_string.remove (1)
								l_last_string.remove (l_last_string.count)
								Result := (create {ENV_INTERP}).interpreted_string (l_last_string)
							else
								Result := ""
							end
						else
							Result := ""
						end
					else
						Result := ""
					end
				end
				Current_selected_cmd_line_argument.put (Result)
			end
		ensure
			current_cmd_line_argument_not_void: Result /= Void
		end
		
	current_selected_cmd_line_argument: CELL [STRING] is
			-- Argument last selected by user, if any.
		once
			create Result.put (Void)
		end
		
feature {NONE} -- Constants

	No_argument_string: STRING is "(No argument)"

	application_working_directory: STRING is
			-- Current directory selected for running application.
		local
			shared_eiffel: SHARED_EIFFEL_PROJECT
		do
			create shared_eiffel
			Result := shared_eiffel.Eiffel_ace.lace.application_working_directory
			if Result = Void or else Result.is_empty then
				Result := "."
			else
					-- If it contains some environment variables, they are translated.			
				Result := (create {ENV_INTERP}).interpreted_string (Result)
			end
		ensure
			application_working_directory_not_void: Result /= Void
		end

end -- class EB_SHARED_ARGUMENTS
