indexing

	description:
			"Disables or Enables output of number of calls in %
			% profile-output";
	default:	"enabled";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_NUMBER_OF_CALLS

inherit
	EWB_PROFILE_SWITCH
		rename
			name as number_of_calls_cmd_name,
			abbreviation as number_of_calls_abb
		end

create
	make_loop

feature -- Creation

	make_loop is
		do
			show_enabled := true;
			output_names.force ("calls", output_names.count + 1);
		end;

feature {NONE} -- Help message

	real_help_message: STRING is
		once
			Result := number_of_calls_help;
		end;

	tabs: STRING is
		once
			Result := "%T%T%T";
		end;

	column_name: STRING is
		once
			Result := "calls";
		end;

feature -- Output string

	abbrev_cmd_name: STRING is
		once
			Result := "#Call";
		end;

end -- class EWB_NUMBER_OF_CALLS
