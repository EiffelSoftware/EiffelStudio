note
	description: "Server to hold and manage eis entries"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIS_ENTRY_SERVER [H -> HASHABLE, G -> HASHABLE]

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- <precursor>
			-- Create entries.
		do
			create entries.make (5)
			entries.compare_objects
		end

feature {EIS_STORAGE} -- Element change

	register_entry (a_entry: attached H; a_id: attached G): BOOLEAN
			-- Retrister an entry
			-- Return True if an entry is really registered.
		local
			l_entries: like entries
			l_entry_list: SEARCH_TABLE [H]
		do
			l_entries := entries
			l_entries.search (a_id)
			if l_entries.found then
				l_entry_list := l_entries.found_item.as_attached
				l_entry_list.search (a_entry)
				if not l_entry_list.found then
					l_entry_list.force (a_entry)
					Result := True
				end
			else
				create l_entry_list.make (3)
				l_entries.force (l_entry_list, a_id)
				l_entry_list.force (a_entry)
				Result := True
			end
		end

	deregister_entry (a_entry: attached H; a_id: attached G): BOOLEAN
			-- Deretrister an entry
			-- Return True if an entry is really deregistered.
		local
			l_entries: like entries
			l_entry_list: SEARCH_TABLE [H]
		do
			if attached entries as lt_entries then
				l_entries := entries
				l_entries.search (a_id)
				if l_entries.found then
					l_entry_list := l_entries.found_item.as_attached
					l_entry_list.search (a_entry)
					if l_entry_list.found then
						l_entry_list.remove (a_entry)
						Result := True
					end
				end
			end
		end

	register_entries_of_id (a_entries: attached SEARCH_TABLE [H]; a_id: attached G)
			-- Deregister entries of `a_id'.
		do
			entries.force (a_entries, a_id)
		end

	deregister_entries_of_id (a_id: attached G)
			-- Deregister entries of `a_id'.
		do
			if attached entries as lt_entries then
				lt_entries.remove (a_id)
			end
		end

	register_component (a_id: attached G)
			-- Register `a_id' with no entry.
		do
			if attached entries as lt_entries then
				lt_entries.force (create {SEARCH_TABLE [H]}.make (0), a_id)
			end
		end

feature -- Access

	entries_of_id (a_id: attached G): detachable SEARCH_TABLE [H]
			-- EIS entries of `a_id'
			-- Do not change directly.
			-- Only for querying.
		do
			if attached entries as lt_entries then
				lt_entries.search (a_id)
				if lt_entries.found then
					Result := lt_entries.found_item
				end
			end
		end

	entries: HASH_TABLE [SEARCH_TABLE [H], G]
			-- Entries to be stored.
			-- Do not change directly.
			-- Only for querying.

invariant
	entries_not_void: entries /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
