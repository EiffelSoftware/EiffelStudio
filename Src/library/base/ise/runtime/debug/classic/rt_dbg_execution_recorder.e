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

	make
			-- Creation of Current object
		do
			set_maximum_record_count (1_000_000)
			set_flatten_when_closing (True)
			set_keep_calls_records (True)
		end

feature {RT_EXTENSION} -- Change

	start_recording (ref: ANY; cid: INTEGER; fid: INTEGER; dep: INTEGER; a_break_index: INTEGER)
			-- Start recording and
			-- Initialize recording with effective information.
		require
			top_callstack_record_is_void: top_callstack_record = Void
			bottom_callstack_record_is_void: bottom_callstack_record = Void
		local
			r: like bottom_callstack_record
			updated_cid: INTEGER
		do
			record_count := 0
			bottom_callstack_record := Void
			top_callstack_record := Void
			check callstack_records_are_void: top_callstack_record = Void and bottom_callstack_record = Void end

			updated_cid := rt_updated_dynamic_type (cid)
			debug ("RT_DBG_RECORD")
				print ("Start_recording  (")
				io.put_string ("ref")
				io.put_character (',')
				io.put_integer (cid)
				io.put_character ('=')
				io.put_integer (updated_cid)
				io.put_character (',')
				io.put_integer (fid)
				io.put_string (",dep=")
				io.put_integer (dep)
				io.put_string (",break_index=")
				io.put_integer (a_break_index)
				io.put_string (")%N")
			end
			create r.make (Current, ref, updated_cid, fid, dep) --| Create initial call record
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

	callstack_record_by_id (a_id: !STRING): like callstack_record
			-- Call record for `a_id'
		local
			p: INTEGER
			i: INTEGER
			r: like callstack_record
			sub_id: STRING
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

	enter_feature (ref: ANY; cid,fid: INTEGER; dep: INTEGER)
			-- Enter feature `{cid}.fid' on object `ref', depth is `dep'
		require
			is_not_replaying: not is_replaying
			cid_positive: cid >= 0 --| 0 might stands for ANY
		local
			r: RT_DBG_CALL_RECORD
			fn: STRING
		do
			debug ("RT_DBG_RECORD")
				dtrace_indent (dep); dtrace ("enter_feature (" + ref.generating_type + ", " + cid.out + ", " + fid.out + ", " + dep.out + ")");
				dtrace (" [[" + record_count.out + "]]%N")
			end
			monitor_record_count
			create r.make (Current, ref, cid, fid, dep)
--| We do not use it anymore, however, we might need to reuse it, with external calls
--| need to check/test this. Since we don't have hands on what the external could do on the Eiffel objects
--			r.record_fields
--			if {flds: LIST [RT_DBG_RECORD]} r.field_records and then not flds.is_empty then
--				increment_records_count (flds.count)
--			end

			if {topr: like top_callstack_record} top_callstack_record then
				if topr.depth = 0 or else topr.depth = r.depth - 1 then
					r.attach_to (topr)
				else
					debug ("RT_DBG_WARNING")
						print ("Warning: enter mismatch !!!%N")
						print (" top: depth=" + r.depth.out + " ->" + r.debug_output + "%N")
						print (" now: depth=" + dep.out
									+ " obj=" + ref.generating_type
									+ " cid=" + cid.out
									+ " fid=" + fid.out
									+ "%N")
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

	enter_rescue (ref: ANY; cid,fid: INTEGER; dep: INTEGER)
			-- Enter rescue on object `ref', depth is `dep'
		require
			is_not_replaying: not is_replaying
		local
			r: RT_DBG_CALL_RECORD
			c: !RT_DBG_CALL_RECORD
		do
			debug ("RT_DBG_RECORD")
				dtrace_indent (dep); dtrace ("enter_rescue (" + ref.generating_type + ", " + dep.out + ")");
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

	leave_feature (ref: ANY; cid,fid: INTEGER; dep: INTEGER)
			-- Leave feature `{cid}.fid' on object `ref', depth is `dep'
		require
			is_not_replaying: not is_replaying
		local
			n: like callstack_record
		do
			debug ("RT_DBG_RECORD")
				dtrace_indent (dep); dtrace ("leave_feature (" + ref.generating_type + " <" + ($ref).out + ">, " + cid.out + ", " + fid.out + ", " + dep.out + "). %N")
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
							print (" now: depth=" + dep.out
										+ " obj=" + ref.generating_type
										+ " cid=" + cid.out
										+ " fid=" + fid.out
										+ "%N")
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
							same_object_type: dynamic_type (n.object) = dynamic_type (ref)
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
				debug ("RT_DBG_WARNING")
					print ("Warning: hook mismatch on depth now=" + dep.out + " top.depth=" + r.depth.out + "%N")
				end
				if r.depth = dep then
					r.register_position (bp_i, bp_ni)
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
				if {l_record: RT_DBG_RECORD} object_attribute_record (a_offset, a_type, ref) then
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
				if a_dep /= t.depth then
					print ("Loc Assign: dep=" + a_dep.out + "; pos=" + a_position.out + " -> depth mismatch %N")
				end
				check same_associated_depth: a_dep = t.depth end
				if {l_record: RT_DBG_RECORD} object_local_record (a_dep, a_position, a_type) then
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
			curr: like replayed_call
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
								check replayed_call.depth = d1 end
							end
							check replayed_call.depth = d2 end
						elseif d2 < d1 then
								--| Go back in the stack
							from
							until
								d1 <= d2
							loop
								replay_back
								d1 := d1 - 1
								check replayed_call.depth = d1 end
							end
							check replayed_call.depth = d2 end
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
				if bottom_callstack_record /= Void then
					Result := replayed_call.available_calls_to_bottom
				end
			when Direction_forth then
				Result := replay_stack.count
			when Direction_left then
				-- Not yet supported
			when Direction_right then
				-- Not yet supported
			else
			end
		end

	replayed_call_details: STRING
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

	callstack_record_details (a_id: !STRING; nb: INTEGER): STRING
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
			p: like bottom_callstack_record
			c, n: INTEGER
		do
			if maximum_record_count > 0 then
				c := record_count
				if c > 1.1 * maximum_record_count then
					if top_callstack_record /= bottom_callstack_record then
						debug ("RT_DBG_OPTIMIZATION")
							print ("monitor_record_count[" + ((maximum_record_count - c).abs // maximum_record_count).out + "%%] -> remove oldest: record_count=" + c.out + " (max=" + maximum_record_count.out + ")%N")
						end
						from
							p := top_callstack_record
						until
							p.parent = bottom_callstack_record
						loop
							p := p.parent
						end
						check
							p_void_void_and_last_of_parent: p /= Void and then bottom_callstack_record.call_records.last = p
						end
						n := bottom_callstack_record.record_count_but (p)
						p.remove_parent
							--| We may clean the current `bottom_callstack_record' to help the GC ...
						bottom_callstack_record := p
						record_count := c - n
						check record_count = bottom_callstack_record.record_count_but (Void) end
						if record_count <= 0.9 * maximum_record_count then
								--| Could be optimized instead of recursively call this monitoring
							monitor_record_count
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

	replay_stack: ?LINKED_LIST [TUPLE [call_record: like callstack_record; chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]]]
			-- Replay operation stacks.
			-- useful to "revert" the replay steps.

	replay_back
			-- Replay execution back
		require
			is_replaying: is_replaying
		local
			n, r, p: like replayed_call
			l_records: ?LIST [RT_DBG_RECORD]
			chgs: ?ARRAYED_LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_back -start- %N")
			end
			r := replayed_call
			check r_not_void: r /= Void end

			p := r.parent
			last_replay_operation_failed := False
			if replay_stack = Void then
				create replay_stack.make
					-- This is the first replay operation
					-- Replay to the beginning of the current frame
				l_records := changes_between (r, Void, False)
			else
				check replay_stack.count > 0 end
				n := replay_stack.last.call_record
				l_records := changes_between (r, n, False)
			end
			if not last_replay_operation_failed then
				if {ot_records: LIST [RT_DBG_RECORD]} l_records then
					create chgs.make (ot_records.count)
					from
						ot_records.finish
					until
						ot_records.before
					loop
						debug ("RT_DBG_REPLAY")
							print ("replay_back -> " + ot_records.item_for_iteration.debug_output + " %N")
						end
						if {ot_rec: RT_DBG_RECORD} ot_records.item_for_iteration then
							if {val: RT_DBG_RECORD} ot_rec.current_value_record then
								chgs.force ([ot_rec, val])
								ot_rec.restore (val)
							else
								check should_not_occur: False end
							end
						end
						ot_records.back
					end
				end
				replay_stack.force ([r, chgs])
				replayed_call := p
			end
			debug ("RT_DBG_REPLAY")
				print ("replay_back -end- %N")
			end
		end

	replay_left
			-- Replay left (up in the current call stack element)
		require
			is_replaying: is_replaying
		local
			n, r: like replayed_call
			chgs: ?ARRAYED_LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]
			r_pos_line: INTEGER
			done: BOOLEAN
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_left -start- %N")
			end
			r := replayed_call
			check r_not_void: r /= Void end

			from
				check r.replayed_position /= Void end
				r_pos_line := r.replayed_position.line

				n := r
			until
				done
			loop
				if {ot_records: LIST [RT_DBG_RECORD]} r.left_step then
					last_replay_operation_failed := False
					if replay_stack = Void then
						create replay_stack.make
							-- This is the first replay operation
							-- Replay to the beginning of the current frame
					end
					create chgs.make (ot_records.count)
					from
						ot_records.finish
					until
						ot_records.before
					loop
						debug ("RT_DBG_REPLAY")
							print ("replay_left -> " + ot_records.item_for_iteration.debug_output + " %N")
						end
						if {ot_rec: RT_DBG_RECORD} ot_records.item_for_iteration then
							if {val: RT_DBG_RECORD} ot_rec.current_value_record then
								chgs.force ([ot_rec, val])
								ot_rec.restore (val)
							else
								check should_not_occur: False end
							end
						end
						ot_records.back
					end
					replay_stack.force ([r, chgs])
				else
					replay_back
				end
				n := replayed_call
				check n.replayed_position /= Void end
				done := n /= r or else (n.replayed_position.line /= r_pos_line)
				--| FIXME jfiat [2008/04/09] : do we want to step left on nested index ?
			end
			debug ("RT_DBG_REPLAY")
				print ("replay_left -end- %N")
			end
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
				n = Void or else n /= r or else r.replayed_position_is_first
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
			replay_stack_not_empty: replay_stack /= Void and then not replay_stack.is_empty
		local
			r,n: like replayed_call
			t: TUPLE [call_record: like callstack_record; chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]]
			done: BOOLEAN
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_forth -start-%N")
			end
			if replay_stack /= Void then
				r := replayed_call
				check r_not_void: r /= Void end
				from
					n := r
				until
					done
				loop
					check replay_stack.count > 0 end
						--| pop last entry
					replay_stack.finish
					t := replay_stack.item_for_iteration
					replay_stack.remove
					if replay_stack.is_empty then
						replay_stack := Void
					end

						--| Replay
					n := t.call_record
					if {ot_chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]} t.chgs then
						from
							ot_chgs.finish
						until
							ot_chgs.before
						loop
							debug ("RT_DBG_REPLAY")
								print ("replay_forth -> " + ot_chgs.item_for_iteration.record.debug_output + " %N")
							end
							if {ch: TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]} ot_chgs.item_for_iteration then
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
		end

	replay_right
			-- Replay right (down in the current call stack element)
		require
			is_replaying: is_replaying
			replayed_call_not_void: replayed_call /= Void
			replay_stack_not_empty: replay_stack /= Void and then not replay_stack.is_empty
		local
			r,n: like replayed_call
			t: TUPLE [call_record: like callstack_record; chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]]
			r_pos_line: INTEGER
			done: BOOLEAN
		do
			debug ("RT_DBG_REPLAY")
				print ("replay_right -start-%N")
			end
			if replay_stack /= Void then
				r := replayed_call
				check r_not_void: r /= Void end

				from
					check r.replayed_position /= Void end
					r_pos_line := r.replayed_position.line
				until
					done
				loop
					check replay_stack.count > 0 end
						--| pop last entry
					replay_stack.finish
					t := replay_stack.item_for_iteration
					replay_stack.remove
					if replay_stack.is_empty then
						replay_stack := Void
					end

						--| Replay

					if {ot_chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]} t.chgs then
						from
							ot_chgs.finish
						until
							ot_chgs.before
						loop
							debug ("RT_DBG_REPLAY")
								print ("replay_right -> " + ot_chgs.index.out + ") " + ot_chgs.item_for_iteration.record.debug_output + " %N")
							end
							if {ch: TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]} ot_chgs.item_for_iteration then
								ch.record.revert (ch.backup)
							end
							ot_chgs.back
						end
					end

					n := t.call_record
					if n = r then
							--| reverted left step
						n.revert_left_step
						check n.replayed_position /= Void end
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
		end

	revert_replay_stack
			-- Revert remaining replay stack
		require
			is_replaying: is_replaying
		local
			r,n: like replayed_call
			t: TUPLE [call_record: like callstack_record; chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]]
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
					if {ot_chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]} t.chgs then
						from
							ot_chgs.finish
						until
							ot_chgs.before
						loop
							debug ("RT_DBG_REPLAY")
								print ("revert_replay_stack -> " + ot_chgs.item_for_iteration.record.debug_output + " %N")
							end
							if {ch: TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]} ot_chgs.item_for_iteration then
								ch.record.revert (ch.backup)
							end
							ot_chgs.back
						end
					end
					if n = r then
						--| reverted left step
						r.revert_left_step
					else
						--| reverted back step
						check n = Void or else r = n.parent end
						replayed_call := n
					end
				end
			end
			check replay_stack.is_empty end
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
