indexing

	description: 
		"Displays short of a class in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_SHORT 

inherit

	EWB_FILTER
		redefine
			help_message, name, abbreviation,
			set_format_attributes
		end;

creation

	make, do_nothing

feature -- Properties

	name: STRING is
		do
			Result := short_cmd_name;
		end;

	abbreviation: CHARACTER is
		do
			Result := short_abb
		end;

	help_message: STRING is
		do
			Result := short_help
		end;

feature {NONE} -- Implementation

	set_format_attributes (ctxt: CLASS_TEXT_FORMATTER) is
			-- Set context attributes `ctxt'.
		do
			ctxt.set_is_short;
			ctxt.set_order_same_as_text;
		end;

end -- class EWB_SHORT
