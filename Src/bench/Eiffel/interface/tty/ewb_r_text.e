
class EWB_R_TEXT 

inherit

	EWB_FEATURE
		rename
			name as text_cmd_name,
			help_message as r_text_help,
			abbreviation as text_abb
		end

creation

	make, null

feature

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		local
			stone: FEATURE_STONE;
			text: STRING;
		do
			stone := feature_i.stone (class_c);
			text := stone.origin_text;
			if text /= Void then
				output_window.put_string (text);
				output_window.new_line;
			else
				output_window.put_string ("Cannot open ");
				output_window.put_string (class_c.file_name);
				output_window.new_line;
			end;
		end;

end
