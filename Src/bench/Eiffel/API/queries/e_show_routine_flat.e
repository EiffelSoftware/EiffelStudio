indexing
	description: "Command to display flat of `current_feature'."
	date: "$Date$"
	revision: "$Revision $"


class
	E_SHOW_ROUTINE_FLAT 

inherit
	E_FEATURE_CMD
		redefine
			has_valid_feature
		end

creation
	make, do_nothing

feature -- Access

	has_valid_feature: BOOLEAN is True
			-- Always a valid feature

feature -- Execution

	work is
		local
			ctxt: FEATURE_TEXT_FORMATTER;
			text_filter: TEXT_FILTER
		do
			!! ctxt;
				--| Show the flat format, that's why we are passing `False'
				--| as parameter to the `format' feature
			ctxt.format (current_feature, False);
			structured_text.add_string (ctxt.text.image);
			structured_text.add_new_line
		end;

end -- class E_SHOW_ROUTINE_FLAT
