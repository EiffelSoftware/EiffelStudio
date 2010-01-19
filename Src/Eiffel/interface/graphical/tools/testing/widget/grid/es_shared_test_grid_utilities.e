note
	description: "[
		Shared utilities used in widgets displaying test suite/session information.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_SHARED_TEST_GRID_UTILITIES

feature {NONE} -- Access

	token_writer: EB_EDITOR_TOKEN_GENERATOR
			-- Token writer used to create clickable items
		once
			create Result.make
		end

feature {NONE} -- Query: time

	now: DATE_TIME
			-- Now
		do
			create Result.make_now
		end

	today: DATE
			-- Today's date
		do
			create Result.make_now
		end

	date_time (a_date_time: DATE_TIME): STRING
			-- Formatted date or time string, depending if given date was today or longer ago
			--
			-- `a_date_time': Date time for which string should be returned.
		require
			a_date_time_attached: a_date_time /= Void
		do
			if a_date_time.date.ordered_compact_date /= today.ordered_compact_date then
				Result := a_date_time.formatted_out (date_format)
			else
				Result := a_date_time.formatted_out (time_format)
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Basic operations

	reset_token_writer
			-- Wipe out contents of `token_writer'.
		do
			token_writer.wipe_out_lines
			token_writer.disable_multiline
		end

feature {NONE} -- Constants

	date_format: STRING = "[0]mm/[0]dd/yyyy"

	time_format: STRING = "[0]hh:[0]mi"

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
