note
	description: "[
		An extended help provider interface {HELP_PROVIDER_I} to augment an implemented help provider with search capabilities.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	SEARCHABLE_HELP_PROVIDER_I

inherit
	HELP_PROVIDER_I

feature -- Query

	search_help (a_search: READABLE_STRING_GENERAL): DS_LIST [TUPLE [title: STRING_32; context_id: STRING_32]]
			-- Searches help provider for documents using a search string.
			-- Note: Search is syncronous and may be slow to retrieve results.
			--
			-- `a_search': Search string to look up reference documentation
			-- `Result': A list of results paired using a textual title of the document and a matching help content context id.
		require
			a_search_attached: a_search /= Void
			not_a_search_is_empty: not a_search.is_empty
		deferred
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: (attached {DS_LIST [detachable ANY]} Result as l_result) and then not l_result.has (Void)
			result_contains_valid_items: Result.for_all (agent (a_ia_item: TUPLE [title: STRING_32; context_id: STRING_32]): BOOLEAN
				require
					a_ia_item_attached: a_ia_item /= Void
					title_attached: a_ia_item.title /= Void
					context_id_attached: a_ia_item.context_id /= Void
				do
					Result := not a_ia_item.title.is_empty and then
						not a_ia_item.context_id.is_empty and then
						is_valid_context_id (a_ia_item.context_id)
				end)
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
