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
			ctxt: FORMAT_FEAT_CONTEXT
		do
			!! ctxt.make (current_class);
			ctxt.execute (current_feature);
			output_window.put_string (ctxt.text.image);
			output_window.new_line;
		end;

end -- class E_SHOW_ROUTINE_FLAT
