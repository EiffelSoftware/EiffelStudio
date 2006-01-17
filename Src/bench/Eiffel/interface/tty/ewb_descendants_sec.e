indexing

	description:
			"Disables or Enables output of descendants-time in %
			% profile-output"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EWB_DESCENDANTS_SEC
