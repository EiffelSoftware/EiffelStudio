indexing
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

	make is
			-- Create.
		do
			create found_groups.make
			create visited_targets.make (5)
		ensure
			reset: is_reset
		end

feature -- Access

	found_groups: !LINKED_SET [!G]
			-- Classes with `name' retrieved during last process.

feature {NONE} -- Access

	visited_targets: !SEARCH_TABLE [UUID]
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

	reset is
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

	is_matching (a_group: !G): BOOLEAN
			-- Does `a_group' match what we are searching for?
		deferred
		end

feature -- Visiting

	process_group (a_group: CONF_GROUP)
			-- <Precursor>
		local
			l_group: G
		do
			l_group ?= a_group
			if l_group /= Void then
				if is_matching (l_group) then
					found_groups.force (l_group)
				end
			end
	end

	process_library (a_library: CONF_LIBRARY)
			-- <Precursor>
		local
			l_target: CONF_TARGET
			l_uuid: UUID
		do
			if is_recursive then
				l_target := a_library.library_target
				l_uuid := l_target.system.uuid
				if not visited_targets.has (l_uuid) then
					visited_targets.force (l_uuid)
					process_target (l_target)
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

end
