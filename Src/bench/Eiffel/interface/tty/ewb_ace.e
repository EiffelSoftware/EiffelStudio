indexing

	description: 
		"Displays Ace text in output_window.";
	date: "$Date$";
	revision: "$Revision $"


class EWB_ACE 

inherit

	EWB_CMD
		rename
			name as ace_cmd_name,
			help_message as ace_loop_help,
			abbreviation as ace_abb
		end

feature {NONE} -- Execution

	execute is
			-- Execute Current batch command.
		local
			stone: SYSTEM_STONE;
			text: STRING;
		do
			!!stone.make;
			if stone.is_valid then
				text := stone.origin_text
			end;
			if text /= Void then
				output_window.put_string (text);
				output_window.new_line;
			elseif Eiffel_project.lace_file_name = Void then
				output_window.put_string ("You must compile a project first%N");
			else
				output_window.put_string ("Cannot open ");
				output_window.put_string (Eiffel_project.lace_file_name);
				output_window.new_line;
			end;
		end;

end -- class EWB_ACE
