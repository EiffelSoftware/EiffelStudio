indexing
	description : "Eiffel class instanciated and used from the Eiffel runtime."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"

class
	RT_EXTENSION

inherit
	RT_EXTENSION_GENERAL

feature -- Notification

	notify (a_id: INTEGER; a_data: TUPLE)
			-- Notify operation `a_id' with data `a_data'
		local
			retried: BOOLEAN
		do
			if not retried then
				inspect a_id
				when Op_enter_feature then
					process_enter_feature (events_feature_argument (a_data))
				when Op_leave_feature then
					process_leave_feature (events_feature_argument (a_data))
				when Op_rescue_feature then
					process_rescue_feature (events_feature_argument (a_data))
				when Op_exec_replay_record then
					process_execution_replay_record (exec_replay_argument (a_data))
				when Op_exec_replay then
					process_execution_replay (exec_replay_argument (a_data))
				when Op_exec_replay_query then
					process_execution_replay_query (exec_replay_argument (a_data))
				when Op_object_storage_save then
					process_object_storage_save (object_storage_argument (a_data))
				when Op_object_storage_load then
					process_object_storage_load (object_storage_argument (a_data))
				else
					debug ("RT_EXTENSION")
						dtrace ("Error: " + out + " ->" + a_id.out + "%N")
					end
				end
			end
		rescue
			debug ("RT_EXTENSION")
				dtrace ("Error: Rescue -> RT_EXTENSION.notify (" + a_id.out + ")%N")
			end
			retried := True
			retry
		end

	notify_argument (a_id: INTEGER): TUPLE
			-- Empty argument container for operation `a_id'.
		local
			retried: BOOLEAN
		do
			if not retried then
				inspect a_id
				when Op_enter_feature, Op_leave_feature, Op_rescue_feature then
					create {like events_feature_argument} Result
				when Op_exec_replay_record, Op_exec_replay, Op_exec_replay_query then
					create {like exec_replay_argument} Result
				when Op_object_storage_save, Op_object_storage_load then
					create {like object_storage_argument} Result
				else
				end
			end
		rescue
			debug ("RT_EXTENSION")
				dtrace ("Error: Rescue -> RT_EXTENSION.notify_argument (" + a_id.out + ")%N")
			end
			retried := True
			retry
		end

feature {NONE} -- Execution replay

	events_feature_argument (t: TUPLE): TUPLE [ref: ANY; cid: INTEGER; fid: INTEGER; level:INTEGER; fn: POINTER]
			-- Argument for `process_*_feature'.
		do
			Result ?= t
		end

	exec_replay_argument (t: TUPLE): TUPLE [op: INTEGER; val: INTEGER]
			-- Argument for `process_execution_replay'
		do
			Result ?= t
		end

	process_enter_feature (a_data: like events_feature_argument)
			-- Execution enters a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		local
			r: like execution_recorder
		do
			r := execution_recorder
			r.enter_feature (a_data.ref, a_data.cid, a_data.fid, a_data.level, a_data.fn)
		end

	process_rescue_feature (a_data: like events_feature_argument)
			-- Execution enters a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		local
			r: like execution_recorder
		do
			r := execution_recorder
			r.enter_rescue (a_data.ref, a_data.level)
		end

	process_leave_feature (a_data: like events_feature_argument)
			-- Execution leaves a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		local
			r: like execution_recorder
		do
			r := execution_recorder
			r.leave_feature (a_data.ref, a_data.cid, a_data.fid, a_data.level)
		end

	process_execution_replay_record (a_data: like exec_replay_argument)
			-- (De)Activate execution recording
		local
			r: like execution_recorder
		do
			if a_data.op.to_boolean then --| True: 1; False: 0
				check execution_recorder = Void end
				r := new_execution_recorder
				execution_recorder_cell.replace (r)
				r.start_recording
			else
				r := execution_recorder
				r.stop_recording
				execution_recorder_cell.replace (Void)
			end
		ensure
			recorder_if_on: a_data.op = 1 implies execution_recorder /= Void
			no_recorder_if_off: a_data.op /= 1 implies execution_recorder = Void
		end

	process_execution_replay (a_data: like exec_replay_argument)
			-- Replay execution
		require
			execution_recording_not_void: execution_recorder /= Void
		local
			r: like execution_recorder
		do
			r := execution_recorder
			r.replay (a_data.op, a_data.val)
			if r.last_replay_operation_failed then
				a_data.val := 0
			end
		end

	process_execution_replay_query (a_data: like exec_replay_argument)
			-- Query about available steps for execution replay
		require
			execution_recording_not_void: execution_recorder /= Void
		local
			r: like execution_recorder
		do
			r := execution_recorder
			a_data.val := r.replay_query (a_data.op)
		end

	new_execution_recorder: like execution_recorder
			-- New Execution recorder.
		do
			create Result.make
				--| Uncomment on of the following lines if you want to set
				--|		+ 10_000 as maximum number of records
				--|		+ 0 for unlimited number of records.
--			r.set_maximum_record_count (10_000) -- Limited to 10_000 records
--			r.set_maximum_record_count (0)	-- No limit
		end

	execution_recorder: RT_DBG_EXECUTION_RECORDER
			-- Once per thread record.
		do
			Result := execution_recorder_cell.item
		end

	execution_recorder_cell: CELL [RT_DBG_EXECUTION_RECORDER]
			-- Cell containing the once per thread recorder, if activated.
		indexing
			description: "Once per thread"
		once
			create Result
		end

feature {NONE} -- Object storage

	object_storage_argument (t: TUPLE): TUPLE [ref: ANY; fn: POINTER; succeed: BOOLEAN]
			-- Argument for `process_object_storage_save' and `process_object_storage_load'.
		do
			Result ?= t
		end

	process_object_storage_save (t: like object_storage_argument)
			-- Process the object saving for `t' data
		local
			fn: STRING
		do
			create fn.make_from_c (t.fn)
			t.succeed := saved_object_to (t.ref, fn) /= Void
		end

	process_object_storage_load (t: like object_storage_argument)
			-- Process the object loading for `t' data
		local
			obj: ANY
			fn: STRING
		do
			create fn.make_from_c (t.fn)
			obj := object_loaded_from (t.ref, fn)
			t.succeed := obj /= Void
			t.ref := obj
		end

invariant
	no_attribute: (create {INTERNAL}).field_count (Current) = 0
			-- Since this object is shared among threads,
			-- it is better to avoid any attribute conflict

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
