indexing

	description:
			"Disables or Enables output of descendents-time in %
			% profile-output";
	default:	"disabled";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_DESCENDENTS_SEC

inherit
	EWB_PROFILE_SWITCH
		rename
			name as descendents_cmd_name,
			abbreviation as descendents_abb
		end;

feature {NONE} -- Help message

	real_help_message: STRING is
		once
			Result := Descendents_help;
		end;

	tabs: STRING is
		once
			Result := "%T%T";
		end;

	column_name: STRING is
		once
			Result := "descendents";
		end;

feature -- Output String

	abbrev_cmd_name: STRING is
		once
			Result := "Desc"
		end;

end -- class EWB_DESCENDENTS_SEC
