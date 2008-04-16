indexing
	description: "Help provider helper for EIS."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_HELP_PROVIDER_HELPER

feature {NONE} -- Access

	help_provider_from_protocol (a_protocol: ?STRING_32): !UUID is
			-- Helper provider from `a_protocol'
		do
			if a_protocol /= Void and then not a_protocol.is_empty then
				if {lt_uuid: UUID}providers.item (a_protocol) then
					Result := lt_uuid
				else
					Result := (create {HELP_PROVIDER_KINDS}).eis_default
				end
			else
				Result := (create {HELP_PROVIDER_KINDS}).eis_default
			end
		end

	providers: !HASH_TABLE [UUID, STRING_32] is
			-- Provider mappings.
			-- String in lower.
		local
			l_provider: HELP_PROVIDER_KINDS
		once
			create l_provider
			create Result.make (2)
			Result.force (l_provider.pdf, "pdf")
			Result.force (l_provider.doc, "doc")
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
