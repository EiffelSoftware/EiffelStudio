note
	description : "Eiffel class instanciated and used from the Eiffel runtime."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_EXTENSION

inherit
	RT_EXTENSION_GENERAL

feature -- Notification

	notify (a_id: INTEGER; a_data: TUPLE)
			-- Notify operation `a_id' with data `a_data'
		require
			a_data_attached: a_data /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				inspect a_id
				when Op_enter_feature then
					if attached {like events_feature_argument} a_data as t_ef then
						process_enter_feature (t_ef)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_leave_feature then
					if attached {like events_feature_argument} a_data as t_lf then
						process_leave_feature (t_lf)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rescue_feature then
					if attached {like events_feature_argument} a_data as t_rf then
						process_rescue_feature (t_rf)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rt_hook then
					if attached {like events_feature_argument} a_data as t_rh then
						process_rt_hook (t_rh)
					else
						check valid_tuple_data: False end
					end
					reset_events_feature_argument (a_data)
				when Op_rt_assign_attrib then
					if attached {like events_assign_argument} a_data as t_att then
						process_rt_assign_attrib (t_att)
					else
						check valid_tuple_data: False end
					end
					reset_events_assign_argument (a_data)
				when Op_rt_assign_local then
					if attached {like events_assign_argument} a_data as t_loc then
						process_rt_assign_local (t_loc)
					else
						check valid_tuple_data: False end
					end
					reset_events_assign_argument (a_data)
				else
					debug ("RT_EXTENSION")
						dtrace ({STRING_32} "Error: " + out + " ->" + a_id.out + "%N")
					end
				end
			end
		rescue
			dtrace ({STRING_32} "Error: Rescue -> RT_EXTENSION.notify (" + a_id.out + ", a_data)%N")
			retried := True
			retry
		end

	notify_argument (a_id: INTEGER): detachable TUPLE
			-- Empty argument container for operation `a_id'.
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := cached_arguments[a_id]
				if Result = Void then
					inspect a_id
					when Op_enter_feature, Op_leave_feature, Op_rescue_feature, Op_rt_hook then
						create {like events_feature_argument} Result
					when Op_rt_assign_attrib, Op_rt_assign_local then
						create {like events_assign_argument} Result
					else
						debug ("RT_EXTENSION")
							dtrace ({STRING_32} "Error: RT_EXTENSION.notify_argument (" + a_id.out + "): unmatched id !%N")
						end
					end
					cached_arguments[a_id] := Result
				end
			end
		rescue
			dtrace ({STRING_32} "Error: Rescue -> RT_EXTENSION.notify_argument (" + a_id.out + ")%N")
			retried := True
			retry
		end

	cached_arguments: ARRAY [detachable TUPLE]
			-- Cached argument to use less temporary objects
		once ("THREAD")
				--| Make sure, the id are contigus, and in this range !
			create Result.make_filled (Void, Op_enter_feature, Op_rt_assign_local)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Execution replay

	events_feature_argument: TUPLE [ref: detachable ANY; cid: INTEGER; fid: INTEGER; a_dep: INTEGER]
			-- Argument for `process_*_feature'.
			-- used only as anchor for type declaration
		do
			check False then end
		ensure
			False
		end

	events_assign_argument: TUPLE [ref: detachable ANY; a_dep: INTEGER; a_pos: INTEGER; a_type: INTEGER; a_xpm_info: INTEGER]
			-- Argument for `process_*_assign'.
			-- used only as anchor for type declaration
		do
			check False then end
		ensure
			False
		end

	reset_events_feature_argument (t: TUPLE)
			-- Reset argument for `process_*_feature'.
		require
			t_attached: t /= Void
		do
			if attached {like events_feature_argument} t as ot then
				ot.ref := Void
				ot.cid := 0
				ot.fid := 0
				ot.a_dep := 0
			end
		end

	reset_events_assign_argument (t: TUPLE)
			-- Reset argument for `process_*_feature'.
		require
			t_attached: t /= Void
		do
			if attached {like events_assign_argument} t as ot then
				ot.ref := Void
				ot.a_dep := 0
				ot.a_pos := 0
				ot.a_type := 0
				ot.a_xpm_info := 0
			end
		end

	process_enter_feature (a_data: like events_feature_argument)
			-- Execution enters a feature
		require
			a_data_attached: a_data /= Void
			execution_recording_not_void: execution_recorder /= Void
		do
			if attached execution_recorder as r then
				if attached {ANY} a_data.ref as ref then
					r.enter_feature (ref, a_data.cid, a_data.fid, a_data.a_dep)
				else
					check ref_should_not_be_void: False end
				end
			end
		end

	process_rescue_feature (a_data: like events_feature_argument)
			-- Execution enters a feature
		require
			a_data_attached: a_data /= Void
			execution_recording_not_void: execution_recorder /= Void
		do
			if attached execution_recorder as r then
				if attached {ANY} a_data.ref as ref then
					r.enter_rescue (ref, a_data.cid, a_data.fid, a_data.a_dep)
				else
					check ref_should_not_be_void: False end
				end
			end
		end

	process_leave_feature (a_data: like events_feature_argument)
			-- Execution leaves a feature
		require
			a_data_attached: a_data /= Void
			execution_recording_not_void: execution_recorder /= Void
		do
			if attached execution_recorder as r then
				if attached {ANY} a_data.ref as ref then
					r.leave_feature (ref, a_data.cid, a_data.fid, a_data.a_dep)
				else
					check ref_should_not_be_void: False end
				end
			end
		end

	process_rt_hook (a_data: TUPLE [unused_ref: detachable ANY; a_dep: INTEGER; bp_i: INTEGER; bp_ni: INTEGER])
			-- Execution reach a RTHOOK or RTNHOOK point
		require
			a_data_attached: a_data /= Void
			execution_recording_not_void: execution_recorder /= Void
		do
			if attached execution_recorder as r then
				r.notify_rt_hook (a_data.a_dep, a_data.bp_i, a_data.bp_ni)
			end
		end

	process_rt_assign_attrib (a_data: like events_assign_argument)
			-- Local variable assignment event
		require
			a_data_attached: a_data /= Void
			execution_recording_not_void: execution_recorder /= Void
		do
			if
				attached execution_recorder as r and then
				r.recording_values and then
				attached a_data.ref as ot_ref
			then
				r.notify_rt_assign_attribute (a_data.a_dep, ot_ref, a_data.a_pos, a_data.a_type.to_natural_32, a_data.a_xpm_info)
			end
		end

	process_rt_assign_local (a_data: like events_assign_argument)
			-- Local variable assignment event
		require
			a_data_attached: a_data /= Void
			execution_recording_not_void: execution_recorder /= Void
			no_ref: a_data.ref = Void
		do
			if
				attached execution_recorder as r and then
				r.recording_values
			then
				r.notify_rt_assign_local (a_data.a_dep, a_data.a_pos, a_data.a_type.to_natural_32, a_data.a_xpm_info)
			end
		end

	new_execution_recorder: RT_DBG_EXECUTION_RECORDER
			-- New Execution recorder.
			-- You can overwrite default parameters in this feature.
			-- Check `{RT_DBG_EXECUTION_RECORDER}.make' to see the default values.
			--| Note: in the future, there will be a way to set those parameter from the debugger
		do
			create Result.make (execution_recorder_parameters)
		ensure
			result_attached: Result /= Void
		end

	execution_recorder: detachable like new_execution_recorder
			-- Once per thread record.
		do
			Result := execution_recorder_cell.item
		end

	execution_recorder_parameters: separate RT_DBG_EXECUTION_PARAMETERS
			-- Once per process record parameters.
		once ("PROCESS")
			create Result.make
		ensure
			result_attached: Result /= Void
		end

	set_execution_recorder_parameters (a_maximum_record_count: INTEGER; a_flatten_when_closing: BOOLEAN;
				a_keep_calls_record: BOOLEAN; a_recording_values: BOOLEAN)
			-- Set execution recorder parameters
			--| this feature might be used remotely by debugger to change parameters
		local
			p: like execution_recorder_parameters
		do
			p := execution_recorder_parameters
			set_execution_recorder_parameters_to (
				a_maximum_record_count,
				a_flatten_when_closing,
				a_keep_calls_record,
				a_recording_values,
				p
			)
			if attached execution_recorder as r then
				r.update_parameters (p)
			end
		end

	set_execution_recorder_parameters_to (a_maximum_record_count: INTEGER; a_flatten_when_closing: BOOLEAN;
				a_keep_calls_record: BOOLEAN; a_recording_values: BOOLEAN; p: like execution_recorder_parameters)
			-- Set execution recorder parameters to `p'.
		do
			p.set_maximum_record_count (a_maximum_record_count)
			p.set_flatten_when_closing (a_flatten_when_closing)
			p.set_keep_calls_records (a_keep_calls_record)
			p.set_recording_values (a_recording_values)
		end

	execution_recorder_cell: CELL [detachable RT_DBG_EXECUTION_RECORDER]
			-- Cell containing the once per thread recorder, if activated.
		once ("THREAD")
			create Result.put (Void)
		ensure
			result_attached: Result /= Void
		end

feature -- Execution replay		

	activate_execution_replay_recording (b: BOOLEAN; ref: ANY; cid: INTEGER; fid: INTEGER; dep: INTEGER; break_index: INTEGER)
			-- Start or Stop execution replay recording
		require
			ref_attached: ref /= Void
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
				if r /= Void then
					r.stop_recording
				end
				execution_recorder_cell.replace (Void)
			end
		ensure
			recorder_if_on: b implies execution_recorder /= Void
			no_recorder_if_off: not b implies execution_recorder = Void
		end

feature -- debug purpose: to remove

	test_activate_recording (ref: ANY; fid: INTEGER; dep: INTEGER; bpline: INTEGER)
		require
			ref_attached: ref /= Void
		do
			activate_execution_replay_recording (True, ref, ref.generating_type.type_id, fid, dep, bpline)
			c_activate_recording
		end

	frozen c_activate_recording
		external
			"C inline use %"eif_main.h%""
		alias
			"[
				#ifdef WORKBENCH
					EIF_GET_CONTEXT
					is_inside_rt_eiffel_code = 0;
					exec_recording_enabled = 1;
					set_debug_mode (1);
				#endif
			]"
		end

	frozen c_is_inside_rt_eiffel_code: INTEGER
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

feature -- SCOOP Access	

	scoop_processor_id_from_object (a_object: ANY): INTEGER_32
			-- SCOOP Processor id for object `a_object'.
		external
			"C inline use %"eif_scoop.h%""
		alias
			"RTS_PID(eif_access($a_object))"
		end

invariant
	no_attribute: (create {REFLECTED_REFERENCE_OBJECT}.make (Current)).field_count = 0
			-- Since this object is shared among threads,
			-- it is better to avoid any attribute conflict

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
