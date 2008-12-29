note
	description: "Object that represent basic utility used in general tooltip support"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GENERAL_TOOLTIP_UTILITY

inherit
	EVS_UTILITY


feature -- Access

	tooltip_window: EVS_GENERAL_TOOLTIP_WINDOW
			-- Window to display tooltip
		once
			create Result.make
		end

feature{NONE} -- Implementation

	tooltip_delay_time: INTEGER
			-- Delay time to display tooltip when pointer is hovering on some region
		do
			Result := ev_application.tooltip_delay
		ensure
			good_result: Result >= 0
		end

	screen: EV_SCREEN
			-- Screen used to get pointer position
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

invariant
	ev_application_attached: ev_application /= Void
	screen_attached: screen /= Void
	tooltip_delay_time_non_negative: tooltip_delay_time >= 0

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

end
