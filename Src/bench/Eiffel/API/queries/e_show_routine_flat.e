indexing

	description: 
		"Command to display flat of `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_ROUTINE_FLAT 

inherit

	E_FEATURE_CMD
		redefine
			has_valid_feature
		end

creation

	make, do_nothing

feature -- Access

	has_valid_feature: BOOLEAN is
			-- Always a valid feature
		do
			Result := True
		end

feature -- Execution

	work is
		local
			ctxt: FEATURE_TEXT_FORMATTER;
			text_filter: TEXT_FILTER
		do
			!! ctxt;
			ctxt.format (current_feature);
			structured_text.add_string (ctxt.text.image);
			structured_text.add_new_line
		end;

end -- class E_SHOW_ROUTINE_FLAT
