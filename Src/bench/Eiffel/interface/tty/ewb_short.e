class EWB_SHORT 

inherit

	EWB_FS
		redefine
			loop_execute, help_message, name, abbreviation
		end;

creation

	null

feature

	name: STRING is
		do
			Result := short_cmd_name;
		end;

	abbreviation: CHARACTER is
		do
			Result := short_abb
		end;

	help_message: STRING is
		do
			Result := short_help
		end;

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			troffed := False;
			only_current_class := True;
			check_arguments_and_execute;
		end;

end
