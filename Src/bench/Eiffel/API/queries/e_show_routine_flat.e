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

	execute is
		local
			ctxt: ROUTINE_TEXT_FORMATTER
		do
			!! ctxt;
			ctxt.format (current_feature, current_class);
			output_window.put_string (ctxt.text.image);
			output_window.new_line;
		end;

end -- class E_SHOW_ROUTINE_FLAT
