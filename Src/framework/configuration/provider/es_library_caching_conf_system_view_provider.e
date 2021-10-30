note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_LIBRARY_CACHING_CONF_SYSTEM_VIEW_PROVIDER

inherit
	ES_LIBRARY_PROVIDER

	ES_CACHE_UTILITIES

feature -- Access

	libraries (a_query: detachable READABLE_STRING_32; a_target: CONF_TARGET): ARRAYED_LIST [ES_LIBRARY_PROVIDER_ITEM]
			-- Configuration system view objects indexed by location.
		local
			l_cache_id: READABLE_STRING_8
			libs: like no_cached_libraries
			i: ES_LIBRARY_PROVIDER_ITEM
		do
			l_cache_id := cache_name (a_target)
			if
				is_eiffel_layout_defined and then
				attached {like no_cached_libraries} cached_data (l_cache_id) as cfg_libs
			then
				libs := cfg_libs
			else
				libs := no_cached_libraries (a_query, a_target)
				if is_eiffel_layout_defined then
					cache_data (libs, l_cache_id)
				end
			end
			if a_query /= Void and then not a_query.is_whitespace then
				create Result.make (libs.count)
				across
					scorer.scored_list (a_query, libs, False) as ic
				loop
					create i.make (ic.score, ic.value, ic.value.library_target_name)
					Result.extend (i)
				end
			else
				create Result.make (libs.count)
				across
					libs as ic
				loop
					create i.make (1.0, ic, ic.library_target_name)
					Result.extend (i)
				end
			end
		end

	no_cached_libraries (a_query: detachable READABLE_STRING_GENERAL; a_target: CONF_TARGET): LIST [CONF_SYSTEM_VIEW]
			-- Configuration system view objects indexed by location, ignoring any cached data.
		deferred
		ensure
			result_attached: attached Result
		end

	updated_date (a_target: CONF_TARGET): detachable DATE_TIME
			-- Date of last update.
		do
			Result := cache_date (cache_name (a_target))
		end

feature -- Factory

	scorer: ES_CONF_SYSTEM_VIEW_SCORER
		do
			create Result
		end

feature -- Reset

	reset (a_target: CONF_TARGET)
		do
			if is_eiffel_layout_defined then
				cache_data (Void, cache_name (a_target))
			end
		end

feature {NONE} -- Cache: implementation

	cache_name (a_target: CONF_TARGET): STRING
			-- Cache name depending on `a_target' setting.
		deferred
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
