note
	description: "Asynchronous check for service availability."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ASYNC_STATUS

inherit
	ES_CLOUD_ASYNC_OPERATION

	SHARED_LOGGER_SERVICE

create
	make

feature {NONE} -- Access: worker thread

	is_available: BOOLEAN

feature {NONE} -- Execution

	execute_operation
		local
			wapi: ES_CLOUD_API
		do
			create wapi.make (config)
			wapi.get_is_available
			is_available := wapi.is_available
		end

feature {NONE} -- Access

	on_operation_completion
		do
			if is_available then
				service.on_cloud_available (is_available)
			end
		end

	reset_operation
		do
			is_available := False
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
