indexing

	description:
			"Disables or Enables output of number of calls in %
			% profile-output";
	default:	"disabled";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_PERCENTAGE

inherit
	EWB_PROFILE_SWITCH
		rename
			name as percentage_cmd_name,
			abbreviation as percentage_abb
		end

feature {NONE} -- Help message

	real_help_message: STRING is
		once
			Result := Percentage_help;
		end;

	tabs: STRING is
		once
			Result := "%T%T";
		end;

	column_name: STRING is
		once
			Result := "percentage";
		end;

feature -- Output string

	abbrev_cmd_name: STRING is
		once
			Result := "%%Time";
		end;

end -- class EWB_PERCENTAGE
