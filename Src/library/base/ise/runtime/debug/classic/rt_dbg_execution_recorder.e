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

create {RT_EXTENSION}
	make

feature {NONE} -- Initialization

	make is
			-- Creation of Current object
		do
			max_record_count := 5_000
		end

feature -- Status

	start_recording is
		require
			top_callstack_record_is_void: top_callstack_record = Void
		do
			debug ("RT_EXTENSION")
				dtrace ("Start recording %N")
			end
			record_count := 0
		end

	stop_recording is
		do
			debug ("RT_EXTENSION")
				dtrace ("Stop recording %N")
			end
			top_callstack_record := Void
			bottom_callstack_record := Void
			record_count := 0
			if replay_stack /= Void then
				replay_stack.wipe_out
				replay_stack := Void
			end
			last_replay_operation_failed := False
		ensure
			top_callstack_record_is_void: top_callstack_record = Void
		end

feature -- Properties

	record_count: INTEGER
			-- Number of field records.

	max_record_count: INTEGER
			-- Maximum number of record
			-- `0' stands for no limit.

	top_callstack_record: RT_DBG_CALLSTACK_RECORD
			-- Current top callstack record.

	bottom_callstack_record: RT_DBG_CALLSTACK_RECORD
			-- Bottom (or root) callstack record.

feature -- Constants from eif_debug.h

	Direction_back: INTEGER = 1
	Direction_forth: INTEGER = 2
	Direction_left: INTEGER = 3
	Direction_right: INTEGER = 4

feature -- Access

	enter_feature (ref: ANY; cid,fid: INTEGER; dep: INTEGER; fnp: POINTER) is
			-- Enter feature `{cid}.fid' on object `ref', depth is `dep'
			-- And if available, `fnp' is a C string representing the feature name.
		require
			cid_positive: cid > 0
		local
			r: RT_DBG_CALLSTACK_RECORD
			fn: STRING
			flds: LIST [RT_DBG_RECORD]
		do
			debug ("RT_EXTENSION")
				dtrace (offset (dep) + "enter_feature (" + ref.generating_type + ", " + cid.out + ", " + fid.out + ", " + dep.out + ")");
				if fnp /= Default_pointer then
					dtrace (" -> " + create {STRING}.make_from_c (fnp) )
				end
				dtrace (" [[" + record_count.out + "]]")
				dtrace ("%N")
			end
			monitor_record_count
			create r.make (Current, ref, cid, fid, dep)
			if fnp /= Default_pointer then
				create fn.make_from_c (fnp)
				r.set_feature_name (fn)
			end
			r.record_fields
			flds := r.field_records
			if flds /= Void and then not flds.is_empty then
				increment_records_count (flds.count)
			end

			if top_callstack_record /= Void then
				r.attach_to (top_callstack_record)
			end
			top_callstack_record := r

			check top_callstack_record /= Void end
			if bottom_callstack_record = Void then
				bottom_callstack_record := top_callstack_record
				debug ("RT_EXTENSION")
					dtrace ("Set root record to " + bottom_callstack_record.to_string + "%N")
				end
			end
			debug ("RT_EXTENSION")
				dtrace (offset (dep) + "enter_feature (" + ref.generator + ", " + cid.out + ", " + fid.out + ", " + dep.out + ")")
				if fn /= Void then
					dtrace (" -> " + fn)
				end
				dtrace (" - DONE%N")
			end
		end

	enter_rescue (ref: ANY; dep: INTEGER) is
			-- Enter rescue on object `ref', depth is `dep'
		local
			r,pr,c: RT_DBG_CALLSTACK_RECORD
			subs: LIST [like top_callstack_record]
			flds: LIST [RT_DBG_RECORD]
		do
			debug ("RT_EXTENSION")
				dtrace (offset (dep) + "enter_rescue (" + ref.generating_type + ", " + dep.out + ")");
				dtrace (" [[" + record_count.out + "]]")
				dtrace ("%N")
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
					dtrace (offset (dep) + "enter_rescue -> No record !!%N")
				end
			else
				debug ("RT_EXTENSION")
					dtrace (offset (dep) + "enter_rescue -> found record: " + r.to_string + "%N")
				end
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

				r.record_fields
				flds := r.field_records
				if flds /= Void and then not flds.is_empty then
					increment_records_count (flds.count)
				end
				top_callstack_record := r
			end
			debug ("RT_EXTENSION")
				dtrace (offset (dep) + "enter_rescue (" + ref.generating_type + ", " + dep.out + ")")
				if top_callstack_record /= Void then
					dtrace (" --TOP--> " + top_callstack_record.to_string)
				end
				dtrace (" - DONE%N")
			end
		end

	leave_feature (ref: ANY; cid,fid: INTEGER; dep: INTEGER) is
			-- Leave feature `{cid}.fid' on object `ref', depth is `dep'
		local
			r: like top_callstack_record
		do
			debug ("RT_EXTENSION")
				dtrace (offset (dep) + "leave_feature (" + ref.generating_type + " <" + ($ref).out + ">, " + cid.out + ", " + fid.out + ", " + dep.out + "). %N")
			end

			if top_callstack_record = Void then
				--| This can occurs if the recording started deeper in the call stack.
				--| in this case, do not record anything until we enter again inside a feature
				--| In the meantime, just discard the recorded data
				--| Note: in the future, when we'll support move_left/move_right, we'll handle this case.
			else
				r := top_callstack_record
				if r = bottom_callstack_record then
					check parent_is_void: r.parent = Void end

						--| We are leaving the root record.
						--| and thus discard previous recorded data
					debug ("RT_EXTENSION")
						dtrace ("Leaving root_callstack ... %N")
					end
					record_count := 0
					bottom_callstack_record := Void
					top_callstack_record := Void
				else
					check
						same_object_type: dynamic_type (r.object) = dynamic_type (ref)
						same_reference: not object_is_expanded (ref) implies r.object = ref
						same_cid: r.class_type_id = cid
						same_fid: r.feature_rout_id = fid
						same_dep: r.depth = dep
					end
					r.close
					top_callstack_record := r.parent
				end
			end
			debug ("RT_EXTENSION")
				dtrace (offset (dep) + "leave_feature (" + ref.generating_type + ", " + cid.out + ", " + fid.out + ", " + dep.out + ")");
				if r /= Void and then r.feature_name /= Void then
					dtrace (" -> " + r.feature_name)
				end
				dtrace (" [[" + record_count.out + "]]")
				if top_callstack_record /= Void then
					dtrace (" --TOP--> " + top_callstack_record.to_string)
				end
				dtrace (" - DONE%N")
			end
		end

	replay (dir: INTEGER; nb: INTEGER) is
			-- Replay execution `nb' steps in direction `dir'
		do
			inspect dir
			when Direction_back then
				replay_back
			when Direction_forth then
				replay_forth
			when Direction_left then
			when Direction_right then
			else
				-- Error
			end
		end

	replay_query (dir: INTEGER): INTEGER is
			-- Replay execution `nb' steps in direction `dir'	
		do
			inspect dir
			when Direction_back then
				if bottom_callstack_record /= Void then
--					debug ("RT_EXTENSION_TRACE")
					display (bottom_callstack_record, True, False)
--					end
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

	monitor_record_count is
			-- Monitor if record_count is not over `max_record_count'
			-- if `max_record_count' is 0, then no limit
		local
			p: like bottom_callstack_record
			c, n: INTEGER
		do
			if max_record_count > 0 then
				c := record_count
				if c > 1.1 * max_record_count then
					debug ("RT_EXTENSION")
						dtrace (generating_type + ".monitor_records_count %N")
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
					bottom_callstack_record := p
					p.remove_parent
					record_count := c - n
					check record_count = bottom_callstack_record.record_count_but (Void) end
					if record_count <= 0.9 * max_record_count then
							--| Could be optimized instead of recursively call this monitoring
						monitor_record_count
					end
				end
			end
		end

feature -- Replay operation

	last_replay_operation_failed: BOOLEAN

	replay_stack: LINKED_LIST [TUPLE [record: like top_callstack_record; chgs: LIST [TUPLE [ANY,RT_DBG_RECORD]]]]

	replay_back is
		local
			n, r, p: like top_callstack_record
			chgs: LIST [TUPLE [ANY, RT_DBG_RECORD]]
		do
			debug ("RT_EXTENSION")
				dtrace ("Replay BACK -> start%N")
			end
			r := top_callstack_record
			p := top_callstack_record.parent
			last_replay_operation_failed := False
			if replay_stack = Void then
				create replay_stack.make
					-- This is the first replay operation
					-- Replay to the beginning of the current frame
				chgs := changes_between (r, Void)
			elseif r /= Void then
				check replay_stack.count > 0 end
				n := replay_stack.last.record
				chgs := changes_between (r, n)
			else
				last_replay_operation_failed := False
			end
			if not last_replay_operation_failed then
				restore_records (chgs)
				replay_stack.extend ([r, chgs])
				top_callstack_record := p
			end
			debug ("RT_EXTENSION")
				r := top_callstack_record
				if r /= Void then
					dtrace ("Replay BACK -> stack = {")
					if r.object /= Void then
						dtrace (r.object.generating_type + ":")
					end
					dtrace (r.class_type_id.out + "}." + r.feature_rout_id.out + ".%N")
				else
					dtrace ("Replay BACK -> nowhere %N")
				end
				if last_replay_operation_failed then
					dtrace ("Replay BACK -> failed.%N")
				else
					dtrace ("Replay BACK -> done.%N")
				end
			end
		end

	replay_forth is
		require
			replay_stack_not_empty: replay_stack /= Void and then not replay_stack.is_empty
		local
			r: like top_callstack_record
			t: TUPLE [record: like top_callstack_record; chgs: LIST [TUPLE [ANY, RT_DBG_RECORD]]]
		do
			debug ("RT_EXTENSION")
				dtrace ("Replay FORTH -> start%N")
			end
			if replay_stack /= Void then
				check replay_stack.count > 0 end
				replay_stack.finish
				t := replay_stack.item_for_iteration
				replay_stack.remove
				if replay_stack.is_empty then
					replay_stack := Void
				end
				r := t.record
				check top_callstack_record = r.parent end
				revert_records (t.chgs)
				top_callstack_record := r
			else
				last_replay_operation_failed := True
			end

			debug ("RT_EXTENSION")
				dtrace ("Replay FORTH -> done ")
				if last_replay_operation_failed then
					dtrace ("(failure!)")
				end
				dtrace (".%N")
			end
		end

feature -- Queries

	increment_records_count (n: INTEGER) is
			-- Incremente `record_count' by `n'
		do
			debug ("RT_EXTENSION_TRACE")
				dtrace ("incremente records count by " + n.out + " (" + record_count.out + "->" + (n + record_count).out + "). %N")
			end
			record_count := record_count + n
		end

feature -- Internal helper

	restore_records (chgs: LIST [TUPLE [ANY, RT_DBG_RECORD]]) is
		require
			chgs /= Void
		local
			l_chg: TUPLE [obj: ANY; rec: RT_DBG_RECORD]
		do
			debug ("RT_EXTENSION")
				dtrace ("restore_records -> " + chgs.count.out + " entries...%N")
				chgs.do_all (agent (tu: TUPLE [ao: ANY; ar: RT_DBG_RECORD])
						do
							dtrace (" + " + tu.ao.generating_type + " #" + tu.ar.position.out + " : " + tu.ar.to_string + "%N")
						end
					)
			end
			from
				chgs.finish
			until
				chgs.before
			loop
				l_chg := chgs.item_for_iteration
				l_chg.rec.restore (l_chg.obj, object_record (l_chg.rec.position, l_chg.obj))
				chgs.back
			end
		end

	revert_records (chgs: LIST [TUPLE [ANY, RT_DBG_RECORD]]) is
		require
			chgs /= Void
		local
			l_chg: TUPLE [obj: ANY; rec: RT_DBG_RECORD]
		do
			debug ("RT_EXTENSION")
				dtrace ("revert_records -> " + chgs.count.out + " entries...%N")
				chgs.do_all (agent (tu: TUPLE [ao: ANY; ar: RT_DBG_RECORD])
						do
							dtrace (" + " + tu.ao.generating_type + " #" + tu.ar.position.out + " : " + tu.ar.to_string + "%N")
						end
					)
			end
			from
				chgs.start
			until
				chgs.after
			loop
				l_chg := chgs.item_for_iteration
				l_chg.rec.revert (l_chg.obj)
				chgs.forth
			end
		end

feature -- helper

	display (r: like top_callstack_record; rec: BOOLEAN; a_show_values: BOOLEAN) is
		local
			fn: STRING
			cn: STRING
			dep: INTEGER
			d: STRING
			lst: LIST [like top_callstack_record]
			flds: LIST [RT_DBG_RECORD]
		do
			cn := class_name_of_type (r.class_type_id)
			if r.feature_name /= Void then
				fn := r.feature_name
			else
				fn := r.feature_rout_id.out
			end
			dep := r.depth
			lst := r.call_records
			flds := r.field_records
			d := offset (dep)

			io.put_string (d)
			io.put_character ('<')
			io.put_string (cn + "." + fn)
			if
				not rec
				or (lst = Void or else lst.is_empty)
			then
				io.put_character (' ')
				io.put_character ('/')
				io.put_character ('>')
				io.put_new_line
				if a_show_values then
					display_fields (flds, r, d)
				end
			else
				io.put_character ('>')
				io.put_new_line
				if
					lst /= Void
				then
					check has_records: not lst.is_empty end
					from
						lst.start
					until
						lst.after
					loop
						display (lst.item, rec, a_show_values)
						lst.forth
					end
				end
				if a_show_values then
					display_fields (flds, r, d)
				end
				io.put_string (d)
				io.put_character ('<')
				io.put_character ('/')
				io.put_string (cn + "." + fn)
				io.put_character ('>')
				io.put_new_line
			end
		end

	display_fields (flds: LIST [RT_DBG_RECORD]; r: like top_callstack_record; d: STRING) is
		local
			tv: RT_DBG_RECORD
		do
			if flds /= Void then
				from
					flds.start
				until
					flds.after
				loop
					tv := flds.item_for_iteration
					io.put_string (d)
					io.put_string (" - ")
					io.put_integer (tv.position)
					io.put_character ('<')
					io.put_integer (tv.type)
					io.put_character ('>')
					io.put_string (" = ")
					io.put_string (tv.to_string)

					tv := object_record (tv.position, r.object)
					io.put_string (" -> ")
					io.put_string (tv.to_string)

					io.put_new_line
					flds.forth
				end
			end
		end

	offset (i: INTEGER): STRING is
		do
			create Result.make_filled (' ', 2 * i)
		end

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
