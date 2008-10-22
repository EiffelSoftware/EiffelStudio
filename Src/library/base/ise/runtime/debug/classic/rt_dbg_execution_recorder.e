indexing
	description: "Execution recorder"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DBG_EXECUTION_RECORDER

inherit
	RT_DBG_COMMON

	RT_DBG_INTERNAL
		export
			{NONE} all
		end

create {RT_EXTENSION}
	make

feature {NONE} -- Initialization

	make (p: RT_DBG_EXECUTION_PARAMETERS)
			-- Creation of Current object
		require
			p_attached: p /= Void
		do
			update_parameters (p)
		end

feature {RT_EXTENSION} -- Change

	update_parameters (p: RT_DBG_EXECUTION_PARAMETERS)
		require
			p_attached: p /= Void
		do
			maximum_record_count := p.maximum_record_count
			flatten_when_closing := p.flatten_when_closing
			keep_calls_records := p.keep_calls_records
			recording_values := p.recording_values
		end

	start_recording (ref: !ANY; cid: INTEGER; fid: INTEGER; dep: INTEGER; a_break_index: INTEGER)
			-- Start recording and
			-- Initialize recording with effective information.
		require
			top_callstack_record_is_void: top_callstack_record = Void
			bottom_callstack_record_is_void: bottom_callstack_record = Void
		local
			r: like bottom_callstack_record
		do
			record_count := 0
			bottom_callstack_record := Void
			top_callstack_record := Void
			check callstack_records_are_void: top_callstack_record = Void and bottom_callstack_record = Void end

			debug ("RT_DBG_RECORD")
				print ("Start_recording  (")
				io.put_string ("ref=")
				io.put_string (($ref).out)
				io.put_string (",cid=")
				io.put_integer (cid)
				io.put_string (",fid=")
				io.put_integer (fid)
				io.put_string (",dep=")
				io.put_integer (dep)
				io.put_string (",break_index=")
				io.put_integer (a_break_index)
				io.put_string (")%N")
			end
			create r.make (Current, ref, cid, fid, dep) --| Create initial call record
			r.set_breakable_info ([a_break_index, 0])
			bottom_callstack_record := r
			top_callstack_record := r
		ensure
			bottom_callstack_record_is_not_void: bottom_callstack_record /= Void
			top_callstack_record_is_bottom: top_callstack_record = bottom_callstack_record
		end

	clear_recording_data
			-- Clear recording data when stopping recording
			-- or when leaving the recorded area (on leave_feature)
		do
			top_callstack_record := Void
			bottom_callstack_record := Void
			record_count := 0
		end

	stop_recording
			-- Stop recording (and clean data)
		do
			clear_recording_data

			if {r: like replay_stack} replay_stack then
				r.wipe_out
				replay_stack := Void
			end
			last_replay_operation_failed := False
			debug ("RT_DBG_RECORD")
				print ("Stop_recording  %N")
			end
		ensure
			no_callstack_record: top_callstack_record = Void and bottom_callstack_record = Void
		end

feature -- Optimization properties

	record_count: INTEGER
			-- Number of field records.

	maximum_record_count: INTEGER
			-- Maximum number of records.
			-- `0' stands for no limit.

	flatten_when_closing: BOOLEAN
			-- Option: flatten record when closing

	keep_calls_records: BOOLEAN
			-- Option: keep calls record even when flattening calls

	recording_values: BOOLEAN
			-- Option: record values ?

feature -- Properties

	top_callstack_record: ?like callstack_record
			-- Current top callstack record.

	bottom_callstack_record: ?like callstack_record
			-- Bottom (or root) callstack record.

feature -- Access

	callstack_record (dep: INTEGER): ?RT_DBG_CALL_RECORD
			-- Call stack record with depth `dep'
			--| if `dep' is negative, then return the `dep'_th call stack record from top_callstack_record
		local
			i: INTEGER
		do
			Result := top_callstack_record
			if dep < 0 then
				from
					i := dep
				until
					Result = Void or i = -1
				loop
					Result := Result.parent
					i := i + 1
				end
			else
				from
				until
					Result = Void or else Result.depth = dep
				loop
					Result := Result.parent
				end
				if Result /= Void and then Result.depth /= dep then
					Result := Void
				end
			end
			debug ("RT_DBG_REPLAY")
				if Result /= Void then
					print ("callstack_record (" + dep.out + ") -> Result=" + Result.to_string (0) + "%N")
				end
			end
		end

	callstack_record_by_id (a_id: !STRING): ?like callstack_record
			-- Call record for `a_id'
		local
			p: INTEGER
			i: INTEGER
			r: like callstack_record
			sub_id: ?STRING
		do
			debug ("RT_DBG_REPLAY")
				print ("callstack_record_by_id (" + a_id + ") -start-%N")
			end
			p := a_id.index_of ('.', 1)
			if p > 0 then
				sub_id := a_id.substring (p + 1, a_id.count)
				i := a_id.substring (1, p-1).to_integer_32
			else
				i := a_id.to_integer_32
			end
			r := callstack_record (i)
			if sub_id = Void then
				Result := r
			elseif r /= Void then
				Result := r.call_by_id (sub_id)
			end
			debug ("RT_DBG_REPLAY")
				print ("callstack_record_by_id (" + a_id + ") -end-%N")
			end
		end

feature -- Constants from eif_debug.h

	Direction_back: INTEGER = 1
			-- previous call
	Direction_forth: INTEGER = 2
			-- next call
	Direction_left: INTEGER = 3
			-- previous instruction
	Direction_right: INTEGER = 4
			-- next intruction

feature -- Event

	enter_feature (ref: !ANY; cid,fid: INTEGER; dep: INTEGER)
			-- Enter feature `{cid}.fid' on object `ref', depth is `dep'
		require
			is_not_replaying: not is_replaying
			cid_positive: cid >= 0 --| 0 might stands for ANY
		local
			r: RT_DBG_CALL_RECORD
		do
			debug ("RT_DBG_RECORD")
				dtrace_indent (dep);
				dtrace ("enter_feature (")
				dtrace (ref.generating_type)
				dtrace (", " + cid.out + ", " + fid.out + ", " + dep.out + ")");
				dtrace (" [[" + record_count.out + "]]%N")
			end
			monitor_record_count
			create r.make (Current, ref, cid, fid, dep)
			increment_records_count (+1)

--| We do not use it anymore, however, we might need to reuse it, with external calls
--| need to check/test this. Since we don't have hands on what the external could do on the Eiffel objects
--			r.record_fields
--			if {flds: LIST [RT_DBG_VALUE_RECORD]} r.field_records and then not flds.is_empty then
--				increment_records_count (flds.count)
--			end

			if {topr: like top_callstack_record} top_callstack_record then
				if topr.depth = 0 or else topr.depth = r.depth - 1 then
					r.attach_to (topr)
				else
					debug ("RT_DBG_WARNING")
						print ("Warning: enter mismatch !!!%N")
						print (" top: depth=" + r.depth.out + " ->" + r.debug_output + "%N")
						print (" now: depth=" + dep.out)
						print (" obj=" + ref.generating_type)
						print (" cid=" + cid.out)
						print (" fid=" + fid.out)
						print ("%N")
						print ("%N")
					end
					if topr.depth = r.depth then
						topr.deep_close
					end
					if {depr: like callstack_record} callstack_record (r.depth - 1) then
						r.attach_to (depr)
					else
						check should_not_occur: False end
					end
				end
			end
			top_callstack_record := r

			check top_callstack_record /= Void end
			if bottom_callstack_record = Void then
				bottom_callstack_record := top_callstack_record
			end
		end

	enter_rescue (ref: !ANY; cid,fid: INTEGER; dep: INTEGER)
			-- Enter rescue on object `ref', depth is `dep'
		require
			is_not_replaying: not is_replaying
		local
			r: ?RT_DBG_CALL_RECORD
		do
			debug ("RT_DBG_RECORD")
				dtrace_indent (dep);
				dtrace ("enter_rescue (")
				dtrace (ref.generating_type)
				dtrace (", " + dep.out + ")");
				dtrace (" [[" + record_count.out + "]]%N")
			end
			r := top_callstack_record
			from
				r := top_callstack_record
			until
				r = Void or else r.depth = dep
			loop
				r := r.parent
			end
			if r = Void then
					-- Unable to find the related callstack record
					-- then reset current recording
				debug ("RT_DBG_RECORD")
					dtrace ("Error: enter_rescue -> No record !!%N")
				end
				stop_recording
				start_recording (ref, cid, fid, dep, 0) --| Find a way to know the break_index
			else
				check same_depth: r.depth = dep end

				top_callstack_record := r
					--| Close remaining callstack record (from first step, to rescued callstack)
				r.close_call_records

				top_callstack_record := r
			end
		end

	leave_feature (ref: !ANY; cid,fid: INTEGER; dep: INTEGER)
			-- Leave feature `{cid}.fid' on object `ref', depth is `dep'
		require
			is_not_replaying: not is_replaying
		local
			n: like callstack_record
		do
			debug ("RT_DBG_RECORD")
				dtrace_indent (dep);
				dtrace ("leave_feature (")
				dtrace (ref.generating_type + " <" + ($ref).out + ">")
				dtrace (", " + cid.out + ", " + fid.out + ", " + dep.out + "). %N")
			end

			if not {r: like callstack_record} top_callstack_record then
				--| This can occurs if the recording started deeper in the call stack.
				--| in this case, do not record anything until we enter again inside a feature
				--| In the meantime, just discard the recorded data
				--| Note: in the future, when we'll support move_left/move_right, we'll handle this case.
			else
				if r = bottom_callstack_record then
					check parent_is_void: r.parent = Void end

						--| We are leaving the root record.
						--| and thus discard previous recorded data
					clear_recording_data
				else
					if r.depth > dep then
						debug ("RT_DBG_WARNING")
							print ("Warning: leave mismatch !!!%N")
							print (" top: depth=" + r.depth.out + " ->" + r.debug_output + "%N")
							print (" now: depth=" + dep.out)
							print (" obj=" + ref.generating_type)
							print (" cid=" + cid.out)
							print (" fid=" + fid.out)
							print ("%N")
							print ("%N")
						end
						from
							n := r
						until
							n = Void or else n.depth = dep
						loop
							n := n.parent
						end
						if n /= Void then
								--| Close previous records
							r.deep_close_until (n)
							n.close_call_records
						end
					else
						n := r
					end
					if n = Void then
						debug ("RT_DBG_RECORD")
							dtrace ("Error: leave_feature -> No associated record !!%N")
						end
						check should_not_occur: False end

							--| We are leaving the root record.
							--| and thus discard previous recorded data
						clear_recording_data
					else
						check
							same_dep: n.depth = dep
							same_object_type: n.same_object_type (ref)
							same_reference: not n.is_expanded implies n.object = ref
							same_cid: n.class_type_id = cid
							same_fid: n.feature_rout_id = fid
						end
						n.close
						top_callstack_record := n.parent
					end
				end
			end
		end

	notify_rt_hook (dep: INTEGER; bp_i, bp_ni: INTEGER)
			-- Notify RT_HOOK (bp_i) or RTNHOOK (bp_i, bp_ni)
		require
			is_not_replaying: not is_replaying
		do
			if {r: like callstack_record} top_callstack_record then
				if r.depth = dep then
					r.register_position (bp_i, bp_ni)
				else
					debug ("RT_DBG_WARNING")
						print ("Warning: hook mismatch on depth now=" + dep.out + " top.depth=" + r.depth.out + "%N")
					end
				end
			end
		end

	notify_rt_assign_attribute (a_dep: INTEGER; ref: !ANY; a_offset: INTEGER; a_type: NATURAL_32; a_xpm: INTEGER)
			-- Notify variable assignment
			-- `a_xpm' contains information about expanded, precompiled, melted
		require
			is_not_replaying: not is_replaying
			top_call_stack_record_not_void: top_callstack_record /= Void
			valid_xpm_value: valid_xpm_value (a_xpm)
		do
			if {t: like top_callstack_record} top_callstack_record then
				check same_associated_depth: a_dep = t.depth end
				if {l_record: RT_DBG_VALUE_RECORD} object_attribute_record (a_offset, a_type, ref) then
					debug ("RT_DBG_RECORD")
						print ("Att Assign=> " + l_record.debug_output + "%N")
					end
					t.add_value_record (l_record)
				end
			else
				debug ("RT_DBG_RECORD")
					print ("Att Assign=> ERROR, no top_callstack_record !%N")
				end
				check should_not_occur: False end
			end
		end

	notify_rt_assign_local (a_dep: INTEGER; a_position: INTEGER; a_type: NATURAL_32; a_xpm: INTEGER)
			-- Notify variable assignment
			-- `a_xpm' contains information about expanded, precompiled, melted
		require
			is_not_replaying: not is_replaying
			top_call_stack_record_not_void: top_callstack_record /= Void
			valid_xpm_value: valid_xpm_value (a_xpm)
		do
			if {t: like top_callstack_record} top_callstack_record then
				debug ("RT_DBG_WARNING")
					if a_dep /= t.depth and t.depth /= 0 then
						print ("Loc Assign: dep=" + a_dep.out + "; pos=" + a_position.out + " -> depth mismatch %N")
					end
				end
				check same_associated_depth: a_dep = t.depth end
				if {l_record: RT_DBG_VALUE_RECORD} object_local_record (a_dep, a_position, a_type) then
					debug ("RT_DBG_RECORD")
						print ("Loc Assign=> " + l_record.debug_output + "%N")
					end
					t.add_value_record (l_record)
				end
			else
				debug ("RT_DBG_RECORD")
					print ("Loc Assign=> ERROR, no top_callstack_record !%N")
				end
				check should_not_occur: False end
			end
		end

feature -- Helpers

	valid_xpm_value (a_xpm: INTEGER): BOOLEAN
			-- Is `a_xpm' a valid xpm value ?
		local
			x,p,m: BOOLEAN
		do
			x := xpm_to_is_expanded (a_xpm)
			p := xpm_to_is_precompiled (a_xpm)
			m := xpm_to_is_melted (a_xpm)

			Result := a_xpm = x.to_integer + (p.to_integer |<< 1)	+ (m.to_integer |<< 2)
		end

	xpm_to_is_expanded (a_xpm: INTEGER): BOOLEAN
			-- Does `a_xpm' say is expanded ?
		do
			Result := (a_xpm & 0x1).to_boolean
		end

	xpm_to_is_precompiled (a_xpm: INTEGER): BOOLEAN
			-- Does `a_xpm' say is precompiled ?
		do
			Result := ((a_xpm & 0x2) |>> 1).to_boolean
		end

	xpm_to_is_melted (a_xpm: INTEGER): BOOLEAN
			-- Does `a_xpm' say is melted ?
		do
			Result := ((a_xpm & 0x4) |>> 2).to_boolean
		end

feature -- Replay

	activate_replay (b: BOOLEAN)
			-- Activate or deactive replay mode according to `b'
		do
			if b then
				if is_replaying then
					-- already activated !
				else
					-- Start replay
					replayed_call := top_callstack_record
					is_replaying := True
				end
			else -- not b
				if is_replaying then
					-- Stop replay
					-- revert previous replay
					revert_replay_stack
					check replay_stack = Void end
					is_replaying := False
					replayed_call := Void
				else
					-- already stopped
				end
			end
		ensure
			b_set: b and is_replaying
		end

	replay (dir: INTEGER; nb: INTEGER)
			-- Replay execution `nb' steps in direction `dir'
		do
			inspect dir
			when Direction_back then
				replay_back
			when Direction_forth then
				replay_forth
			when Direction_left then
				replay_left
			when Direction_right then
				replay_right
			else
				-- Error
			end
		end

	replay_to_point	(a_id: !STRING): BOOLEAN
			-- Replay execution to point identified by `a_id'
		local
			d1,d2: INTEGER
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_to_point (" + a_id + ") -start-%N")
			end
			if {l_curr: like replayed_call} replayed_call then
				--| Current replayed call exists
				if {l_req: like callstack_record_by_id} callstack_record_by_id (a_id) then
					--| a_id correspond to an existing call
					--| now find the associated replayable call (with rt_information_available)
					if {l_next: like callstack_record} l_req.associated_replayable_call then
						d1 := l_curr.depth
						d2 := l_next.depth
						if d2 > d1 then
								--| Go forth in the stack
							from
							until
								d1 >= d2
							loop
								replay_forth
								d1 := d1 + 1
								check valid_replayed_depth: is_call_at_depth (replayed_call, d1) end
							end
							check valid_replayed_depth: is_call_at_depth (replayed_call, d2) end
						elseif d2 < d1 then
								--| Go back in the stack
							from
							until
								d1 <= d2
							loop
								replay_back
								d1 := d1 - 1
								check valid_replayed_depth: is_call_at_depth (replayed_call, d1) end
							end
							check valid_replayed_depth: is_call_at_depth (replayed_call, d2) end
						end

						Result := True
					end
				end
			end

			debug ("RT_DBG_REPLAY")
				print ("replay_to_point (" + a_id + ") -end- => "+ Result.out +"%N")
			end
		end

	replay_query (dir: INTEGER): INTEGER
			-- Replay execution `nb' steps in direction `dir'
		do
			inspect dir
			when Direction_back then
				if bottom_callstack_record /= Void and {rc: like replayed_call} replayed_call then
					Result := rc.available_calls_to_bottom
				end
			when Direction_forth then
				if {rs: like replay_stack} replay_stack then
					Result := rs.count
				end
			when Direction_left then
				-- Not yet supported
			when Direction_right then
				-- Not yet supported
			else
			end
		end

	replayed_call_details: ?STRING
			-- Details for `replayed_call'
		require
			is_replaying: is_replaying
		do
			if {r: like replayed_call} replayed_call then
				debug ("RT_DBG_REPLAY")
					print ("replayed_call_details -> " + r.to_string (0) + "%N")
				end
				Result := r.to_string (0)
			else
				debug ("RT_DBG_REPLAY")
					print ("replayed_call_details -> None !%N")
				end
			end
		end

	callstack_record_details (a_id: !STRING; nb: INTEGER): ?STRING
			-- Details for callstack identified by `a_id'
			-- get information for `nb' levels.
		require
			is_replaying: is_replaying
		do
			debug ("RT_DBG_REPLAY")
				print ("callstack_record_details (" + a_id + "," + nb.out + ") -start- %N")
			end
			if {r: like callstack_record_by_id} callstack_record_by_id (a_id) then
				Result := r.to_string (nb)
			end
			debug ("RT_DBG_REPLAY")
				print ("callstack_record_details (" + a_id + "," + nb.out + ") -end- %N")
				if Result = Void then
					print ("%T -> Not Found")
				else
					print ("%T -> Result=" + Result)
				end
				print ("%N")
			end
		end

feature -- Monitoring

	monitor_record_count
			-- Monitor if record_count is not over `max_record_count'
			-- if `max_record_count' is 0, then no limit
		local
			bt: like bottom_callstack_record
			p: like bottom_callstack_record
			c, m, n: INTEGER
		do
			m := maximum_record_count
			if m > 0 then
				c := record_count
				if c > 1.1 * m then
					bt := bottom_callstack_record
					if top_callstack_record /= bt then
						debug ("RT_DBG_OPTIMIZATION")
							print ("monitor_record_count[" + ((m - c).abs // m).out + "%%] -> remove oldest: record_count=" + c.out + " (max=" + m.out + ")%N")
						end
						from
							p := top_callstack_record
						until
							p = Void or else p.parent = bt
						loop
							p := p.parent
						end
						check
							p_not_void_and_last_of_parent: p /= Void and then
								bt /= Void and then bt.call_records /= Void and then bt.call_records.last = p
						end
						n := bt.record_count_but (p)
						p.remove_parent

							--| We may clean the current `bottom_callstack_record' to help the GC ...
						bottom_callstack_record := p
						bt := p

						c := c - n
						record_count := c
						check same_record_count: bt /= Void and then record_count = bt.record_count_but (Void) end
						if c <= 0.9 * m then
								--| Could be optimized instead of recursively call this monitoring
							monitor_record_count
						end
						debug ("RT_DBG_OPTIMIZATION")
							print ("monitor_record_count -> count=" + c.out + "%N")
						end
					end
				end
			end
		end

feature -- Replay operation

	is_replaying: BOOLEAN
			-- Is replaying

	last_replay_operation_failed: BOOLEAN
			-- Does last replay operation failed ?

	replayed_call: ?RT_DBG_CALL_RECORD
			-- Current replayed call stack record

	replay_stack_not_empty: BOOLEAN
			-- Is `replay_stack' non empty?
		do
			Result := {rs: like replay_stack} replay_stack and then not rs.is_empty
		end

	replay_stack: ?LINKED_LIST [TUPLE [call_record: !RT_DBG_CALL_RECORD; chgs: ?LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]]]
			-- Replay operation stacks.
			-- useful to "revert" the replay steps.

	replay_back
			-- Replay execution back
		require
			is_replaying: is_replaying
			replayed_call_attached: replayed_call /= Void
		local
			rs: !like replay_stack
			n: ?RT_DBG_CALL_RECORD
			l_records: ?LIST [RT_DBG_VALUE_RECORD]
			chgs: ?ARRAYED_LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_back -start- %N")
			end
			if {r: RT_DBG_CALL_RECORD} replayed_call then
				if {p: RT_DBG_CALL_RECORD} r.parent then
					last_replay_operation_failed := False
					if {ot_rs: like replay_stack} replay_stack then
						rs := ot_rs
						check replay_stack_not_empty: rs.count > 0 end
						n := rs.last.call_record
					else
						create rs.make
						replay_stack := rs
							-- This is the first replay operation
							-- Replay to the beginning of the current frame
						n := Void
					end
					l_records := changes_between (r, n)
					if not last_replay_operation_failed then
						if {ot_records: LIST [RT_DBG_VALUE_RECORD]} l_records then
							create chgs.make (ot_records.count)
							from
								ot_records.finish
							until
								ot_records.before
							loop
								debug ("RT_DBG_REPLAY")
									print ("replay_back -> " + ot_records.item_for_iteration.debug_output + " %N")
								end
								if {ot_rec: RT_DBG_VALUE_RECORD} ot_records.item_for_iteration then
									if {val: RT_DBG_VALUE_RECORD} ot_rec.current_value_record then
										chgs.force ([ot_rec, val])
										ot_rec.restore (val)
									else
										check should_not_occur: False end
									end
								end
								ot_records.back
							end
						end
						rs.force ([r, chgs])
						replayed_call := p
					end
				else
					last_replay_operation_failed := True
				end
			else
				last_replay_operation_failed := True
			end
			debug ("RT_DBG_REPLAY")
				print ("replay_back -end- %N")
			end
		ensure
			replayed_call_attached: replayed_call /= Void
		end

	replay_left
			-- Replay left (up in the current call stack element)
		require
			is_replaying: is_replaying
			replayed_call_attached: replayed_call /= Void
		local
			n: like replayed_call
			chgs: ?ARRAYED_LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]
			r_pos_line: INTEGER
			done: BOOLEAN
			rs: !like replay_stack
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_left -start- %N")
			end
			if {r: like replayed_call} replayed_call then
				from
					r_pos_line := r.replayed_position.line
					if {ot_rs: like replay_stack} replay_stack then
						rs := ot_rs
					else
							-- This is the first replay operation
							-- Replay to the beginning of the current frame
						create rs.make
						replay_stack := rs
					end
					n := r
				until
					done
				loop
					if {ot_records: LIST [!RT_DBG_VALUE_RECORD]} r.left_step then
						last_replay_operation_failed := False

						create chgs.make (ot_records.count)
						from
							ot_records.finish
						until
							ot_records.before
						loop
							debug ("RT_DBG_REPLAY")
								print ("replay_left -> " + ot_records.item_for_iteration.debug_output + " %N")
							end
							if {ot_rec: RT_DBG_VALUE_RECORD} ot_records.item_for_iteration then
								if {val: RT_DBG_VALUE_RECORD} ot_rec.current_value_record then
									chgs.force ([ot_rec, val])
									ot_rec.restore (val)
								else
									check should_not_occur: False end
								end
							end
							ot_records.back
						end
						rs.force ([r, chgs])
					else
						if r.parent = Void then
							--| Revert the step left which was supposed to be a step back,
							--| but which wasn't since we reached the bottom
							r.revert_left_step
						else
							replay_back
						end
						done := True
					end
					n := replayed_call
					check n_attached: n /= Void end
					if not done then
						done := n /= r or else n = Void or else (n.replayed_position.line /= r_pos_line)
					end

					--| FIXME jfiat [2008/04/09] : do we want to step left on nested index ?
				end
			end
			debug ("RT_DBG_REPLAY")
				print ("replay_left -end- %N")
			end
		ensure
			replayed_call_attached: replayed_call /= Void
		end

	replay_left_to_first
			-- Replay execution left as many times as needed to be at the entry of the feature
		local
			r,n: like replayed_call
		do
			from
				r := replayed_call
				r := n
			until
				n = Void or else n /= r or else r = Void or else r.replayed_position_is_first
			loop
				replay_left
				r := replayed_call
			end
		end

	replay_forth
			-- Replay execution forth
		require
			is_replaying: is_replaying
			replayed_call_not_void: replayed_call /= Void
			replay_stack_not_empty: replay_stack_not_empty
		local
			r: like replayed_call
			n: !RT_DBG_CALL_RECORD
			t: TUPLE [call_record: !RT_DBG_CALL_RECORD; chgs: ?LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]]
			done: BOOLEAN
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_forth -start-%N")
			end
			if {rs: like replay_stack} replay_stack then
				r := replayed_call
				check r_not_void: r /= Void end
				from
				until
					done
				loop
					check rs.count > 0 end
						--| pop last entry
					rs.finish
					t := rs.item_for_iteration
					rs.remove
					if rs.is_empty then
						replay_stack := Void
					end

						--| Replay
					n := t.call_record
					if {ot_chgs: LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]} t.chgs then
						from
							ot_chgs.finish
						until
							ot_chgs.before
						loop
							debug ("RT_DBG_REPLAY")
								print ("replay_forth -> " + ot_chgs.item_for_iteration.record.debug_output + " %N")
							end
							if {ch: TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]} ot_chgs.item_for_iteration then
								ch.record.revert (ch.backup)
							end
							ot_chgs.back
						end
					end
					if n = r then
						--| reverted left step
						r.revert_left_step
						done := replay_stack = Void
					else
						--| reverted back step
						check r = n.parent end
						replayed_call := n
						done := True
					end
				end
			else
				last_replay_operation_failed := True
			end
			debug ("RT_DBG_REPLAY")
				print ("replay_forth -end-%N")
			end
		ensure
			replayed_call_attached: replayed_call /= Void
		end

	replay_right
			-- Replay right (down in the current call stack element)
		require
			is_replaying: is_replaying
			replayed_call_not_void: replayed_call /= Void
			replay_stack_not_empty: replay_stack_not_empty
		local
			r: like replayed_call
			n: !RT_DBG_CALL_RECORD
			t: TUPLE [call_record: !RT_DBG_CALL_RECORD; chgs: ?LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]]
			r_pos_line: INTEGER
			done: BOOLEAN
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_right -start-%N")
			end
			if {rs: like replay_stack} replay_stack then
				r := replayed_call
				check r_not_void: r /= Void end
				from
					r_pos_line := r.replayed_position.line
				until
					done
				loop
					check replay_stack_not_empty: replay_stack_not_empty end
						--| pop last entry
					rs.finish
					t := rs.item_for_iteration
					rs.remove
					if rs.is_empty then
						replay_stack := Void
					end

						--| Replay

					if {ot_chgs: LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]} t.chgs then
						from
							ot_chgs.finish
						until
							ot_chgs.before
						loop
							debug ("RT_DBG_REPLAY")
								print ("replay_right -> " + ot_chgs.index.out + ") " + ot_chgs.item_for_iteration.record.debug_output + " %N")
							end
							if {ch: TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]} ot_chgs.item_for_iteration then
								ch.record.revert (ch.backup)
							end
							ot_chgs.back
						end
					end

					n := t.call_record
					if n = r then
							--| reverted left step
						n.revert_left_step
						done := n.replayed_position.line /= r_pos_line
					else --| n /= r
							--| reverted back step
						check r = n.parent end
						if n.replayed_position.line = 0 then
							n.revert_left_step
						end
						replayed_call := n
						replay_left_to_first
						replayed_call := n
						done := True
					end
				end
			else
				last_replay_operation_failed := True
			end
			debug ("RT_DBG_REPLAY")
				print ("replay_right -end-%N")
			end
		ensure
			replayed_call_attached: replayed_call /= Void
		end

	revert_replay_stack
			-- Revert remaining replay stack
		require
			is_replaying: is_replaying
		local
			r: like replayed_call
			n: !like callstack_record
			t: TUPLE [call_record: !like callstack_record; chgs: ?LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]]
		do
			debug ("RT_DBG_REPLAY")
				print ("revert_replay_stack -start-%N")
			end
			if {rs: like replay_stack} replay_stack then
				from
					r := replayed_call
				until
					rs.count = 0
				loop
						--| pop last entry
					rs.finish
					t := rs.item_for_iteration
					rs.remove

						--| Replay
					n := t.call_record
					if {ot_chgs: LIST [TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]]} t.chgs then
						from
							ot_chgs.finish
						until
							ot_chgs.before
						loop
							debug ("RT_DBG_REPLAY")
								print ("revert_replay_stack -> " + ot_chgs.item_for_iteration.record.debug_output + " %N")
							end
							if {ch: TUPLE [record: !RT_DBG_VALUE_RECORD; backup: !RT_DBG_VALUE_RECORD]} ot_chgs.item_for_iteration then
								ch.record.revert (ch.backup)
							end
							ot_chgs.back
						end
					end
					if n = r then
						--| reverted left step
						if r /= Void then
							r.revert_left_step
						end
					else
						--| reverted back step
						check r = n.parent end
						replayed_call := n
					end
				end
				check empty_replay_stack: rs.is_empty end
			end
			replay_stack := Void
			debug ("RT_DBG_REPLAY")
				print ("revert_replay_stack -end-%N")
			end
		end

feature -- Change

	increment_records_count (n: INTEGER)
			-- Incremente `record_count' by `n'
		do
			record_count := record_count + n
		ensure
			record_count_positive: record_count >= 0
		end

feature -- Measurement

	is_call_at_depth (a_call: like replayed_call; d: INTEGER): BOOLEAN
			-- Call `a_call' has depth `d' ?
		do
			Result := {c: like replayed_call} a_call and then c.depth = d
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
