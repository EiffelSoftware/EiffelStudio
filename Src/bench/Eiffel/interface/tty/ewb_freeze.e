indexing

	description: 
		"Freeze eiffel system.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FREEZE 

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute, loop_action, perform_compilation
		end

feature -- Properties

	name: STRING is
		do
			Result := freeze_cmd_name
		end;

	help_message: STRING is
		do
			Result := freeze_help
		end;

	abbreviation: CHARACTER is
		do
			Result := freeze_abb
		end;

feature {NONE} -- Execution

	loop_action is
		do
			if Eiffel_project.is_read_only then
				io.error.put_string ("Read-only project: cannot compile.%N")
			elseif 
				command_line_io.confirmed 
					("Freezing implies some C compilation and linking.%N%
							%Do you want to do it now") 
			then
				execute
			end
		end;

	execute is
		do
			if Eiffel_project.is_read_only then
				io.error.put_string ("Read-only project: cannot compile.%N")
			else	
				init;
				if Eiffel_ace.file_name /= Void then
					compile;
					if Eiffel_project.successful then
						print_tail;
						process_finish_freezing (False);
					end
				end;
			end;
		end;

feature {NONE} -- Implementation

    perform_compilation is
            -- Melt eiffel project.
        do
            Eiffel_project.freeze;
        end;

end -- class EWB_FREEZE
