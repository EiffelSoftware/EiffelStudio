indexing

	description: 
		"Displays class text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_TEXT 

inherit

	EWB_CLASS
		rename
			name as text_cmd_name,
			help_message as text_help,
			abbreviation as text_abb
		redefine
			process_uncompiled_class
		end

creation

	make, do_nothing

feature {NONE} -- Implementation

	associated_cmd: E_CLASS_CMD is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			check
				not_be_called: false
			end
		end;

	process_uncompiled_class (class_i: CLASS_I) is
			-- Display the class text.
		local
			text: STRING
		do
			if class_i.file_name /= Void then
				text := class_i.text
			end;
			if text /= Void then
				output_window.put_string (text);
				output_window.new_line;
			else
				output_window.put_string ("Cannot open ");
				output_window.put_string (class_i.file_name);
				output_window.new_line;
			end;
		end;

end -- class EWB_TEXT
