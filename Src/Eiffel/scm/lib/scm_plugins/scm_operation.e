note
	description: "Summary description for {SCM_OPERATION}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_OPERATION

feature -- Access

	root_location: SCM_DISTRIBUTED_LOCATION

	is_processed: BOOLEAN
	has_error: BOOLEAN
	execution_message: detachable READABLE_STRING_32

feature -- Element change

	reset
		do
			is_processed := False
			has_error := False
			execution_message := Void
		end

	report_error (m: READABLE_STRING_GENERAL)
		do
			is_processed := True
			has_error := True
			if attached execution_message as msg then
				execution_message := msg + "%N" + m
			else
				execution_message := m
			end
		end

	report_success (m: READABLE_STRING_GENERAL)
		do
			is_processed := True
			if attached execution_message as msg then
					-- Keep previous `has_error` as there was already an execution message.
				execution_message := msg + "%N" + m
			else
				has_error := False
				execution_message := m
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
