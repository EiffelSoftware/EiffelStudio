
class EWB_ACE 

inherit

	EWB_CMD
		rename
			name as ace_cmd_name,
			help_message as ace_loop_help,
			abbreviation as ace_abb
		end

feature

	execute is
		local
			stone: SYSTEM_STONE;
			text: STRING;
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					!!stone.make (system);
					if stone.is_valid then
						text := stone.origin_text
					end;
					if text /= Void then
						output_window.put_string (text);
						output_window.new_line;
					elseif Lace.file_name = Void then
						output_window.put_string ("You must compile a project first%N");
					else
						output_window.put_string ("Cannot open ");
						output_window.put_string (Lace.file_name);
						output_window.new_line;
					end;
				end;
			end;
		end;

end
