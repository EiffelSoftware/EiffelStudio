indexing
	description: "Abstract record for execution recording mechanism"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_DBG_RECORD

inherit
	DEBUG_OUTPUT

	RT_DBG_COMMON

feature -- Properties

	position: INTEGER
			-- Position of record.

	type: INTEGER
			-- Type of record value.

	backup: RT_DBG_RECORD
			-- Backup value after restore operation.

feature -- Access

	debug_output: STRING
		do
			Result := "#" + position.out + " = " + to_string
		end

	is_same_as (other: RT_DBG_RECORD): BOOLEAN
			-- Is Current same as `other' ?
		do
			Result := position = other.position
			check same_type: Result implies type = other.type end
		end

	to_string: STRING
		deferred
		end

feature -- Change properties

	set_position (v: like position)
			-- Set `position'
		do
			position := v
		end

	set_type (v: like type)
			-- Set `type'
		do
			type := v
		end

	set_backup (v: like backup)
			-- Set `backup'
		do
			backup := v
		end

feature -- Runtime

	restore (obj: ANY; bak: RT_DBG_RECORD)
			-- Restore Current on target `obj',
			-- and associate the backup value to `bak'
		require
			no_backup: backup = Void
		deferred
		end

	revert (obj: ANY)
			-- Revert previous `restore' using the associated `backup' value
		deferred
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
