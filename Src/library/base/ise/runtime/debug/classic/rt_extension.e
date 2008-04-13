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
					if {t_ef: like events_feature_argument} a_data then
						process_enter_feature (t_ef)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_leave_feature then
					if {t_lf: like events_feature_argument} a_data then
						process_leave_feature (t_lf)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rescue_feature then
					if {t_rf: like events_feature_argument} a_data then
						process_rescue_feature (t_rf)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rt_hook then
					if {t_rh: like events_feature_argument} a_data then
						process_rt_hook (t_rh)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rt_assign_attrib then
					if {t_att: like events_assign_argument} a_data then
						process_rt_assign_attrib (t_att)
					else
						check valid_tuple_data: False end
					end
					reset_events_assign_argument (a_data)
				when Op_rt_assign_local then
					if {t_loc: like events_assign_argument} a_data then
						process_rt_assign_local (t_loc)
					else
						check valid_tuple_data: False end
					end
					reset_events_assign_argument (a_data)
				else
					debug ("RT_EXTENSION")
						dtrace ("Error: " + out + " ->" + a_id.out + "%N")
					end
				end
			end
		rescue
			debug ("RT_EXTENSION")
				dtrace ("Error: Rescue -> RT_EXTENSION.notify (" + a_id.out + ", a_data)%N")
			end
			retried := True
			retry
		end

	notify_argument (a_id: INTEGER): ?TUPLE is
			-- Empty argument container for operation `a_id'.
		local
			retried: BOOLEAN
		do
			if not retried then
				if cached_arguments.has_key (a_id) then
					Result := cached_arguments.found_item
					check Result /= Void end
				else
					inspect a_id
					when Op_enter_feature, Op_leave_feature, Op_rescue_feature, Op_rt_hook then
						create {like events_feature_argument} Result
					when Op_rt_assign_attrib, Op_rt_assign_local then
						create {like events_assign_argument} Result
					else
						debug ("RT_EXTENSION")
							dtrace ("Error: RT_EXTENSION.notify_argument (" + a_id.out + "): unmatched id !%N")
						end
					end
					if {t: TUPLE} Result then
						cached_arguments.force (t, a_id)
					end
				end
			end
		rescue
			debug ("RT_EXTENSION")
				dtrace ("Error: Rescue -> RT_EXTENSION.notify_argument (" + a_id.out + ")%N")
			end
			retried := True
			retry
		end

	cached_arguments: !HASH_TABLE [!TUPLE, INTEGER]
			-- Cached argument to use less temporary objects
		once
			create Result.make (11)
		end

feature {NONE} -- Execution replay

	events_feature_argument (t: TUPLE): ?TUPLE [ref: ANY; cid: INTEGER; fid: INTEGER; a_dep: INTEGER]
			-- Argument for `process_*_feature'.
		do
			Result ?= t
		end

	events_assign_argument (t: TUPLE): ?TUPLE [ref: ANY; a_dep: INTEGER; a_pos: INTEGER; a_type: INTEGER; a_xpm_info: INTEGER]

			-- Argument for `process_*_assign'.
		do
			Result ?= t
		end

	reset_events_feature_argument (t: TUPLE)
			-- Reset argument for `process_*_feature'.
		do
			if {ot: like events_feature_argument} t then
				ot.ref := Void
				ot.cid := 0
				ot.fid := 0
				ot.a_dep := 0
			end
		end

	reset_events_assign_argument (t: TUPLE)
			-- Reset argument for `process_*_feature'.
		do
			if {ot: like events_assign_argument} t then
				ot.ref := Void
				ot.a_dep := 0
				ot.a_pos := 0
				ot.a_type := 0
				ot.a_xpm_info := 0
			end
		end

	process_enter_feature (a_data: !like events_feature_argument)
			-- Execution enters a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.enter_feature (a_data.ref, a_data.cid, a_data.fid, a_data.a_dep)
			end
		end

	process_rescue_feature (a_data: !like events_feature_argument)
			-- Execution enters a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.enter_rescue (a_data.ref, a_data.cid, a_data.fid, a_data.a_dep)
			end
		end

	process_leave_feature (a_data: !like events_feature_argument)
			-- Execution leaves a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.leave_feature (a_data.ref, a_data.cid, a_data.fid, a_data.a_dep)
			end
		end

	process_rt_hook (a_data: !TUPLE [unused_ref: ANY; a_dep: INTEGER; bp_i: INTEGER; bp_ni: INTEGER])
			-- Execution reach a RTHOOK or RTNHOOK point
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.notify_rt_hook (a_data.a_dep, a_data.bp_i, a_data.bp_ni)
			end
		end

	process_rt_assign_attrib (a_data: !like events_assign_argument)
			-- Local variable assignment event
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				if {ot_ref: ANY} a_data.ref then
					r.notify_rt_assign_attribute (a_data.a_dep, ot_ref, a_data.a_pos, a_data.a_type.to_natural_32, a_data.a_xpm_info)
				end
			end
		end

	process_rt_assign_local (a_data: !like events_assign_argument)
			-- Local variable assignment event
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.notify_rt_assign_local (a_data.a_dep, a_data.a_pos, a_data.a_type.to_natural_32, a_data.a_xpm_info)
			end
		end

	activate_execution_replay_recording (b: BOOLEAN; ref: ANY; cid: INTEGER; fid: INTEGER; dep: INTEGER; break_index: INTEGER)
			-- Start or Stop execution replay recording
		local
			r: like execution_recorder
		do
			if b then
				check execution_recorder = Void end
				r := new_execution_recorder
				execution_recorder_cell.replace (r)
				r.start_recording (ref, cid, fid, dep, break_index)
			else
				r := execution_recorder
				r.stop_recording
				execution_recorder_cell.replace (Void)
			end
		ensure
			recorder_if_on: b implies execution_recorder /= Void
			no_recorder_if_off: not b implies execution_recorder = Void
		end

	new_execution_recorder: !like execution_recorder
			-- New Execution recorder.
		do
			create Result.make
				--| Uncomment on of the following lines if you want to set
				--|		+ 10_000 as maximum number of records
				--|		+ 0 for unlimited number of records.
--			Result.set_maximum_record_count (10_000) -- Limited to 10_000 records
--			Result.set_maximum_record_count (0)	-- No limit
--			Result.set_flatten_when_closing (False)
--			Result.set_keep_calls_records (True)
		end

	execution_recorder: ?RT_DBG_EXECUTION_RECORDER
			-- Once per thread record.
		do
			Result := execution_recorder_cell.item
		end

	execution_recorder_cell: !CELL [?RT_DBG_EXECUTION_RECORDER]
			-- Cell containing the once per thread recorder, if activated.
		indexing
			description: "Once per thread"
		once
			create Result
		end

feature -- debug purpose: to remove

	frozen c_is_inside_rt_eiffel_code: INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
				#ifdef WORKBENCH
					EIF_GET_CONTEXT
					return is_inside_rt_eiffel_code;
				#else
					return 0;
				#endif
			]"
		end

invariant
	no_attribute: (create {INTERNAL}).field_count (Current) = 0
			-- Since this object is shared among threads,
			-- it is better to avoid any attribute conflict

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
