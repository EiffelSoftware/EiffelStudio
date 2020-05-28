note
	description: "Asynchronous check for service availability."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ASYNC_STATUS

inherit
	ES_CLOUD_ASYNC_JOB

create
	make

feature {NONE} -- Access: worker thread

	is_available: BOOLEAN

feature -- Execution in concurrent thread

	execute
		local
			wapi: ES_CLOUD_API
		do
			wapi := web_api
			wapi.get_is_available
			is_available := wapi.is_available
		end

feature -- Execution in main thread		

	pre_execute
		do
			is_available := False
		end

	post_execute
		do
			debug ("es_cloud")
				print (generator + ": cloud is available = " + is_available.out + "%N")
			end
--			if is_available then
				service.on_cloud_available (is_available)
--			end
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
