indexing

	description: 
		"Displays class flat in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FLAT 

inherit

	EWB_FILTER
		redefine
			name, help_message, abbreviation,
			set_format_attributes
		end

creation

	make, do_nothing

feature -- Properties

	name: STRING is
		do
			Result := flat_cmd_name;
		end;

	help_message: STRING is
		do
			Result := flat_help
		end;

	abbreviation: CHARACTER is
		do
			Result := flat_abb
		end;

feature {NONE} -- Setting

	set_format_attributes (ctxt: CLASS_TEXT_FORMATTER) is
			-- Set context attributes `ctxt'.
		do
			ctxt.set_is_short;
		end;

end -- class EWB_FLAT
