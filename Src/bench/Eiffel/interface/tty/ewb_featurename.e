indexing

	description:
			"Disables or Enables output of featurenames in %
			% profile-output";
	default:	"enabled";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_FEATURENAME

inherit
	EWB_PROFILE_SWITCH
		rename
			name as featurename_cmd_name,
			abbreviation as featurename_abb
		end

create
	make_loop

feature -- Creation

	make_loop is
		do
			show_enabled := true;
			output_names.force ("featurename", output_names.count + 1);
		end;

feature {NONE} -- Initialization

	init is
		do
		end

feature {NONE} -- Help message

	real_help_message: STRING is
		once
			Result := featurename_help;
		end;

	tabs: STRING is
		once
			Result := "%T%T%T%T%T";
		end;

	column_name: STRING is
		once
			Result := "featurename"
		end;

feature -- Output string

	abbrev_cmd_name: STRING is
		once
			Result := "Name";
		end;

end -- class EWB_FEATURENAME
