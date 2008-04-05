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
			set_maximum_record_count (Default_maximum_record_count)
		end

feature {RT_EXTENSION} -- Change

 	set_maximum_record_count (nb: INTEGER)
 			-- Set `maximum_record_count'
 		do
 			maximum_record_count := nb
 		end

	start_recording (ref: ANY; cid: INTEGER; fid: INTEGER; dep: INTEGER)
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
			debug ("RT_EXTENSION")
				print ("Start_recording  (")
				io.put_string ("ref")
				io.put_character (',')
				io.put_integer (cid)
				io.put_character ('=')
				io.put_integer (updated_cid)
				io.put_character (',')
				io.put_integer (fid)
				io.put_character (',')
				io.put_integer (dep)
				io.put_string (")%N")
			end
			create r.make (Current, ref, updated_cid, fid, dep) --| Create initial call record
			bottom_callstack_record := r
			top_callstack_record := r
		ensure
			bottom_callstack_record_is_not_void: bottom_callstack_record /= Void
			top_callstack_record_is_bottom: top_callstack_record = bottom_callstack_record
		end

	stop_recording
			-- Stop recording (and clean data)
		do
			top_callstack_record := Void
			bottom_callstack_record := Void
			record_count := 0
			if {r: like replay_stack} replay_stack then
				r.wipe_out
				replay_stack := Void
			end
			last_replay_operation_failed := False
		ensure
			no_callstack_record: top_callstack_record = Void and bottom_callstack_record = Void
		end

feature -- Optimization properties

	record_count: INTEGER
			-- Number of field records.

	maximum_record_count: INTEGER
			-- Maximum number of records.
			-- `0' stands for no limit.

	flatten_when_closing: BOOLEAN = True

	keep_calls_records: BOOLEAN = True

	Default_maximum_record_count: INTEGER = 5_000
			-- Default maximum number of records.

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
			debug ("RT_EXTENSION")
				if Result /= Void then
					print ("callstack_record (" + dep.out + ") -> Result=" + Result.to_string (0) + "%N")
				end
			end
		end

	callstack_record_by_id (a_id: !STRING): like callstack_record
		local
			p: INTEGER
			i: INTEGER
			r: like callstack_record
			sub_id: STRING
		do
			debug ("RT_EXTENSION")
				print ("callstack_record_by_id (" + a_id + ")%N")
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

	Assign_local_kind: INTEGER = 1
			-- Local Assignment operation (RTDBG_OP_ASSIGN_LOCAL)
	Assign_attribute_kind: INTEGER = 2
			-- Attribute Assignment operation (RTDBG_OP_ASSIGN_ATTRB)

feature -- Event

	enter_feature (ref: ANY; cid,fid: INTEGER; dep: INTEGER; fnp: POINTER)
			-- Enter feature `{cid}.fid' on object `ref', depth is `dep'
			-- And if available, `fnp' is a C string representing the feature name.
		require
			is_not_replaying: not is_replaying
			cid_positive: cid >= 0 --| 0 might stands for ANY
		local
			r: RT_DBG_CALL_RECORD
			fn: STRING
		do
			debug ("RT_EXTENSION")
				dtrace_indent (dep); dtrace ("enter_feature (" + ref.generating_type + ", " + cid.out + ", " + fid.out + ", " + dep.out + ")");
				if fnp /= Default_pointer then
					dtrace (" -> " + create {STRING}.make_from_c (fnp) )
				end
				dtrace (" [[" + record_count.out + "]]%N")
			end
			monitor_record_count
			create r.make (Current, ref, cid, fid, dep)
			if fnp /= Default_pointer then
				create fn.make_from_c (fnp)
				r.set_feature_name (fn)
			end
--			r.record_fields
--			if {flds: LIST [RT_DBG_RECORD]} r.field_records and then not flds.is_empty then
--				increment_records_count (flds.count)
--			end

			--| FIXME: we should use   {topr: like top_callstack_record} ... but compiler is not happy with it for now.
			if {topr: RT_DBG_CALL_RECORD} top_callstack_record then
				r.attach_to (topr)
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
			r,pr,c: RT_DBG_CALL_RECORD
			subs: LIST [like callstack_record]
		do
			debug ("RT_EXTENSION")
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
				debug ("RT_EXTENSION")
					dtrace ("Error: enter_rescue -> No record !!%N")
				end
				stop_recording
				start_recording (ref, cid, fid, dep)
			else
				pr := r.parent
				if pr /= Void then
						--| Close remaining callstack record (from top, to rescued callstack)
					subs := pr.call_records
					if subs /= Void then
						from
							subs.finish
						until
							subs.before
						loop
							c := subs.item_for_iteration
							if c /= r and then not c.is_flat then
								c.close
							end
							subs.back
						end
					end
				end

--				r.record_fields
--				if {flds: LIST [RT_DBG_RECORD]} r.field_records and then not flds.is_empty then
--					increment_records_count (flds.count)
--				end
				top_callstack_record := r
			end
		end

	leave_feature (ref: ANY; cid,fid: INTEGER; dep: INTEGER)
			-- Leave feature `{cid}.fid' on object `ref', depth is `dep'
		require
			is_not_replaying: not is_replaying
		do
			debug ("RT_EXTENSION")
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
					record_count := 0
					bottom_callstack_record := Void
					top_callstack_record := Void
				else
					check
						same_object_type: dynamic_type (r.object) = dynamic_type (ref)
						same_reference: not r.is_expanded implies r.object = ref
						same_cid: r.class_type_id = cid
						same_fid: r.feature_rout_id = fid
						same_dep: r.depth = dep
					end
					r.close
					top_callstack_record := r.parent
				end
			end
		end

	notify_rt_hook (bp_i, bp_ni: INTEGER)
			-- Notify RT_HOOK (bp_i) or RTNHOOK (bp_i, bp_ni)
		require
			is_not_replaying: not is_replaying
		do
			if {r: like callstack_record} top_callstack_record then
				r.notify_breakable_info (bp_i, bp_ni)
			end
		end

	notify_rt_assign (ref: ANY; a_var_kind: INTEGER; a_id: INTEGER; a_type: NATURAL_32;
					a_is_expanded: BOOLEAN; a_is_precompiled: BOOLEAN; a_is_melted: BOOLEAN)
			-- Notify variable assignment
		require
			is_not_replaying: not is_replaying
			top_call_stack_record_not_void: top_callstack_record /= Void
		local
			s32: STRING_32
			r: like callstack_record
		do
			debug ("RT_EXTENSION")
				s32 := once ""
				s32.wipe_out
				r := top_callstack_record
				inspect a_var_kind
				when Assign_local_kind then
					if a_id = 0 then
						s32.append_string ("[rt_assign]: Result")
						s32.append_integer (a_id)
					else
						s32.append_string ("[rt_assign]: local#")
						s32.append_integer (a_id)
					end
				when Assign_attribute_kind then
					s32.append_string ("[rt_assign]: attribute#")
					s32.append_integer (a_id)
					if a_type > 0 then
						s32.append_string (" <type:0x")
						s32.append_string (a_type.to_hex_string)
						s32.append_string (">")
					end
				else
					s32.append_string ("[rt_assign]: ERROR (#")
					s32.append_integer (a_id)
					s32.append_string (")")
				end

				if ref /= Void then
					s32.append_string (" {"+ ($ref).out +"}")
				else
					s32.append_string (" {Void}")
				end
				if a_is_expanded then
					s32.append_string (" +expanded")
				end
				if a_is_precompiled then
					s32.append_string (" +precompiled")
				end
				if a_is_melted then
					s32.append_string (" +melted")
				end
				if r /= Void then
					s32.append_string (" - ")
					s32.append_string (r.debug_output) --to_string (True))
					dtrace_indent (r.depth);
				end
				dtrace (s32 + "%N")
			end

			inspect a_var_kind
			when Assign_local_kind then
				notify_rt_assign_local (a_id, a_type, a_is_expanded, a_is_precompiled, a_is_melted)
			when Assign_attribute_kind then
				if {ot_ref: ANY} ref then
					notify_rt_assign_attribute (ot_ref, a_id, a_type, a_is_expanded, a_is_precompiled, a_is_melted)
				end
			else
			end
		end

	notify_rt_assign_local (a_position: INTEGER; a_type: NATURAL_32;
				a_is_expanded: BOOLEAN; a_is_precompiled: BOOLEAN; a_is_melted: BOOLEAN)
			-- Notify variable assignment
		require
			is_not_replaying: not is_replaying
			top_call_stack_record_not_void: top_callstack_record /= Void
		do
--if a_position > 0 then
	--| Ignore Result for now
			if {t: like top_callstack_record} top_callstack_record then
				if {l_record: RT_DBG_RECORD} object_local_record (t.depth, a_position, a_type) then
					debug ("RT_EXTENSION")
						print ("Loc Assign=> " + l_record.debug_output + "%N")
					end
					t.add_value_record (l_record)
				end
			else
				debug ("RT_EXTENSION")
					print ("Loc Assign=> ERROR, no top_callstack_record !%N")
				end
				check should_not_occur: False end
			end
--end
		end

	notify_rt_assign_attribute (ref: !ANY; a_offset: INTEGER; a_type: NATURAL_32;
					a_is_expanded: BOOLEAN; a_is_precompiled: BOOLEAN; a_is_melted: BOOLEAN)
			-- Notify variable assignment
		require
			is_not_replaying: not is_replaying
			top_call_stack_record_not_void: top_callstack_record /= Void
		do
			if {t: like top_callstack_record} top_callstack_record then
				if {l_record: RT_DBG_RECORD} object_attribute_record (a_offset, a_type, ref) then
					debug ("RT_EXTENSION")
						print ("Att Assign=> " + l_record.debug_output + "%N")
					end
					t.add_value_record (l_record)
				end
			else
				debug ("RT_EXTENSION")
					print ("Att Assign=> ERROR, no top_callstack_record !%N")
				end
				check should_not_occur: False end
			end
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
					if {rs: like replay_stack} replay_stack then
						from
						until
							rs.count = 0
						loop
							replay_forth
						end
					end
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

	replay_query (dir: INTEGER): INTEGER
			-- Replay execution `nb' steps in direction `dir'
		do
			inspect dir
			when Direction_back then
				if bottom_callstack_record /= Void then
					Result := top_callstack_record.available_calls_to_bottom
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

	callstack_record_details (a_id: !STRING; nb: INTEGER): STRING
		do
			if {r: like callstack_record} callstack_record_by_id (a_id) then
				Result := r.to_string (nb)
				debug ("RT_EXTENSION")
					print ("callstack_record_details (" + a_id + "," + nb.out + ") %N")
					print (" -> " + Result)
					print ("%N")
				end
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
					bottom_callstack_record := p
					p.remove_parent
					record_count := c - n
					check record_count = bottom_callstack_record.record_count_but (Void) end
					if record_count <= 0.9 * maximum_record_count then
							--| Could be optimized instead of recursively call this monitoring
						monitor_record_count
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
			n, r, p: like callstack_record
			l_records: ?LIST [RT_DBG_RECORD]
			chgs: ?ARRAYED_LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]
		do
			r := replayed_call
			check r_not_void: r /= Void end

			p := r.parent
			last_replay_operation_failed := False
			if replay_stack = Void then
				create replay_stack.make
					-- This is the first replay operation
					-- Replay to the beginning of the current frame
				l_records := changes_between (r, Void, False)
			elseif r /= Void then
				check replay_stack.count > 0 end
				n := replay_stack.last.call_record
				l_records := changes_between (r, n, False)
			else
				last_replay_operation_failed := False
			end
			if not last_replay_operation_failed then
				if {ot_records: LIST [RT_DBG_RECORD]} l_records then
					create chgs.make (ot_records.count)
					from
						ot_records.finish
					until
						ot_records.before
					loop
						if {ot_rec: RT_DBG_RECORD} ot_records.item_for_iteration then
							if {val: RT_DBG_RECORD} ot_rec.current_value_record then
								chgs.extend ([ot_rec, val])
								ot_rec.restore (val)
							else
								check should_not_occur: False end
							end
						end
						ot_records.back
					end
				end
				replay_stack.extend ([r, chgs])
				replayed_call := p
			end
		end

	replay_forth
			-- Replay execution forth
		require
			is_replaying: is_replaying
			replayed_call_not_void: replayed_call /= Void
			replay_stack_not_empty: replay_stack /= Void and then not replay_stack.is_empty
		local
			r: like callstack_record
			t: TUPLE [call_record: like callstack_record; chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]]
		do
			if replay_stack /= Void then
				check replay_stack.count > 0 end
					--| pop last entry
				replay_stack.finish
				t := replay_stack.item_for_iteration
				replay_stack.remove
				if replay_stack.is_empty then
					replay_stack := Void
				end

					--| Replay
				r := t.call_record
				check replayed_call = r.parent end
				if {ot_chgs: LIST [TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]]} t.chgs then
					from
						ot_chgs.start
					until
						ot_chgs.after
					loop
						if {ch: TUPLE [record: !RT_DBG_RECORD; backup: !RT_DBG_RECORD]} ot_chgs.item_for_iteration then
							ch.record.revert (ch.backup)
						end
						ot_chgs.forth
					end
				end
				replayed_call := r
			else
				last_replay_operation_failed := True
			end
		end

	replay_left
			-- Replay left (up in the current call stack element)
		require
			is_replaying: is_replaying
		do

		end

	replay_right
			-- Replay right (down in the current call stack element)
		require
			is_replaying: is_replaying
		do

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
