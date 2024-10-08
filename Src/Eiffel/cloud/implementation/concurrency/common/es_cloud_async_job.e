note
	description: "Summary description for {ES_CLOUD_ASYNC_JOB}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_ASYNC_JOB

feature {NONE} -- Initialization

	make (a_service: ES_CLOUD_S; cfg: ES_CLOUD_CONFIG)
		require
			a_service /= Void
		do
			service := a_service
			config := cfg
		end

feature -- Access: Current

	service: ES_CLOUD_S

feature {NONE} -- Access: worker thread

	config: ES_CLOUD_CONFIG

	web_api: ES_CLOUD_API
		local
			cfg: ES_CLOUD_CONFIG
		do
			create cfg.make_from_separate (config)
			Result := once_web_api
			Result.set_config (cfg)
		end

	once_web_api: ES_CLOUD_API
		once ("THREAD")
			create Result.make (config)
		end

feature -- Execution in concurrent thread

	execute
		deferred
		end

feature -- Execution in main thread		

	pre_execute
		deferred
		end

	post_execute
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
