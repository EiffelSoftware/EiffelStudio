indexing

	description: 
		"Displays routine text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_R_TEXT 

inherit

	EWB_FEATURE
		rename
			name as text_cmd_name,
			help_message as r_text_help,
			abbreviation as text_abb
		redefine
			process_feature
		end

creation

	make, do_nothing

feature {NONE} -- Implementation

	associated_cmd: E_FEATURE_CMD is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
			-- (No associated cmd)
		do
			check 
				not_be_called: false
			end
		end;

	process_feature (e_feature: E_FEATURE; e_class: E_CLASS) is
			-- Process feature `e_feature' defined in `e_class'.
		local
			text: STRING;
		do
			if e_class.file_name /= Void then
				text := e_feature.text.image;
			end;
			if text /= Void then
				output_window.put_string (text);
				output_window.new_line;
			else
				output_window.put_string ("Cannot open ");
				output_window.put_string (e_class.file_name);
				output_window.new_line;
			end;
		end;

end -- class EWB_R_TEXT
