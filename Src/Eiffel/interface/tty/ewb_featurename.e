note

	description:
			"Disables or Enables output of featurenames in %
			% profile-output"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	make_loop
		do
			show_enabled := true;
			output_names.force ("featurename", output_names.count + 1);
		end;

feature {NONE} -- Initialization

	init
		do
		end

feature {NONE} -- Help message

	real_help_message: STRING_32
		once
			Result := featurename_help;
		end;

	tabs: STRING
		once
			Result := "%T%T%T%T%T";
		end;

	column_name: STRING
		once
			Result := "featurename"
		end;

feature -- Output string

	abbrev_cmd_name: STRING
		once
			Result := "Name";
		end;

note
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

end -- class EWB_FEATURENAME
