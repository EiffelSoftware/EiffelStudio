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
			if Project_read_only.item then
				io.error.put_string ("Read-only project: cannot compile.%N")
			elseif 
				confirmed ("Freezing implies some C compilation and linking.%N%
							%Do you want to do it now") 
			then
				execute
			end
		end;

	execute is
		do
			init;
			if not error_occurred and then Lace.file_name /= Void then
					-- Do not call the once function `System' directly
					-- since it's value may be replaced during the first
					-- compilation (as soon as we figured out whether the
					-- system describes a Dynamic Class Set or not).
				Workbench.system.set_freeze (True);
				compile;
				if Workbench.successfull then
					terminate_project;
					print_tail;
					prompt_finish_freezing (False);
					if System.is_dynamic then
						dle_link_system
					end
				end;
			end;
		end;

end
