indexing

	description:
			"Disables or Enables output of descendants-time in %
			% profile-output";
	default:	"disabled";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_DESCENDANTS_SEC

inherit
	EWB_PROFILE_SWITCH
		rename
			name as descendants_cmd_name,
			abbreviation as descendants_abb
		end;

feature {NONE} -- Help message

	real_help_message: STRING is
		once
			Result := Descendants_time_help;
		end;

	tabs: STRING is
		once
			Result := "%T%T";
		end;

	column_name: STRING is
		once
			Result := "descendants";
		end;

feature -- Output String

	abbrev_cmd_name: STRING is
		once
			Result := "Desc"
		end;

end -- class EWB_DESCENDANTS_SEC
