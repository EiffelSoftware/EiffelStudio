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
		do
			if current_selected_cmd_line_argument.item /= Void then
				Result := Current_selected_cmd_line_argument.item
			else
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
				current_selected_cmd_line_argument.put (Result)
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
