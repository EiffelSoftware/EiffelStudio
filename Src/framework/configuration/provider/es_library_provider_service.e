note
	description: "[
			Service providing library information.
			Could be local eiffel libraries, iron packages, available packages, web search results.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LIBRARY_PROVIDER_SERVICE

create
	make

feature {NONE} -- Initialization

	make (a_count: INTEGER)
		do
			create providers.make (a_count)
			create on_provider_execution_begin_actions
			create on_provider_execution_end_actions
		end

feature -- Access

	libraries (a_query: detachable READABLE_STRING_32; a_target: CONF_TARGET; a_provider_ids: detachable LIST [READABLE_STRING_GENERAL]): LIST [ES_LIBRARY_PROVIDER_ITEM]
			-- Available libraries in the context of target `a_target'.
			-- If `a_provider_ids' is set and not empty, return only the libraries from the associated providers.
		local
			libs: like libraries
		do
			create {ARRAYED_LIST [ES_LIBRARY_PROVIDER_ITEM]} Result.make (0)
			if a_provider_ids /= Void and then not a_provider_ids.is_empty then
				across
					a_provider_ids as ic
				loop
					if attached provider (ic) as prov then
						libs := provider_libraries (prov, a_query, a_target)
						Result.append (libs)
					end
				end
			else
				across
					providers as ic
				loop
					libs := provider_libraries (ic, a_query, a_target)
					Result.append (libs)
				end
			end
		end

	sorted_libraries (a_query: detachable READABLE_STRING_32; a_target: CONF_TARGET; a_provider_ids: detachable LIST [READABLE_STRING_GENERAL]): LIST [ES_LIBRARY_PROVIDER_ITEM]
		do
			Result := libraries (a_query, a_target, a_provider_ids)
			sort_list (Result)
		end

	sort_list (lst: LIST [ES_LIBRARY_PROVIDER_ITEM])
		do
			sorter.sort (lst)
		end

	sorter: QUICK_SORTER [ES_LIBRARY_PROVIDER_ITEM]
			-- Item sorter.
		once
			create Result.make (create {ES_LIBRARY_PROVIDER_ITEM_COMPARATOR})
		end

	providers: STRING_TABLE [ES_LIBRARY_PROVIDER]

	provider (a_id: READABLE_STRING_GENERAL): detachable ES_LIBRARY_PROVIDER
		do
			Result := providers.item (a_id)
		end

feature -- Actions

	on_provider_execution_begin_actions: ACTION_SEQUENCE [TUPLE [ES_LIBRARY_PROVIDER]]
			-- Actions triggered when entering `libraries' function from the given provider.

	on_provider_execution_end_actions: ACTION_SEQUENCE [TUPLE [ES_LIBRARY_PROVIDER]]
			-- Actions triggered when exiting `libraries' function from the given provider.

feature {NONE} -- Implementation

	provider_libraries (a_provider: ES_LIBRARY_PROVIDER; a_query: detachable READABLE_STRING_32; a_target: CONF_TARGET): LIST [ES_LIBRARY_PROVIDER_ITEM]
			-- Libraries from `a_provider'.
		do
			on_provider_execution_begin (a_provider)
			Result := a_provider.libraries (a_query, a_target)
			on_provider_execution_end (a_provider)
		end

	on_provider_execution_begin (a_provider: ES_LIBRARY_PROVIDER)
		do
			on_provider_execution_begin_actions.call ([a_provider])
		end

	on_provider_execution_end (a_provider: ES_LIBRARY_PROVIDER)
		do
			on_provider_execution_end_actions.call ([a_provider])
		end

feature -- Element change

	reset_all (a_target: CONF_TARGET)
			-- Reset all providers.
		do
			across
				providers as ic
			loop
				ic.reset (a_target)
			end
		end

	reset_provider (a_id: READABLE_STRING_GENERAL; a_target: CONF_TARGET)
			-- Reset provider associated with `a_id'.
		do
			if attached provider (a_id) as prov then
				prov.reset (a_target)
			end
		end

	register (a_prov: ES_LIBRARY_PROVIDER)
		do
			providers.put (a_prov, a_prov.identifier)
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
