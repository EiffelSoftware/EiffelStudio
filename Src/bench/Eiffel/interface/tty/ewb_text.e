
class EWB_TEXT 

inherit

	EWB_CMD
		rename
			name as text_cmd_name,
			help_message as text_help,
			abbreviation as text_abb
		end

creation

	make, null

feature -- Creation

	make (cn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
		end;

	class_name: STRING;

feature

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			class_name.to_lower;
			execute;
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
					text := class_i.stone.origin_text
					if text /= Void then
						output_window.put_string (text);
						output_window.new_line;
					else
						output_window.put_string ("Cannot open ");
						output_window.put_string (class_i.file_name);
						output_window.new_line;
					end;
				end;
			end;
		end;

end
