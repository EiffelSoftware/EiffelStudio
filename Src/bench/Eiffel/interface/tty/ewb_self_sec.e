indexing

	description:
			"Disables or Enables output of time spent in feature in %
			% profile-output";
	default:	"disabled";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_SELF_SEC

inherit
	EWB_PROFILE_SWITCH
		rename
			name as self_sec_cmd_name,
			abbreviation as self_sec_abb
		end

feature {NONE} -- Help message

	real_help_message: STRING is
		once
			Result := self_sec_help;
		end;

	tabs: STRING is
		once
			Result := "%T%T%T";
		end;

	column_name: STRING is
		once
			Result := "self";
		end;

feature -- Output string

	abbrev_cmd_name: STRING is
		once
			Result := "Self";
		end;

end -- class EWB_SELF_SEC
