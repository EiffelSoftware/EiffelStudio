

class EWB_EDIT_CLASS 

inherit

	EWB_CMD
		rename
			name as edit_class_cmd_name,
			help_message as edit_class_help,
			abbreviation as edit_class_abb
		redefine
			loop_execute
		end

feature

	class_name: STRING;

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			check_arguments_and_execute;
		end;

	execute is
		local
			class_i: CLASS_I
			text: STRING;
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					class_i := Universe.unique_class (class_name);
					if class_i /= Void then
						edit (class_i.file_name);
					else
						output_window.put_string (class_name);
						output_window.put_string (" is not in the universe%N");
					end;
				end;
			end;
		end;

end
