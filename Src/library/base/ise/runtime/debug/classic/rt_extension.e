indexing
	description : "Eiffel class instanciated and used from the Eiffel runtime."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"

class
	RT_EXTENSION

inherit
	RT_EXTENSION_COMMON

feature -- Notification

	notify (a_id: INTEGER; a_data: TUPLE) is
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

	notify_argument (a_id: INTEGER): TUPLE is
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

feature -- Direct Access

	saved_object_to (r: ANY; fn: STRING): ANY is
			-- Save object `r' into file `fn'
		local
			file: RAW_FILE
		do
			create file.make (fn)
			if not file.exists or else file.is_writable then
				file.create_read_write
				file.independent_store (r)
				file.close
				Result := r
			else
				Result := Void
			end
		end

	object_loaded_from (r: ANY; fn: STRING): ANY is
			-- Loaded object from file `fn'.
			-- if `r' is Void return a new object
			-- else load into `r'
			-- If failure then results Void object.
		local
			o1, o2: ANY
			file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				o1 := r
				create file.make (fn)
				if file.exists and then file.is_readable then
					file.open_read
					o2 := file.retrieved
					file.close
					if o1 /= Void then
						if o1.same_type (o2) then
							o1.standard_copy (o2)
							Result := o1
						else
							Result := Void
						end
					else
						Result := o2
					end
				else
					Result := Void
				end
			else
				Result := r
			end
		rescue
			retried := True
			retry
		end

feature -- Constants (check eif_debug.h uses the same values)

	Op_enter_feature: 		INTEGER = 10
	Op_leave_feature: 		INTEGER = 11
	Op_rescue_feature: 		INTEGER = 12

	Op_exec_replay_record: 	INTEGER = 15
	Op_exec_replay: 		INTEGER = 16
	Op_exec_replay_query: 	INTEGER = 17

	Op_object_storage_save:	INTEGER = 31
	Op_object_storage_load:	INTEGER = 32

feature {NONE} -- Execution replay

	events_feature_argument (t: TUPLE): TUPLE [ref: ANY; cid: INTEGER; fid: INTEGER; level:INTEGER; fn: POINTER] is
			-- Argument for `process_*_feature'.
		do
			Result ?= t
		end

	exec_replay_argument (t: TUPLE): TUPLE [op: INTEGER; val: INTEGER] is
			-- Argument for `process_execution_replay'
		do
			Result ?= t
		end

	process_enter_feature (a_data: like events_feature_argument) is
			-- Execution enters a feature
		require
			execution_recording_not_void: execution_recording /= Void
		local
			r: like execution_recording
		do
			r := execution_recording
			r.enter_feature (a_data.ref, a_data.cid, a_data.fid, a_data.level, a_data.fn)
		end

	process_rescue_feature (a_data: like events_feature_argument) is
			-- Execution enters a feature
		require
			execution_recording_not_void: execution_recording /= Void
		local
			r: like execution_recording
		do
			r := execution_recording
			r.enter_rescue (a_data.ref, a_data.level)
		end

	process_leave_feature (a_data: like events_feature_argument) is
			-- Execution leaves a feature
		require
			execution_recording_not_void: execution_recording /= Void
		local
			r: like execution_recording
		do
			r := execution_recording
			r.leave_feature (a_data.ref, a_data.cid, a_data.fid, a_data.level)
		end

	process_execution_replay_record (a_data: like exec_replay_argument) is
			-- (De)Activate execution recording
		local
			r: like execution_recording
			b: BOOLEAN
		do
			if a_data.op.to_boolean then --| True: 1; False: 0
				check execution_recording = Void end
				create r.make (5_000)
				execution_recording_cell.replace (r)
				r.start_recording
			else
				r := execution_recording
				r.stop_recording
				execution_recording_cell.replace (Void)
			end
		ensure
			recorder_if_on: a_data.op = 1 implies execution_recording /= Void
			no_recorder_if_off: a_data.op /= 1 implies execution_recording = Void
		end

	process_execution_replay (a_data: like exec_replay_argument) is
			-- Replay execution
		require
			execution_recording_not_void: execution_recording /= Void
		local
			r: like execution_recording
		do
			r := execution_recording
			r.replay (a_data.op, a_data.val)
			if r.last_replay_operation_failed then
				a_data.val := 0
			end
		end

	process_execution_replay_query (a_data: like exec_replay_argument) is
			-- Query about available steps for execution replay
		require
			execution_recording_not_void: execution_recording /= Void
		local
			r: like execution_recording
		do
			r := execution_recording
			a_data.val := r.replay_query (a_data.op)
		end

	execution_recording: RT_DBG_EXECUTION_RECORDER is
			-- Once per thread record.
		do
			Result := execution_recording_cell.item
		end

	execution_recording_cell: CELL [RT_DBG_EXECUTION_RECORDER] is
			-- Cell containing the once per thread recorder, if activated.
		indexing
			description: "Once per thread"
		once
			create Result
		end

feature {NONE} -- Object storage

	object_storage_argument (t: TUPLE): TUPLE [ref: ANY; fn: POINTER; succeed: BOOLEAN] is
			-- Argument for `process_object_storage_save' and `process_object_storage_load'.
		do
			Result ?= t
		end

	process_object_storage_save (t: like object_storage_argument) is
			-- Process the object saving for `t' data
		local
			fn: STRING
		do
			create fn.make_from_c (t.fn)
			t.succeed := saved_object_to (t.ref, fn) /= Void
		end

	process_object_storage_load (t: like object_storage_argument) is
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
