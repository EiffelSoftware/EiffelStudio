indexing

	description: 
		"Displays flat/short of a class in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FS 

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
			Result := flatshort_cmd_name;
		end;

	help_message: STRING is
		do
			Result := flatshort_help
		end;

	abbreviation: CHARACTER is
		do
			Result := flatshort_abb
		end;

feature {NONE} -- Implementation

	set_format_attributes (ctxt: CLASS_TEXT_FORMATTER) is
			-- Set format attributes `ctxt'.
		do
			ctxt.set_is_short;
		end;

end -- class EWB_FS
