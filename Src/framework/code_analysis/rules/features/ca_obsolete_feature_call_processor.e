note
	description: "[
			Processor for obsolete feature calls.
			It is used as a replacement for a standard obsolete feature call processor in the compiler.
			It provides fine-grained information about obsolete calls, including whether the issue should be reported as an error or as a warning and how many days remain before a warning turns into an error.
		]"
	date: "$Date$"
	revision: "$Revision$"


class
	CA_OBSOLETE_FEATURE_CALL_PROCESSOR [CONTEXT]

inherit
	CA_OBSOLETE_FEATURE

create
	make

feature -- Processing

	process (message: READABLE_STRING_8; warning_index: like {CONF_OPTION}.warning_term_index_none; context: CONTEXT; reporter: OBSOLETE_CALL_REPORTER [CONTEXT])
			-- A procedure to process the osbolete message `message` with the flag indicating whether the warning is enabled `is_warning_enabled`
			-- and report it using one of `report_error`, `report_warning` or `report_hint` accordingly.
		local
			stamp: like {OBSOLETE_MESSAGE_PARSER}.date
			expires_in: INTEGER
			clean_message: READABLE_STRING_32
			obsolete_message: READABLE_STRING_32
			u: UTF_CONVERTER
			is_error: BOOLEAN
			is_warning: BOOLEAN
			is_hint: BOOLEAN
		do
			stamp := {OBSOLETE_MESSAGE_PARSER}.date (message)
			obsolete_message := u.utf_8_string_8_to_string_32 (message)
			clean_message := u.utf_8_string_8_to_string_32 (stamp.message)
			expires_in := stamp.date.relative_duration (create {DATE}.make_now_utc).days_count
			if
				warning_index /= {CONF_OPTION}.warning_term_index_none or else
				expires_in + feature_call_suppression_period.value <= 0
			then
					-- Warnings are either enabled or cannot be suppressed.
				if expires_in > 0 then
					is_hint := warning_index = {CONF_OPTION}.warning_term_index_all
				else
					is_warning := True
				end
			end
			expires_in := expires_in + feature_call_expiration.value
			is_error := expires_in <= 0
			if is_error then
				reporter.report_obsolete_call (obsolete_message, clean_message, expires_in, {OBSOLETE_CALL_REPORTER [CONTEXT]}.obsolete_call_error, context)
			elseif is_warning then
				reporter.report_obsolete_call (obsolete_message, clean_message, expires_in, {OBSOLETE_CALL_REPORTER [CONTEXT]}.obsolete_call_warning, context)
			elseif is_hint then
				reporter.report_obsolete_call (obsolete_message, clean_message, expires_in, {OBSOLETE_CALL_REPORTER [CONTEXT]}.obsolete_call_hint, context)
			end
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
