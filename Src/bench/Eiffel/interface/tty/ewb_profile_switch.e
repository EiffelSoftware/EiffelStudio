indexing

	description:
			"General features of profile switches for output."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EWB_PROFILE_SWITCH
