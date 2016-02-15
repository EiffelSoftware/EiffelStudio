note
	description: "Summary description for {ES_LIBRARY_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LIBRARY_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_count: INTEGER)
		do
			create providers.make (a_count)
		end

feature -- Access

	libraries (a_target: CONF_TARGET; a_provider_id: detachable READABLE_STRING_GENERAL): STRING_TABLE [CONF_SYSTEM_VIEW]
			-- Available libraries in the context of target `a_target'.
			-- If `a_provider_id' is set, return only the related libraries.
		local
			libs: like libraries
		do
			create Result.make (0)
			if a_provider_id /= Void then
				if attached provider (a_provider_id) as prov then
					libs := prov.libraries (a_target)
					Result.merge (libs)
				end
			else
				across
					providers as ic
				loop
					libs := ic.item.libraries (a_target)
					Result.merge (libs)
				end
			end
		end

	filtered_libraries (a_filter: READABLE_STRING_GENERAL; a_target: CONF_TARGET; a_provider_id: detachable READABLE_STRING_GENERAL): STRING_TABLE [CONF_SYSTEM_VIEW]
			-- Available libraries in the context of target `a_target' and filtered by `a_filter'.
			-- If `a_provider_id' is set, return only the related libraries.
		local
			libs: like libraries
		do
			create Result.make (0)
			if a_provider_id /= Void then
				if attached provider (a_provider_id) as prov then
					libs := prov.filtered_libraries (a_filter, a_target)
					Result.merge (libs)
				end
			else
				across
					providers as ic
				loop
					libs := ic.item.filtered_libraries (a_filter, a_target)
					Result.merge (libs)
				end
			end
		end

feature -- Access

	providers: STRING_TABLE [ES_LIBRARY_PROVIDER]

	provider (a_id: READABLE_STRING_GENERAL): detachable ES_LIBRARY_PROVIDER
		do
			Result := providers.item (a_id)
		end

feature -- Element change

	reset_provider (a_id: READABLE_STRING_GENERAL; a_target: CONF_TARGET)
			-- Reset provider associated with `a_id'.
		do
			if attached provider (a_id) as prov then
				prov.clear_cache (a_target)
			end
		end

	register (a_prov: ES_LIBRARY_PROVIDER)
		do
			providers.put (a_prov, a_prov.identifier)
		end

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
