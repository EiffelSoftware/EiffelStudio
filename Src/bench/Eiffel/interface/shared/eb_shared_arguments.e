indexing
	description: "Facilities concerning the command line management"
	author: "Xavier Rousselot"
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
			create shared_eiffel
			if not shared_eiffel.Eiffel_ace.lace.argument_list.is_empty then
				Result := shared_eiffel.Eiffel_ace.lace.argument_list.i_th (1)
				if Result.is_equal (" ") then -- (No argument)
					Result := ""
				end
			else
				Result := ""
			end
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
			end
		end

end -- class EB_SHARED_ARGUMENTS
