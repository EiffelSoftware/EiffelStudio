note
	description: "Summary description for {IRON_NODE_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_EXECUTION

inherit
	WSF_EXECUTION

	WSF_FILTERED_EXECUTION

	WSF_FILTER
		rename
			execute as execute_filter
		end

	IRON_NODE_CONSTANTS

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {IRON_NODE_SERVICE_I} -- Services

--	api_service: IRON_NODE_API_SERVICE
--		local
--			s: like internal_api_service
--		do
--			s := internal_api_service
--			if s = Void then
--				create s.make (iron, Current)
--				internal_api_service := s
--			end
--			Result := s
--		end

--	cms_service: IRON_NODE_CMS_SERVICE
--		local
--			s: like internal_cms_service
--		do
--			s := internal_cms_service
--			if s = Void then
--				create s.make (iron, Current)
--				internal_cms_service := s
--			end
--			Result := s
--		end

feature {NONE} -- Internal

--	internal_api_service: detachable like api_service

--	internal_cms_service: detachable like cms_service

feature -- Iron

	iron: IRON_NODE

feature -- Execution

	execute_filter (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			d: HTTP_DATE
		do
			create d.make_now_utc
			res.put_header_line ("Date: " + d.string)

--			if req.request_uri.starts_with_general (iron.api_base_url) then
--				res.put_header_line ("X-IronServer-API: " + version)
--				api_service.execute (req, res)
--			else
--				res.put_header_line ("X-IronServer-CMS: " + version)
--				cms_service.execute (req, res)
--			end
		end

feature -- Router and Filter

	create_filter
			-- Create `filter'
		local
			f, l_filter: detachable WSF_FILTER
			fh: WSF_CUSTOM_HEADER_FILTER
			cfg: IRON_CONFIGURATION_FILTER
		do
			l_filter := Void
			create cfg
			cfg.uploaded_file_path := iron.layout.tmp_path
			cfg.set_next (l_filter)
			l_filter := cfg

				-- Header
			create fh.make (1)
			fh.set_next (l_filter)
			fh.custom_header.put_header ("X-IronServer: " + version)
			l_filter := fh

				-- Maintenance
			create {WSF_MAINTENANCE_FILTER} f
			f.set_next (l_filter)
			l_filter := f
			debug ("iron")
					-- Debug
				create {WSF_DEBUG_FILTER} f
				f.set_next (l_filter)
				l_filter := f
			end

			if launcher.is_console_output_supported then
					-- Logging for nino
				create {WSF_LOGGING_FILTER} f.make_with_output (io.output)
				f.set_next (l_filter)
				l_filter := f
			end

--			if attached iron.basedir as p_basedir then
--				create {WSF_FILE_SYSTEM_FILTER} f.make_with_path (p_basedir.extended ("html"))
--				f.set_next (l_filter)
--				l_filter := f
--			end

			filter := l_filter
		end

	setup_filter
			-- Setup `filter'
		local
			f: WSF_FILTER
		do
			from
				f := filter
			until
				not attached f.next as l_next
			loop
				f := l_next
			end
			f.set_next (Current)
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
