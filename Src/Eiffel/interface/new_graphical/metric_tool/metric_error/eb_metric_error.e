indexing
	description: "Metric error class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_ERROR

inherit
	ANY
		redefine
			out
		end

feature -- Access

	text: STRING is
			-- The error message.
		deferred
		end

	out: STRING is
			-- Output
		do
			Result := text
		end

	to_do: STRING
			-- Information about how to do to deal with current error

feature -- Setting

	set_to_do (a_to_do: STRING) is
			-- Set `to_do' with `a_to_do'.
		do
			if a_to_do /= Void then
				create to_do.make_from_string (a_to_do)
			else
				to_do := Void
			end
		ensure
			to_do_set: (a_to_do = Void implies to_do = Void) and (a_to_do /= Void implies (to_do /= Void and then to_do.is_equal (a_to_do)))
		end

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
