indexing
	description: "Parse error class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ERROR_PARSE

inherit
	EB_METRIC_ERROR

create
	default_create,
	make,
	make_with_no_title

feature {NONE} -- Initialization

	make (a_message: STRING) is
			-- Create.
		require
			a_message_not_void: a_message /= Void
		do
			message := a_message
			should_parser_error_be_displayed := True
		end

	make_with_no_title (a_message: STRING) is
			-- Initialize with `a_message'.
		require
			a_message_not_void: a_message /= Void
		do
			make (a_message)
			should_parser_error_be_displayed := False
		end

feature -- Access

	text: STRING is
		do
			create Result.make (message.count + 20)
			if should_parser_error_be_displayed then
				Result.append (once "Parser error: ")
			end
			Result.append (message)
		end

feature -- Status report

		should_parser_error_be_displayed: BOOLEAN
				-- Should "Parser error" be displayed before actual error message?
				-- Default: True

feature -- Update

	set_message (a_message: STRING) is
			-- Set the extended error message to `a_message'.
		require
			a_message_attached: a_message /= Void
		do
			create message.make_from_string (a_message)
		end

feature {NONE} -- Implementation

	message: STRING
			-- Error message

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
