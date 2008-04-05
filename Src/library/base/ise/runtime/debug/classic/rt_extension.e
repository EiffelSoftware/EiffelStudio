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
--FIXME: when compiler is fixed regarding the use of like ... in regard with attached nature
--		 use the following code, to improve readibility and avoid error.
--					if {t_ef: like events_feature_argument} a_data then
			if not retried then
				inspect a_id
				when Op_enter_feature then
					if {t_ef: TUPLE [ref: ANY; cid: INTEGER; fid: INTEGER; level: INTEGER; pfn: POINTER]} a_data then
						process_enter_feature (t_ef)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_leave_feature then
					if {t_lf: TUPLE [ref: ANY; cid: INTEGER; fid: INTEGER; level: INTEGER; pfn: POINTER]} a_data then
						process_leave_feature (t_lf)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rescue_feature then
					if {t_rf: TUPLE [ref: ANY; cid: INTEGER; fid: INTEGER; level: INTEGER; pfn: POINTER]} a_data then
						process_rescue_feature (t_rf)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rt_hook then
					if {t_rh: TUPLE [unused_ref: ANY; bp_i: INTEGER; bp_ni: INTEGER; unused_i3: INTEGER; unused_pfn: POINTER]} a_data then
						process_rt_hook (t_rh)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rt_assign_attrib then
					if {t_att: TUPLE [ref: ANY; a_loc: INTEGER; a_type: INTEGER; a_info: INTEGER; unused_pfn: POINTER]} a_data then
						process_rt_assign ({RT_DBG_EXECUTION_RECORDER}.Assign_attribute_kind, t_att)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rt_assign_local then
					if {t_loc: TUPLE [ref: ANY; a_loc: INTEGER; a_type: INTEGER; a_info: INTEGER; unused_pfn: POINTER]} a_data then
						process_rt_assign ({RT_DBG_EXECUTION_RECORDER}.Assign_local_kind, t_loc)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				else
--					debug ("RT_EXTENSION")
						dtrace ("Error: " + out + " ->" + a_id.out + "%N")
--					end
				end
			end
		rescue
			debug ("RT_EXTENSION")
				dtrace ("Error: Rescue -> RT_EXTENSION.notify (" + a_id.out + ")%N")
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
					when Op_enter_feature, Op_leave_feature, Op_rescue_feature, Op_rt_hook,
						Op_rt_assign_attrib, Op_rt_assign_local
					then
						create {like events_feature_argument} Result
					else
--						debug ("RT_EXTENSION")
							dtrace ("Error: RT_EXTENSION.notify_argument (" + a_id.out + "): unmatched id !%N")
--						end
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

	events_feature_argument (t: TUPLE): ?TUPLE [ref: ANY; cid: INTEGER; fid: INTEGER; level: INTEGER; pfn: POINTER]
			-- Argument for `process_*_feature'.
		do
			Result ?= t
		end

	reset_events_feature_argument (t: TUPLE)
			-- Reset argument for `process_*_feature'.
		local
			p: POINTER
		do
			if {ot: like events_feature_argument} t then
				ot.ref := Void
				ot.cid := 0
				ot.fid := 0
				ot.level := 0
				ot.pfn := p
			end
		end

	process_enter_feature (a_data: !like events_feature_argument)
			-- Execution enters a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.enter_feature (a_data.ref, a_data.cid, a_data.fid, a_data.level, a_data.pfn)
			end
		end

	process_rescue_feature (a_data: !like events_feature_argument)
			-- Execution enters a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.enter_rescue (a_data.ref, a_data.cid, a_data.fid, a_data.level)
			end
		end

	process_leave_feature (a_data: !like events_feature_argument)
			-- Execution leaves a feature
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.leave_feature (a_data.ref, a_data.cid, a_data.fid, a_data.level)
			end
		end

	process_rt_hook (a_data: !TUPLE [unused_ref: ANY; bp_i: INTEGER; bp_ni: INTEGER; unused_i3: INTEGER; unused_pfn: POINTER])
			-- Execution reach a RTHOOK or RTNHOOK point
		require
			execution_recording_not_void: execution_recorder /= Void
		do
			if {r: like execution_recorder} execution_recorder then
				r.notify_rt_hook (a_data.bp_i, a_data.bp_ni)
			end
		end

	process_rt_assign (a_var_type: INTEGER; a_data: !TUPLE [ref: ANY; a_loc: INTEGER; a_type: INTEGER; a_info: INTEGER; unused_pfn: POINTER])
			-- Local variable assignment event
		require
			execution_recording_not_void: execution_recorder /= Void
		local
			x,p,m: BOOLEAN
		do
			x := (a_data.a_info & 0x1).to_boolean
			p := ((a_data.a_info & 0x2) |>> 1).to_boolean
			m := ((a_data.a_info & 0x4) |>> 2).to_boolean
			check x.to_integer + (p.to_integer |<< 1) + (m.to_integer |<< 2) = a_data.a_info end

			if {r: like execution_recorder} execution_recorder then
				r.notify_rt_assign (a_data.ref, a_var_type, a_data.a_loc, a_data.a_type.to_natural_32, x, p, m)
			end
		end

	activate_execution_replay_recording (b: BOOLEAN; ref: ANY; cid: INTEGER; fid: INTEGER; dep: INTEGER)
			-- Start or Stop execution replay recording
		local
			r: like execution_recorder
		do
			if b then
				check execution_recorder = Void end
				r := new_execution_recorder
				execution_recorder_cell.replace (r)
				r.start_recording (ref, cid, fid, dep)
			else
				r := execution_recorder
				r.stop_recording
				execution_recorder_cell.replace (Void)
			end
		ensure
			recorder_if_on: b implies execution_recorder /= Void
			no_recorder_if_off: not b implies execution_recorder = Void
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
		ensure
			Result_not_void: Result /= Void
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
