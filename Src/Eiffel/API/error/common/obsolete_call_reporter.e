note
	description: "An reporter for obsolete calls."
	date: "$Date$"
	revision: "$Revision$"
	ca_ignore: "CA011", "CA011: too many arguments"

deferred class OBSOLETE_CALL_REPORTER [CONTEXT]

feature -- Report

	report_obsolete_call (obsolete_message: READABLE_STRING_32; clean_message: READABLE_STRING_32; expiration: INTEGER_32; severity: NATURAL_32; context: CONTEXT)
			-- Report an obsolete call in context `context` with orignal obsolete message `obsolete_message`,
			-- cleaned obsolete message `clean_message` and the issue severity `severity`
			-- with the number of days before it expires `expiration`.
			-- If `expiration > 0`, `expiration` denotes a number of days before a warning or a hint becomes an error.
			-- Otherwise `- expiration` means the number of days since the expriration date passed.
		require
			is_valid_severity: is_valid_severity (severity)
		deferred
		end

feature -- Severity

	is_valid_severity (obsolete_call_severity: NATURAL_32): BOOLEAN
			-- Is `obsolete_call_severity` a valid obsolete call severity level?
		do
			inspect
				obsolete_call_severity
			when obsolete_call_error, obsolete_call_warning, obsolete_call_hint then
				Result := True
			else
					-- False otherwise.
			end
		ensure
			class
			definition: Result = (<<obsolete_call_error, obsolete_call_warning, obsolete_call_hint>>).has (obsolete_call_severity)
		end

	obsolete_call_error: NATURAL_32 = 0
			-- The severity level indicating that the obsolete call should be reported as an error.
			-- See also: `obsolete_call_warning`, `obsolete_call_hint`.

	obsolete_call_warning: NATURAL_32 = 1
			-- The severity level indicating that the obsolete call should be reported as a warning.
			-- See also: `obsolete_call_error`, `obsolete_call_hint`.

	obsolete_call_hint: NATURAL_32 = 2
			-- The severity level indicating that the obsolete call should be reported as a hint.
			-- See also: `obsolete_call_error`, `obsolete_call_warning`.

feature {NONE} -- Typing

	frozen context_type: CONTEXT
			-- The type of the context.
		require
			is_callable: False
		do
		ensure
			exists: False
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
