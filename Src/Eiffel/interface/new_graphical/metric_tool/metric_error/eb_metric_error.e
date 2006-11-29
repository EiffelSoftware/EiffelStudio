indexing
	description: "Metric error class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ERROR

inherit
	EB_METRIC_SHARED

create
	make

feature{NONE} -- Initialization

	make (a_message: like message) is
			-- Initialize `message' with `a_message'.
		require
			a_message_attached: a_message /= Void
		do
			set_message (a_message)
		end

feature -- Access

	message: STRING_GENERAL
			-- The error message.

	to_do: STRING_GENERAL
			-- Information about how to do to deal with current error

	location: STRING_GENERAL
			-- Location where current error occurs

	message_with_location: STRING_GENERAL is
			-- `message' with `location' (if any)
		local
			l_str: STRING_32
		do
			create l_str.make (message.count + 64)
			l_str.append (message)
			if location /= Void then
				l_str.append (metric_names.location_string (location))
			end
			Result := l_str
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_message (a_message: like message) is
			-- Set `message 'with `a_message'.
		require
			a_message_attached: a_message /= Void
		do
			create {STRING_32}message.make_from_string (a_message)
		ensure
			message_set: message /= Void and then message.is_equal (a_message)
		end

	set_location (a_location: like location) is
			-- Set `location 'with `a_location'.
		do
			if a_location /= Void then
				create {STRING_32}location.make_from_string (a_location)
			else
				location := Void
			end
		ensure
			location_set: (a_location /= Void implies location.is_equal (a_location)) and then
						  (a_location = Void) implies location = Void
		end

	set_to_do (a_to_do: like to_do) is
			-- Set `to_do' with `a_to_do'.
		do
			if a_to_do /= Void then
				create {STRING_32}to_do.make_from_string (a_to_do)
			else
				to_do := Void
			end
		ensure
			to_do_set: (a_to_do = Void implies to_do = Void) and (a_to_do /= Void implies (to_do /= Void and then to_do.is_equal (a_to_do)))
		end

invariant
	message_attached: message /= Void

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



end
