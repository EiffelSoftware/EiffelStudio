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

	process_feature (e_feature: E_FEATURE; e_class: CLASS_C) is
			-- Process feature `e_feature' defined in `e_class'.
		local
			text: STRUCTURED_TEXT;
			filter: TEXT_FILTER
		do
            if e_feature.written_class.lace_class.hide_implementation then
                output_window.put_string 
					("Not able to show routine precompiled text (implementation is hidden");
                output_window.new_line;
			else
				if e_class.file_name /= Void then
					text := e_feature.text;
				end;
				if text /= Void then
					if filter_name /= Void and then not filter_name.is_empty then
						!! filter.make (filter_name);
						filter.process_text (text);
						output_window.put_string (filter.image)
					else
						output_window.put_string (text.image)
					end
					output_window.new_line
				else
					output_window.put_string ("Cannot open ");
					output_window.put_string (e_class.file_name);
					output_window.new_line;
				end;
			end
		end;

end -- class EWB_R_TEXT
