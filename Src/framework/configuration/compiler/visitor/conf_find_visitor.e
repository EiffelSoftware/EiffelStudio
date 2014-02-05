note
	description: "[
		Abstract visitor which finds groups in a {CONF_TARGET} or {CONF_SYSTEM} based on a criteria.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_FIND_VISITOR [G -> CONF_GROUP]

inherit
	CONF_ITERATOR
		redefine
			process_group,
			process_library,
			process_precompile
		end

feature {NONE} -- Initialization

	make
			-- Create.
		do
			create found_groups.make
			create visited_targets.make (5)
		ensure
			reset: is_reset
		end

feature -- Access

	found_groups: attached LINKED_SET [attached G]
			-- Classes with `name' retrieved during last process.

feature {NONE} -- Access

	visited_targets: attached SEARCH_TABLE [UUID]
			-- Targets which have been traversed by last search

feature -- Status report

	is_reset: BOOLEAN
			-- Have any previous search results been reset?
		do
			Result := found_groups.is_empty and then
				visited_targets.is_empty
		end

	is_recursive: BOOLEAN
			-- Should search include sub libraries?

feature -- Status setting

	reset
			-- Clear any previous search results.
		do
			found_groups.wipe_out
			visited_targets.wipe_out
		ensure
			reset: is_reset
		end

	set_recursive (a_is_recursive: like is_recursive)
			-- Set `is_recursive' to `a_is_recursive'.
		do
			is_recursive := a_is_recursive
		ensure
			is_recusrive_set: is_recursive = a_is_recursive
		end

feature {NONE} -- Query

	is_matching (a_group: attached G): BOOLEAN
			-- Does `a_group' match what we are searching for?
		deferred
		end

feature -- Visiting

	process_group (a_group: CONF_GROUP)
			-- <Precursor>
		do
			if attached {G} a_group as l_group and then is_matching (l_group) then
				found_groups.force (l_group)
			end
		end

	process_library (a_library: CONF_LIBRARY)
			-- <Precursor>
		local
			l_target: detachable CONF_TARGET
			l_uuid: UUID
		do
			if is_recursive then
				l_target := a_library.library_target
					-- Ensure that library has been included in project as it is
					-- Void when it does not meet the conditions.
				if l_target /= Void then
					l_uuid := l_target.system.uuid
					if not visited_targets.has (l_uuid) then
						visited_targets.force (l_uuid)
						process_target (l_target)
					end
				end
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- <Precursor>
			--
			--| Unfortunately {CONF_PRECOMPILE}.process does not call its precursor like all other groups,
			--| that is why we need to call it excplicitly here.
		do
			process_library (a_precompile)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
