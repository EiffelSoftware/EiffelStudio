indexing
	description: "[
			Currently used to map help context IDs to a Eiffel Documentation on line url page name.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOC_ID_MAP

feature {EIFFEL_DOC_HELP_PROVIDER} -- Access

	eiffel_doc_context_ids: HASH_TABLE [!STRING, !READABLE_STRING_GENERAL]
			-- Map of ids mapped to the Eiffel Documentation help provider context ids.
		once
			create Result.make (31)
			Result.put ("error-list-tool", error_list_tool_id)
			Result.put ("information-tool", information_tool_id)
		end

feature -- Query

	item alias "[]" (a_id: !READABLE_STRING_GENERAL): ?STRING
			--
		require
			not_a_id_is_empty: not a_id.is_empty
		do
			if eiffel_doc_context_ids.has (a_id) then
				Result := eiffel_doc_context_ids.item (a_id)
			end
		end

feature -- Constants: IDs

	error_list_tool_id: !STRING = "com.eiffel.tools.error_list"
	information_tool_id: !STRING = "com.eiffel.tools.information"

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
