indexing
	description : "Eiffel class instanciated and used from the Eiffel runtime."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"

class
	RT_DBG_EXECUTION_PARAMETERS

create {RT_EXTENSION}
	make

feature {NONE} -- Initialization

	make
		do
				--| Limit the number of recorded values, for instance
				--|		+ 10_000 as maximum number of value records
				--|		+ 0 for unlimited number of value records.
				--| Default: 1_000_000
			maximum_record_count := 1_000_000

				--| when leaving a feature, flatten all the value record from call records, and its sub calls
				--| Default: True
			flatten_when_closing := True

				--| When we flatten call records' value, do we keep the sub-call records (i.e: the execution calls history)?
				--| Default: True
			keep_calls_records := True

				--| When executing, records attribute and locals assignment ?
				--| if ever you want to record only the execution calls history
				--| set this value to False, but usually it should be True
				--| Default: True
			recording_values := True
		end

feature -- Access
	
	maximum_record_count: INTEGER
			-- Maximum number of records.
			-- `0' stands for no limit.

	flatten_when_closing: BOOLEAN
			-- Option: flatten record when closing

	keep_calls_records: BOOLEAN
			-- Option: keep calls record even when flattening calls

	recording_values: BOOLEAN
			-- Option: record values ?

feature -- Change

	set_maximum_record_count (nb: INTEGER)
			-- Set `maximum_record_count'
		do
			maximum_record_count := nb
		end

	set_flatten_when_closing (b: BOOLEAN)
			-- Set `flatten_when_closing'
		do
			flatten_when_closing := b
		end

	set_keep_calls_records (b: BOOLEAN)
			-- Set `keep_calls_records'
		do
			keep_calls_records := b
		end

	set_recording_values (b: BOOLEAN)
			-- Set `recording_values'
		do
			recording_values := b
		end
	
indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
