class EWB_FREEZE 

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			execute, loop_execute
		end

feature

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

feature

	loop_execute is
		do
			if confirmed ("Freezing implies some C compilation and linking.%N%
							%Do you want to do it now") then
				execute
			end
		end;

	execute is
		do
			init;
			if not error_occurred then
				System.set_freeze (True);
				compile;
				if System.successfull then
					terminate_project;
					print_tail;
					prompt_finish_freezing (False)
				end;
			end;
		end;

end
