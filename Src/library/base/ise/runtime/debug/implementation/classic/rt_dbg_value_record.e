note
	description: "Abstract record for execution recording mechanism."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_DBG_VALUE_RECORD

inherit
	DEBUG_OUTPUT

	RT_DBG_COMMON

	RT_DBG_INTERNAL

feature -- Properties

	position: INTEGER
			-- Position of record.

	type: INTEGER
			-- Eiffel type of record value.

	breakable_info: detachable TUPLE [line: INTEGER; nested: INTEGER]
			-- breakable information

feature -- Access

	current_value_record: detachable RT_DBG_VALUE_RECORD
			-- Record for current value
		deferred
		end

	debug_output: STRING_32
		do
			Result := generating_type.name_32 + ": #" + position.out + " = " + to_string
		end

	associated_object: detachable ANY
			-- Associated object, if any
		deferred
		end

	is_local_record: BOOLEAN
			-- Is local record ?
		deferred
		end

	is_same_as (other: RT_DBG_VALUE_RECORD): BOOLEAN
			-- Is Current same as `other' ?
		require
			other_attached: other /= Void
		deferred
		ensure
			same_type: Result implies type = other.type
		end

	to_string: STRING
		deferred
		ensure
			Result_attached: Result /= Void
		end

feature -- Change

	set_breakable_info (v: like breakable_info)
			-- Set `breakable_info'
		do
			breakable_info := v
		end

feature -- Change properties

	get_value
			-- Get value
		deferred
		end

feature -- Runtime

	restore (val: RT_DBG_VALUE_RECORD)
			-- Restore Current record
			-- and associate the backup value to `val'
		require
			val_attached: val /= Void
		deferred
		end

	revert (bak: RT_DBG_VALUE_RECORD)
			-- Revert previous `restore' using the associated `backup' value
		require
			bak_attached: bak /= Void
		deferred
		end

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
