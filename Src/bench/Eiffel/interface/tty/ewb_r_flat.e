
class EWB_R_FLAT 

inherit

	EWB_FEATURE
		rename
			name as flat_cmd_name,
			help_message as r_flat_help,
			abbreviation as flat_abb
		end

creation

	make, null

feature

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		local
			ctxt: FORMAT_FEAT_CONTEXT
		do
			!!ctxt.make (class_c);
			ctxt.execute (feature_i);
			output_window.put_string (ctxt.text.image);
			output_window.new_line;
		end;

end
