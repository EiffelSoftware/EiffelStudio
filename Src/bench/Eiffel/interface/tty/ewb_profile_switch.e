indexing

	description:
			"General features of profile switches for output.";
	date:		"$Date$";
	revision:	"%Revision $"

deferred class EWB_PROFILE_SWITCH

inherit
	EWB_CMD
	SHARED_QUERY_VALUES

feature {EWB_SWITCHES_CMD} -- Help message

	show_enabled: BOOLEAN
		-- Should number of calls be shown?

	help_message: STRING is
		local
			current_value: STRING
		do
			if show_enabled then
				Result := "disable"
				current_value := "[enabled]";
			else
				Result := "enable"
				current_value := "[disabled]";
			end;
			Result.append (real_help_message);
			Result.append (tabs);
			Result.append (current_value);
		end;

feature {NONE} -- Execution

	execute is
			-- Execute Current batch command.
		local
			new_array: ARRAY [STRING];
			i: INTEGER;
		do
			show_enabled := not show_enabled;
			if not show_enabled then
				from
					create new_array.make (1, 0);
					i := 1;
				until
					i > output_names.count
				loop
					if not output_names.item (i).is_equal (column_name) then
						new_array.force (output_names.item (i), new_array.count + 1);
					end;
					i := i + 1;
				end;
				output_names.copy (new_array);
			else
				output_names.force (column_name, output_names.count + 1);
			end;
		end;

feature -- Output strings

	real_help_message: STRING is
			-- Used in help_message.
		deferred
		end

	tabs: STRING is
			-- Used in help_message.
		deferred
		end

	column_name: STRING is
			-- Used in execute.
		deferred
		end

	abbrev_cmd_name: STRING is
			-- Used in EWB_SWITCHES_CMD
		deferred
		end;

end -- class EWB_PROFILE_SWITCH
