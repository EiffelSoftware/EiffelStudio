indexing

	description:
			"Disables or Enables output of total amount of time in %
			% both the feature and its descendants in profile-output";
	default:	"disabled";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_TOTAL_SEC

inherit
	EWB_PROFILE_SWITCH
		rename
			name as total_sec_cmd_name,
			abbreviation as total_sec_abb
		end

feature {NONE} -- Help message

	real_help_message: STRING is
		once
			Result := total_sec_help;
		end;

	tabs: STRING is
		once
			Result := "%T";
		end;

	column_name: STRING is
		once
			Result := "total";
		end;

feature -- Output string

	abbrev_cmd_name: STRING is
		once
			Result := "Total";
		end;

end -- class EWB_TOTAL_SEC
