indexing

	description: 
		"Freeze eiffel system.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_QUICK_MELT 

inherit

	EWB_COMP
		redefine
			name, help_message, abbreviation,
			perform_compilation
		end

feature -- Properties

	name: STRING is
		do
			Result := quick_melt_cmd_name
		end;

	help_message: STRING is
		do
			Result := quick_melt_help
		end;

	abbreviation: CHARACTER is
		do
			Result := quick_melt_abb
		end;

feature {NONE} -- Implementation

    perform_compilation is
            -- Quick melt of Current eiffel project.
        do
            Eiffel_project.quick_melt;
        end;

end -- class EWB_QUICK_MELT
