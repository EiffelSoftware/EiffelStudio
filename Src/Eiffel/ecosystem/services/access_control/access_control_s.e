note
	description: "[
			Objects that ...
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACCESS_CONTROL_S

inherit
	SERVICE_I

feature -- Execution

	process (issuer: READABLE_STRING_GENERAL; operation: detachable READABLE_STRING_GENERAL; a_action: PROCEDURE)
		local
			cl: CELL [detachable READABLE_STRING_GENERAL]
		do
			create cl.put (Void)
			if is_operation_allowed (issuer, operation, cl) then
				a_action.call (Void)
				record_operation (issuer, operation)
			else
				report_operation_access_not_allowed (issuer, operation, cl.item)
			end
		end

feature -- Access

	is_operation_allowed (issuer: READABLE_STRING_GENERAL; operation: detachable READABLE_STRING_GENERAL; a_denied_reason: detachable CELL [detachable READABLE_STRING_GENERAL]): BOOLEAN
		deferred
		end

feature -- Basic operation

	record_operation (issuer: READABLE_STRING_GENERAL; operation: detachable READABLE_STRING_GENERAL)
		deferred
		end

	report_operation_access_not_allowed (issuer: READABLE_STRING_GENERAL; operation: detachable READABLE_STRING_GENERAL; a_message: detachable READABLE_STRING_GENERAL)
		deferred
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
